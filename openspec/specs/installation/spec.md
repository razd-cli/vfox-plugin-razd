# installation Specification

## Purpose
TBD - created by archiving change configure-turbodb-plugin. Update Purpose after archive.
## Requirements
### Requirement: Platform Detection
The plugin SHALL detect the user's operating system and architecture.

#### Scenario: Windows x64 detection
- **WHEN** plugin runs on Windows x86_64 system
- **THEN** platform is identified as "windows" with architecture "x86_64"

#### Scenario: macOS detection
- **WHEN** plugin runs on macOS Intel system
- **THEN** platform is identified as "darwin" with architecture "x86_64"
- **WHEN** plugin runs on macOS Apple Silicon
- **THEN** platform is identified as "darwin" with architecture "aarch64"

#### Scenario: Linux detection
- **WHEN** plugin runs on Linux x86_64 system
- **THEN** platform is identified as "linux" with architecture "x86_64"
- **WHEN** plugin runs on Linux ARM64 system
- **THEN** platform is identified as "linux" with architecture "aarch64"

### Requirement: Download URL Construction
The plugin SHALL construct correct download URLs based on platform and architecture.

#### Scenario: Windows x64 download URL
- **WHEN** installing version "0.2.2" on Windows x86_64
- **THEN** download URL is constructed as:
  - `https://github.com/tursodatabase/turso/releases/download/v0.2.2/turso_cli-0.2.2-x86_64-pc-windows-msvc.zip`

#### Scenario: macOS Intel download URL
- **WHEN** installing version "0.2.2" on macOS x86_64
- **THEN** download URL is constructed as:
  - `https://github.com/tursodatabase/turso/releases/download/v0.2.2/turso_cli-0.2.2-x86_64-apple-darwin.tar.gz`

#### Scenario: macOS Apple Silicon download URL
- **WHEN** installing version "0.2.2" on macOS aarch64
- **THEN** download URL is constructed as:
  - `https://github.com/tursodatabase/turso/releases/download/v0.2.2/turso_cli-0.2.2-aarch64-apple-darwin.tar.gz`

#### Scenario: Linux x64 download URL
- **WHEN** installing version "0.2.2" on Linux x86_64
- **THEN** download URL is constructed as:
  - `https://github.com/tursodatabase/turso/releases/download/v0.2.2/turso_cli-0.2.2-x86_64-unknown-linux-gnu.tar.gz`

#### Scenario: Linux ARM64 download URL
- **WHEN** installing version "0.2.2" on Linux aarch64
- **THEN** download URL is constructed as:
  - `https://github.com/tursodatabase/turso/releases/download/v0.2.2/turso_cli-0.2.2-aarch64-unknown-linux-gnu.tar.gz`

### Requirement: Installation Information Response
The plugin SHALL return complete installation information to vfox.

#### Scenario: Successful installation preparation
- **WHEN** PreInstall hook processes valid version and platform
- **THEN** it returns table containing:
  - `version`: normalized version string
  - `url`: download URL for platform-specific binary
  - `sha256`: checksum if available (optional)
  - `note`: additional information or warnings

#### Scenario: Unsupported platform
- **WHEN** PreInstall hook detects unsupported platform/architecture combination
- **THEN** it returns table with:
  - `version`: empty string
  - `note`: error message describing unsupported configuration

### Requirement: Archive Extraction Support
The plugin SHALL leverage vfox's automatic extraction for supported archive formats.

#### Scenario: Windows ZIP extraction
- **WHEN** vfox downloads .zip file for Windows
- **THEN** vfox automatically extracts contents to SDK directory

#### Scenario: Unix tar.gz extraction
- **WHEN** vfox downloads .tar.gz file for macOS or Linux
- **THEN** vfox automatically extracts contents to SDK directory

### Requirement: Checksum Validation
The plugin SHALL provide checksums when available from releases.

#### Scenario: Checksum available
- **WHEN** GitHub release includes SHA256 checksum
- **THEN** plugin includes checksum in installation info
- **AND** vfox validates downloaded file

#### Scenario: Checksum unavailable
- **WHEN** GitHub release does not include checksum
- **THEN** plugin omits checksum field
- **AND** vfox proceeds with installation without validation

