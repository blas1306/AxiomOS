#!/bin/bash

check_command() {
    local cmd="$1"
    local version_arg="$2"

    if command -v "$cmd" >/dev/null 2>&1; then
        version=$($cmd $version_arg 2>/dev/null | head -n 1)

        echo "[OK] $cmd"
        echo "     $version"
    else
        echo "[MISSING] $cmd"
    fi

    echo
}

echo "AxiomOS Doctor"
echo

check_command python3 --version
check_command git --version
check_command octave --version
check_command julia --version
check_command pdflatex --version
check_command jupyter --version
check_command code --version

check_python_package() {
    local pkg="$1"

    if python3 -c "import $pkg" >/dev/null 2>&1; then
        echo "[OK] python package: $pkg"
    else
        echo "[MISSING] python package: $pkg"
    fi
}

echo "Python packages"
echo

check_python_package numpy
check_python_package scipy
check_python_package sympy
check_python_package matplotlib
check_python_package pandas
check_python_package jupyter