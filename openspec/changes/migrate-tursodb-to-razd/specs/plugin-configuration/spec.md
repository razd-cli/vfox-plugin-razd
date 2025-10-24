# Plugin Configuration

## MODIFIED Requirements

### Requirement: Plugin Identity
The vfox plugin SHALL identify itself as razd instead of tursodb.

#### Scenario: Plugin name is razd
Given a user installs the vfox plugin
When the plugin is loaded
Then the plugin name should be "razd"

#### Scenario: Plugin homepage points to razd repository
Given a user checks plugin information
When viewing the homepage
Then it should point to "https://github.com/razd-cli/razd"

### Requirement: Release Source
The plugin SHALL fetch releases from razd GitHub repository.

#### Scenario: Fetch releases from razd repository
Given the plugin needs to list available versions
When it queries GitHub API
Then it should use "https://api.github.com/repos/razd-cli/razd/releases"

### Requirement: Asset Naming
The plugin SHALL use razd asset naming patterns for downloads.

#### Scenario: Windows asset name includes version
Given a user installs razd version 0.1.0 on Windows x64
When the plugin determines the asset name
Then it should be "razd-v0.1.0-x86_64-pc-windows-msvc.zip"

#### Scenario: macOS Intel asset name includes version
Given a user installs razd version 0.1.0 on macOS Intel
When the plugin determines the asset name
Then it should be "razd-v0.1.0-x86_64-apple-darwin.tar.gz"

#### Scenario: macOS ARM asset name includes version
Given a user installs razd version 0.1.0 on macOS Apple Silicon
When the plugin determines the asset name
Then it should be "razd-v0.1.0-aarch64-apple-darwin.tar.gz"

#### Scenario: Linux asset name includes version
Given a user installs razd version 0.1.0 on Linux x64
When the plugin determines the asset name
Then it should be "razd-v0.1.0-x86_64-unknown-linux-gnu.tar.gz"

### Requirement: Download URLs
The plugin SHALL construct correct download URLs for razd releases.

#### Scenario: Download URL construction
Given a user installs razd version 0.1.0 on any platform
When the plugin constructs the download URL
Then it should use base URL "https://github.com/razd-cli/razd/releases/download/v{version}/{asset}"

### Requirement: User Messages
All user-facing messages SHALL reference razd instead of TursoDB.

#### Scenario: Error messages reference razd
Given the plugin encounters an error fetching releases
When it displays an error message
Then the message should say "Error fetching razd releases"

#### Scenario: Installation messages reference razd
Given a user installs razd
When the installation note is shown
Then it should say "Installing razd CLI {version} for {platform}"
