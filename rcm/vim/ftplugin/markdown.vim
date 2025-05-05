
let s:path_bin = fnamemodify(resolve(expand('<sfile>:p')), ':p:h') . "/result/bin/"
let &l:equalprg = s:path_bin."pandoc
      \ --columns=80
      \ -f markdown -t markdown
      \ '%' -o -"

let &l:textwidth = 80
