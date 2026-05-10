#!/bin/bash

PROJECT_FILE=".axiom/project.conf"

if [ ! -f "$PROJECT_FILE" ]; then
    echo "Not inside an AxiomOS project."
    exit 1
fi

source "$PROJECT_FILE"

case "$TYPE" in

    latex)
        echo "Cleaning LaTeX build files..."

        rm -f *.aux
        rm -f *.log
        rm -f *.out
        rm -f *.toc
        rm -f *.synctex.gz

        echo "Done."
        ;;

    python)
        echo "Cleaning Python cache..."

        find . -type d -name "__pycache__" -exec rm -rf {} +

        echo "Done."
        ;;

    julia)
        echo "No clean step implemented for Julia yet."
        ;;

    *)
        echo "Unknown project type: $TYPE"
        exit 1
        ;;

esac
