
complete \
  --command zit \
  --no-files \
  --arguments "(__zit_complete)"

function __zit_complete
  set -l in_progress (commandline -ct)
  set -l cmd (commandline -p --tokenize)
  set cmd $cmd[1] complete -in-progress=$in_progress $cmd[2..]
  $cmd
end
