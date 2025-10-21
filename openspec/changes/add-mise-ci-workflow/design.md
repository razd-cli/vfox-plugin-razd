# Design: Add mise CI Workflow

## Overview

This design document describes the technical implementation of a GitHub Actions workflow that validates mise compatibility by testing plugin installation from source on every push.

## Architecture

### Workflow Structure

```yaml
name: Test mise Integration
on: [push]
jobs:
  test-mise:
    runs-on: ubuntu-latest
    steps:
      - checkout
      - setup-mise
      - install-plugin
      - test-version-discovery
      - test-installation
      - verify-binary
```

### Component Breakdown

#### 1. Mise Installation
**Approach**: Use official mise installation script
```bash
curl https://mise.run | sh
export PATH="$HOME/.local/bin:$PATH"
```

**Alternatives considered**:
- Install from package manager: Rejected (might not have latest version)
- Build from source: Rejected (too slow, unnecessary)

**Caching strategy**: Cache `~/.local/bin/mise` and `~/.local/share/mise` using `actions/cache@v4`

#### 2. Plugin Installation from Source
**Approach**: Use mise's ability to install plugins from local path
```bash
mise plugin install tursodb $GITHUB_WORKSPACE
```

This installs the plugin directly from the checked-out repository, ensuring we test the current commit's code.

**Why not use GitHub URL**: We want to test the exact code in the commit, not the published version.

#### 3. Version Discovery Test
**Approach**: Execute version listing and validate output
```bash
mise ls-remote tursodb | tee versions.txt
test -s versions.txt  # Ensure file is not empty
```

**Validation**: Check that output contains semantic version numbers

#### 4. Installation Test
**Approach**: Install latest version and verify binary exists
```bash
mise install tursodb@latest
mise use tursodb@latest
which turso
```

**Why latest**: Most likely to expose compatibility issues; specific versions can be added later

#### 5. Binary Verification
**Approach**: Execute turso command and check exit code
```bash
turso --version
```

**Expected behavior**: Command succeeds (exit code 0) and prints version information

## Implementation Details

### Error Handling

Each step uses `set -e` (errexit) to fail fast on errors. This ensures:
- Pipeline stops immediately when something breaks
- GitHub Actions marks workflow as failed
- Commit status checks show failure

### Logging

Use GitHub Actions native logging:
- `echo "::group::Step Name"` for collapsible sections
- `echo "::error::Error message"` for highlighted errors
- Default stdout/stderr capture for debugging

### Performance Optimization

**Caching layers**:
1. **Mise binary cache** (~50MB, rarely changes)
   - Key: `mise-${{ runner.os }}-${{ hashFiles('.mise-version') }}`
   - Fallback: `mise-${{ runner.os }}-`
   
2. **Mise installation cache** (optional, for future optimization)
   - Cache downloaded TursoDB binaries
   - Key includes TursoDB version hash

**Expected timing**:
- First run: ~3-4 minutes
- Cached runs: ~2-3 minutes

### Security Considerations

- Use official mise installation script over HTTPS
- No secrets required (public API, public releases)
- Run in isolated GitHub Actions environment
- No persistent state between runs

## Testing Strategy

### Validation Checkpoints

1. **Mise installation**: `mise --version` succeeds
2. **Plugin installation**: `mise plugin list | grep tursodb` succeeds
3. **Version discovery**: `mise ls-remote tursodb | wc -l` > 0
4. **TursoDB installation**: `mise list tursodb` shows installed version
5. **Binary access**: `turso --version` succeeds

### Failure Scenarios

| Scenario | Detection | Recovery |
|----------|-----------|----------|
| Mise install fails | Step exits non-zero | Workflow fails, retry on next push |
| Plugin install fails | grep returns no match | Workflow fails, indicates plugin code issue |
| Version discovery fails | Empty output or network error | Workflow fails, check GitHub API |
| TursoDB install fails | mise exits non-zero | Workflow fails, check release assets |
| Binary not accessible | which/command fails | Workflow fails, check env_keys.lua |

## Workflow File Structure

```yaml
name: Test mise Integration

on:
  push:
    branches:
      - '**'
  pull_request:

jobs:
  test-mise:
    runs-on: ubuntu-latest
    
    steps:
      - name: Checkout code
        uses: actions/checkout@v4
      
      - name: Cache mise
        uses: actions/cache@v4
        with:
          path: |
            ~/.local/bin/mise
            ~/.local/share/mise
          key: mise-${{ runner.os }}-v1
      
      - name: Install mise
        run: |
          curl https://mise.run | sh
          echo "$HOME/.local/bin" >> $GITHUB_PATH
      
      - name: Verify mise installation
        run: mise --version
      
      - name: Install plugin from source
        run: mise plugin install tursodb $GITHUB_WORKSPACE
      
      - name: List available versions
        run: mise ls-remote tursodb
      
      - name: Install TursoDB latest
        run: mise install tursodb@latest
      
      - name: Activate TursoDB
        run: mise use tursodb@latest
      
      - name: Verify turso command
        run: |
          eval "$(mise activate bash)"
          turso --version
```

## Future Enhancements

### Phase 2 (Deferred)
- Test on multiple platforms (macOS, Windows)
- Test multiple TursoDB versions
- Test version switching
- Add performance benchmarks

### Phase 3 (Future consideration)
- Integration tests with actual TursoDB operations
- Test plugin uninstall/reinstall
- Test with different mise configurations

## Rollback Plan

If workflow causes issues:
1. Rename workflow file to `.github/workflows/test-mise.yaml.disabled`
2. Or add `if: false` condition to job
3. Fix issues offline
4. Re-enable by renaming or removing condition

No user-facing impact since this is CI-only change.
