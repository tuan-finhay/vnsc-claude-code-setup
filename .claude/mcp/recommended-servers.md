# Recommended MCP Servers

This document lists recommended Model Context Protocol (MCP) servers for enhanced Claude Code functionality.

## What are MCP Servers?

MCP servers extend Claude Code's capabilities by providing additional tools and context. They run locally and connect to Claude Code via the Model Context Protocol.

## Installation

Use the `claude mcp add` command to easily install MCP servers. This automatically configures them in your Claude Code settings.

## Recommended Servers

### 1. Context7 (Library Documentation & Code Examples)

**Purpose**: Provides up-to-date documentation and code examples for any library or framework.

**Repository**: [https://github.com/upstash/context7](https://github.com/upstash/context7)

**Installation**:

```bash
# Using HTTP transport (recommended)
claude mcp add --transport http context7 https://mcp.context7.com/mcp --header "CONTEXT7_API_KEY: YOUR_API_KEY" --scope user
```

Or using local server:

```bash
# Using local npx
claude mcp add context7 -- npx -y @upstash/context7-mcp --api-key YOUR_API_KEY
```

**Note**: Context7 requires an API key. Get yours at [context7.com](https://context7.com).

**Key Features**:
- Access to current library documentation
- Real-time code examples and best practices
- API usage patterns and references
- Multi-framework support

**Use Cases**:
- Looking up latest framework documentation
- Finding code examples for specific libraries
- Understanding API usage patterns
- Quick reference for library features

**Example Usage**:
- "Show me the latest React hooks documentation"
- "How do I use Prisma transactions?"
- "Give me examples of Next.js middleware"

---

### 2. Serena (Semantic Code Analysis & Editing)

**Purpose**: Provides IDE-like semantic code retrieval and editing tools for efficient codebase navigation and modification.

**Repository**: [https://github.com/oraios/serena](https://github.com/oraios/serena)

**Installation**:

```bash
# From your project directory
claude mcp add serena -- uvx --from git+https://github.com/oraios/serena serena start-mcp-server --context ide-assistant --project "$(pwd)"
```

**Important**: Run this command from your project root directory.

**Key Features**:
- **Semantic code understanding** via Language Server Protocol
- **Symbol-level navigation** (find definitions, references, implementations)
- **Targeted code editing** without reading entire files
- **25+ language support** (TypeScript, Python, Rust, Go, Java, etc.)
- **Token efficiency** - reduces context usage dramatically

**Use Cases**:
- Navigating large, complex codebases efficiently
- Finding symbol definitions and references across files
- Making precise code modifications without full file reads
- Understanding code structure through symbol analysis
- Reducing token consumption on large projects

**Why It Matters**:
- Traditional grep/search reads entire files, wasting tokens
- Serena uses language servers for precise, semantic code location
- Enables "IDE-like" understanding of code structure
- Particularly valuable for large codebases where context matters

**Example Usage**:
- "Find all references to the UserService class"
- "Show me the definition of the processPayment function"
- "Where is the authenticate method implemented?"
- "Insert this new method into the UserController class"

---

## Quick Setup Guide

### Step 1: Install Context7

```bash
# Get your API key from https://context7.com
claude mcp add --transport http context7 https://mcp.context7.com/mcp --header "CONTEXT7_API_KEY: YOUR_API_KEY"
```

### Step 2: Install Serena (Per Project)

```bash
# Navigate to your project directory
cd /path/to/your/project

# Install Serena for this project
claude mcp add serena -- uvx --from git+https://github.com/oraios/serena serena start-mcp-server --context ide-assistant --project "$(pwd)"
```

### Step 3: Verify Installation

```bash
# Restart Claude Code
# MCP servers should load automatically
# Check status bar or logs for confirmation
```

## Verification

After installing MCP servers:

1. Restart Claude Code
2. The MCP servers should load automatically
3. Context7 tools will be available for documentation queries
4. Serena tools will be available for semantic code analysis in your project

## Why These Two?

**Context7** and **Serena** complement each other perfectly:

- **Context7**: Helps understand *libraries and frameworks* you're using
- **Serena**: Helps understand *your own codebase* structure

Together, they provide:
- External knowledge (libraries, APIs, frameworks)
- Internal knowledge (your code structure, symbols, references)
- Significant token savings
- Enhanced code quality and accuracy

## Configuration Details

### Context7 Configuration

After installation, Context7 is configured globally and available across all projects. You can use either:
- **HTTP transport** (recommended): Faster, cloud-based
- **Local transport**: Runs locally via npx

### Serena Configuration

Serena is typically configured per-project because:
- It needs to know your project directory
- Language servers are project-specific
- Each project may use different languages

To use Serena in multiple projects, run the `claude mcp add` command in each project directory.

## Security Notes

- **Context7**: Requires an API key but doesn't access your code - only provides documentation
- **Serena**: Runs completely locally using your project's language servers
- No code is sent to external services with Serena
- Context7 only sends library names to fetch documentation

## Troubleshooting

### Context7 Issues

**API Key Error**:
```bash
# Ensure you have a valid API key from https://context7.com
# Replace YOUR_API_KEY with your actual key
```

**Server Not Responding**:
- Check your internet connection (for HTTP transport)
- Verify API key is correct
- Check Claude Code logs for errors

### Serena Issues

**Installation Fails**:
- Ensure you're in your project directory
- Check that `uvx` is installed (comes with `uv` package manager)
- Install `uv` if needed: `pip install uv`

**Language Not Supported**:
- Check supported languages at [Serena repository](https://github.com/oraios/serena)
- Some languages require additional language server setup
- See Serena documentation for language-specific requirements

**Performance Issues**:
- Serena may take a moment to index large codebases on first use
- This is normal and subsequent operations will be faster
- Language servers run in the background

### General MCP Issues

**Server Not Loading**:
```bash
# Check MCP server status
claude mcp list

# Remove and re-add if needed
claude mcp remove <server-name>
claude mcp add <server-name> [options]
```

**Conflicts with Existing Setup**:
- `claude mcp add` automatically handles configuration
- It updates `~/.claude/config.json` for you
- Manual edits to config.json are not needed

## Advanced Usage

### Updating MCP Servers

```bash
# Remove old version
claude mcp remove context7
claude mcp remove serena

# Add latest version
# (Use the installation commands above)
```

### Viewing Installed Servers

```bash
# List all installed MCP servers
claude mcp list
```

## Additional Resources

- [MCP Documentation](https://modelcontextprotocol.io)
- [Claude Code MCP Guide](https://docs.claude.com/en/docs/claude-code/mcp)
- [Context7 GitHub Repository](https://github.com/upstash/context7)
- [Serena GitHub Repository](https://github.com/oraios/serena)
- [Context7 Website](https://context7.com)
