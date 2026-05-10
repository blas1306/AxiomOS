#!/bin/bash

load_pipeline() {

    PIPELINE_FILE=".axiom/pipeline.conf"

    if [ ! -f "$PIPELINE_FILE" ]; then
        error "Pipeline config not found: $PIPELINE_FILE"
        exit 1
    fi

    source "$PIPELINE_FILE"
}
