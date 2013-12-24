"
" ~/.vimrc
"
" Inspired by
" http://dougireton.com/blog/2013/02/23/layout-your-vimrc-like-a-boss/
" http://stevelosh.com/blog/2010/09/coming-home-to-vim/
" http://nvie.com/posts/how-i-boosted-my-vim/
" --------------------------------------------------------------------------- "
" --------------------------------------------------------------------------- "
"                                 OPTIONS
" --------------------------------------------------------------------------- "
" --------------------------------------------------------------------------- "
"  1 important
" --------------------------------------------------------------------------- "

" Use Vim settings, rather then Vi settings (much better!).
" This must be first, because it changes other options as a side effect.
set nocompatible

" --------------------------------------------------------------------------- "
"  2 moving around, searching and patterns
" --------------------------------------------------------------------------- "

set nostartofline            " keep cursor in same column for long movements
set ignorecase               " Do case insensitive matching...
set smartcase                " ... except when pattern contains uppercase
set incsearch                " Incremental search

" --------------------------------------------------------------------------- "
"  3 tags
" --------------------------------------------------------------------------- "

" --------------------------------------------------------------------------- "
"  4 displaying text
" --------------------------------------------------------------------------- "

set scrolloff=3              " Keep some lines around current line
let &showbreak = '+++ '      " Explicitly mark line continuations with +++
set linebreak                " Only break lines at word boundaries
set relativenumber           " Show line numbers relative to current line
set number                   " ... but still give abs number for current line
set list                     " Show whitespace using characters ...
set listchars=tab:>-,trail:. " ... tabs and trailing spaces

" --------------------------------------------------------------------------- "
"  5 syntax, highlighting and spelling
" --------------------------------------------------------------------------- "

set background=dark          " Adjust colors for dark terminal background
set hlsearch                 " Highlight all matches of previous search
set cursorline               " Highlight screen line of cursor

" --------------------------------------------------------------------------- "
"  6 multiple windows
" --------------------------------------------------------------------------- "

set laststatus=2             " Windows always have status lines
set winheight=15             " Current window shouldn't be too small
set winwidth=80              " or too narrow
set hidden                   " Hide buffers when they are abandoned
set switchbuf=useopen,split  " For quick fix lists, jump to file containing
                             " errors if already open, else split to open it
set splitbelow               " Put newly opened split windows below...
set splitright               " ... and to the right of current window

" --------------------------------------------------------------------------- "
"  7 multiple tab pages
" --------------------------------------------------------------------------- "

" --------------------------------------------------------------------------- "
"  8 terminal
" --------------------------------------------------------------------------- "

set title                    " Change window title to include filename

" --------------------------------------------------------------------------- "
"  9 using the mouse
" --------------------------------------------------------------------------- "

set mouse=                   " Disable mouse (allows copying from vim
                             " via middle click paste)

" --------------------------------------------------------------------------- "
" 10 printing
" --------------------------------------------------------------------------- "

" --------------------------------------------------------------------------- "
" 11 messages and info
" --------------------------------------------------------------------------- "

set ruler                    " Show ruler bar (row, column, and file location)
set report=0                 " Always report number of lines altered
set vb t_vb=                 " No bell or visual bell
set showcmd                  " Show (partial) command in status line.

" --------------------------------------------------------------------------- "
" 12 selecting text
" --------------------------------------------------------------------------- "

" --------------------------------------------------------------------------- "
" 13 editing text
" --------------------------------------------------------------------------- "

set undolevels=4096          " Lots of undo
set textwidth=79             " Used to break comments (and text if enabled)
set backspace=2              " Can backspace over everything in insert mode
set formatoptions=croq       " Automatically wrap and 'gq' comments, and insert
                             " comment leaders on new lines
set formatoptions+=1         " Don't break after 1-letter words
set formatoptions+=j         " Remove comment leader when joining lines
set formatoptions+=n         " Autoformat numbered lists
set completeopt=menuone      " Always show popup menu for C-n completion...
set completeopt+=preview     " ... and show extra information about completion
set showmatch                " Show matching brackets.

" --------------------------------------------------------------------------- "
" 14 tabs and indenting
" --------------------------------------------------------------------------- "

