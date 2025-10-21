# Design: TursoDB Plugin Architecture

## Overview
This design describes the architecture and technical decisions for implementing a vfox plugin that manages TursoDB CLI installations across multiple platforms.

## Architecture Components

### 1. Plugin Metadata (metadata.lua)
**Purpose**: Define plugin identity and configuration

**Key Decisions**:
- Plugin name: "tursodb" (lowercase, consistent with vfox conventions)
- Target minRuntimeVersion: 0.3.0 (supports required hooks)
- Distribution: GitHub releases (self-hosted manifest)

### 2. Version Discovery (hooks/available.lua)
**Purpose**: List all available TursoDB CLI versions

**Technical Approach**:
- Data Source: GitHub Releases API (`https://api.github.com/repos/tursodatabase/turso/releases`)
- Caching: Rely on vfox's built-in 12-hour cache
- Version Parsing: Extract version from tag name (e.g., `v0.2.2` → `0.2.2`)
- Filtering: Include all non-draft releases

**Data Flow**:
```
GitHub API → Parse JSON → Extract versions → Format for vfox → Return array
```

**Error Handling**:
- API unavailable: Return empty array, vfox will prompt user
- Malformed response: Log error, return empty array
- Rate limiting: Leverage vfox cache to minimize requests

### 3. Installation Resolution (hooks/pre_install.lua)
**Purpose**: Determine download URL and metadata for requested version

**Technical Approach**:
- Platform Detection: Use vfox runtime OS detection
- Architecture Detection: Use vfox runtime architecture info
- URL Construction: Map platform/arch to GitHub release asset names

**Platform/Architecture Matrix**:
| Platform | Architecture | Asset Name Pattern |
|----------|-------------|-------------------|
| Windows | x86_64 | `turso_cli-{version}-x86_64-pc-windows-msvc.zip` |
| macOS | x86_64 | `turso_cli-{version}-x86_64-apple-darwin.tar.gz` |
| macOS | aarch64 | `turso_cli-{version}-aarch64-apple-darwin.tar.gz` |
| Linux | x86_64 | `turso_cli-{version}-x86_64-unknown-linux-gnu.tar.gz` |
| Linux | aarch64 | `turso_cli-{version}-aarch64-unknown-linux-gnu.tar.gz` |

**Assumptions**:
- GitHub releases follow consistent naming conventions
- Checksums may not be available in release assets (optional field)
- vfox handles archive extraction automatically

**Fallback Strategy**:
- Unsupported platform: Return error message in note field
- Missing asset: Return error, suggest latest compatible version

### 4. Environment Configuration (hooks/env_keys.lua)
**Purpose**: Configure PATH to include turso binary

**Technical Approach**:
- Binary Location: Extracted binaries are placed in SDK root
- PATH Strategy: Add single PATH entry pointing to binary directory
- Cross-platform: Same logic works for Windows and Unix-like systems

**Configuration**:
```lua
{
    key = "PATH",
    value = mainPath .. "/bin"  -- or mainPath depending on extraction structure
}
```

**Binary Location Discovery**:
- Need to verify actual extraction structure from archives
- Common patterns:
  - Archive contains `bin/turso` → use `mainPath .. "/bin"`
  - Archive contains `turso` directly → use `mainPath`

### 5. HTTP Utilities (lib/util.lua)
**Purpose**: Provide reusable HTTP and data processing functions

**Functions**:
1. `fetchGitHubReleases()`: GET request to GitHub API
2. `parseReleases(json)`: Parse JSON response into version array
3. `getAssetName(version, os, arch)`: Generate platform-specific asset name
4. `platformInfo()`: Detect and return current OS and architecture

**Dependencies**:
- vfox HTTP library (built-in)
- vfox JSON library (built-in)

**Error Handling**:
- Network errors: Return nil + error message
- JSON parsing errors: Return nil + error message
- Validation: Check response structure before parsing

## Trade-offs and Decisions

### Decision 1: GitHub API vs Installer Scripts
**Choice**: Use GitHub Releases API
**Rationale**: 
- vfox plugins expect direct binary downloads
- Installer scripts add complexity and platform-specific logic
- API provides structured, parseable data
- Consistent with other vfox plugins

**Trade-off**: Requires manual version mapping instead of script automation

### Decision 2: Checksum Validation
**Choice**: Optional, only if provided in releases
**Rationale**:
- GitHub releases may not include checksums
- vfox supports optional validation
- TLS ensures download integrity
- Can be added later if TursoDB publishes checksums

**Trade-off**: Slightly lower security guarantee

### Decision 3: Legacy Version Files
**Choice**: Not implemented initially
**Rationale**:
- TursoDB is new, no established version file conventions
- Can be added in future change if needed
- Keeps initial implementation simpler

**Trade-off**: Users can't auto-select versions from project files

### Decision 4: Platform Support
**Choice**: Windows, macOS (both architectures), Linux (x64, arm64)
**Rationale**:
- Matches TursoDB's official release targets
- Covers 95%+ of development environments
- vfox provides platform detection

**Trade-off**: No support for other Linux architectures (can be added)

## Testing Strategy

### Manual Testing
1. Test each platform independently
2. Verify binary extraction structure
3. Confirm PATH configuration works
4. Test version switching

### Validation Points
- Available hook returns valid versions
- PreInstall hook generates correct URLs
- Downloaded archives contain expected binaries
- turso command executes after installation
- Multiple versions can coexist

## Future Enhancements
1. Add checksum validation when available
2. Support legacy version files (`.turso-version` or similar)
3. Add more Linux architecture variants
4. Implement smart caching for release info
5. Add release notes display in Available hook

## References
- TursoDB GitHub: https://github.com/tursodatabase/turso
- vfox Plugin Guide: https://vfox.dev/plugins/create/howto.html
- GitHub Releases API: https://docs.github.com/en/rest/releases/releases
