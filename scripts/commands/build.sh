#!/bin/bash

SCRIPT_DIR="$(cd "$(dirname "${BASH_SOURCE[0]}")" && pwd)"
AXIOM_HOME="$(cd "$SCRIPT_DIR/../.." && pwd)"

source "$AXIOM_HOME/scripts/lib/project.sh"
source "$AXIOM_HOME/scripts/lib/cli.sh"

require_project

case "$TYPE" in
    latex)
        if [ ! -f "main.tex" ]; then
            echo "main.tex not found."
            exit 1
        fi

        echo "Building LaTeX project..."
        pdflatex main.tex
        ;;

    python)
        echo "Python projects do not need build step."
        ;;

    julia)
        echo "Julia projects do not need build step yet."
        ;;

    physics_report)
        if [ ! -f "report/main.tex" ]; then
            echo "report/main.tex not found."
            exit 1
        fi

        echo "Building physics report..."

        cd report
        pdflatex main.tex
        ;;

    *)
        echo "Unknown project type: $TYPE"
        exit 1
        ;;
esac
