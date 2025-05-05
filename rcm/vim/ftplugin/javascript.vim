
let s:path_bin = fnamemodify(resolve(expand('<sfile>:p')), ':p:h') . "/result/bin/"
let &l:equalprg = s:path_bin."prettier %"

let &l:makeprg = s:path_bin."eslint --format unix %"
