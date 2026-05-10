#!/bin/bash

PROJECT_FILE=".axiom/project.conf"

if [ ! -f "$PROJECT_FILE" ]; then
    echo "Not inside an AxiomOS project."
    exit 1
fi

if command -v code >/dev/null 2>&1; then
    echo "Opening project in VS Code..."
    code .
else
    echo "VS Code not found."
    exit 1
fi
