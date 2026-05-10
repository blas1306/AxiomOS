#!/bin/bash

SCRIPT_DIR="$(cd "$(dirname "${BASH_SOURCE[0]}")" && pwd)"
AXIOM_HOME="$(cd "$SCRIPT_DIR/../.." && pwd)"

source "$AXIOM_HOME/scripts/lib/project.sh"

load_project

echo "AxiomOS Project Status"
echo
echo "Project: $NAME"
echo "Type: $TYPE"