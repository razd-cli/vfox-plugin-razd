# Project Context

## Purpose
This is a vfox plugin for managing TursoDB (Turso Database) CLI installations. The plugin enables developers to easily install, manage, and switch between different versions of TursoDB CLI across multiple platforms (Windows, macOS, Linux).

## Tech Stack
- Lua (5.1+ compatible) - Plugin implementation language
- vfox - Version management framework
- GitHub Releases API - Source for version information and binaries

## Project Conventions

### Code Style
- Lua naming: snake_case for functions and variables
- Follow vfox plugin conventions and hook signatures
- Use descriptive variable names
- Add comments for complex logic

### Architecture Patterns
- Hook-based architecture following vfox plugin specification
- Separation of concerns: metadata, discovery, installation, environment setup
- Utility functions in lib/ directory for reusability
- Platform detection and conditional logic for cross-platform support

### Testing Strategy
- Manual testing using vfox commands (`search`, `install`, `use`)
- Test on multiple platforms (Windows, macOS, Linux)
- Verify binary accessibility after installation
- Test version switching between multiple installed versions

### Git Workflow
- main branch for stable releases
- Use semantic versioning tags (vX.Y.Z format)
- GitHub Actions CI for automated packaging and publishing

## Domain Context
- **TursoDB**: An in-process SQL database written in Rust, compatible with SQLite
- **vfox**: Cross-platform version manager supporting custom plugins
- **GitHub Releases**: Distribution mechanism for TursoDB CLI binaries
- Target users: Developers using TursoDB in their projects who need version management

## Important Constraints
- Must support vfox runtime >= 0.3.0
- Cannot execute arbitrary code during installation (vfox restriction)
- Must rely on pre-built binaries from GitHub releases
- Platform/architecture detection relies on vfox runtime capabilities
- Network connectivity required for version discovery and downloads

## External Dependencies
- GitHub Releases API (https://api.github.com/repos/tursodatabase/turso/releases)
- TursoDB release assets following naming convention:
  - turso_cli-{version}-{arch}-{platform}-{toolchain}.{ext}
- vfox built-in libraries: HTTP, JSON, archive extraction
