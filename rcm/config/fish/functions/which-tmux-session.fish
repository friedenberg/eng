function which-tmux-session --description "which TMUX session is a tty attached to"
  set tty $argv
  set sessions (tmux -L sessions list-session -F '#{session_name}' ^ /dev/null)

  for session in $sessions
    tmux -L sessions list-panes -F '#{pane_tty} #{session_name}' -t "$session"
  end | grep "$tty" | awk '{print $2}'
end
