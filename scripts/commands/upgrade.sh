#!/bin/bash

SCRIPT_DIR="$(cd "$(dirname "${BASH_SOURCE[0]}")" && pwd)"
AXIOM_HOME="$(cd "$SCRIPT_DIR/../.." && pwd)"

source "$AXIOM_HOME/scripts/lib/project.sh"
source "$AXIOM_HOME/scripts/lib/ui.sh"
source "$AXIOM_HOME/scripts/lib/cli.sh"

require_project

ensure_dir() {
    local dir="$1"

    if [ ! -d "$dir" ]; then
        mkdir -p "$dir"
        success "Created directory: $dir"
    else
        info "Directory already exists: $dir"
    fi
}

ensure_file() {
    local file="$1"
    local content="$2"

    if [ ! -f "$file" ]; then
        cat > "$file" <<EOF
$content
EOF
        success "Created file: $file"
    else
        info "File already exists: $file"
    fi
}

case "$TYPE" in

    physics_report)
        info "Upgrading physics report project..."

        ensure_dir ".axiom"
        ensure_dir ".axiom/logs"
        ensure_dir "data"
        ensure_dir "figures"
        ensure_dir "src"
        ensure_dir "report"

        ensure_file ".axiom/pipeline.conf" "RUN_PYTHON=src/generate_plot.py
BUILD_LATEX=report/main.tex"

        ensure_file "requirements.txt" "numpy
matplotlib"

        ensure_file ".gitignore" ".venv/
__pycache__/
*.pyc

*.aux
*.log
*.out
*.toc
*.synctex.gz"

        if [ ! -d ".venv" ]; then
            info "Creating virtual environment..."
            python3 -m venv .venv
            success "Virtual environment created."
        else
            info "Virtual environment already exists."
        fi

        success "Physics report project upgraded."
        ;;

    python)
        info "Upgrading Python project..."

        ensure_dir ".axiom"
        ensure_dir ".axiom/logs"

        ensure_file "requirements.txt" "numpy
matplotlib
scipy
sympy
pandas"

        ensure_file ".gitignore" "__pycache__/
*.pyc
.venv/"

        if [ ! -d ".venv" ]; then
            info "Creating virtual environment..."
            python3 -m venv .venv
            success "Virtual environment created."
        else
            info "Virtual environment already exists."
        fi

        success "Python project upgraded."
        ;;

    *)
        warning "No upgrade rules implemented for project type: $TYPE"
        ;;

esac
