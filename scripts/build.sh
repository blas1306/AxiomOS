#!/bin/bash

PROJECT_FILE=".axiom/project.conf"

if [ ! -f "$PROJECT_FILE" ]; then
    echo "Not inside an AxiomOS project."
    exit 1
fi

source "$PROJECT_FILE"

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

    *)
        echo "Unknown project type: $TYPE"
        exit 1
        ;;
esac
