{...}:
let
	mkAutostart = description: command: {
		Unit = {
			Description = description;
			PartOf = ["graphical-session.target"];
			After = ["graphical-session.target"];
		};

		Service = {
			ExecStart = "uwsm app -- ${command}";
			Restart = "on-failure";
		};

		Install.WantedBy = ["graphical-session.target"];
	};
in {
	systemd.user.services = {
		vesktop = mkAutostart "Vesktop" "vesktop";
		zapzap = mkAutostart "ZapZap" "flatpak run com.rtosta.zapzap";
		wlsunset = mkAutostart "wlsunset" "wlsunset -l 25 -L 67";
	};
}