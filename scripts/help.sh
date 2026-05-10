#!/bin/bash

SCRIPT_DIR="$(cd "$(dirname "${BASH_SOURCE[0]}")" && pwd)"
AXIOM_HOME="$(cd "$SCRIPT_DIR/.." && pwd)"

source "$AXIOM_HOME/scripts/lib/ui.sh"

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
