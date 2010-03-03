
" Use Vim settings, rather then Vi settings (much better!).
" This must be first, because it changes other options as a side effect.
set nocompatible

" Colors!
set background=dark
colorscheme ir_black
syntax on
set guifont=Bitstream\ Vera\ Sans\ Mono:h12.00
" set guifont=Monaco:h12
" set guifont=DejaVu\ Sans\ Mono:h13

set modeline
set modelines=3

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


" -----------------------------------
" dubek additions


" Disable these ~ files
set nobackup
set nowritebackup

highlight comment ctermfg=lightblue

" Highlight redundant whitespaces and tabs at the end of the line
highlight RedundantSpaces ctermbg=red guibg=red
" match RedundantSpaces /\S\zs\s\+$/
match RedundantSpaces /\s\+$/

let ruby_space_errors = 1
highlight ExtraWhitespace ctermbg=red guibg=red

" Show matching brackets
set showmatch

" interactive pattern matching settings
set ignorecase smartcase
set incsearch

" Tell Vim to quit whining about unsaved buffers when I want to open a new
" buffer. Vim just hides the unsaved buffer, instead of trying to close it.
set hidden

" Toggle highlighting of found search terms on/off
map <F4> :set hlsearch!<CR>:set nohlsearch?<CR>

map <leader>t :NERDTreeToggle<CR>

"
" bufferlist plugin
"
map <silent> <F3> :call BufferList()<CR>
let g:BufferListWidth = 25
let g:BufferListMaxWidth = 50
hi BufferSelected term=reverse ctermfg=white ctermbg=red cterm=bold
hi BufferNormal term=NONE ctermfg=black ctermbg=darkcyan cterm=NONE

autocmd FileType ruby,eruby,perl,tex,html,xhtml,xml set shiftwidth=2 sts=2 et

autocmd FileType ruby set kp=ri
autocmd FileType ruby set softtabstop=2|set shiftwidth=2|set expandtab

autocmd BufEnter *.yaml set softtabstop=2|set shiftwidth=2|set expandtab
autocmd BufEnter *.yml  set softtabstop=2|set shiftwidth=2|set expandtab

" Abbreviations
ab comline #-----------------------------------------------------------------------------#
