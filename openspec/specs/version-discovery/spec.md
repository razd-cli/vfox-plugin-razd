# version-discovery Specification

## Purpose
TBD - created by archiving change configure-turbodb-plugin. Update Purpose after archive.
## Requirements
### Requirement: GitHub Releases API Integration
The plugin SHALL fetch available TursoDB versions from the GitHub Releases API.

#### Scenario: Fetching versions from GitHub
- **WHEN** user executes `vfox search tursodb`
- **THEN** the plugin queries https://api.github.com/repos/tursodatabase/turso/releases
- **AND** returns a list of all available versions

#### Scenario: API unavailable
- **WHEN** user executes `vfox search tursodb`
- **THEN** the plugin displays a list of available versions from GitHub releases

#### Scenario: Fallback on API Error
- **WHEN** user executes `vfox search tursodb` and GitHub API is unreachable
- **THEN** the plugin returns an empty array
- **AND** vfox prompts user that no versions were found

### Requirement: Version Parsing
The plugin SHALL parse version tags into normalized version numbers.

#### Scenario: Parsing semver tags
- **WHEN** GitHub release has tag "v0.2.2"
- **THEN** the plugin extracts version as "0.2.2"

#### Scenario: Parsing various tag formats
- **WHEN** release tags follow format "v{major}.{minor}.{patch}"
- **THEN** the plugin removes 'v' prefix and returns semantic version

### Requirement: Version List Formatting
The plugin SHALL return versions in vfox-compatible format with metadata.

#### Scenario: Returning formatted version list
- **WHEN** plugin processes release data
- **THEN** each version entry includes:
  - `version`: normalized version string
  - `note`: optional release description or label (e.g., "Latest", "Beta")

### Requirement: Caching Behavior
The plugin SHALL leverage vfox's built-in caching for version lists.

#### Scenario: Respecting cache duration
- **WHEN** user searches for versions within cache period (12 hours default)
- **THEN** the plugin relies on cached results
- **AND** does not make additional API requests

