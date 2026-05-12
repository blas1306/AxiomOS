#!/usr/bin/env python3

import subprocess
import sys
import time
from pathlib import Path

from watchdog.events import FileSystemEventHandler
from watchdog.observers import Observer


class AxiomDevHandler(FileSystemEventHandler):
    def __init__(self, axiom_home: str):
        self.axiom_home = axiom_home
        self.last_run = 0.0
        self.debounce_seconds = 1.0

    def should_ignore(self, path: str) -> bool:
        ignored_parts = {
            ".git",
            ".venv",
            ".axiom/logs",
            "__pycache__",
        }

        p = Path(path)

        if any(part in p.parts for part in ignored_parts):
            return True

        ignored_suffixes = {
            ".aux",
            ".log",
            ".out",
            ".toc",
            ".synctex.gz",
            ".pdf",
            ".png",
            ".jpg",
            ".jpeg",
        }

        return any(str(p).endswith(suffix) for suffix in ignored_suffixes)

    def on_modified(self, event):
        if event.is_directory:
            return

        if self.should_ignore(event.src_path):
            return

        now = time.time()

        if now - self.last_run < self.debounce_seconds:
            return

        self.last_run = now

        print()
        print(f"[INFO] Change detected: {event.src_path}")
        print("[INFO] Running preview...")

        subprocess.run(
            [str(Path.home() / ".local/bin/axiom"), "preview"],
            cwd=Path.cwd(),
        )


def main():
    if len(sys.argv) < 2:
        print("[ERROR] Missing AXIOM_HOME argument.")
        sys.exit(1)

    axiom_home = sys.argv[1]

    observer = Observer()
    handler = AxiomDevHandler(axiom_home)

    observer.schedule(handler, ".", recursive=True)
    observer.start()

    try:
        while True:
            time.sleep(1)
    except KeyboardInterrupt:
        print()
        print("[INFO] Stopping dev mode...")
        observer.stop()

    observer.join()


if __name__ == "__main__":
    main()
