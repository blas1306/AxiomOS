#!/bin/bash

SCRIPT_DIR="$(cd "$(dirname "${BASH_SOURCE[0]}")" && pwd)"
AXIOM_HOME="$(cd "$SCRIPT_DIR/../.." && pwd)"

source "$AXIOM_HOME/scripts/lib/ui.sh"

TARGET="$1"

if [ -z "$TARGET" ]; then
    title "AxiomOS Setup"
    echo "Usage:"
    echo "  axiom setup <target>"
    echo
    echo "Targets:"
    echo "  shell       Configure shell integration"
    echo "  workspace   Create workspace directories"
    echo "  packages    Install AxiomOS package profiles"
    echo "  all         Complete AxiomOS setup"
    exit 0
fi

case "$TARGET" in

    shell)
        title "AxiomOS Shell Setup"

        mkdir -p "$HOME/.local/bin"
        mkdir -p "$HOME/.local/share/bash-completion/completions"

        cp "$AXIOM_HOME/axiom" "$HOME/.local/bin/axiom"
        success "Installed axiom CLI to ~/.local/bin/axiom"

        cp "$AXIOM_HOME/completions/axiom.bash" \
           "$HOME/.local/share/bash-completion/completions/axiom"
        success "Installed bash completion"

        if ! grep -q 'export PATH="$HOME/.local/bin:$PATH"' "$HOME/.bashrc"; then
            echo 'export PATH="$HOME/.local/bin:$PATH"' >> "$HOME/.bashrc"
            success "Added ~/.local/bin to PATH in ~/.bashrc"
        else
            info "~/.local/bin already configured in PATH"
        fi

        if ! grep -q 'bash-completion/bash_completion' "$HOME/.bashrc"; then
            cat >> "$HOME/.bashrc" <<'EOF'

if [ -f /usr/share/bash-completion/bash_completion ]; then
    source /usr/share/bash-completion/bash_completion
fi
EOF
            success "Added bash-completion loading to ~/.bashrc"
        else
            info "bash-completion already configured"
        fi

        success "Shell setup completed. Restart terminal or run: source ~/.bashrc"
        ;;

    workspace)
        title "AxiomOS Workspace Setup"

        mkdir -p "$HOME/Workspace"
        mkdir -p "$HOME/Workspace/Math"
        mkdir -p "$HOME/Workspace/Programming"
        mkdir -p "$HOME/Workspace/LaTeX"
        mkdir -p "$HOME/Workspace/Research"
        mkdir -p "$HOME/Workspace/Notes"
        mkdir -p "$HOME/Workspace/Notebooks"

        success "Workspace directories created."
        ;;

    all)
        title "AxiomOS Full Setup"

        "$0" shell
        "$0" workspace
        "$0" packages minimal

        success "AxiomOS setup completed."
        ;;

    packages)
        PROFILE="$2"
        shift 2 || true

        if [ "$PROFILE" = "--list" ]; then
            title "AxiomOS Package Profiles"

            section "Profiles"
            printf "  %-10s %s\n" "minimal" "Base tools only"
            printf "  %-10s %s\n" "math" "Mathematics and scientific computing"
            printf "  %-10s %s\n" "dev" "Programming tools"
            printf "  %-10s %s\n" "full" "Math + development tools"

            section "Modules"
            printf "  %-10s %s\n" "java" "JDK, Maven, Gradle"
            printf "  %-10s %s\n" "docker" "Docker tooling"
            printf "  %-10s %s\n" "vscode" "VS Code setup"
            printf "  %-10s %s\n" "jetbrains" "JetBrains Toolbox setup"
            printf "  %-10s %s\n" "julia" "Julia setup"

            exit 0
        fi

        if [ -z "$PROFILE" ]; then
            error "Usage: axiom setup packages <profile> [modules/options]"
            echo
            echo "Available profiles:"
            echo "  minimal"
            echo "  math"
            echo "  dev"
            echo "  full"
            echo
            echo "Examples:"
            echo "  axiom setup packages math --dry-run"
            echo "  axiom setup packages dev java docker"
            exit 1
        fi

        "$AXIOM_HOME/install.sh" "$PROFILE" "$@"
        ;;

    *)
        error "Unknown setup target: $TARGET"
        echo
        echo "Available targets:"
        echo "  shell"
        echo "  workspace"
        echo "  packages"
        exit 1
        ;;
esac
