# Git Commit Standards

## Commit Message Format

Always use Conventional Commits format for all git commits:

```
<type>(<scope>): <subject>

<body>

<footer>
```

### Types

- **feat**: A new feature
- **fix**: A bug fix
- **docs**: Documentation only changes
- **style**: Changes that don't affect code meaning (formatting, whitespace, etc.)
- **refactor**: Code change that neither fixes a bug nor adds a feature
- **perf**: Performance improvement
- **test**: Adding or correcting tests
- **chore**: Changes to build process or auxiliary tools
- **ci**: Changes to CI configuration files and scripts
- **build**: Changes that affect the build system or external dependencies

### Rules

- Use lowercase for type and subject
- Subject line: max 50 characters, no period at end
- Use imperative mood ("add" not "added" or "adds")
- Include scope in parentheses when relevant (optional but recommended)
- Body: wrap at 72 characters, explain what and why (optional)
- Footer: reference issues, breaking changes (optional)
- **Do NOT include Claude Code credits, attribution, or "Generated with Claude Code" links in commit messages**

### Examples

```
feat(auth): add JWT token validation
fix(api): resolve race condition in user creation
docs: update README with installation steps
refactor(database): simplify query builder interface
test(user): add unit tests for registration flow
chore(deps): upgrade react to v18.2.0
```

### Breaking Changes

If introducing breaking changes, add `BREAKING CHANGE:` in the footer or add `!` after type/scope:

```
feat(api)!: remove deprecated v1 endpoints

BREAKING CHANGE: v1 API endpoints have been removed. Migrate to v2.
```
### Atomic Commits

  - **One logical change per commit**: Each commit should have a single, clear purpose
  - **Complete changes**: Include related tests and documentation in the same commit
  - **Self-contained**: The codebase should work after each commit (tests pass)
  - **Focused scope**: If you need "and" to describe the commit, it's probably too large

  **Examples:**
  - ✅ Good: `feat(cart): add item quantity validation`
  - ❌ Bad: `feat: add validation and fix styling and update deps`

  **When to combine changes in one commit:**
  - A feature + its tests
  - A refactor + updates to affected code
  - A fix + the test that verifies it

  **When to split into separate commits:**
  - Unrelated bug fixes
  - Different features
  - Code formatting changes (separate from logic changes)