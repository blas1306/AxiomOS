#!/bin/bash

LOG_DIR=".axiom/logs"
mkdir -p "$LOG_DIR"

TIMESTAMP=$(date +"%Y-%m-%d_%H-%M-%S")
LOG_FILE="$LOG_DIR/pipeline_$TIMESTAMP.log"

cd "$LOG_DIR"
ln -sf "$(basename "$LOG_FILE")" latest.log
cd - > /dev/null

exec > >(tee "$LOG_FILE") 2>&1

SCRIPT_DIR="$(cd "$(dirname "${BASH_SOURCE[0]}")" && pwd)"
AXIOM_HOME="$(cd "$SCRIPT_DIR/../.." && pwd)"

source "$AXIOM_HOME/scripts/lib/project.sh"
source "$AXIOM_HOME/scripts/lib/ui.sh"
source "$AXIOM_HOME/scripts/lib/pipeline.sh"

load_project

case "$TYPE" in

    python)
        if [ ! -d ".venv" ]; then
            error "Virtual environment not found. Run: axiom install"
            exit 1
        fi

        info "Running Python project..."
        .venv/bin/python main.py
        ;;

    latex)
        info "Running LaTeX project..."
        pdflatex main.tex
        ;;

    julia)
        info "Running Julia project..."
        julia main.jl
        ;;

    physics_report)
        load_pipeline

        if [ ! -d ".venv" ]; then
            error "Virtual environment not found. Run: axiom install"
            exit 1
        fi

        if [ -n "$RUN_PYTHON" ]; then
            info "Running Python step: $RUN_PYTHON"
            if .venv/bin/python "$RUN_PYTHON"; then
                success "Python step finished."
            else
                error "Python step failed."
                exit 1
            fi
        fi

        if [ -n "$BUILD_LATEX" ]; then
            info "Building LaTeX step: $BUILD_LATEX"

            LATEX_DIR="$(dirname "$BUILD_LATEX")"
            LATEX_FILE="$(basename "$BUILD_LATEX")"

            LATEX_LOG="../.axiom/logs/latex.log"

            cd "$LATEX_DIR"

            if pdflatex "$LATEX_FILE" > /dev/null 2>&1; then
                success "PDF generated."
            else
                error "LaTeX build failed. Check .axiom/logs/latest.log"
                exit 1
            fi

            cd - > /dev/null
        fi

        success "Pipeline finished."
        ;;

    *)
        error "Unknown project type: $TYPE"
        exit 1
        ;;

esac