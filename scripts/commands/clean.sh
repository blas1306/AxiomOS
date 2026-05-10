#!/bin/bash

SCRIPT_DIR="$(cd "$(dirname "${BASH_SOURCE[0]}")" && pwd)"
AXIOM_HOME="$(cd "$SCRIPT_DIR/../.." && pwd)"

source "$AXIOM_HOME/scripts/lib/project.sh"
source "$AXIOM_HOME/scripts/lib/ui.sh"

load_project

case "$TYPE" in

    latex)
        echo "Cleaning LaTeX build files..."

        rm -f *.aux
        rm -f *.log
        rm -f *.out
        rm -f *.toc
        rm -f *.synctex.gz

        echo "Done."
        ;;

    python)
        echo "Cleaning Python cache..."

        find . -type d -name "__pycache__" -exec rm -rf {} +

        echo "Done."
        ;;

    julia)
        echo "No clean step implemented for Julia yet."
        ;;

    physics_report)
        info "Cleaning physics report build files..."

        rm -f report/*.aux
        rm -f report/*.log
        rm -f report/*.out
        rm -f report/*.toc
        rm -f report/*.synctex.gz

        find . -type d -name "__pycache__" -exec rm -rf {} +

        success "Done."
        ;;

    *)
        echo "Unknown project type: $TYPE"
        exit 1
        ;;

esac
