" ----------------------------------------
" File: .vimrc
" Author: Chris Brown <cb@tardis.ed.ac.uk>
" Last Change: 16-Feb-2011.
"
" Large Contributions:
"	Ryan Tomayko - (romayko/dotfiles)
" ----------------------------------------

" == PATHOGEN CALLS =================================================
call pathogen#helptags()
call pathogen#runtime_append_all_bundles()

" == PLUGIN VARIABLES ===============================================
" Taglist should gain focus when opened.
let Tlist_GainFocus_On_ToggleOpen=1

" If we can't detect the indentation of the file, use these.
let g:detectindent_preferred_expandtab = 1
let g:detectindent_preferred_indent = 2

" Gist Configuration
let g:gist_clip_command = 'pbcopy'
let g:gist_detect_filetype = 1
let g:gist_open_browser_after_post = 1

" == GENERAL ========================================================
" Turn off vi compatibility. Vim Supremacy!
set nocompatible

" Allow vim to work natively with all main eol characters.
set ffs=unix,dos,mac

" Set format options, look at ':help fo-table'.
set formatoptions+=1

" Turn on modeline support.
set modeline

" Automatically reload files when they are changed on disk.
set autoread

" Write all files when running :make
set autowrite

" Turn off spell checking.
set nospell

" Break at word endings.
set linebreak

" Make file completion like a shell.
set wildmode=list:longest,full

" Ignore certain filetypes.
set wildignore=*.class				   " Ignore compiled Java files
set wildignore+=.svn,CVS,.git		   " Ignore VCS files
set wildignore+=*.o,*.a,*.so		   " Ignore compiled binaries
set wildignore+=*.jpg,*.png,*.gif	   " Ignore images
set wildignore+=*.pdf				   " Ignore PDF files
set wildignore+=*.pyc,*.pyo			   " Ignore compiled Python files
set wildignore+=*.hi,*.ho			   " Ignore compiled Haskell files
set wildignore+=*.fam				   " Ignore compiled Falcon files

" Hide the mouse while typing.
set mousehide

" Show the mode in the status line.
set showmode

" Show the command in the status line.
set showcmd

" Always show the status bar.
set laststatus=2

" Show matching brace on insertion or cursor over.
set showmatch
set matchtime=3
set matchpairs+=<:>

" Allow freeform visual selections.
set virtualedit=block

" Set the <leader> key to '`'.
let mapleader = "`"

" Remember many commands into the past.
set history=2000

" Set up persistent undo.
if version >= 730
  set undofile
  set undodir=~/.undo
endif

" Start scrolling with 5 lines to go.
set scrolloff=5

" Report every change to me.
set report=0

" Don't move the sursor to the start of the line when scrolling.
set nostartofline

" Single space after full stop.
set nojoinspaces

" Bad sound. Bad!
set visualbell

" Default to using UTF-8.
set fileencodings=utf-8

" Grep should show the line and file number.
set grepprg=grep\ -nH\ $*

" Open a new split on the right or below.
set splitright
set splitbelow

" Use the same symbols as TextMate for tabstops and EOLs
set listchars=tab:▸\ ,eol:¬

" == SEARCHING ======================================================
" Highlight search matches.
set hlsearch

" Ignore case when searching.
set ignorecase

" Try to find matches as we type the search string.
set incsearch

" Only be case sensitive if the search string contains an uppercase letter.
set smartcase

" == GUI =============================================================
" Turn syntax highlighting on.
syntax on

" Vim Theme
set background=dark
colorscheme solarized

hi EasyMotionTarget ctermbg=none ctermfg=196 cterm=bold guifg=#ff4500
hi EasyMotionShade ctermbg=none ctermfg=240 cterm=none guifg=#222222 

" Set global color settings, regardless of colorscheme currently in use.
function! GlobalColorSettings()
    " Set 'TODO' & 'FIXME' strings to be bold and standout as hell.
    highlight Todo term=standout ctermfg=196 guifg=#ff4500
endfunction

" Turns on line numbering.
set number

" Always show the ruler in the status bar.
set ruler

" Divert power away from the redraw engines!
set lazyredraw

" Set the height of the command bar to 2.
set ch=2

" Set the font.
set guifont=Monaco:h12

