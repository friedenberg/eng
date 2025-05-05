complete -c t -w tmux

complete -c t -n "__t_complete_needs_completions" -a "(__fish_complete_directories)"

function __t_complete_needs_completions
  set current_command_line (commandline)

  if test (count $current_command_line) -ne 1
    return 1
  end

  set first_arg $current_command_line[1]

  if test (string sub -l 1 "$first_arg") = "-"
    return 1
  end

  return 0
end
