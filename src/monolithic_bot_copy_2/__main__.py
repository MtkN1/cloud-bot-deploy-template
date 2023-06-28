import signal
from contextlib import suppress

from .main import main

if __name__ == "__main__":
    signal.signal(signal.SIGTERM, lambda *args: exit())
    with suppress(KeyboardInterrupt):
        main()
