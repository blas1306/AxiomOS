# AxiomOS

AxiomOS is a modular Linux distribution project focused on mathematics, scientific computing, programming, and research workflows.

The project is currently based on Ubuntu/Debian systems and aims to provide a customizable environment where users can choose different installation profiles and optional modules depending on their needs.

Instead of forcing users into a single workflow, AxiomOS is designed around the idea:

> comfortable by default, powerful when needed.

---

# Vision

AxiomOS is intended for:

* mathematics students;
* computer science and engineering students;
* researchers;
* programmers;
* scientific computing users;
* LaTeX-heavy academic workflows;
* users who want a productive environment without manually configuring everything from scratch.

The long-term goal is to create a scientific/programming ecosystem rather than simply another Linux distribution.

---

# Current State

At the moment, AxiomOS is implemented as:

* a modular setup system;
* installation profiles;
* optional modules;
* workspace bootstrap;
* automatic package installation;
* logging support;
* basic distro detection.

Future versions may include:

* custom ISO builds;
* installer GUI;
* project templates;
* scientific project bootstrap tools;
* MathTeX Studio integration;
* notebook workflows;
* desktop customization;
* academic templates.

---

# Features

## Profiles

Profiles define the main workflow category.

Currently available:

* `minimal`
* `math`
* `dev`
* `full`

Example:

```bash
./install.sh math
```

---

## Modules

Modules provide optional components.

Examples:

* `docker`
* `java`
* `julia`
* `vscode`
* `jetbrains`

Example:

```bash
./install.sh dev docker java
```

---

## Dry Run

Preview the installation without making changes.

```bash
./install.sh math --dry-run
```

---

## Automatic Workspace Setup

AxiomOS automatically creates a scientific/programming workspace structure:

```text
~/Workspace/
├── LaTeX
├── Math
├── Notebooks
├── Notes
├── Programming
└── Research
```

---

# Project Structure

```text
axiomos/
├── configs/
├── logs/
├── modules/
├── profiles/
├── scripts/
├── templates/
├── install.sh
└── README.md
```

---

# Installation

Clone the repository:

```bash
git clone <repository-url>
cd axiomos
```

Make the installer executable:

```bash
chmod +x install.sh
```

Run a profile:

```bash
./install.sh math
```

Run a profile with modules:

```bash
./install.sh full docker java
```

Skip confirmation:

```bash
./install.sh minimal --yes
```

---

# Supported Systems

Currently supported:

* Ubuntu
* Debian
* Linux Mint
* Pop!_OS

---

# Goals

AxiomOS does not aim to replace:

* Ubuntu;
* Arch Linux;
* Debian;
* VS Code;
* JetBrains IDEs;
* MATLAB;
* Octave;
* Jupyter.

Instead, the goal is to integrate scientific and programming workflows into a coherent environment.

---

# Philosophy

AxiomOS follows several core ideas:

* modular instead of monolithic;
* productive defaults;
* customizable workflows;
* scientific/programming focus;
* terminal-friendly but not terminal-only;
* beginner-accessible while still powerful.

---

# Roadmap

## Near Term

* better error handling;
* project templates;
* project bootstrap tools;
* improved logging;
* package categories;
* configuration management.

## Mid Term

* GUI installer;
* desktop customization;
* MathTeX Studio integration;
* notebook support;
* automatic IDE setup.

## Long Term

* custom ISO;
* live environment;
* package repositories;
* full distribution release.

---

# License

GPLv3