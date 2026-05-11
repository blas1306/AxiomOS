#!/bin/bash

SCRIPT_DIR="$(cd "$(dirname "${BASH_SOURCE[0]}")" && pwd)"
AXIOM_HOME="$(cd "$SCRIPT_DIR/../.." && pwd)"

source "$AXIOM_HOME/scripts/lib/ui.sh"
source "$AXIOM_HOME/scripts/lib/cli.sh"

require_project

title "AxiomOS Project"

echo "Name:     $NAME"
echo "Type:     $TYPE"
echo "Location: $(pwd)"
echo "Config:   .axiom/project.conf"