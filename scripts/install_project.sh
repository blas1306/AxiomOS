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
            echo "Creating virtual environment..."
            python3 -m venv .venv
        fi

        if [ ! -f "requirements.txt" ]; then
            echo "requirements.txt not found."
            exit 1
        fi

        echo "Installing Python dependencies..."
        .venv/bin/pip install -r requirements.txt
        ;;

    latex)
        echo "LaTeX project detected."
        echo "No project dependencies to install yet."
        ;;

    julia)
        echo "Julia project detected."
        echo "Julia dependency installation not implemented yet."
        ;;

    physics_report)
        if [ ! -d ".venv" ]; then
            echo "Creating virtual environment..."
            python3 -m venv .venv
        fi

        if [ ! -f "requirements.txt" ]; then
            echo "requirements.txt not found."
            exit 1
        fi

        echo "Installing physics report dependencies..."
        .venv/bin/pip install -r requirements.txt
        ;;

    *)
        echo "Unknown project type: $TYPE"
        exit 1
        ;;
esac
