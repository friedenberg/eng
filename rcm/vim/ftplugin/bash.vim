
" Softtabs, 2 spaces
set tabstop=2
set shiftwidth=2
set shiftround
set expandtab

setlocal equalprg=shfmt\ %

let s:path = expand('<sfile>:p')
let &makeprg = s:path." -f gcc % >&1"
