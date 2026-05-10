#!/bin/bash

_axiom_completions()
{
    local cur prev

    cur="${COMP_WORDS[COMP_CWORD]}"
    prev="${COMP_WORDS[COMP_CWORD-1]}"

    COMMANDS="new run build clean install status info doctor help version open"

    PROJECT_TYPES="latex python julia physics_report"

    if [[ $COMP_CWORD -eq 1 ]]; then
        COMPREPLY=( $(compgen -W "$COMMANDS" -- "$cur") )
        return
    fi

    if [[ "$prev" == "new" ]]; then
        COMPREPLY=( $(compgen -W "$PROJECT_TYPES" -- "$cur") )
        return
    fi
}

complete -F _axiom_completions axiom
