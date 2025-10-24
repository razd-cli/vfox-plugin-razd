# Tasks: Migrate TursoDB Plugin to razd

## Implementation Tasks

### 1. Update Plugin Metadata
- [ ] Change `PLUGIN.name` from "tursodb" to "razd" in `metadata.lua`
- [ ] Update `PLUGIN.homepage` to "https://github.com/razd-cli/razd"
- [ ] Update `PLUGIN.description` to reference razd
- [ ] Update `PLUGIN.manifestUrl` to razd repository
- [ ] Remove or update TursoDB-specific notes

### 2. Update Utility Functions
- [ ] Change GitHub API URL in `util.fetch_github_releases()` to "https://api.github.com/repos/razd-cli/razd/releases"
- [ ] Update `util.get_asset_name()` to match razd asset naming pattern: `razd-v{version}-{platform}.{ext}`
- [ ] Update platform mappings for:
  - Windows: `razd-v*-x86_64-pc-windows-msvc.zip`
  - macOS Intel: `razd-v*-x86_64-apple-darwin.tar.gz`
  - macOS ARM: `razd-v*-aarch64-apple-darwin.tar.gz`
  - Linux: `razd-v*-x86_64-unknown-linux-gnu.tar.gz`
- [ ] Update `util.get_download_url()` to construct correct razd download URLs

### 3. Update Hook Functions
- [ ] Change error message in `hooks/available.lua` from "TursoDB" to "razd"
- [ ] Update installation note in `hooks/pre_install.lua` from "TursoDB CLI" to "razd CLI"
- [ ] Update platform support message if needed

### 4. Update Documentation
- [ ] Change README title from "vfox-plugin-tursodb" to "vfox-plugin-razd"
- [ ] Update repository URLs in README
- [ ] Replace TursoDB description with razd description
- [ ] Update all installation command examples
- [ ] Change verification command from `turso --version` to `razd --version`
- [ ] Update badges and GitHub Actions links

### 5. Validation
- [ ] Run `openspec validate migrate-tursodb-to-razd --strict`
- [ ] Test plugin installation with vfox/mise
- [ ] Verify download URLs work for all platforms

## Verification Checklist
- [ ] No "tursodb" or "TursoDB" references remain in code
- [ ] No "turso" references remain (except in historical comments if needed)
- [ ] GitHub API points to razd-cli/razd
- [ ] Asset names match actual razd release assets
- [ ] Download URLs are valid
- [ ] Documentation is accurate and complete
