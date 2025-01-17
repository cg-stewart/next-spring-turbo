#!/bin/bash
# For terminal emulators that support command line splits
if [ "$TERM_PROGRAM" = "iTerm.app" ]; then
	# iTerm2 specific
	osascript -e 'tell application "iTerm2"
        tell current window
            create tab with default profile
            tell current session
                split horizontally with default profile
            end tell
        end tell
    end tell'
elif [ -n "$KITTY_WINDOW_ID" ]; then
	# Kitty specific
	kitty @ launch --location=hsplit
	kitty @ send-text "turbo dev --filter=web\n"
	kitty @ launch --location=vsplit
	kitty @ send-text "pnpm dev:api\n"
fi
