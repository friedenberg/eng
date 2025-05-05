# vim: set syntax=fish:

if test -n "$TMUX"; or not status --is-interactive
  exit 0
end
