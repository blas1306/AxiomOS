#!/bin/bash

SCRIPT_DIR="$(cd "$(dirname "${BASH_SOURCE[0]}")" && pwd)"
AXIOM_HOME="$(cd "$SCRIPT_DIR/../.." && pwd)"

source "$AXIOM_HOME/scripts/lib/ui.sh"
source "$AXIOM_HOME/scripts/lib/cli.sh"

require_project

info "Running project..."

if "$AXIOM_HOME/scripts/commands/run.sh"; then
    success "Build finished."
else
    error "Build failed."
    exit 1
fi

case "$TYPE" in

    latex)
        PDF_FILE="main.pdf"
        ;;

    physics_report)
        PDF_FILE="report/main.pdf"
        ;;

    *)
        warning "This project type does not generate PDFs."
        exit 0
        ;;

esac

if [ ! -f "$PDF_FILE" ]; then
    error "PDF not found."
    exit 1
fi

info "Opening PDF..."

xdg-open "$PDF_FILE" > /dev/null 2>&1 &
