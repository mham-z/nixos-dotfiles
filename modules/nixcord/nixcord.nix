{inputs, ...}: {
	imports = [inputs.nixcord.homeModules.nixcord];

	programs.nixcord = {
		enable = true;
		discord.enable = false;
		equibop.enable = true;

		config = {};
		
		config.plugins = {
			alwaysExpandRoles.enable = true;
			anonymiseFileNames = {
				enable = true;
				anonymiseByDefault = false;
				randomisedLength = 5;
			};
			betterSessions.enable = true;
			betterSettings.enable = true;
			blurNsfw = {
				blurAmount = 20;
			};
			callTimer.enable = true;
			clientTheme = {
				color = "211f30";
			};
			copyFileContents.enable = true;
			crashHandler.enable = true;
			disableDeepLinks.enable = true;
			fakeNitro = {
				enable = true;
				emojiSize = 64.0;
			};
			fakeProfileThemes.enable = true;
			fixSpotifyEmbeds.enable = true;
			gifPaste.enable = true;
			hideMedia.enable = true;
			imageZoom = {
				zoom = 9.608141766171304;
				nearestNeighbour = true;
			};
			implicitRelationships.enable = true;
			messageLatency.enable = true;
			messageLogger = {
				enable = true;
				deleteStyle = "overlay";
			};
			noDevtoolsWarning.enable = true;
			noF1.enable = true;
			noOnboardingDelay.enable = true;
			noPendingCount = {
				enable = true;
				hideFriendRequestsCount = false;
				hideMessageRequestsCount = false;
			};
			noTypingAnimation.enable = true;
			permissionsViewer.enable = true;
			platformIndicators.enable = true;
			readAllNotificationsButton.enable = true;
			shikiCodeblocks.enable = true;
			showHiddenChannels.enable = true;
			showHiddenThings.enable = true;
			silentTyping.enable = true;
			spotifyCrack.enable = true;
			stickerPaste.enable = true;
			typingIndicator.enable = true;
			validReply.enable = true;
			validUser.enable = true;
			viewRaw.enable = true;
			voiceChatDoubleClick.enable = true;
			voiceDownload.enable = true;
			voiceMessages.enable = true;
			volumeBooster.enable = true;
			webContextMenus = {
				enable = true;
				addBack = true;
			};
			webKeybinds.enable = true;
			webScreenShareFixes.enable = true;
			whoReacted.enable = true;
			youtubeAdblock.enable = true;
			gameActivityToggle.enable = true;
		};
	};
}