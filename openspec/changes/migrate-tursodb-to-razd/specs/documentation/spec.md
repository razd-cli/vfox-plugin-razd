# Documentation

## MODIFIED Requirements

### Requirement: README Title and Description
The README SHALL identify the plugin as vfox-plugin-razd.

#### Scenario: README title is razd-specific
Given a user views the README
When they see the title
Then it should be "vfox-plugin-razd"

#### Scenario: README description references razd
Given a user reads the plugin description
When they check what it manages
Then it should mention "razd CLI versions"

### Requirement: Installation Instructions
The README SHALL provide accurate razd installation commands.

#### Scenario: mise installation command uses razd
Given a user wants to install with mise
When they follow the instructions
Then the command should be "mise plugin install razd https://github.com/razd-cli/vfox-plugin-razd"

#### Scenario: vfox installation command uses razd
Given a user wants to install with vfox
When they follow the instructions
Then the command should be "vfox add razd"

### Requirement: Usage Examples
All usage examples SHALL use razd instead of tursodb.

#### Scenario: Version listing command uses razd
Given a user wants to list versions
When using mise
Then the command should be "mise ls-remote razd"

#### Scenario: Installation command uses razd
Given a user wants to install a version
When using vfox
Then the command should be "vfox install razd@0.1.0"

### Requirement: Verification Command
The verification command SHALL check razd version.

#### Scenario: Verify installation command uses razd
Given a user completes installation
When they verify it worked
Then the command should be "razd --version"

### Requirement: External Links
All external links SHALL point to razd resources.

#### Scenario: Repository link points to razd
Given a user clicks the official repository link
When navigating
Then it should go to "https://github.com/razd-cli/razd"
