#!/bin/bash

SCRIPT_DIR="$(cd "$(dirname "${BASH_SOURCE[0]}")" && pwd)"
AXIOM_HOME="$(cd "$SCRIPT_DIR/../.." && pwd)"

source "$AXIOM_HOME/scripts/lib/ui.sh"

if [ "$1" = "new" ]; then
    info "axiom new"
    echo
    echo "Usage:"
    echo "  axiom new <type> <name> [options]"
    echo
    echo "Project types:"
    echo "  latex"
    echo "  python"
    echo "  julia"
    echo "  physics_report"
    echo
    echo "Examples:"
    echo "  axiom new python MyProject --install"
    echo "  axiom new --list"
    echo "  axiom new physics_report Electrostatica"
    exit 0
fi

if [ "$1" = "logs" ]; then
    info "axiom logs"
    echo
    echo "Usage:"
    echo "  axiom logs [option]"
    echo
    echo "Options:"
    echo "  --latest   Open latest log"
    echo "  --list     List logs"
    echo "  --tail     Show last 50 lines"
    echo "  --follow   Follow latest log"
    exit 0
fi

if [ "$1" = "run" ]; then
    info "axiom run"
    echo
    echo "Usage:"
    echo "  axiom run"
    echo
    echo "Runs the current AxiomOS project."
    echo
    echo "For physics_report projects, it runs the configured pipeline:"
    echo "  Python step -> LaTeX build -> PDF output"
    exit 0
fi

if [ "$1" = "status" ]; then
    info "axiom status"
    echo
    echo "Usage:"
    echo "  axiom status"
    echo
    echo "Shows operational status for the current project."
    exit 0
fi

title "AxiomOS CLI"

section "Project commands"
printf "  %-28s %s\n" "axiom new <type> <name>" "Create a project"
printf "  %-28s %s\n" "axiom run" "Run current project"
printf "  %-28s %s\n" "axiom build" "Build current project"
printf "  %-28s %s\n" "axiom clean" "Clean generated files"
printf "  %-28s %s\n" "axiom open" "Open project resources"
printf "  %-28s %s\n" "axiom preview" "Build and open PDF"
printf "  %-28s %s\n" "axiom dev" "Watch files and auto-preview"
printf "  %-28s %s\n" "axiom install" "Install project dependencies"
printf "  %-28s %s\n" "axiom status" "Show project status"
printf "  %-28s %s\n" "axiom info" "Show project metadata"
printf "  %-28s %s\n" "axiom logs" "Open project logs"

section "Aliases"
printf "  %-12s -> %s\n" "axiom r" "run"
printf "  %-12s -> %s\n" "axiom bd" "build"
printf "  %-12s -> %s\n" "axiom st" "status"
printf "  %-12s -> %s\n" "axiom lg" "logs"
printf "  %-12s -> %s\n" "axiom dr" "doctor"

section "Utility commands"
printf "  %-28s %s\n" "axiom doctor" "Check system/project environment"
printf "  %-28s %s\n" "axiom help" "Show help"
printf "  %-28s %s\n" "axiom version" "Show CLI version"

section "Examples"
echo "  axiom new python MyProject"
echo "  axiom new physics_report Electrostatica"
echo "  axiom run"
echo "  axiom preview"
echo "  axiom logs --latest"
