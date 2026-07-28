{pkgs, ...}:
let
	mkAutostart = description: command: {
		Unit = {
			Description = description;
			PartOf = ["graphical-session.target"];
			After = ["graphical-session.target"];
		};

		Service = {
			ExecStart = "${pkgs.uwsm}/bin/uwsm app -- ${command}";
			Restart = "on-failure";
		};

		Install.WantedBy = ["graphical-session.target"];
	};
in {
	systemd.user.services = {
		zen = mkAutostart "Zen Browser" "flatpak run app.zen_browser.zen";
		vesktop = mkAutostart "Equibop" "equibop";
		zapzap = mkAutostart "ZapZap" "flatpak run com.rtosta.zapzap";
		wlsunset = mkAutostart "wlsunset" "wlsunset -l 25 -L 67";
		footserver = mkAutostart "Foot Server" "foot --server";
	};
}