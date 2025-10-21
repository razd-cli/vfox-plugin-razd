# Implementation Tasks

## 1. Update Plugin Metadata
- [x] 1.1 Update PLUGIN.name to "tursodb"
- [x] 1.2 Update PLUGIN.description with TursoDB information
- [x] 1.3 Update PLUGIN.homepage to TursoDB GitHub repository
- [x] 1.4 Update PLUGIN.version to "0.1.0" (initial release)
- [x] 1.5 Set appropriate minRuntimeVersion based on required vfox features
- [x] 1.6 Update or remove manifestUrl for distribution

## 2. Implement HTTP Utilities
- [x] 2.1 Create GitHub API request helper in lib/util.lua
- [x] 2.2 Implement release data parsing function
- [x] 2.3 Add error handling for API failures
- [x] 2.4 Add platform and architecture detection helpers

## 3. Implement Available Hook
- [x] 3.1 Fetch releases from GitHub API (https://api.github.com/repos/tursodatabase/turso/releases)
- [x] 3.2 Parse release versions (format: v0.2.2 -> 0.2.2)
- [x] 3.3 Extract release notes/descriptions
- [x] 3.4 Return formatted version list
- [x] 3.5 Handle API errors gracefully

## 4. Implement PreInstall Hook
- [x] 4.1 Detect user's platform (Windows, macOS, Linux)
- [x] 4.2 Detect architecture (x86_64, aarch64, arm64)
- [x] 4.3 Construct download URL based on platform and architecture
  - [x] Windows: turso_cli-{version}-x86_64-pc-windows-msvc.zip
  - [x] macOS Intel: turso_cli-{version}-x86_64-apple-darwin.tar.gz
  - [x] macOS Apple Silicon: turso_cli-{version}-aarch64-apple-darwin.tar.gz
  - [x] Linux x64: turso_cli-{version}-x86_64-unknown-linux-gnu.tar.gz
  - [x] Linux arm64: turso_cli-{version}-aarch64-unknown-linux-gnu.tar.gz
- [x] 4.4 Return installation information with version, URL, and checksums (if available)
- [x] 4.5 Handle unsupported platform/architecture combinations

## 5. Implement EnvKeys Hook
- [x] 5.1 Remove template placeholder code (JAVA_HOME, bin2)
- [x] 5.2 Set PATH to include turso binary directory
- [x] 5.3 Handle platform-specific path conventions (Windows vs Unix)
- [x] 5.4 Test PATH configuration on different platforms

## 6. Clean Up Template Code
- [x] 6.1 Remove or simplify post_install.lua if no post-installation steps are needed
- [x] 6.2 Remove pre_use.lua if version transformation is not needed
- [x] 6.3 Remove parse_legacy_file.lua (no legacy files initially)
- [x] 6.4 Remove pre_uninstall.lua if no cleanup is needed
- [x] 6.5 Update README.md with TursoDB-specific information

## 7. Testing
- [x] 7.1 Test `vfox search tursodb` - should list available versions
- [x] 7.2 Test `vfox install tursodb@latest` - should download and install
- [x] 7.3 Test `vfox use tursodb@<version>` - should set up PATH correctly
- [x] 7.4 Verify `turso --version` works after installation
- [x] 7.5 Test on Windows
- [x] 7.6 Test on macOS (Intel and/or Apple Silicon if available)
- [x] 7.7 Test on Linux

## 8. Documentation
- [x] 8.1 Update README.md with usage instructions
- [x] 8.2 Add installation examples
- [x] 8.3 Document platform support matrix
- [x] 8.4 Add troubleshooting section

## Validation
- [x] Run `openspec validate configure-tursodb-plugin --strict` before marking complete
- [x] Ensure all hooks work end-to-end in a test environment
- [x] Verify turso CLI executes correctly after installation
