# vfox-plugin-tursodb

A [vfox](https://vfox.dev/) plugin for managing [TursoDB](https://github.com/tursodatabase/turso) CLI versions.

> TursoDB is an in-process SQL database written in Rust, compatible with SQLite.

⚠️ **Note**: TursoDB is currently in BETA. Use caution with production data and ensure you have backups.

## Prerequisites

- [vfox](https://vfox.dev/) version 0.3.0 or higher, or
- [mise](https://mise.jdx.dev/) (supports vfox plugins)

## Installation

### Using mise

Install the plugin:

```bash
mise plugin install tursodb https://github.com/dealenx/vfox-plugin-tursodb
```

Set global version:

```bash
mise use -g tursodb
```

Or install and use a specific version:

```bash
mise use -g tursodb@0.2.2
```

### Using vfox

Install the plugin:

```bash
vfox add tursodb
```

Or install from source:

```bash
vfox add --source https://github.com/dealenx/vfox-plugin-tursodb.git tursodb
```

## Usage

### With mise

```bash
# List available versions
mise ls-remote tursodb

# Install latest version
mise install tursodb@latest

# Install specific version
mise install tursodb@0.2.2

# Use globally
mise use -g tursodb@0.2.2

# Use in current project
mise use tursodb@0.2.2
```

### With vfox

```bash
# Search available versions
vfox search tursodb

# Install latest version
vfox install tursodb@latest

# Install specific version
vfox install tursodb@0.2.2

# Use in current shell session
vfox use tursodb@0.2.2

# Set global version
vfox use -g tursodb@0.2.2

# Set project-specific version
vfox use -p tursodb@0.2.2
```

### Verify installation

```bash
turso --version
```

## Quick Start with TursoDB

After installing TursoDB CLI with vfox, you can start using the interactive shell:

### 1. Launch the interactive shell

```bash
tursodb
```

This will start the Turso interactive shell:

```
Turso
Enter ".help" for usage hints.
Connected to a transient in-memory database.
Use ".open FILENAME" to reopen on a persistent database
turso>
```

### 2. Execute SQL statements

#### Create a table

```sql
CREATE TABLE users (id INT, username TEXT);
```

#### Insert data

```sql
INSERT INTO users VALUES (1, 'alice');
INSERT INTO users VALUES (2, 'bob');
```

#### Query data

```sql
SELECT * FROM users;
```

This will return:

```
1|alice
2|bob
```

### 3. Working with persistent databases

To work with a persistent database file:

```bash
tursodb my_database.db
```

For more information, see the [TursoDB Documentation](https://docs.turso.tech/tursodb/quickstart).

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

Make sure you've run `vfox use tursodb@<version>` to activate the version. Check that vfox is properly configured in your shell:

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
- [TursoDB Documentation](https://docs.turso.tech/tursodb/quickstart)
- [vfox Documentation](https://vfox.dev/)
- [Plugin Development Guide](https://vfox.dev/plugins/create/howto.html)
