" ----------------------------------------
" File: .vimrc
" Author: Chris Brown <cb@tardis.ed.ac.uk>
" Last Change: 29-Dec-2010.
"
" Large Contributions:
"   Ryan Tomayko - (romayko/dotfiles)
" ----------------------------------------

call pathogen#helptags()
call pathogen#runtime_append_all_bundles()

" Plugin Variables
let Tlist_GainFocus_On_ToggleOpen=1

let g:detectindent_preferred_expandtab = 1
let g:detectindent_preferred_indent = 4

" == GENERAL ========================================================

" nocompatible - turns off vi compatibility. vim supremacy!
set nocompatible

" hide top bar
set guioptions-=T

" ffs - allow vim to work nativly with all main eol characters
set ffs=unix,dos,mac

" When wrapping paragraphs, don't end lines 
" with 1-letter words (looks stupid)        
set formatoptions+=1            

" modeline - make sureModeline support
set modeline

" autoread - automatically reload files when they are changed on disk
set autoread

" change the pwd to the directory of the current file
"set autochdir

" spell - turn off spelling
set nospell

" linebreak - Break at word endings
set linebreak

" wildmode - Make file completion like batch
set wildmode=list:longest,full

" wildignore - Ignore certain filetypes
set wildignore=*.o,*.class,*.pyc,*.pyo
set wildignore+=.svn,CVS,.git          " Ignore VCS files
set wildignore+=*.o,*.a,*.so           " Ignore compiled binaries
set wildignore+=*.jpg,*.png,*.gif      " Ignore images
set wildignore+=*.pdf                  " Ignore PDF files
set wildignore+=*.pyc,*.pyo            " Ignore compiled Python files
set wildignore+=*.hi,*.ho              " Ignore compiled Haskell files
set wildignore+=*.fam                  " Ignore compiled Falcon files

set mousehide                          " Hide mouse when typing

" showmode - show the mode in the status line
set showmode

" showcmd - show the command in the status line
set showcmd

" laststatus - always show the status bar
set laststatus=2

" showmatch - Show matching brace
set showmatch

" matchtime - Time to match for
set matchtime=3

" allow freeform visual selections
set virtualedit=block

" mapleader - Set the leader key to '`'. Easier to type on a British
"             mac keyboard.
let mapleader = "`"

" history - remember a lot of stuff
set history=2000

" undo - set up persistent undo
set undofile
set undodir=~/.undo

" scrolloff - start scrolling with 5 lines to go
set scrolloff=5

" == SEARCHING ======================================================
" hlsearch - Highlight search matches
set hlsearch

" ignorecase - Ignore case when searching
set ignorecase

" incsearch - Try to find matches as we type the search string
set incsearch

" smartcase - Only be case sensitive if the search string contains an uppercase letter
set smartcase

" == VISUAL =========================================================
" syntax - turn syntax highlighting on
syntax on

" colorscheme - vim theme
colorscheme sorcerer

" number - Turns on line numbering
set number

" shut the fuck up (rtomayko/dotfiles)
set visualbell

" ruler - always show the ruler in the status bar
set ruler

" nolazyredraw - divert power to the redraw engines!
set nolazyredraw

" ch - set the height of the command bar to 2
set ch=2

" report - report every change to me
set report=0

" nostartofline - don't move the sursor to the start of the line when
"                 scrolling
set nostartofline

" single space after full stop
set nojoinspaces

set fileencodings=utf-8                " Default to using UTF-8
set matchpairs+=<:>                    " Match angle brackets
set grepprg=grep\ -nH\ $*              " Grep should show the line and file number

