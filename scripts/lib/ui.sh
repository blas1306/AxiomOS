#!/bin/bash

RED='\033[0;31m'
GREEN='\033[0;32m'
YELLOW='\033[1;33m'
BLUE='\033[0;34m'
CYAN='\033[0;36m'
BOLD='\033[1m'
DIM='\033[2m'
NC='\033[0m'

info() {
    printf "${BLUE}%-8s${NC} %s\n" "[INFO]" "$1"
}

success() {
    printf "${GREEN}%-8s${NC} %s\n" "[OK]" "$1"
}

warning() {
    printf "${YELLOW}%-8s${NC} %s\n" "[WARN]" "$1"
}

error() {
    printf "${RED}%-8s${NC} %s\n" "[ERROR]" "$1"
}

title() {
    echo
    echo -e "${BOLD}$1${NC}"
    echo
}

section() {
    echo
    echo -e "${CYAN}── $1 ──${NC}"
}

kv() {
    printf "${BOLD}%-12s${NC} %s\n" "$1:" "$2"
}

divider() {
    echo -e "${DIM}──────────────────────────────${NC}"
}