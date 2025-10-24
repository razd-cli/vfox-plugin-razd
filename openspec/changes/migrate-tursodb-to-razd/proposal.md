# Proposal: Migrate TursoDB Plugin to razd

## Summary
Migrate the vfox plugin from TursoDB CLI to razd CLI, updating all references, URLs, asset names, and installation patterns to support the razd project.

## Why
The plugin was initially created as a template based on TursoDB but is intended to manage the razd CLI tool instead. razd is a separate project with its own GitHub repository, release structure, and purpose. Without this migration, users would be unable to install or use razd through vfox/mise version managers.

## Motivation
The plugin was initially developed for TursoDB but needs to be adapted for razd - a new CLI tool with different:
- GitHub repository location (razd-cli/razd)
- Release asset naming patterns (razd-v{version}-{platform}.{ext})
- Installation instructions and documentation

## Scope
- Update plugin metadata (name, description, homepage)
- Modify GitHub API endpoints and release parsing
- Adjust asset naming patterns for razd releases
- Update all user-facing documentation
- Preserve vfox plugin functionality and structure

## Out of Scope
- Changing vfox plugin API or structure
- Adding new features beyond basic migration
- Supporting non-standard razd installation methods

## Success Criteria
- Plugin successfully installs razd from GitHub releases
- All supported platforms (Windows x64, macOS x64/arm64, Linux x64/arm64) work correctly
- Documentation accurately reflects razd installation
- No references to TursoDB remain in user-facing content

## Timeline
Immediate - single iteration change

## Dependencies
- razd GitHub releases must be available at https://github.com/razd-cli/razd/releases
- Asset naming follows pattern: razd-v{version}-{platform}.{ext}
