#!/bin/bash

SCRIPT_DIR="$(cd "$(dirname "${BASH_SOURCE[0]}")" && pwd)"
AXIOM_HOME="$(cd "$SCRIPT_DIR/.." && pwd)"

source "$AXIOM_HOME/scripts/lib/project.sh"

load_project

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

    physics_report)
        if [ ! -f ".axiom/pipeline.conf" ]; then
            echo "Pipeline config not found: .axiom/pipeline.conf"
            exit 1
        fi

        source ".axiom/pipeline.conf"

        if [ ! -d ".venv" ]; then
            echo "Virtual environment not found. Run: axiom install"
            exit 1
        fi

        if [ -n "$RUN_PYTHON" ]; then
            echo "Running Python step: $RUN_PYTHON"
            .venv/bin/python "$RUN_PYTHON"
        fi

        if [ -n "$BUILD_LATEX" ]; then
            echo "Building LaTeX step: $BUILD_LATEX"

            LATEX_DIR="$(dirname "$BUILD_LATEX")"
            LATEX_FILE="$(basename "$BUILD_LATEX")"

            cd "$LATEX_DIR"
            pdflatex "$LATEX_FILE"
            cd - > /dev/null
        fi
        ;;

    *)
        echo "Unknown project type: $TYPE"
        exit 1
        ;;

esac
