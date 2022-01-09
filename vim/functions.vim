"""""""""""""""""""""""""""""""
"            editor           "
"""""""""""""""""""""""""""""""
function! ToggleSignColumn()
  if !exists("b:signcolumn_on") || b:signcolumn_on
    set signcolumn=no
    let b:signcolumn_on=0
  else
    set signcolumn=yes:1
    let b:signcolumn_on=1
  endif
endfunction
