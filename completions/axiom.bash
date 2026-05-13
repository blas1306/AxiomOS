#!/bin/bash

_axiom_completions()
{
    local cur prev

    cur="${COMP_WORDS[COMP_CWORD]}"
    prev="${COMP_WORDS[COMP_CWORD-1]}"

    COMMANDS="new run build clean install status info doctor help version open upgrade init logs preview dev setup"
    PROJECT_TYPES="latex python julia physics_report"
    LOG_OPTIONS="--latest --list --tail --follow"
    OPEN_TARGETS="code pdf logs"
    SETUP_TARGETS="shell workspace"

    if [[ "$prev" == "open" ]]; then
        COMPREPLY=( $(compgen -W "$OPEN_TARGETS" -- "$cur") )
        return
    fi

    if [[ $COMP_CWORD -eq 1 ]]; then
        COMPREPLY=( $(compgen -W "$COMMANDS" -- "$cur") )
        return
    fi

    if [[ "$prev" == "new" ]]; then
        COMPREPLY=( $(compgen -W "$PROJECT_TYPES --list" -- "$cur") )
        return
    fi

    if [[ "$prev" == "logs" ]]; then
        COMPREPLY=( $(compgen -W "$LOG_OPTIONS" -- "$cur") )
        return
    fi

    if [[ "$prev" == "help" ]]; then
        COMPREPLY=( $(compgen -W "$COMMANDS" -- "$cur") )
        return
    fi

    if [[ "$prev" == "setup" ]]; then
        COMPREPLY=( $(compgen -W "$SETUP_TARGETS" -- "$cur") )
        return
    fi
}

complete -F _axiom_completions axiom