" status line - only if we're running a good version of vim
set statusline=%t%=%{fugitive#statusline()}\ %#warningmsg#\ %{SyntasticStatuslineFlag()}\ (%{strlen(&ft)?&ft:'?'},%{&fenc},%{&ff})\ \ %-9.(%l,%c%V%)\ \ %<%P\ %*

" pretty gui cursor
set guicursor=n-v-c:block-Cursor-blinkon0
set guicursor+=ve:ver35-Cursor
set guicursor+=o:hor50-Cursor
set guicursor+=i-ci:ver25-Cursor
set guicursor+=r-cr:hor20-Cursor
set guicursor+=sm:block-Cursor-blinkwait175-blinkoff150-blinkon175

"set colorcolumn=85

" == INDENT ========================================================
set tabstop=4
set smarttab
set shiftwidth=4
set autoindent
set backspace=start,indent,eol

" == KEYBINDINGS ===================================================
" Create a scratch buffer
nmap <Leader>s :vnew<CR>:set buftype=nofile<CR>

" -- Make C-e and C-y scroll faster
nnoremap <C-e> 5<C-e>
nnoremap <C-y> 5<C-y>

" -- Easy split movement
set winheight=25
map <C-j> <C-W>j<C-W>_
map <C-k> <C-W>k<C-W>_
map <C-h> <C-W>h<C-W>_
map <C-l> <C-W>l<C-W>_

" Thanks to Steve Losh for this liberating tip
" See http://stevelosh.com/blog/2010/09/coming-home-to-vim
nnoremap / /\v
vnoremap / /\v

" Long lines can mess up movement - fix that
nnoremap j gj
nnoremap k gk
vnoremap j gj
vnoremap k gk

map <up>        <nop>
map <down>      <nop>
map <left>      <nop>
map <right>     <nop>
map <Del>       <nop>
map <Home>      <nop>
map <End>       <nop>
map <PageUp>    <nop>
map <PageDown>  <nop>

imap <up>       <nop>
imap <down>     <nop>
imap <left>     <nop>
imap <right>    <nop>
imap <Del>      <nop>
imap <Home>     <nop>
imap <End>      <nop>
imap <PageUp>   <nop>
imap <PageDown> <nop>

" Markdown Underlining
map <leader>1 yypVr=

" Crush leading whitespace
nnoremap <leader>w :%s/\s\+$//<cr>:let @/=''<CR>

" Wrap a paragraph
nnoremap <leader>q gqip

" Comment a line
map <leader>c <plug>NERDCommenterToggle<CR>

" Show a list of syntax errors
map <leader>e :Errors<cr>

" Show a list of tags
map <leader>t :TlistToggle<cr>

" Easy exit to normal mode.
inoremap jj <ESC>

" Move aroud quicklists
map <C-Up> :cprev<CR>
map <C-Down> :cnext<CR>

" NERDTree
map <leader>f :execute ':NERDTreeToggle ' . getcwd()<CR>

" STOP HIGHLIGHTING DAMMIT
map <leader><space> :nohlsearch<CR>

cmap w!! %!sudo tee > /dev/null %

nnoremap <leader>u :GundoToggle<CR>

" Bubble Bubble
nmap <D-Up> [e
nmap <D-Down> ]e

vmap <D-Up> [egv
vmap <D-Down> ]egv

" reselect visual block after in/dedent so we can in/dedent more
vnoremap < <gv
vnoremap > >gv

nmap <leader>v :tabedit $MYVIMRC<CR>

" Use Q for formatting the current paragraph (or selection)
vmap Q gq
nmap Q gqap

if exists(":Tabularize")
  nmap <Leader>a= :Tabularize /=<CR>
  vmap <Leader>a= :Tabularize /=<CR>
  nmap <Leader>a: :Tabularize /:\zs<CR>
  vmap <Leader>a: :Tabularize /:\zs<CR>
endif

inoremap <silent> <Bar>   <Bar><Esc>:call <SID>align()<CR>a
 
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

" format program
set formatprg=par\ -w\ 80

" == FILETYPE ======================================================
" filetype plugin - Plugin loading for specific filetypes
filetype plugin on
filetype plugin indent on

set ofu=syntaxcomplete#Complete

set tags=./tags;

" -- new filetypes
autocmd BufNewFile,BufRead,BufEnter *.txt setlocal filetype=markdown


autocmd BufNewFile,BufReadPost * :Rooter

" language specific settings
autocmd FileType python set ts=4|set sw=4|set expandtab|set sts=4
autocmd FileType ruby set ts=2|set sw=2|set expandtab|set sts=2
autocmd FileType java set ts=4|set sw=4|set noexpandtab|set sts=4

" Reload my vimrc on save. - disabled due to problem with macvim
if has("autocmd")
	autocmd BufWritePost .vimrc source $MYVIMRC
endif

" == BACKUP ========================================================
set backupdir=$HOME/.vim/backup//        " store backups under ~/.vim/backup
set backupcopy=yes                     " keep attributes of original file
set backupskip=/tmp/*,$TMPDIR/*,$TMP/*,$TEMP/*
set directory=~/.vim/swap//      " keep swp files under ~/.vim/swap

au FocusLost * :wa

" == PLUGINS
" Gist Configuration
let g:gist_clip_command = 'pbcopy'
let g:gist_detect_filetype = 1
let g:gist_open_browser_after_post = 1

" == ABBREVIATIONS
" Vim Stuff
cabbrev Q quit
cabbrev W write

" == SPELLING
" Common Stuff
iab teh the
