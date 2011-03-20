" MacVim
if has("gui_macvim")
  " Fullscreen takes up entire screen
  set fuoptions=maxhorz,maxvert

  " Hide Top Bar
  set guioptions-=T
  
  " Nicer Colourscheme
  colorscheme lucius

  " Command-T for CommandT
  macmenu &File.New\ Tab key = <nop>
  map <D-t> <Plug>PeepOpen<cr>

  " Command-Shift-F for Ack
  macmenu Window.Toggle\ Full\ Screen\ Mode key = <nop>
  map <D-F> :Ack<space>

  " Command-e for ConqueTerm
  map <D-e> :call StartTerm()<CR>

  " Command-/ to toggle comments
  map <D-/> <plug>NERDCommenterToggle<CR>

  " Command-][ to increase/decrease indentation
  vmap <D-]> >gv
  vmap <D-[> <gv
endif

" ConqueTerm wrapper
function! StartTerm()
  execute 'ConqueTermSplit ' . $SHELL . ' --login'
  setlocal listchars=tab:\ \ 
endfunction

