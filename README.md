# Claude Code Team Setup

A shared repository containing best practices, configurations, and recommended setup for using Claude Code within our team.

## Purpose

This repository provides standardized configurations and guidelines to ensure:
- **Consistent coding standards** across the team
- **Optimized Claude Code performance** with smart permissions and hooks
- **Security best practices** to prevent accidental exposure of sensitive data
- **Enhanced capabilities** through recommended MCP servers

## What's Included

### 📋 Commit Standards (`.claude/CLAUDE.md`)
- Conventional Commits format enforcement
- Atomic commits guidelines
- Clear commit message standards

### 🔒 Security & Permissions (`.claude/settings.local.json`)
- Blocks access to sensitive files (`.env`, credentials)
- Prevents reading large build artifacts and dependencies
- Reduces token waste

### 🛡️ Bash Command Validation (`.claude/scripts/validate-bash.sh`)
- Validates bash commands before execution
- Blocks forbidden patterns and paths
- Prevents accidental exposure of secrets

### 🔌 MCP Server Recommendations (`.claude/mcp/recommended-servers.md`)
- **Context7**: Library documentation and code examples
- **Serena**: Semantic code analysis and IDE-like editing

## Quick Start

### 1. User-Scope Setup (One-time, applies to all projects)

Copy the `.claude/` directory to your home directory:

```bash
# Clone this repository
git clone <repository-url> claude-code-setup
cd claude-code-setup

# Copy to user scope (applies to all projects)
cp -r .claude ~/.claude

# Make validation script executable
chmod +x ~/.claude/scripts/validate-bash.sh
```

This will apply the standards, permissions, and hooks to **all your projects**.

### 2. Install MCP Servers

**Context7** (User-scope - One-time setup):
```bash
# Get your API key from https://context7.com
claude mcp add --transport http context7 https://mcp.context7.com/mcp --header "CONTEXT7_API_KEY: YOUR_API_KEY" --scope user
```

**Serena** (Project-scope - Run from each project directory):
```bash
cd /path/to/your/project
claude mcp add serena -- uvx --from git+https://github.com/oraios/serena serena start-mcp-server --context ide-assistant --project "$(pwd)"
```

See [`.claude/mcp/recommended-servers.md`](./.claude/mcp/recommended-servers.md) for detailed setup instructions.

### 3. Verify Setup

1. Open any project with Claude Code
2. Hooks and permissions should be active globally
3. MCP servers should load (check status bar)
4. Try making a commit - it should follow Conventional Commits format

## Repository Structure

```
.
├── README.md                          # This file
└── .claude/
    ├── CLAUDE.md                      # Git commit standards
    ├── settings.local.json            # Permissions & hooks
    ├── mcp/
    │   └── recommended-servers.md     # MCP server guide
    └── scripts/
        └── validate-bash.sh           # Bash validation hook
```

## User vs Project Scope

### User-Scope (Global)
Copy to `~/.claude/` - applies to **all projects**:
- ✅ Commit standards (`CLAUDE.md`)
- ✅ Security permissions (`settings.local.json`)
- ✅ Bash validation hook (`scripts/validate-bash.sh`)
- ✅ Context7 MCP server

### Project-Scope (Per-project)
Install in **each project**:
- ✅ Serena MCP server (requires project directory context)

## MCP Servers

### Context7 - Library Documentation
- Instant access to up-to-date library documentation
- Code examples and best practices
- **Setup**: One-time global installation

### Serena - Semantic Code Analysis
- IDE-like code navigation using Language Server Protocol
- Find symbols, definitions, and references efficiently
- Dramatically reduces token usage on large codebases
- **Setup**: Per-project installation

## Customization

### Global Customization
Edit `~/.claude/settings.local.json` to:
- Add user-wide file exclusions
- Allow additional trusted domains
- Add custom hooks

### Project-Specific Overrides
Create `.claude/settings.local.json` in individual projects to override global settings for specific projects only.

## Best Practices

### For Team Members

1. **Complete user-scope setup once** - applies to all your projects
2. **Follow Conventional Commits format** - it's enforced automatically
3. **Install Context7 once** - available globally
4. **Install Serena per project** - for semantic code analysis
5. **Keep atomic commits** - one logical change per commit

### For Team Leads

1. Keep this repository updated with team standards
2. Document new patterns as they emerge
3. Review and approve changes to core settings
4. Ensure team members have Context7 API keys

## Troubleshooting

### Hook Not Running
```bash
chmod +x ~/.claude/scripts/validate-bash.sh
```

### Check MCP Servers
```bash
claude mcp list
```

### Reinstall MCP Server
```bash
claude mcp remove <server-name>
# Run installation command again
```

For detailed troubleshooting, see [`.claude/mcp/recommended-servers.md`](./.claude/mcp/recommended-servers.md).

## Resources

- [Claude Code Documentation](https://docs.claude.com/claude-code)
- [Conventional Commits](https://www.conventionalcommits.org/)
- [Context7](https://github.com/upstash/context7)
- [Serena](https://github.com/oraios/serena)

## Contributing

1. Create a branch with your changes
2. Follow our commit standards
3. Submit a pull request
4. Wait for team review

## Support

For questions or issues:
- Open an issue in this repository
- Contact the team lead
- Check Claude Code documentation
