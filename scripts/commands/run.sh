#!/bin/bash

LOG_DIR=".axiom/logs"
mkdir -p "$LOG_DIR"

TIMESTAMP=$(date +"%Y-%m-%d_%H-%M-%S")
LOG_FILE="$LOG_DIR/pipeline_$TIMESTAMP.log"

cd "$LOG_DIR"
ln -sf "$(basename "$LOG_FILE")" latest.log
cd - > /dev/null

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

        if .venv/bin/python main.py > "$LOG_FILE" 2>&1; then
            success "Python project finished."
            exit 0
        else
            error "Python project failed. Check .axiom/logs/latest.log"
            exit 1
        fi
        ;;

    latex)
        info "Running LaTeX project..."

        if pdflatex main.tex > "$LOG_FILE" 2>&1; then
            success "PDF generated."
            exit 0
        else
            error "LaTeX build failed. Check .axiom/logs/latest.log"
            exit 1
        fi
        ;;

    julia)
        info "Running Julia project..."

        if julia main.jl > "$LOG_FILE" 2>&1; then
            success "Julia project finished."
            exit 0
        else
            error "Julia project failed. Check .axiom/logs/latest.log"
            exit 1
        fi
        ;;

    physics_report)
        load_pipeline

        if [ ! -d ".venv" ]; then
            error "Virtual environment not found. Run: axiom install"
            exit 1
        fi

        if [ -n "$RUN_PYTHON" ]; then
            info "Running Python step: $RUN_PYTHON"

            if .venv/bin/python "$RUN_PYTHON" > "$LOG_FILE" 2>&1; then
                success "Python step finished."
            else
                error "Python step failed. Check .axiom/logs/latest.log"
                exit 1
            fi
        fi

        if [ -n "$BUILD_LATEX" ]; then
            info "Building LaTeX step: $BUILD_LATEX"

            LATEX_DIR="$(dirname "$BUILD_LATEX")"
            LATEX_FILE="$(basename "$BUILD_LATEX")"

            cd "$LATEX_DIR"

            if pdflatex "$LATEX_FILE" >> "../$LOG_FILE" 2>&1; then
                success "PDF generated."
            else
                error "LaTeX build failed. Check .axiom/logs/latest.log"
                exit 1
            fi

            cd - > /dev/null
        fi

        success "Pipeline finished."
        exit 0
        ;;

    *)
        error "Unknown project type: $TYPE"
        exit 1
        ;;

esac