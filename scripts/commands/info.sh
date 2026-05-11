#!/bin/bash

SCRIPT_DIR="$(cd "$(dirname "${BASH_SOURCE[0]}")" && pwd)"
AXIOM_HOME="$(cd "$SCRIPT_DIR/../.." && pwd)"

source "$AXIOM_HOME/scripts/lib/ui.sh"
source "$AXIOM_HOME/scripts/lib/cli.sh"

require_project

title "AxiomOS Project"
divider

kv "Name" "$NAME"
kv "Type" "$TYPE"
kv "Location" "$(pwd)"
kv "Config" ".axiom/project.conf"