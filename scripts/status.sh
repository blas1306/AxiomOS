#!/bin/bash

PROJECT_FILE=".axiom/project.conf"

if [ ! -f "$PROJECT_FILE" ]; then
    echo "Not inside an AxiomOS project."
    exit 1
fi

source "$PROJECT_FILE"

echo "AxiomOS Project Status"
echo
echo "Project: $NAME"
echo "Type: $TYPE"
echo

case "$TYPE" in

    physics_report)

        echo "Pipeline:"

        if [ -f "src/generate_plot.py" ]; then
            echo "  Python step: OK"
        else
            echo "  Python step: MISSING"
        fi

        if [ -f "figures/sine_wave.png" ]; then
            echo "  Figure generated: YES"
        else
            echo "  Figure generated: NO"
        fi

        if [ -f "report/main.pdf" ]; then
            echo "  PDF built: YES"
        else
            echo "  PDF built: NO"
        fi
        ;;

    *)
        echo "No status checks implemented for this project type."
        ;;
esac
