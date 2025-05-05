
function t --wraps tmux --description 'attach to or create an existing session for a given directory'
  if test (count "$argv") -ne 1
    __t_tmux_command $argv
    return $status
  end

  set first_arg $argv[1]

  if test ! -d "$first_arg"
    __t_tmux_command $argv
    return $status
  end

  __t_join_or_attach_directory "$first_arg"
  return $status
end

function __t_tmux_command
  set -l TMUX_COMMAND $TMUX_COMMAND

  if test -z "$TMUX_COMMAND"
    set TMUX_COMMAND tmux -L sessions
  end

  $TMUX_COMMAND $argv
  return $status
end

function __t_join_or_attach_directory
  set path (realpath $argv)
  set session_name (__t_get_session_name_for_path $path)

  if __t_tmux_command has-session "-t=$session_name" >/dev/null 2>&1
    __t_tmux_command attach -t "$session_name" -c "$path"
    return $status
  else
    __t_tmux_command new-session -s "$session_name" -c "$path"
    return $status
  end
end

function __t_get_session_name_for_path
  if test -f "$argv/TERMTABS_NAME"
    string trim (cat "$argv/TERMTABS_NAME")
    return $status
  end

  echo (basename "$argv" | tr -d ".")
  return $status
end
