#!/bin/bash

NAME="$1"

SCRIPT_DIR="$(cd "$(dirname "${BASH_SOURCE[0]}")" && pwd)"
AXIOM_HOME="$(cd "$SCRIPT_DIR/../.." && pwd)"

DEST="$HOME/Workspace/Research/$NAME"

mkdir -p "$DEST"
mkdir -p "$DEST/.axiom"

mkdir -p "$DEST/data"
mkdir -p "$DEST/figures"
mkdir -p "$DEST/src"
mkdir -p "$DEST/report"

cat > "$DEST/.axiom/project.conf" <<EOF
TYPE=physics_report
NAME=$NAME
EOF

cat > "$DEST/.axiom/pipeline.conf" <<EOF
RUN_PYTHON=src/generate_plot.py
BUILD_LATEX=report/main.tex
EOF

python3 -m venv "$DEST/.venv"

cat > "$DEST/requirements.txt" <<EOF
numpy
matplotlib
EOF

cp "$AXIOM_HOME/templates/reports/physics/main.tex" \
   "$DEST/report/main.tex"

cp "$AXIOM_HOME/templates/reports/physics/src/generate_plot.py" \
   "$DEST/src/generate_plot.py"

cat > "$DEST/README.md" <<EOF
# $NAME

Physics report project created with AxiomOS.
EOF

cat > "$DEST/.gitignore" <<EOF
.venv/
__pycache__/
*.pyc

*.aux
*.log
*.out
*.toc
*.synctex.gz
EOF

git init "$DEST" > /dev/null 2>&1

echo "Physics report project created:"
echo "$DEST"