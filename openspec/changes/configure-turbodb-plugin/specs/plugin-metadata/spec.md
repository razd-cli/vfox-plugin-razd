# Plugin Metadata Specification

## ADDED Requirements

### Requirement: Plugin Identity Configuration
The plugin metadata SHALL define accurate identification information for the TursoDB plugin.

#### Scenario: User queries plugin information
- **WHEN** a user executes `vfox list` or inspects plugin metadata
- **THEN** the plugin displays name "tursodb", version "0.1.0", and description "vfox plugin for TursoDB CLI"

### Requirement: Plugin Compatibility Declaration
The plugin metadata SHALL declare minimum vfox runtime version requirements.

#### Scenario: Loading plugin in compatible vfox version
- **WHEN** vfox version >= 0.3.0 loads the plugin
- **THEN** the plugin loads successfully

#### Scenario: Loading plugin in incompatible vfox version
- **WHEN** vfox version < 0.3.0 attempts to load the plugin
- **THEN** vfox prevents loading and prompts user to upgrade

### Requirement: Homepage Reference
The plugin metadata SHALL reference the official TursoDB GitHub repository.

#### Scenario: User seeks additional information
- **WHEN** a user checks plugin homepage
- **THEN** they are directed to https://github.com/tursodatabase/turso

### Requirement: License Declaration
The plugin metadata SHALL declare appropriate license (Apache 2.0 or MIT).

#### Scenario: User checks license compliance
- **WHEN** a user reviews plugin license
- **THEN** the license is clearly stated and matches repository license

## MODIFIED Requirements

None - this is a new capability.

## REMOVED Requirements

None - this is a new capability.
