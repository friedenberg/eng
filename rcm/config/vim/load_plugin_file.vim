
function! LoadPluginFile(f)
  let l:fileName = expand(a:f)
  if filereadable(l:fileName)
    let s:lines = readfile(l:fileName)
    for s:line in s:lines
      call plug#(s:line)
    endfor
  endif
endfunction
