#!/usr/bin/env bash

tmux_get() {
  local value
  value="$(tmux show -gqv "$1")"
  [ -n "$value" ] && echo "$value" || echo "$2"
}

tmux_set() {
  tmux set-option -gq "$1" "$2"
}

session_icon="$(tmux_get '@tmux_power_session_icon' '')"
TC=colour3
FG="#626262"
BG="#272a34"
BG2="#262626"
BG3="#444444"
ALT="colour14"
MUTED="#767676"

function main() {
  # Status options
  tmux_set status-interval 1
  tmux_set status on

  # Basic status bar colors
  tmux_set status-fg "$FG"
  tmux_set status-bg "$BG"
  tmux_set status-attr none

  # tmux-prefix-highlight
  tmux_set @prefix_highlight_fg "$BG"
  tmux_set @prefix_highlight_bg "$FG"
  tmux_set @prefix_highlight_show_copy_mode 'on'
  tmux_set @prefix_highlight_copy_mode_attr "fg=$TC,bg=$BG,bold"

  # Left side of status bar
  RS="#[fg=$BG,bg=$TC] $session_icon #S "
  tmux_set status-left "$LS"

  # Right side of status bar
  tmux_set status-right-bg "$BG"
  tmux_set status-right-fg "$MUTED"
  tmux_set status-right-length 150
  tmux_set status-right "$RS"

  # Window status
  tmux_set window-status-format "#[bg=$ALT,fg=$BG] #I #[bg=$BG2,fg=$MUTED] #W  "
  tmux_set window-status-current-format "#[bg=$TC,fg=$BG] #I #[bg=$BG2,fg=$TC] #W  #[fg=$MUTED,bg=$BG,nobold]"

  # Window separator
  tmux_set window-status-separator ""

  # Window status alignment
  tmux_set status-justify left

  # Current window status
  tmux_set window-status-style "fg=$MUTED,bg=$BG"
  tmux_set window-status-current-style "bg=$BG,fg=$FG"

  # Pane border
  tmux_set pane-border-style "fg=$BG3,bg=default"

  # Active pane border
  tmux_set pane-active-border-style "fg=$TC,bg=$BG"

  # Pane number indicator
  tmux_set display-panes-colour "$ALT"
  tmux_set display-panes-active-colour "$TC"

  # Message
  tmux_set message-style "fg=$TC,bg=$BG"

  # Command message
  tmux_set message-command-style "fg=$TC,bg=$BG"

  # Copy mode highlight
  tmux_set mode-style "bg=$TC,fg=$FG"
}

main
