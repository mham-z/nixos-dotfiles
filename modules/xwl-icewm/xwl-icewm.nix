{ pkgs, ... }: {
	home.packages = with pkgs; [
		icewm

		(pkgs.writeScriptBin "x" ''
			#!/bin/sh
			trap 'kill "$XWAYLAND_PID" 2>/dev/null; exit' INT TERM

			find_free_display() {
				for d in $(seq 10 99); do
					if [ ! -e "/tmp/.X11-unix/X$d" ]; then
						echo ":$d"
						return 0
					fi
				done
				echo ""
				return 1
			}

			run_session() {
				TARGET_DISPLAY=$(find_free_display)

				if [ -z "$TARGET_DISPLAY" ]; then
					echo "No free sockets available between 10 and 99" >&2
					exit 1
				fi

				echo "Creating display at $TARGET_DISPLAY"

				Xwayland "$TARGET_DISPLAY" &
				XWAYLAND_PID=$!

				while [ ! -e "/tmp/.X11-unix/X''${TARGET_DISPLAY#:}" ]; do
					sleep 0.1
				done

				DISPLAY="$TARGET_DISPLAY" icewm
			}

			run_session
		'')
	];
}