
function tt-attach
  if tt has-session -t termtabs 2>&1 > /dev/null
    tt attach
  else
    tt new-session -s termtabs
  end
end
