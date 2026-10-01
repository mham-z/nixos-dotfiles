{pkgs, lib, ...}:
let
	mkAutostart = canRunOnMobileMode: description: command: {
		Unit = {
			Description = description;
			PartOf = ["graphical-session.target"];
			After = ["graphical-session.target"];
			ConditionEnvironment = lib.mkIf (!canRunOnMobileMode) "!NIXOS_MOBILE_MODE=1";
		};
	
		Service = {
			ExecStart = "${pkgs.uwsm}/bin/uwsm app -- ${command}";
			Restart = "on-failure";
		};
	
		Install.WantedBy = ["graphical-session.target"];
	};
in {
	systemd.user.startServices = "suggest";
	systemd.user.services = {
		wlsunset    = mkAutostart true  "wlsunset"              "wlsunset -l 25 -L 67";
		footserver  = mkAutostart true  "Foot Server"           "foot --server";
		alarm-clock = mkAutostart true  "alarm-clock"           "alarm-clock-applet --hidden";

		zen         = mkAutostart false "Zen Browser"           "flatpak run app.zen_browser.zen";
		vesktop     = mkAutostart false "Equibop"               "equibop";
		zapzap      = mkAutostart false "ZapZap"                "flatpak run com.rtosta.zapzap";
		thunderbird = mkAutostart false "Thunderbird"           "thunderbird";
		kdeconnectd = mkAutostart false "KDE Connect Daemon"    "kdeconnectd";
		kdeconnecti = mkAutostart false "KDE Connect Indicator" "kdeconnect-indicator";
	};
}
