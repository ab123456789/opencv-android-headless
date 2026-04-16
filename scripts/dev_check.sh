#!/usr/bin/env bash
set -euo pipefail

ROOT="$(cd "$(dirname "$0")/.." && pwd)"
cd "$ROOT"

chmod +x scripts/*.sh

git status --short || true

echo
echo "Repository scaffold ready at: $ROOT"
echo "Next steps:"
echo "  1. review .github/workflows/build.yml"
echo "  2. git add . && git commit -m 'feat: add android termux opencv build scaffold'"
echo "  3. add GitHub remote"
echo "  4. push and run workflow_dispatch"
