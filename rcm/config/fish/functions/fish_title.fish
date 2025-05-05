function fish_title
  set -l private_prefix ""

  if set -q fish_private_mode
    set private_prefix 🔒
  end

  if test -n "$SSH_CLIENT" -a -n "$TMUX"
    echo $private_prefix$_
  else if test -n "$TMUX" -a -n "$ssh_config_current_alias"
    echo $private_prefix$ssh_config_current_alias
  else if test -z "$TMUX" -a -n "$ssh_config_current_alias"
    echo "$private_prefix$ssh_config_current_alias: " (prompt_pwd)
  else
    echo $private_prefix$_
  end
end
