#!/bin/bash

NAME="$1"

SCRIPT_DIR="$(cd "$(dirname "${BASH_SOURCE[0]}")" && pwd)"
AXIOM_HOME="$(cd "$SCRIPT_DIR/../.." && pwd)"

DEST="$HOME/Workspace/LaTeX/$NAME"

mkdir -p "$DEST"
mkdir -p "$DEST/.axiom"

cat > "$DEST/.axiom/project.conf" <<EOF
TYPE=latex
NAME=$NAME
EOF

cp "$AXIOM_HOME/templates/latex/article.tex" "$DEST/main.tex"

cat > "$DEST/README.md" <<EOF
# $NAME

Created with AxiomOS.
EOF

cat > "$DEST/.gitignore" <<EOF
*.aux
*.log
*.out
*.toc
*.synctex.gz
EOF

git init "$DEST" > /dev/null 2>&1

echo "Project created:"
echo "$DEST"
