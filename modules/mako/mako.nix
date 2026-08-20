{pkgs, ...}: {
	home.packages = with pkgs; [
		libnotify
	];

	services.mako = {
	  enable = true;

		settings = {
			background-color = "#3b4252";
			text-color = "#eceff4";
			border-color = "#88c0d0";
			border-size = 2;
			border-radius = 0;
			progress-color = "over #00000060";

			anchor = "top-right";
			width = 700;
			height = 150;
			outer-margin = 4;
			margin = 4;
			padding = "8,8,8,8";

			layer = "overlay";

			format = "<b>%s</b>\\n%b";

			font = "NotoSansMono 12";

			default-timeout = 5000;
			group-by = "summary";
			max-icon-size = 32;
			max-visible = 5;

			"urgency=high" = {
				border-color = "#d08770";
				default-timeout = 0;
			};

			"mode=dnd" = {
				invisible = 1;
			};

			"mode=dnd urgency=critical" = {
				invisible = 0;
			};

			"grouped=true" = {
				format = "<b>[%g] %s</b>\\n%b";
			};

			"body=" = {
				format = "<b>%s</b>";
			};

			"grouped=true body=" = {
				format = "<b>[%g] %s</b>";
			};
		};
	};
}