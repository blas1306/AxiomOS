#!/bin/bash

PROJECT_FILE=".axiom/project.conf"

if [ ! -f "$PROJECT_FILE" ]; then
    echo "Not inside an AxiomOS project."
    exit 1
fi

source "$PROJECT_FILE"

echo "AxiomOS Project"
echo
echo "Name: $NAME"
echo "Type: $TYPE"
echo "Location: $(pwd)"
