#!/bin/bash

SCRIPT_DIR="$(cd "$(dirname "${BASH_SOURCE[0]}")" && pwd)"
AXIOM_HOME="$(cd "$SCRIPT_DIR/../.." && pwd)"

source "$AXIOM_HOME/scripts/lib/ui.sh"
source "$AXIOM_HOME/scripts/lib/cli.sh"

require_project

TARGET="$1"

case "$TARGET" in

    ""|code)
        info "Opening project in VS Code..."
        code .
        ;;

    pdf)

        case "$TYPE" in

            latex)
                PDF_FILE="main.pdf"
                ;;

            physics_report)
                PDF_FILE="report/main.pdf"
                ;;

            *)
                error "This project type does not generate PDFs."
                exit 1
                ;;

        esac

        if [ ! -f "$PDF_FILE" ]; then
            error "PDF not found."
            exit 1
        fi

        info "Opening PDF..."
        xdg-open "$PDF_FILE" > /dev/null 2>&1
        ;;

    logs)
        info "Opening latest log..."
        less ".axiom/logs/latest.log"
        ;;

    *)
        error "Unknown open target: $TARGET"
        echo
        echo "Usage:"
        echo "  axiom open"
        echo "  axiom open code"
        echo "  axiom open pdf"
        echo "  axiom open logs"
        exit 1
        ;;

esac