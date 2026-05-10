#!/bin/bash

PROJECT_FILE=".axiom/project.conf"

if [ ! -f "$PROJECT_FILE" ]; then
    echo "Not inside an AxiomOS project."
    exit 1
fi

source "$PROJECT_FILE"

case "$TYPE" in

    python)
        if [ ! -d ".venv" ]; then
            echo "Virtual environment not found."
            exit 1
        fi

        source .venv/bin/activate
        python main.py
        ;;

    latex)
        pdflatex main.tex
        ;;

    julia)
        julia main.jl
        ;;

    *)
        echo "Unknown project type: $TYPE"
        exit 1
        ;;

esac
