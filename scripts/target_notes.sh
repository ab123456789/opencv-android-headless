#!/usr/bin/env bash
set -euo pipefail

cat <<'EOF'
Current target:
  Android / Termux / Python 3.13 / headless OpenCV

Reality check:
  Building OpenCV itself for Android is straightforward compared with making
  the Python binding load inside Termux Python 3.13.

What must match:
  - Android ABI
  - API level
  - Python 3.13 headers
  - libpython3.13
  - extension suffix / packaging path
  - runtime linker paths in the final environment

Recommendation:
  Treat this repo as a build scaffold first.
  Validate core build logs and produced .so files.
  Then align against the exact Termux Python 3.13 environment.
EOF
