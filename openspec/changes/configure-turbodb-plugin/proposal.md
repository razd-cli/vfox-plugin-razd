# Configure TursoDB Plugin

## Why
The current vfox plugin is based on a generic template and needs to be configured to install and manage TursoDB (Turso Database CLI). TursoDB is an in-process SQL database written in Rust, compatible with SQLite, and requires a vfox plugin to enable version management across multiple platforms (Windows, macOS, Linux).

## What Changes
- Update plugin metadata to reflect TursoDB identity (name, description, homepage)
- Implement version discovery from GitHub releases API
- Configure download URLs for pre-built binaries based on platform and architecture
- Set up PATH environment variables for the `turso` CLI binary
- Remove template placeholder code and implement production-ready hooks
- Add HTTP utilities for fetching release information from GitHub

## Impact
- **Affected specs**: `plugin-metadata`, `version-discovery`, `installation`, `environment-setup`
- **Affected code**: 
  - `metadata.lua` - plugin identity and configuration
  - `hooks/available.lua` - version listing from GitHub releases
  - `hooks/pre_install.lua` - download URL resolution and binary selection
  - `hooks/env_keys.lua` - PATH configuration for turso binary
  - `lib/util.lua` - HTTP utilities for GitHub API interaction
  - `hooks/post_install.lua` - cleanup (can be removed if not needed)

## Dependencies
- GitHub Releases API for version information
- vfox HTTP library for API requests
- Platform detection capabilities from vfox runtime

## User Benefits
- Easy installation and version management of TursoDB CLI
- Cross-platform support (Windows, macOS, Linux)
- Automatic version discovery from official releases
- Simple version switching with `vfox use turbodb@version`