" Set the status line.
"
"	 %t - filename
"
"  %{cfi#get_func_name()} - current function name
"
"	 %{fugitive#statusline()} - branch information
"
"	 %#warningmsg# - file syntax warnings
"	 %{SyntasticStatuslineFlag()} - file syntax error flags
"
"	 (%{strlen(&ft)?&ft:'?'} - <filetype>
"	 %{&fenc} - <file encoding>
"	 %{&ff}) - <line endings>
"
"	 %-9.(%l,%c%V%) - <row>, <column>
"	 %<%P\ %* - percentage of way through document
"
set statusline=\ %t
set statusline+=%(\[%M%R%H]%)
set statusline+=\ %{strlen(cfi#get_func_name())?'>\ '.cfi#get_func_name():''}
set statusline+=\ %=%{fugitive#statusline()}
set statusline+=%#warningmsg#%{strlen(SyntasticStatuslineFlag())?SyntasticStatuslineFlag():''}%*
set statusline+=\ (%{strlen(&ft)?&ft:'?'},%{&fenc},%{&ff})
set statusline+=\ %-9.(%l,%c%V%)
set statusline+=\ %l/%L\ (%<%P)\ %*

" Pretty GUI Cursor.
set guicursor=n-v-c:block-Cursor-blinkon0
set guicursor+=ve:ver35-Cursor
set guicursor+=o:hor50-Cursor
set guicursor+=i-ci:ver25-Cursor
set guicursor+=r-cr:hor20-Cursor
set guicursor+=sm:block-Cursor-blinkwait175-blinkoff150-blinkon175

" Use the same symbols as TextMate for tabstops and EOLs
set listchars=tab:▸\ ,trail:·,eol:¬

" == INDENT ========================================================
set tabstop=4
set smarttab
set shiftwidth=4
set autoindent
set backspace=start,indent,eol

" == KEYBINDINGS ===================================================
" Create a scratch buffer
nmap <Leader>s :vnew<CR>:set buftype=nofile<CR>

" Make C-e and C-y scroll faster.
nnoremap <C-e> 5<C-e>
nnoremap <C-y> 5<C-y>

" Easy split movement.
map <C-j> <C-W>j<C-W>_
map <C-k> <C-W>k<C-W>_
map <C-h> <C-W>h<C-W>_
map <C-l> <C-W>l<C-W>_

" Make the regex engine be a bit more normal.
"nnoremap / /\v
"vnoremap / /\v

" Long lines can mess up movement.
nnoremap j gj
nnoremap k gk
vnoremap j gj
vnoremap k gk

" Create a new line below no matter where we are in the current line.
imap <D-Return> <ESC>o
nmap <D-Return> o<ESC>

" OLD HABITS. ELIMINATE THEM.
map <up>		<nop>
map <down>		<nop>
map <left>		<nop>
map <right>		<nop>
map <Del>		<nop>
map <Home>		<nop>
map <End>		<nop>
map <PageUp>	<nop>
map <PageDown>	<nop>

imap <up>		<nop>
imap <down>		<nop>
imap <left>		<nop>
imap <right>	<nop>
imap <Del>		<nop>
imap <Home>		<nop>
imap <End>		<nop>
imap <PageUp>	<nop>
imap <PageDown> <nop>

" Markdown Underlining
map <leader>1 yypVr=
map <leader>2 yypVr-

" Crush leading whitespace.
nnoremap <leader>c :%s/\s\+$//<cr>:let @/=''<CR>

" Show a list of syntax errors
map <leader>s :Errors<cr>

" Show a list of tags
map <leader>a :TlistToggle<cr>

" Move aroud quicklists
map <C-Up> :cprev<CR>
map <C-Down> :cnext<CR>

" NERDTree
map <leader>n :execute ':NERDTreeToggle ' . getcwd()<CR>

" STOP HIGHLIGHTING DAMMIT
map <leader><space> :nohlsearch<CR>

" You forgot to `sudo vim` a read only file. No problem!
cmap w!! %!sudo tee > /dev/null %

" Show the best undo plugin ever.
nnoremap <leader>u :GundoToggle<CR>

" Bubble Bubble, Toil and Trouble.
nmap <D-Up> [e
nmap <D-Down> ]e
vmap <D-Up> [egv
vmap <D-Down> ]egv

" Reselect visual block after in/dedent so we can in/dedent more.
vnoremap < <gv
vnoremap > >gv

" Open up .vimrc from anywhere.
nmap <leader>v :tabedit $MYVIMRC<CR>

" Shortcut to rapidly toggle `set list`
nmap <leader>l :set list!<CR>

" Use Q for formatting the current paragraph (or selection).
vmap Q gq
nmap Q gqap

" Toggle between number and relative number.
nnoremap <leader>r :call ToggleRelativeAbsoluteNumber()<CR>
function! ToggleRelativeAbsoluteNumber()
  if &number
    set relativenumber
  else
    set number
  endif
endfunction

" Align lines based on a character.
if exists(":Tabularize")
  nmap <Leader>a= :Tabularize /=<CR>
  vmap <Leader>a= :Tabularize /=<CR>
  nmap <Leader>a: :Tabularize /:\zs<CR>
  vmap <Leader>a: :Tabularize /:\zs<CR>
  nmap <Leader>a& :Tabularize /&<CR>
  vmap <Leader>a& :Tabularize /&<CR>
endif

" Align tables while creating them.
inoremap <silent> <Bar> <Bar><Esc>:call <SID>align()<CR>a

function! s:align()
  let p = '^\s*|\s.*\s|\s*$'
  if exists(':Tabularize') && getline('.') =~# '^\s*|' && (getline(line('.')-1) =~# p || getline(line('.')+1) =~# p)
	let column = strlen(substitute(getline('.')[0:col('.')],'[^|]','','g'))
	let position = strlen(matchstr(getline('.')[0:col('.')],'.*|\s*\zs.*'))
	Tabularize/|/l1
	normal! 0
	call search(repeat('[^|]*|',column).'\s\{-\}'.repeat('.',position),'ce',line('.'))
  endif
endfunction

" When editing a file, always jump to the last known cursor position. Don't do
" it when the position is invalid or when inside an event handler (happens
" when dropping a file on gvim).
if has("autocmd")
  autocmd BufReadPost *
	\ if line("'\"") > 0 && line("'\"") <= line("$") |
      \ exe "normal g`\"" |
    \ endif
endif

" == FILETYPE ======================================================
" Plugin loading for specific filetypes.
filetype plugin on
filetype plugin indent on

" Set the omnicomplete function.
set ofu=syntaxcomplete#Complete

" Search for the tag file up to the filesystem root.
set tags=./tags;

" == EVENTS ==========================================================
" Markdown is great for writing text files.
autocmd BufNewFile,BufRead,BufEnter *.txt setlocal filetype=markdown

" Change the root folder of a project based on where the VCS is.
autocmd BufNewFile,BufReadPost * :Rooter

" language specific settings
autocmd FileType python set ts=4|set sw=4|set expandtab|set sts=4
autocmd FileType ruby set ts=2|set sw=2|set expandtab|set sts=2
autocmd FileType vim set ts=2|set sw=2|set expandtab|set sts=2
autocmd FileType java set ts=4|set sw=4|set noexpandtab|set sts=4
"autocmd FileType markdown set formatoptions+=tcq1roqan

" Mail files should be set up properly.
autocmd BufRead,BufNewFile sup.* set filetype=mail | set textwidth=72 | set spell | set wrap

" Save all files when Vim loses focus.
autocmd FocusLost * :wa

" Reload my vimrc when I save it.
autocmd BufWritePost .vimrc source $MYVIMRC

autocmd ColorScheme * call GlobalColorSettings()  " Call the global color settings on every colorscheme change.

" == BACKUP ========================================================
set backupdir=$HOME/.vim/backup//		 " store backups under ~/.vim/backup
set backupcopy=yes					     " keep attributes of original file
set backupskip=/tmp/*,$TMPDIR/*,$TMP/*,$TEMP/*
set directory=~/.vim/swap//	         	 " keep swp files under ~/.vim/swap

" == ABBREVIATIONS
" Vim Stuff
cabbrev Q quit
cabbrev W write

" == SPELLING
" Common Stuff
iab teh the
iab recieve receive
