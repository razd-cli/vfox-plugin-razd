# vfox-plugin-turbodb

A [vfox](https://vfox.dev/) plugin for managing [TursoDB](https://github.com/tursodatabase/turso) CLI versions.

> TursoDB is an in-process SQL database written in Rust, compatible with SQLite.

⚠️ **Note**: TursoDB is currently in BETA. Use caution with production data and ensure you have backups.

## Prerequisites

- [vfox](https://vfox.dev/) version 0.3.0 or higher

## Installation

Install the plugin:

```bash
vfox add turbodb
```

Or install from source:

```bash
vfox add --source https://github.com/dealenx/vfox-plugin-turbodb.git turbodb
```

## Usage

### Search available versions

```bash
vfox search turbodb
```

### Install a specific version

```bash
# Install latest version
vfox install turbodb@latest

# Install specific version
vfox install turbodb@0.2.2
```

### Use a version

```bash
# Use in current shell session
vfox use turbodb@0.2.2

# Set global version
vfox use -g turbodb@0.2.2

# Set project-specific version
vfox use -p turbodb@0.2.2
```

### Verify installation

```bash
turso --version
```

## Platform Support

| Platform | Architecture | Supported |
|----------|-------------|-----------|
| Windows  | x64         | ✅        |
| macOS    | Intel (x64) | ✅        |
| macOS    | Apple Silicon (arm64) | ✅ |
| Linux    | x64         | ✅        |
| Linux    | arm64       | ✅        |

## Troubleshooting

### Command not found after installation

Make sure you've run `vfox use turbodb@<version>` to activate the version. Check that vfox is properly configured in your shell:

```bash
# For bash/zsh
echo 'eval "$(vfox activate bash)"' >> ~/.bashrc  # or ~/.zshrc

# For fish
echo 'vfox activate fish | source' >> ~/.config/fish/config.fish

# For PowerShell
Add-Content $PROFILE 'Invoke-Expression "$(vfox activate pwsh)"'
```

### Unsupported platform error

This plugin currently supports Windows (x64), macOS (x64/arm64), and Linux (x64/arm64). If you're using a different platform or architecture, TursoDB may not provide pre-built binaries for your system.

## Development

This plugin fetches version information and binaries from the [official TursoDB GitHub releases](https://github.com/tursodatabase/turso/releases).

## License

Apache 2.0

## Links

- [TursoDB Official Repository](https://github.com/tursodatabase/turso)
- [vfox Documentation](https://vfox.dev/)
- [Plugin Development Guide](https://vfox.dev/plugins/create/howto.html)
