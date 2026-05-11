#!/bin/bash

SCRIPT_DIR="$(cd "$(dirname "${BASH_SOURCE[0]}")" && pwd)"
AXIOM_HOME="$(cd "$SCRIPT_DIR/../.." && pwd)"

source "$AXIOM_HOME/scripts/lib/project.sh"
source "$AXIOM_HOME/scripts/lib/ui.sh"

load_project

LOG_DIR=".axiom/logs"
LATEST_LOG="$LOG_DIR/latest.log"

case "$1" in

    ""|--latest)
        if [ ! -f "$LATEST_LOG" ]; then
            error "No latest log found."
            exit 1
        fi

        less "$LATEST_LOG"
        ;;

    --list)
        if [ ! -d "$LOG_DIR" ]; then
            error "No logs directory found."
            exit 1
        fi

        ls -lh "$LOG_DIR"
        ;;

    --tail)
        if [ ! -f "$LATEST_LOG" ]; then
            error "No latest log found."
            exit 1
        fi

        tail -n 50 "$LATEST_LOG"
        ;;

    --follow)
        if [ ! -f "$LATEST_LOG" ]; then
            error "No latest log found."
            exit 1
        fi

        tail -f "$LATEST_LOG"
        ;;

    *)
        error "Unknown logs option: $1"
        echo
        echo "Usage:"
        echo "  axiom logs"
        echo "  axiom logs --latest"
        echo "  axiom logs --list"
        echo "  axiom logs --tail"
        echo "  axiom logs --follow"
        exit 1
        ;;

esac
