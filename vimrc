" Use Vim settings, rather then Vi settings (much better!).
" This must be first, because it changes other options as a side effect.
set nocompatible

"
" Vundle stuff
"
filetype off
set rtp+=~/.vim/bundle/Vundle.vim
call vundle#begin()
" let Vundle manage Vundle - required!
Plugin 'VundleVim/Vundle.vim'

" Plugins from https://github.com/vim-scripts
"Plugin 'surround.vim'
"Plugin 'tComment'

" Plugins from github repos
Plugin 'dubek/bufferlist.vim'
Plugin 'airblade/vim-gitgutter'
Plugin 'tpope/vim-endwise'
Plugin 'tpope/vim-markdown'
Plugin 'wgibbs/vim-irblack'
Plugin 'isRuslan/vim-es6'

"Plugin 'scrooloose/nerdtree' " <-- Commented-out because it's very slow to start up

" All of your Plugins must be added before the following line
call vundle#end()           " required
filetype plugin indent on   " required

" Colors!
set background=dark
" colorscheme ir_black
" hi Normal guibg=#1c1c1c
" hi StatusLine guibg=#303030
" hi StatusLineNC guibg=#303030

syntax on
set guifont=Bitstream\ Vera\ Sans\ Mono\ 12
" set guifont=Source\ Code\ Pro:h16.00
" set guifont=Monaco:h12
" set guifont=DejaVu\ Sans\ Mono:h13
" set printfont=Courier:h7

set modeline
set modelines=3

" show line numbers and sign column for git diff
set number

" allow backspacing over everything in insert mode
set backspace=indent,eol,start

set history=100         " keep 100 lines of command line history
set ruler               " show the cursor position all the time
set showcmd             " display incomplete commands

set guioptions-=T       " remove the toolbar

set laststatus=2        " always show a status line

" Don't use Ex mode, use Q for formatting
map Q gq

" Switch syntax highlighting on, when the terminal has colors
" Also switch on highlighting the last used search pattern.
if &t_Co > 2 || has("gui_running")
  syntax on
  set hlsearch
endif

" Only do this part when compiled with support for autocommands.
if has("autocmd")

  " Enable file type detection.
  " Use the default filetype settings, so that mail gets 'tw' set to 72,
  " 'cindent' is on in C files, etc.
  " Also load indent files, to automatically do language-dependent indenting.
  filetype plugin indent on

  " Enable spell-check when authoring git commits
  autocmd FileType gitcommit setlocal spell

  " Put these in an autocmd group, so that we can delete them easily.
  augroup vimrcEx
  au!

  " For all text files set 'textwidth' to 78 characters.
  autocmd FileType text setlocal textwidth=78

  " When editing a file, always jump to the last known cursor position.
  " Don't do it when the position is invalid or when inside an event handler
  " (happens when dropping a file on gvim).
  autocmd BufReadPost *
    \ if line("'\"") > 0 && line("'\"") <= line("$") |
    \   exe "normal g`\"" |
    \ endif

  augroup END

else

  set autoindent                " always set autoindenting on

endif " has("autocmd")

if has("cscope")
  set csto=0
  " Use Ctrl-] to search for symbol definition
  set cst
  set nocsverb
  if filereadable("cscope.out")
    cs add cscope.out
  endif
  set csverb
endif

" -----------------------------------
" dubek additions

" Disable these ~ files
set nobackup
set nowritebackup

set visualbell

highlight comment ctermfg=lightblue

" SignColumn is used to should git diff signs (gitgutter.vim plugin)
highlight SignColumn ctermbg=NONE guibg=NONE

" Tell gitgutter to slow down
let g:gitgutter_realtime = 0
let g:gitgutter_eager = 0

" Highlight redundant whitespaces and tabs at the end of the line
highlight RedundantSpaces ctermbg=red guibg=red
" match RedundantSpaces /\S\zs\s\+$/
match RedundantSpaces /\s\+$/

let ruby_space_errors = 1
highlight ExtraWhitespace ctermbg=red guibg=red

" Highlight for bad spelling; enable spelling with  :set spell
highlight SpellBad cterm=underline ctermbg=NONE ctermfg=red

" Show matching brackets
set showmatch

" interactive pattern matching settings
set ignorecase smartcase
set incsearch

" show completion options above command line when hitting <Tab>
set wildmenu

" Tell Vim to quit whining about unsaved buffers when I want to open a new
" buffer. Vim just hides the unsaved buffer, instead of trying to close it.
set hidden
map <C-j> :bprev<CR>
map <C-k> :bnext<CR>

" Automatically load a file that has changed outside Vim (and hasn't changed
" inside Vim).
set autoread

" Toggle highlighting of found search terms on/off
map <F4> :set hlsearch!<CR>:set nohlsearch?<CR>
" Disable highlighting of found search terms once, with a single keystroke
map - :nohls<cr>

" Toggle view of special chars
map <F5> :set list!<CR>

"map <leader>t :NERDTreeToggle<CR>

" paste toggle
nnoremap <F2> :set invpaste paste?<CR>
set pastetoggle=<F2>
set showmode

" Load matchit.vim, but only if the user hasn't installed a newer version.
if !exists('g:loaded_matchit') && findfile('plugin/matchit.vim', &rtp) ==# ''
  runtime! macros/matchit.vim
endif

" emacs-style editing on the command-line
cnoremap <C-A>        <Home>
cnoremap <C-B>        <Left>
cnoremap <C-D>        <Del>
cnoremap <C-E>        <End>
cnoremap <C-F>        <Right>

"
" bufferlist plugin
"
map <leader>b :call BufferList()<CR>
let g:BufferListWidth = 25
let g:BufferListMaxWidth = 50
hi BufferSelected term=reverse ctermfg=white ctermbg=red cterm=bold
hi BufferNormal term=NONE ctermfg=black ctermbg=darkcyan cterm=NONE

"
" Ag command - internally uses vim's grep
"
if executable("ag")
  set grepprg=ag\ --nogroup\ --nocolor\ --ignore-case\ --column
  set grepformat=%f:%l:%c:%m,%f:%l:%m
  command! -nargs=+ Ag execute 'silent grep! <args>' | copen
endif

" Bind the 'K' key to search for the word under the cursor (using Ag -
" the_silver_searcher) and open the results in a quickfix window
nnoremap K :Ag<CR>:cw<CR>

" vim-go settings
let g:go_fmt_command = "goimports"

augroup dubek
  autocmd!
  autocmd FileType ruby,eruby,javascript,json,lua,perl,tex,vhdl,vim setlocal shiftwidth=2 sts=2 et

  autocmd FileType ruby setlocal kp=ri
  " autocmd FileType ruby setlocal softtabstop=2 shiftwidth=2 expandtab
  autocmd FileType ruby setlocal path+=lib|set path+=test

  autocmd BufEnter *.yaml setlocal softtabstop=2 shiftwidth=2 expandtab
  autocmd BufEnter *.yml  setlocal softtabstop=2 shiftwidth=2 expandtab

  autocmd FileType java,c,cc,cpp,d,html,xhtml,xml,xslt,html.handlebars,python,tcl,st,io setlocal shiftwidth=4 sts=4 et
augroup END

" Abbreviations
ab comline #-----------------------------------------------------------------------------#
