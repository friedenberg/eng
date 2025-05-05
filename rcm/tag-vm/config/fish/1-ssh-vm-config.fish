
mkdir -p ~/.local/state
set -x SYM_SSH_AUTH_SOCK ~/.local/state/ssh_auth_sock

# Fix SSH auth socket location so agent forwarding works with tmux
if test -e $SSH_AUTH_SOCK
  ln -sf $SSH_AUTH_SOCK $SYM_SSH_AUTH_SOCK
end

set -x SSH_AUTH_SOCK $SYM_SSH_AUTH_SOCK

