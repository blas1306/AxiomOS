#!/bin/bash

SCRIPT_DIR="$(cd "$(dirname "${BASH_SOURCE[0]}")" && pwd)"
AXIOM_HOME="$(cd "$SCRIPT_DIR/../.." && pwd)"

source "$AXIOM_HOME/scripts/lib/ui.sh"
source "$AXIOM_HOME/scripts/lib/cli.sh"

require_project

info "Starting AxiomOS dev mode..."
info "Watching project files. Press Ctrl+C to stop."

python3 "$AXIOM_HOME/scripts/dev_watcher.py" "$AXIOM_HOME"
