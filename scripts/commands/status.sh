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

case "$TYPE" in

    python)
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

        if [ -f "main.py" ]; then
            success "main.py found."
        else
            error "main.py missing."
        fi
        ;;

    latex)
        if [ -f "main.tex" ]; then
            success "main.tex found."
        else
            error "main.tex missing."
        fi

        if [ -f "main.pdf" ]; then
            success "PDF generated."
        else
            warning "PDF not generated yet."
        fi
        ;;

    julia)
        if [ -f "main.jl" ]; then
            success "main.jl found."
        else
            error "main.jl missing."
        fi
        ;;

    physics_report)
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
        else
            error "pipeline.conf missing."
        fi

        if [ -f "src/generate_plot.py" ]; then
            success "Python step file found."
        else
            warning "Python step file missing."
        fi

        if [ -f "figures/sine_wave.png" ]; then
            success "Generated figure found."
        else
            warning "Generated figure missing."
        fi

        if [ -f "report/main.tex" ]; then
            success "report/main.tex found."
        else
            error "report/main.tex missing."
        fi

        if [ -f "report/main.pdf" ]; then
            success "PDF generated."
        else
            warning "PDF not generated yet."
        fi
        ;;

    *)
        warning "No status checks implemented for project type: $TYPE"
        ;;

esac

echo

if [ -d ".axiom/logs" ]; then
    success "Logs directory found."
fi

if [ -L ".axiom/logs/latest.log" ]; then
    success "Latest log available."
fi