" These settings will likely be overridden by particular project / language
" style conventions. These are generic defaults basically to avoid doing any
" shocking automatic changes.
set tabstop=8                " Display tabs as 8 spaces
set shiftwidth=8             " Use 8 spaces worth for autoindent and <<,>>,etc
set noexpandtab              " Actually put tabs in the file when <Tab> pressed
                             " or when using autoindent, <<, >>
set autoindent               " Automatically indent to match current line
                             " (will be overridden by filetype indents etc)
set copyindent               " match space/tab mix of prev line for autoindent
set preserveindent           " Preserve space/tab mix of line for <<, >>, etc

" --------------------------------------------------------------------------- "
" 15 folding
" --------------------------------------------------------------------------- "

" Details of how to fold will be set by filetype plugins.
set foldenable               " Use IDE-style folding
set foldlevelstart=0         " Start with all folds closed when opening a file
set foldclose=all            " Folds close when moving out of them
set foldopen=all             " Folds open when pretty much anything takes
                             " cursor into them
set foldmethod=manual        " No automatically created folds

" --------------------------------------------------------------------------- "
" 16 diff mode
" --------------------------------------------------------------------------- "

" --------------------------------------------------------------------------- "
" 17 mapping
" --------------------------------------------------------------------------- "

" --------------------------------------------------------------------------- "
" 18 reading and writing files
" --------------------------------------------------------------------------- "

set nomodeline               " Mode lines are scary
set nowritebackup            " No backup files when overwriting

" --------------------------------------------------------------------------- "
" 19 the swap file
" --------------------------------------------------------------------------- "

set noswapfile               " No swap files

" --------------------------------------------------------------------------- "
" 20 command line editing
" --------------------------------------------------------------------------- "

set history=128              " Remember last 128 commands
set wildmode=longest,list    " Tab complete file names bash-style
" Wildcards ignore lots of files we would never open in vim
set wildignore+=*.bak,*.swp,*.tmp,*~
set wildignore+=*.o,*.a,*.d,*.so,*.out
set wildignore+=*.class,*.gz,*.hi,*.pdf,*.dvi,*.aux,*.log

" --------------------------------------------------------------------------- "
" 21 executing external commands
" --------------------------------------------------------------------------- "

" --------------------------------------------------------------------------- "
" 22 running make and jumping to errors
" --------------------------------------------------------------------------- "

" --------------------------------------------------------------------------- "
" 23 language specific
" --------------------------------------------------------------------------- "

" --------------------------------------------------------------------------- "
" 24 multi-byte characters
" --------------------------------------------------------------------------- "

" --------------------------------------------------------------------------- "
" 25 various
" --------------------------------------------------------------------------- "

set viminfo='100             " Save registers, pattern/cmd history, and marks
                             " to viminfo file to be loaded on startup

" --------------------------------------------------------------------------- "
" --------------------------------------------------------------------------- "
"                      AUTOCOMMANDS AND EXTERNAL FILES
" --------------------------------------------------------------------------- "
" --------------------------------------------------------------------------- "
if has('autocmd')

" Jump to the last position when reopening a file.
au BufReadPost * if line("'\"") > 0 && line("'\"") <= line("$")
    \ | exe "normal! g'\"" | endif

" Fix up some file extensions vim doesn't know about
au BufNewFile,BufRead *.rkt set filetype=scheme  " plt racket
au BufNewFile,BufRead *.flex set filetype=lex    " gnu flex
au BufNewFile,BufRead *.do set filetype=sh       " apenwarr redo

" Automagically open quickfix / location window when running
" appropriate commands (:make, :grep, etc.)
au QuickFixCmdPost [^l]* nested cwindow
au QuickFixCmdPost    l* nested lwindow

filetype plugin indent on    " Detect filetypes, load plugin and indent files

" Custom settings for various filetypes
au FileType lisp,scheme,clojure,racket,haskell,ocaml
    \ set expandtab shiftwidth=2 softtabstop=2 " 2 spaces no tabs
au FileType tex,text
    \ set formatoptions+=t " wrap all text

endif

runtime! macros/matchit.vim " Use fancy % matching algorithm

