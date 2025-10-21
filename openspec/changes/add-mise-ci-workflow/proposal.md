# Proposal: Add mise CI Workflow

## Why

The plugin advertises mise compatibility in README.md, but there's no automated validation. This creates risk:
- Users install via mise and encounter issues that weren't caught during development
- Contributors can't confidently make changes without manual mise testing
- Regressions in mise compatibility go unnoticed until reported by users

Adding CI testing provides continuous validation, improving reliability and developer confidence.

## Problem Statement

The plugin currently lacks automated testing for mise compatibility. While the plugin is advertised as compatible with mise (a version manager supporting vfox plugins), there's no CI validation ensuring that:
- The plugin can be installed via mise from source
- Version discovery works correctly through mise
- Installation and activation of TursoDB versions succeeds
- The installed binary is accessible and functional

Manual testing is time-consuming and doesn't catch regressions early. Every commit should validate mise integration to maintain compatibility.

## Proposed Solution

Add a GitHub Actions workflow (`.github/workflows/test-mise.yaml`) that runs on every push to validate mise integration using the current commit's source code.

The workflow will:
1. Install mise on Ubuntu runner
2. Install the plugin from the checked-out source (current commit)
3. List available TursoDB versions via mise
4. Install the latest TursoDB version
5. Verify the `turso` command is accessible and functional
6. Report success/failure status

This provides continuous validation of mise compatibility without requiring manual intervention.

## Impact Analysis

### Benefits
- **Early detection**: Catch mise compatibility issues immediately on push
- **Confidence**: Developers and users can trust that mise integration works
- **Documentation**: Workflow serves as executable documentation of mise usage
- **Regression prevention**: Breaking changes to plugin hooks are caught automatically

### Risks
- **CI time**: Adds ~2-3 minutes to CI pipeline per push
- **Network dependency**: Relies on GitHub API and TursoDB releases availability
- **False negatives**: Transient network issues might cause spurious failures

### Mitigation
- Run in parallel with other workflows to minimize perceived delay
- Add retry logic for network operations
- Cache mise installation to speed up subsequent runs

## Requirements

### Functional Requirements
1. Workflow MUST install mise on Ubuntu
2. Workflow MUST install plugin from checked-out source code (not from GitHub releases)
3. Workflow MUST verify version discovery (`mise ls-remote tursodb`)
4. Workflow MUST install and activate a TursoDB version
5. Workflow MUST verify `turso --version` executes successfully
6. Workflow MUST fail if any step fails

### Non-Functional Requirements
1. Workflow SHOULD complete within 5 minutes under normal conditions
2. Workflow SHOULD use caching to optimize mise installation
3. Workflow SHOULD provide clear error messages on failure

## Alternatives Considered

### Alternative 1: Test with vfox instead of mise
**Rejected**: The plugin already works with vfox (it's the primary target). mise support is what needs validation since it's a different runtime.

### Alternative 2: Test on multiple platforms (Ubuntu, macOS, Windows)
**Deferred**: Start with Ubuntu for simplicity. Can expand to multi-platform in a future change if needed.

### Alternative 3: Use scheduled workflow instead of per-commit
**Rejected**: Per-commit validation provides faster feedback and catches issues immediately after they're introduced.

## Dependencies

- GitHub Actions runner with Ubuntu
- mise binary (downloaded during workflow)
- GitHub API availability (for version discovery)
- TursoDB releases availability (for installation)

## Success Criteria

- [x] Workflow file created at `.github/workflows/test-mise.yaml`
- [x] Workflow triggers on push events
- [x] Workflow successfully installs mise
- [x] Workflow successfully installs plugin from source
- [x] Workflow successfully lists TursoDB versions
- [x] Workflow successfully installs and verifies TursoDB CLI
- [ ] Workflow passes on current codebase (pending: requires push to trigger)
- [ ] Documentation updated to mention CI testing (optional enhancement)
