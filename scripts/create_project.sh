#!/bin/bash

SCRIPT_DIR="$(cd "$(dirname "${BASH_SOURCE[0]}")" && pwd)"
AXIOM_HOME="$(dirname "$SCRIPT_DIR")"

TYPE="$1"
NAME="$2"

INSTALL_DEPS=false

shift 2 || true

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

if [ -z "$TYPE" ] || [ -z "$NAME" ]; then
    echo "Usage:"
    echo "./create_project.sh <type> <name>"
    echo
    echo "Available types: latex, python, julia"
    exit 1
fi

case "$TYPE" in

    latex)
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
        ;;

    python)
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
        ;;

    julia)
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
        ;;

    *)
        echo "Unknown project type: $TYPE"
        echo "Available types: latex, python, julia"
        exit 1
        ;;

esac

echo "Project created:"
echo "$DEST"