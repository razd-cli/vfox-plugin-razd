# vfox-plugin-razd

[![Test mise Integration](https://github.com/razd-cli/vfox-plugin-razd/actions/workflows/test-mise.yaml/badge.svg)](https://github.com/razd-cli/vfox-plugin-razd/actions/workflows/test-mise.yaml)

A [vfox](https://vfox.dev/) plugin for managing [razd](https://github.com/razd-cli/razd) CLI versions.

> razd is a command-line interface tool for managing database schemas and migrations.

## Prerequisites

- [vfox](https://vfox.dev/) version 0.3.0 or higher, or
- [mise](https://mise.jdx.dev/) (supports vfox plugins)

## Installation

### Using mise

Install the plugin:

```bash
mise plugin install razd https://github.com/razd-cli/vfox-plugin-razd
```

Set global version:

```bash
mise use -g razd
```

Or install and use a specific version:

```bash
mise use -g razd@0.1.0
```

### Using vfox

Install the plugin:

```bash
vfox add razd
```

Or install from source:

```bash
vfox add --source https://github.com/razd-cli/vfox-plugin-razd.git razd
```

## Usage

### With mise

```bash
# List available versions
mise ls-remote razd

# Install latest version
mise install razd@latest

# Install specific version
mise install razd@0.1.0

# Use globally
mise use -g razd@0.1.0

# Use in current project
mise use razd@0.1.0
```

### With vfox

```bash
# Search available versions
vfox search razd

# Install latest version
vfox install razd@latest

# Install specific version
vfox install razd@0.1.0

# Use in current shell session
vfox use razd@0.1.0

# Set global version
vfox use -g razd@0.1.0

# Set project-specific version
vfox use -p razd@0.1.0
```

### Verify installation

```bash
razd --version
```

## Quick Start with razd

After installing razd CLI with vfox, you can start using it:

```bash
razd --help
```

For more information, see the [razd Documentation](https://github.com/razd-cli/razd).

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

Make sure you've run `vfox use razd@<version>` to activate the version. Check that vfox is properly configured in your shell:

```bash
# For bash/zsh
echo 'eval "$(vfox activate bash)"' >> ~/.bashrc  # or ~/.zshrc

# For fish
echo 'vfox activate fish | source' >> ~/.config/fish/config.fish

# For PowerShell
Add-Content $PROFILE 'Invoke-Expression "$(vfox activate pwsh)"'
```

### Unsupported platform error

This plugin currently supports Windows (x64), macOS (x64/arm64), and Linux (x64/arm64). If you're using a different platform or architecture, razd may not provide pre-built binaries for your system.

## Development

This plugin fetches version information and binaries from the [official razd GitHub releases](https://github.com/razd-cli/razd/releases).

## License

Apache 2.0

## Links

- [razd Official Repository](https://github.com/razd-cli/razd)
- [razd Documentation](https://github.com/razd-cli/razd)
- [vfox Documentation](https://vfox.dev/)
- [Plugin Development Guide](https://vfox.dev/plugins/create/howto.html)
