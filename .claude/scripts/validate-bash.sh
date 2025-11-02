#!/bin/bash

# Read JSON input from stdin
INPUT=$(cat)

# Extract the command from JSON - correct path
COMMAND=$(echo "$INPUT" | jq -r '.tool_input.command // empty')

# If no command found, allow it
if [ -z "$COMMAND" ]; then
  exit 0
fi

# Define forbidden patterns to prevent accessing files/folders that waste tokens
# These patterns are checked against bash commands to block unnecessary file access
FORBIDDEN_PATTERNS=(
  # === Environment & Secrets ===
  "\.env"                    # Environment variables (may contain secrets)

  # === Version Control ===
  "\.git/"                   # Git internal files
  "\.DS_Store"               # macOS metadata files

  # === Node.js / JavaScript / TypeScript ===
  "node_modules"             # Node dependencies (can be huge)
  "frontend/node_modules"    # Frontend-specific node dependencies
  "package-lock\.json"       # NPM lock file (typically very large)
  "yarn\.lock"               # Yarn lock file
  "\.next/"                  # Next.js build output
  "\.turbo/"                 # Turborepo cache
  "dist/"                    # JavaScript build output
  "build/"                   # Build artifacts
  "out/"                     # Output directory

  # === Python ===
  "__pycache__"              # Python bytecode cache
  "venv/"                    # Python virtual environment
  "env/"                     # Alternative virtual environment name
  "\.pyc$"                   # Compiled Python files
  "\.pytest_cache"           # Pytest cache directory
  "\.mypy_cache"             # MyPy type checker cache
  "\.tox/"                   # Tox testing tool cache
  "\.egg-info"               # Python package metadata
  "\.coverage"               # Coverage.py data files

  # === Java / Kotlin ===
  "target/"                  # Maven build output
  "bin/"                     # Compiled binaries
  "\.gradle/"                # Gradle cache and build files
  "\.class$"                 # Compiled Java class files
  "\.jar$"                   # Java archive files
  "\.war$"                   # Java web application archive
  "\.ear$"                   # Java enterprise archive

  # === Android (Kotlin/Java) ===
  "\.cxx/"                   # C++ build artifacts in Android
  "\.externalNativeBuild/"   # Android native build output
  "\.apk$"                   # Android package files
  "\.aab$"                   # Android app bundle files

  # === iOS / Swift ===
  "\.build/"                 # Swift build directory
  "DerivedData/"             # Xcode derived data (build artifacts)
  "Pods/"                    # CocoaPods dependencies
  "Carthage/"                # Carthage dependencies
  "\.ipa$"                   # iOS app archive
  "\.dSYM"                   # Debug symbols

  # === Flutter / Dart ===
  "\.dart_tool/"             # Dart tool cache
  "android/app/build/"       # Flutter Android build output
  "ios/Pods/"                # Flutter iOS CocoaPods
  "ios/build/"               # Flutter iOS build output

  # === General Development ===
  "coverage/"                # Code coverage reports
  "\.csv$"                   # CSV data files (can be large)
  "\.log$"                   # Log files
)

# Check if command contains any forbidden patterns
for pattern in "${FORBIDDEN_PATTERNS[@]}"; do
  if echo "$COMMAND" | grep -qE "$pattern"; then
    echo "ERROR: Access to '$pattern' is blocked by security policy" >&2
    exit 2  # Exit code 2 = blocking error
  fi
done

# Command is clean, allow it
exit 0