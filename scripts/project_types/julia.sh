#!/bin/bash

NAME="$1"

SCRIPT_DIR="$(cd "$(dirname "${BASH_SOURCE[0]}")" && pwd)"
AXIOM_HOME="$(cd "$SCRIPT_DIR/../.." && pwd)"

DEST="$HOME/Workspace/Programming/$NAME"

mkdir -p "$DEST"
mkdir -p "$DEST/.axiom"

cat > "$DEST/.axiom/project.conf" <<EOF
TYPE=julia
NAME=$NAME
EOF

cp "$AXIOM_HOME/templates/julia/scientific_script.jl" "$DEST/main.jl"

cat > "$DEST/README.md" <<EOF
# $NAME

Created with AxiomOS.
EOF

cat > "$DEST/.gitignore" <<EOF
Manifest.toml
EOF

git init "$DEST" > /dev/null 2>&1

echo "Project created:"
echo "$DEST"
