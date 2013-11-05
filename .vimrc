"
" ~/.vimrc
"
" This is your Vim initialization file. It is read on Vim startup.
"
" Change this file to customize your Vim settings.
"
" Vim treats lines beginning with " as comments.
"
" Layout taken from
" http://dougireton.com/blog/2013/02/23/layout-your-vimrc-like-a-boss/
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
set number                   " Show line numbers

" --------------------------------------------------------------------------- "
"  5 syntax, highlighting and spelling
" --------------------------------------------------------------------------- "

set background=dark          " Adjust colors for dark terminal background

" --------------------------------------------------------------------------- "
"  6 multiple windows
" --------------------------------------------------------------------------- "

set laststatus=2             " Windows always have status lines
set winheight=15             " Current window shouldn't be too small
set hidden                   " Hide buffers when they are abandoned
set switchbuf=useopen,split  " For quick fix lists, jump to file containing
                             " errors if already open, else split to open it

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

set mouse=a                  " Enable mouse usage (all modes) in terminals

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

" --------------------------------------------------------------------------- "
" 19 the swap file
" --------------------------------------------------------------------------- "

" --------------------------------------------------------------------------- "
" 20 command line editing
" --------------------------------------------------------------------------- "

set history=128              " Remember last 128 commands
set wildmode=list:longest    " Tab complete file names bash-style
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

" Jump to the last position when reopening a file.
autocmd BufReadPost * if line("'\"") > 0 && line("'\"") <= line("$")
    \| exe "normal! g'\"" | endif

autocmd BufNewFile,BufRead *.hs set comments=b:-- expandtab makeprg=cabal\ build
autocmd BufNewFile,BufRead *.do call Overrideftscripts()
autocmd BufNewFile,BufRead *.py set comments=b:# expandtab
autocmd BufNewFile,BufRead *.c  set cindent " comments=sr:/*,mb:*,ex:*/
autocmd BufNewFile,BufRead *.rkt set filetype=scheme
autocmd BufNewFile,BufRead *.pyhtml set filetype=html
autocmd BufNewFile,BufRead *.flex set filetype=lex
" autocmd BufNewFile,BufRead *.tex set formatoptions+=t
" Dvorakitude - home row
noremap t gj
noremap n gk
noremap s l
" need to move search
noremap l n
noremap L N
" l for Look

syntax enable                " Turn on syntax highlighting
filetype plugin indent on    " Turn on filetype detection

colorscheme desert

"--------------------------------"
" Highlight lines that are too long (80+ characters)
highlight OverLength ctermbg=darkred
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
highlight ExtraWhitespace ctermbg=darkgreen
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

" Use hard tabs (will display at width 4)
" Note that we use retab! to replace spaces with tabs
noremap <F8> :set noexpandtab<Enter> :retab!<Enter>
" Use soft tabs (4 spaces)
noremap <F9> :set expandtab<Enter> :retab<Enter>

" Yay LaTeX compilation!
noremap <F4> :!pdflatex % < /dev/null<Enter>

" Or other compilation
noremap <F5> :make<Enter>
" Automagically open fixes window when running make
autocmd QuickFixCmdPost [^l]* nested cwindow
autocmd QuickFixCmdPost    l* nested lwindow

" This pile of garbage is to simplify splitting worksheets into individual
" problem files for wkgen. Basically, yank a problem, then hit <F3> to paste
" that problem into a newly created %num.tex file in pwd. Note that due to
" vim bugs this file has some extra newlines in it.
let g:ind = 0
fun! IncInd()
	let g:ind = (g:ind + 1)
	return g:ind
endf
noremap <F3> :exe ":redir > ".IncInd().".tex"<Enter> :sil echon @"<Enter> :redir END<Enter>

" Other stuff
noremap - $
noremap _ ^

source ~/.vim/cscope_macros.vim
