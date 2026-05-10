#!/bin/bash

SCRIPT_DIR="$(cd "$(dirname "${BASH_SOURCE[0]}")" && pwd)"
AXIOM_HOME="$(cd "$SCRIPT_DIR/../.." && pwd)"

source "$AXIOM_HOME/scripts/lib/ui.sh"

check_command() {
    local cmd="$1"
    local version_arg="$2"

    if command -v "$cmd" >/dev/null 2>&1; then
        version=$($cmd $version_arg 2>/dev/null | head -n 1)
        success "$cmd"
        echo "     $version"
    else
        warning "$cmd missing"
    fi

    echo
}

check_python_package() {
    local pkg="$1"

    if python3 -c "import $pkg" >/dev/null 2>&1; then
        success "python package: $pkg"
    else
        warning "python package missing: $pkg"
    fi
}

title "AxiomOS Doctor"
echo

check_command python3 --version
check_command git --version
check_command octave --version
check_command julia --version
check_command pdflatex --version
check_command jupyter --version
check_command code --version

info "Global Python packages"
echo

check_python_package numpy
check_python_package scipy
check_python_package sympy
check_python_package matplotlib
check_python_package pandas
check_python_package jupyter

if [ -f ".axiom/project.conf" ]; then
    echo
    info "Project diagnostics"

    source ".axiom/project.conf"

    echo
    echo "Project: $NAME"
    echo "Type: $TYPE"
    echo

    case "$TYPE" in
        python)
            if [ -d ".venv" ]; then
                success "Virtual environment found."
            else
                error "Virtual environment missing."
            fi

            if [ -f "requirements.txt" ]; then
                success "requirements.txt found."
            else
                warning "requirements.txt missing."
            fi
            ;;

        physics_report)
            if [ -d ".venv" ]; then
                success "Virtual environment found."
            else
                error "Virtual environment missing."
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

            if [ -f "report/main.tex" ]; then
                success "report/main.tex found."
            else
                error "report/main.tex missing."
            fi
            ;;

        *)
            warning "No project diagnostics implemented for type: $TYPE"
            ;;
    esac
fi