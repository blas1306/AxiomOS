#!/bin/bash

load_project() {

    PROJECT_FILE=".axiom/project.conf"

    if [ ! -f "$PROJECT_FILE" ]; then
        echo "Not inside an AxiomOS project."
        exit 1
    fi

    source "$PROJECT_FILE"
}
