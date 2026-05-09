#!/bin/bash

SCRIPT_DIR="$(cd "$(dirname "${BASH_SOURCE[0]}")" && pwd)"
AXIOM_HOME="$(dirname "$SCRIPT_DIR")"

TYPE="$1"
NAME="$2"

if [ -z "$TYPE" ] || [ -z "$NAME" ]; then
    echo "Usage:"
    echo "./create_project.sh <type> <name>"
    exit 1
fi

case "$TYPE" in

    latex)
        DEST="$HOME/Workspace/LaTeX/$NAME"

        mkdir -p "$DEST"

        cp "$AXIOM_HOME/templates/latex/article.tex" "$DEST/main.tex"

        ;;

    python)
        DEST="$HOME/Workspace/Programming/$NAME"

        mkdir -p "$DEST"

        cp "$AXIOM_HOME/templates/python/scientific_script.py" "$DEST/main.py"

        ;;

    julia)
        DEST="$HOME/Workspace/Programming/$NAME"

        mkdir -p "$DEST"

        cp "$AXIOM_HOME/templates/julia/scientific_script.jl" "$DEST/main.jl"

        ;;

    *)
        echo "Unknown project type."
        exit 1
        ;;

esac

echo "Project created:"
echo "$DEST"
