#!/bin/bash
# Check if tmux is installed
if ! command -v tmux &>/dev/null; then
	echo "tmux is not installed. Please install tmux or use 'pnpm dev:all' instead."
	exit 1
fi

# Create a new tmux session named 'dev' in detached mode
tmux new-session -d -s dev

# Split the window horizontally
tmux split-window -h

# Select the left pane and start the frontend
tmux select-pane -L
tmux send-keys 'turbo dev --filter=web' C-m

# Select the right pane and start the backend
tmux select-pane -R
tmux send-keys 'pnpm dev:api' C-m

# Attach to the session
tmux attach-session -t dev
