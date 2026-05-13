#!/bin/bash

set -e

LOG_FILE="logs/install.log"

RED='\033[0;31m'
GREEN='\033[0;32m'
YELLOW='\033[1;33m'
BLUE='\033[0;34m'
NC='\033[0m'

mkdir -p logs

echo "========== NEW INSTALL ==========" >> "$LOG_FILE"
date >> "$LOG_FILE"

source /etc/os-release
DISTRO="$ID"

DISTRO_FILE="install/distros/$DISTRO.conf"

if [ ! -f "$DISTRO_FILE" ]; then
    echo -e "${RED}Unsupported distro: $DISTRO${NC}"
    exit 1
fi

source "$DISTRO_FILE"

if [ "$SUPPORTED" != "true" ]; then
    echo -e "${RED}Distro not supported: $DISTRO${NC}"
    exit 1
fi

PROFILE="$1"
shift || true

YES=false
DRY_RUN=false
MODULES=()

for arg in "$@"; do
    case "$arg" in
        --yes|-y)
            YES=true
            ;;
        --dry-run)
            DRY_RUN=true
            ;;
        *)
            MODULES+=("$arg")
            ;;
    esac
done

if [ -z "$PROFILE" ]; then
    echo "Usage:"
    echo "  ./install.sh <profile> [modules...] [options]"
    echo
    echo "Examples:"
    echo "  ./install.sh math"
    echo "  ./install.sh dev java docker"
    echo "  ./install.sh full vscode jetbrains --yes"
    echo "  ./install.sh math --dry-run"
    exit 1
fi

BASE_FILE="install/profiles/base.conf"
PROFILE_FILE="install/profiles/$PROFILE.conf"

if [ ! -f "$BASE_FILE" ]; then
    echo -e "${RED}Error: base profile not found: $BASE_FILE${NC}"
    exit 1
fi

if [ ! -f "$PROFILE_FILE" ]; then
    echo -e "${RED}Error: profile not found: $PROFILE_FILE${NC}"
    exit 1
fi

source "$BASE_FILE"
source "$PROFILE_FILE"

APT_PACKAGES=(
    "${BASE_APT_PACKAGES[@]}"
    "${PROFILE_APT_PACKAGES[@]}"
)

PIP_PACKAGES=(
    "${BASE_PIP_PACKAGES[@]}"
    "${PROFILE_PIP_PACKAGES[@]}"
)

for module in "${MODULES[@]}"; do
    MODULE_FILE="install/modules/$module.conf"

    if [ ! -f "$MODULE_FILE" ]; then
        echo -e "${RED}Error: module not found: $MODULE_FILE${NC}"
        exit 1
    fi

    MODULE_APT_PACKAGES=()
    MODULE_PIP_PACKAGES=()

    source "$MODULE_FILE"

    APT_PACKAGES+=("${MODULE_APT_PACKAGES[@]}")
    PIP_PACKAGES+=("${MODULE_PIP_PACKAGES[@]}")
done

APT_PACKAGES=($(printf "%s\n" "${APT_PACKAGES[@]}" | sort -u))
PIP_PACKAGES=($(printf "%s\n" "${PIP_PACKAGES[@]}" | sort -u))

echo -e "${BLUE}AxiomOS Setup${NC}"
echo
echo -e "Detected distro: ${GREEN}$DISTRO${NC}"
echo -e "Selected profile: ${GREEN}$PROFILE${NC}"
echo -e "Selected modules: ${GREEN}${MODULES[*]:-none}${NC}"
echo

echo -e "${YELLOW}APT packages (${#APT_PACKAGES[@]}):${NC}"
printf '  - %s\n' "${APT_PACKAGES[@]}"
echo

echo -e "${YELLOW}PIP packages (${#PIP_PACKAGES[@]}):${NC}"
printf '  - %s\n' "${PIP_PACKAGES[@]}"
echo

if [ "$DRY_RUN" = true ]; then
    echo -e "${GREEN}Dry run finished. No changes were made.${NC}"
    exit 0
fi

if [ "$YES" = false ]; then
    read -p "Continue with installation? [y/N] " confirm

    if [[ "$confirm" != "y" && "$confirm" != "Y" ]]; then
        echo -e "${YELLOW}Installation cancelled.${NC}"
        exit 0
    fi
fi

source scripts/install_apt.sh
source scripts/install_pip.sh
source scripts/setup_directories.sh

echo -e "${GREEN}Done.${NC}"