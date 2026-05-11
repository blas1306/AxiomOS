#!/bin/bash

SCRIPT_DIR="$(cd "$(dirname "${BASH_SOURCE[0]}")" && pwd)"
AXIOM_HOME="$(dirname "$SCRIPT_DIR")"

TYPE="$1"
NAME="$2"

if [ "$TYPE" = "--list" ]; then
    echo "Available project types"
    echo
    printf "  %-16s %s\n" "python" "Python scientific project"
    printf "  %-16s %s\n" "latex" "Basic LaTeX project"
    printf "  %-16s %s\n" "julia" "Julia scientific project"
    printf "  %-16s %s\n" "physics_report" "Python + LaTeX scientific report pipeline"
    exit 0
fi

shift 2 || true

if [ -z "$TYPE" ] || [ -z "$NAME" ]; then
    echo "Usage:"
    echo "axiom new <type> <name> [options]"
    echo
    echo "Available types: latex, python, julia"
    exit 1
fi

PROJECT_TYPE_SCRIPT="$AXIOM_HOME/scripts/project_types/$TYPE.sh"

if [ ! -f "$PROJECT_TYPE_SCRIPT" ]; then
    echo "Unknown project type: $TYPE"
    echo "Available types: latex, python, julia"
    exit 1
fi

"$PROJECT_TYPE_SCRIPT" "$NAME" "$@"