" Use pathogen (~/.vim/bundle/vim-pathogen/autoload/pathogen.vim) to
" automatically load all packages under ~/.vim/bundle/
" Note this will not automatically tag all help files included in doc/
" directories : to do so, run :Helptags in vim
runtime bundle/vim-pathogen/autoload/pathogen.vim
execute pathogen#infect()

" --------------------------------------------------------------------------- "
" --------------------------------------------------------------------------- "
"                                MAPPINGS
" --------------------------------------------------------------------------- "
" --------------------------------------------------------------------------- "

" Shortcut for getting into command mode
nnoremap ; :
" Use Dvorak home row for movements (htns not hjkl)
noremap t gj
noremap n gk
noremap s l
noremap S L
" Move overwritten keys:
noremap l n
noremap L N
" l for 'lookup next search'
noremap k s
" k for 'kill (and replace) some characters'
" never use t or T movements anyway, or S command

" Easy movement to start and end of line
noremap - 0
noremap _ $

" Easy movement between matching brace / paren pairs
noremap <Tab> %

" Hardcore vim mode: no arrow keys in insert, normal, visual, or operator mode
noremap <Up> <Nop>
noremap <Down> <Nop>
noremap <Left> <Nop>
noremap <Right> <Nop>
inoremap <Up> <Nop>
inoremap <Down> <Nop>
inoremap <Left> <Nop>
inoremap <Right> <Nop>

" Use , as map leader for custom fancy mappings
let mapleader=","

" Quickly stop highlighting most recent search
nnoremap <Leader><Space> :nohlsearch<CR>
" Turn paste mode on and off
nnoremap <Leader>p :set paste!<CR>
" Turn line numbering on and off
nnoremap <Leader>l :set number! relativenumber!<CR>

" Use hard tabs (will display at width 4)
" Note that we use retab! to replace spaces with tabs
noremap <F8> :set noexpandtab<Enter> :retab!<Enter>
" Use soft tabs (4 spaces)
noremap <F9> :set expandtab<Enter> :retab<Enter>

" Yay LaTeX compilation!
noremap <F4> :!pdflatex % < /dev/null<Enter>

" Or other compilation
noremap <F5> :make<Enter>

" --------------------------------------------------------------------------- "
" --------------------------------------------------------------------------- "
"                                 COLORS
" --------------------------------------------------------------------------- "
" --------------------------------------------------------------------------- "

syntax enable                " Turn on syntax highlighting
colorscheme desert

" Make current line number more obvious, others less obvious
autocmd ColorScheme * highlight LineNr ctermfg=242
autocmd ColorScheme * highlight CursorLineNr ctermfg=1
" Make current line (very subtly) highlighted
autocmd ColorScheme * highlight CursorLine cterm=NONE
autocmd ColorScheme * highlight CursorLine ctermbg=235

" Make comments more muted
autocmd ColorScheme * highlight Comment ctermfg=248

" Highlight lines that are too long (80+ characters)
highlight link OverLength ErrorMsg
match OverLength /\%>79v.\+/

" Toggle on and off
noremap <F6> :silent! match OverLength<Enter>
noremap <F7> :match OverLength /\%>80v.\+/<Enter>
"--------------------------------"

" Highlight end-of-line whitespace. If expanding tabs, highlight all tab
" characters. If not, highlight all spaces appearing before tabs
" (still want to allow spaces to align line continuations)
" Hideous autocmd is to avoid highlighting end-of-line space while still
" typing in insert mode.
highlight link ExtraWhitespace IncSearch
if &expandtab
	2match ExtraWhitespace /\s\+$\|\t\+/
	autocmd BufWinEnter * 2match ExtraWhitespace /\s\+$\|\t\+/
	autocmd InsertEnter * 2match ExtraWhitespace /\s\+\%#\@<!$\|\t\+/
	autocmd InsertLeave * 2match ExtraWhitespace /\s\+$\|\t\+/
else
	2match ExtraWhitespace /\s\+$\| \+\ze\t/
	autocmd BufWinEnter * 2match ExtraWhitespace /\s\+$\| \+\ze\t/
	autocmd InsertEnter * 2match ExtraWhitespace /\s\+\%#\@<!$\| \+\ze\t/
	autocmd InsertLeave * 2match ExtraWhitespace /\s\+$\| \+\ze\t/
endif
