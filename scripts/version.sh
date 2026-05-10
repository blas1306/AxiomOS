#!/bin/bash

SCRIPT_DIR="$(cd "$(dirname "${BASH_SOURCE[0]}")" && pwd)"
AXIOM_HOME="$(cd "$SCRIPT_DIR/.." && pwd)"

source "$AXIOM_HOME/scripts/lib/ui.sh"

VERSION=$(cat "$AXIOM_HOME/VERSION")

info "AxiomOS CLI v$VERSION"
