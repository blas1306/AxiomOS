#!/bin/bash

NAME="$1"
shift || true

SCRIPT_DIR="$(cd "$(dirname "${BASH_SOURCE[0]}")" && pwd)"
AXIOM_HOME="$(cd "$SCRIPT_DIR/../.." && pwd)"

INSTALL_DEPS=false

for arg in "$@"; do
    case "$arg" in
        --install)
            INSTALL_DEPS=true
            ;;
        *)
            echo "Unknown option: $arg"
            exit 1
            ;;
    esac
done

DEST="$HOME/Workspace/Programming/$NAME"

mkdir -p "$DEST"
mkdir -p "$DEST/.axiom"

cat > "$DEST/.axiom/project.conf" <<EOF
TYPE=python
NAME=$NAME
EOF

cp "$AXIOM_HOME/templates/python/scientific_script.py" "$DEST/main.py"

cat > "$DEST/README.md" <<EOF
# $NAME

Created with AxiomOS.
EOF

cat > "$DEST/.gitignore" <<EOF
__pycache__/
*.pyc
.venv/
EOF

cat > "$DEST/requirements.txt" <<EOF
numpy
matplotlib
scipy
sympy
pandas
EOF

python3 -m venv "$DEST/.venv"

if [ "$INSTALL_DEPS" = true ]; then
    "$DEST/.venv/bin/pip" install -r "$DEST/requirements.txt"
fi

git init "$DEST" > /dev/null 2>&1

echo "Project created:"
echo "$DEST"
