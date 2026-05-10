#!/bin/bash

SCRIPT_DIR="$(cd "$(dirname "${BASH_SOURCE[0]}")" && pwd)"
AXIOM_HOME="$(cd "$SCRIPT_DIR/.." && pwd)"

source "$AXIOM_HOME/scripts/lib/ui.sh"

TYPE="$1"

if [ -z "$TYPE" ]; then
    error "Usage: axiom init <type>"
    exit 1
fi

PROJECT_NAME="$(basename "$PWD")"

mkdir -p .axiom

cat > .axiom/project.conf <<EOF
TYPE=$TYPE
NAME=$PROJECT_NAME
EOF

case "$TYPE" in

    python)

        cp "$AXIOM_HOME/templates/python/scientific_script.py" main.py

        cat > requirements.txt <<EOF
numpy
matplotlib
scipy
sympy
pandas
EOF

        cat > .gitignore <<EOF
__pycache__/
*.pyc
.venv/
EOF

        python3 -m venv .venv

        success "Initialized Python project."
        ;;

    latex)

        cp "$AXIOM_HOME/templates/latex/article.tex" main.tex

        cat > .gitignore <<EOF
*.aux
*.log
*.out
*.toc
*.synctex.gz
EOF

        success "Initialized LaTeX project."
        ;;

    *)

        error "Unknown project type: $TYPE"
        exit 1
        ;;

esac

success "AxiomOS project initialized."
