#!/bin/bash

source "$AXIOM_HOME/scripts/lib/ui.sh"

require_project() {
    if [ ! -f ".axiom/project.conf" ]; then
        error "Not inside an AxiomOS project."
        exit 1
    fi

    source ".axiom/project.conf"
}

require_venv() {
    if [ ! -d ".venv" ]; then
        error "Virtual environment not found. Run: axiom install"
        exit 1
    fi
}

usage_error() {
    error "$1"
    exit 1
}
