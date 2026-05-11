#!/bin/bash

SCRIPT_DIR="$(cd "$(dirname "${BASH_SOURCE[0]}")" && pwd)"
AXIOM_HOME="$(cd "$SCRIPT_DIR/../.." && pwd)"

source "$AXIOM_HOME/scripts/lib/ui.sh"

if [ "$1" = "new" ]; then
    info "axiom new"
    echo
    echo "Usage:"
    echo "  axiom new <type> <name> [options]"
    echo
    echo "Project types:"
    echo "  latex"
    echo "  python"
    echo "  julia"
    echo "  physics_report"
    echo
    echo "Examples:"
    echo "  axiom new python MyProject --install"
    echo "  axiom new physics_report Electrostatica"
    exit 0
fi

if [ "$1" = "logs" ]; then
    info "axiom logs"
    echo
    echo "Usage:"
    echo "  axiom logs [option]"
    echo
    echo "Options:"
    echo "  --latest   Open latest log"
    echo "  --list     List logs"
    echo "  --tail     Show last 50 lines"
    echo "  --follow   Follow latest log"
    exit 0
fi

if [ "$1" = "run" ]; then
    info "axiom run"
    echo
    echo "Usage:"
    echo "  axiom run"
    echo
    echo "Runs the current AxiomOS project."
    echo
    echo "For physics_report projects, it runs the configured pipeline:"
    echo "  Python step -> LaTeX build -> PDF output"
    exit 0
fi

if [ "$1" = "status" ]; then
    info "axiom status"
    echo
    echo "Usage:"
    echo "  axiom status"
    echo
    echo "Shows operational status for the current project."
    exit 0
fi

info "AxiomOS CLI"
echo

echo "Project commands:"
echo "  axiom new <type> <name>"
echo "  axiom run"
echo "  axiom build"
echo "  axiom clean"
echo "  axiom install"
echo "  axiom status"
echo "  axiom info"
echo

echo "Utility commands:"
echo "  axiom doctor"
echo "  axiom help"
echo "  axiom version"
echo

echo "Examples:"
echo "  axiom new python MyProject"
echo "  axiom new physics_report Electrostatica"
echo "  axiom run"
