"""""""""""""""""""""""""""""""
"         undo - redo         "
"""""""""""""""""""""""""""""""
"
"      ctrl + z: undo
"      ctrl + y: redo
"
nnoremap <silent> <C-z>      u
inoremap <silent> <C-z> <Esc>ugi
vnoremap <silent> <C-z> <Esc>ugv

nnoremap <silent> <C-y>      <C-R>
inoremap <silent> <C-y> <Esc><C-R>gi
vnoremap <silent> <C-y> <Esc><C-R>gv

"""""""""""""""""""""""""""""""
"         copy - paste        "
"""""""""""""""""""""""""""""""
"
"       alt + c: copy
"       alt + x: cut
"       alt + v: paste
"
nnoremap <M-c>      yy
inoremap <M-c> <Esc>yygi
vnoremap <M-c>      ygv

nnoremap <M-x>      dd
inoremap <M-x> <Esc>ddgi
vnoremap <M-x>      d

nnoremap <M-v>      p
inoremap <M-v> <Esc>pgi
vnoremap <M-v>      p

"""""""""""""""""""""""""""""""
"          move lines         "
"""""""""""""""""""""""""""""""
"
"         alt +   up: move line up
"         alt + down: move line down
" alt + shift +   up: copy line up
" alt + shift + down: copy line down
"
nnoremap <silent> <M-UP>        :m-2<CR>
inoremap <silent> <M-UP>   <Esc>:m-2<CR>gi
vnoremap <silent> <M-UP>        :m'<-2<CR>gv

nnoremap <silent> <M-DOWN>      :m+1<CR>
inoremap <silent> <M-DOWN> <Esc>:m+1<CR>gi
vnoremap <silent> <M-DOWN>      :m'>+1<CR>gv

nnoremap <silent> <M-S-UP> yykp
inoremap <silent> <M-S-UP> <Esc>yykpgi<up>
vnoremap <silent> <M-S-UP> Y'>pgv

nnoremap <silent> <M-S-DOWN> yyp
inoremap <silent> <M-S-DOWN> <Esc>yypgi<down>
vnoremap <silent> <M-S-DOWN> Ykpgv

"""""""""""""""""""""""""""""""
"            select           "
"""""""""""""""""""""""""""""""
"
"  ctrl + m: visual block mode
"
" shift + [up|down|left|rigt]:
"          select line|char
"
"  ctrl + shift + [left|rigt]:
"          select word
"
nnoremap <C-l> <C-v>
inoremap <C-l> <Esc><C-v>
vnoremap <C-l> <Esc><C-v>

nnoremap <S-UP> vk
inoremap <S-UP> <Esc>vk
vnoremap <S-UP> k

nnoremap <S-DOWN> vj
inoremap <S-DOWN> <Esc>vj
vnoremap <S-DOWN> j

nnoremap <S-RIGHT> vl
inoremap <S-RIGHT> <Esc>vl
vnoremap <S-RIGHT> l

nnoremap <S-LEFT> vh
inoremap <S-LEFT> <Esc>vh
vnoremap <S-LEFT> h

nnoremap <S-C-RIGHT> ve
inoremap <S-C-RIGHT> <Esc>ve
vnoremap <S-C-RIGHT> e

nnoremap <S-C-LEFT> vb
inoremap <S-C-LEFT> <Esc>vb
vnoremap <S-C-LEFT> b

"""""""""""""""""""""""""""""""
"            delete           "
"""""""""""""""""""""""""""""""
"
"   ctrl + del: delete word
"
vnoremap<BS> d

nnoremap <C-DEL> dw
inoremap <C-DEL> <Esc>ldwgi

"""""""""""""""""""""""""""""""
"            indent           "
"""""""""""""""""""""""""""""""
"
"          tab: indent
"  shift + tab: undo indent
"
nnoremap <TAB> >>
vnoremap <TAB> >gv

nnoremap <S-TAB> <<
inoremap <S-TAB> <Esc><<gi<left><left>
vnoremap <S-TAB> <gv

"""""""""""""""""""""""""""""""
"           comment           "
"""""""""""""""""""""""""""""""
"
"     ctrl + /: toggle comment
"
nmap <C-_> gcc
imap <C-_> <Esc>gccgi
vmap <silent> <C-_> <Esc>:'<,'>Commentary<CR>gv

"""""""""""""""""""""""""""""""
"             tree            "
"""""""""""""""""""""""""""""""
"
"     ctrl + b: toggle
"
nnoremap <silent> <C-b> :NvimTreeToggle<CR>
inoremap <silent> <C-b> <Esc>:NvimTreeToggle<CR>
vnoremap <silent> <C-b> <Esc>:NvimTreeToggle<CR>

"""""""""""""""""""""""""""""""
"         buffer line         "
"""""""""""""""""""""""""""""""
"
"         alt + t: go to next tab
" alt + shift + t: go to previous tab
"
nnoremap <silent> <M-t> :BufferLineCycleNext<CR>
nnoremap <silent> <M-S-t> :BufferLineCyclePrev<CR>

"""""""""""""""""""""""""""""""
"             file            "
"""""""""""""""""""""""""""""""
"
"     ctrl + s: save
"     ctrl + w: close tab
"     ctrl + q: quit
"
nnoremap <silent> <C-s> :w<CR>
inoremap <silent> <C-s> <Esc>:w<CR>gi
vnoremap <silent> <C-s> <Esc>:w<CR>gv

nnoremap <silent> <C-w> :Bdelete<CR>
inoremap <silent> <C-w> <Esc>:Bdelete<CR>
vnoremap <silent> <C-w> <Esc>:Bdelete<CR>

nnoremap <silent> <C-q> :q<CR>
inoremap <silent> <C-q> <Esc>:q<CR>
vnoremap <silent> <C-q> <Esc>:q<CR>

"""""""""""""""""""""""""""""""
"            split            "
"""""""""""""""""""""""""""""""
"
"      alt + -: split down
"      alt + |: split right
"
nnoremap <M--> :split<CR>
nnoremap <M-\> :vsplit<CR>

"""""""""""""""""""""""""""""""
"            other            "
"""""""""""""""""""""""""""""""
"
"     ctrl + n: toggle number
"     ctrl + h: hide search result
"
nnoremap <silent> <C-n>      :set invnumber<CR>:call ToggleSignColumn()<CR>
inoremap <silent> <C-n> <Esc>:set invnumber<CR>:call ToggleSignColumn()<CR>gi
vnoremap <silent> <C-n> <Esc>:set invnumber<CR>:call ToggleSignColumn()<CR>gv

nnoremap <silent> <C-h> :noh<CR>
