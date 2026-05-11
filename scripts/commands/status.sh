#!/bin/bash

SCRIPT_DIR="$(cd "$(dirname "${BASH_SOURCE[0]}")" && pwd)"
AXIOM_HOME="$(cd "$SCRIPT_DIR/../.." && pwd)"

source "$AXIOM_HOME/scripts/lib/ui.sh"
source "$AXIOM_HOME/scripts/lib/cli.sh"

require_project

title "AxiomOS Project Status"

echo "Project: $NAME"
echo "Type:    $TYPE"
echo

if [ -d ".venv" ]; then
    success "Virtual environment found."
else
    warning "Virtual environment missing."
fi

if [ -f "requirements.txt" ]; then
    success "requirements.txt found."
else
    warning "requirements.txt missing."
fi

if [ -f ".axiom/pipeline.conf" ]; then
    success "pipeline.conf found."
fi

if [ -f "report/main.tex" ]; then
    success "report/main.tex found."
fi

if [ -f "report/main.pdf" ]; then
    success "PDF generated."
fi

if [ -d ".axiom/logs" ]; then
    success "Logs directory found."
fi

if [ -L ".axiom/logs/latest.log" ]; then
    success "Latest log available."
fi