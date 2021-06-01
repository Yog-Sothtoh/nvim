" ====================
" === Editor Setup ===
" ====================
" ===
" === System
" ===
"set clipboard=unnamedplus
let &t_ut=''
set autochdir

" ===
" === Editor behavior
" ===
set exrc
set secure
set number
set relativenumber
set cursorline
set expandtab
set tabstop=4
set shiftwidth=4
set softtabstop=4
set autoindent
"set list
set scrolloff=5
set sidescrolloff=5
set ttimeoutlen=0
set notimeout
set viewoptions=cursor,folds,slash,unix
set wrap
set tw=0
set indentexpr=
set foldmethod=indent
set foldlevel=99
set foldenable
set formatoptions-=tc
set splitright
set splitbelow
set noshowmode
set showcmd
set wildmenu
exec "nohlsearch"
set ignorecase
set smartcase
set inccommand=split
set completeopt=longest,noinsert,menuone,noselect,preview
set ttyfast "should make scrolling faster
set lazyredraw "same as above
set visualbell
silent !mkdir -p ~/.config/nvim/tmp/backup
silent !mkdir -p ~/.config/nvim/tmp/undo
"silent !mkdir -p ~/.config/nvim/tmp/sessions
set backupdir=~/.config/nvim/tmp/backup,.
set directory=~/.config/nvim/tmp/backup,.
if has('persistent_undo')
  set undofile
  set undodir=~/.config/nvim/tmp/undo,.
endif
set virtualedit=block

au BufReadPost * if line("'\"") > 1 && line("'\"") <= line("$") | exe "normal! g'\"" | endif

:inoremap ( ()<ESC>i
:inoremap ) <c-r>=ClosePair(')')<CR>
:inoremap { {}<ESC>i
:inoremap } <c-r>=ClosePair('}')<CR>
:inoremap [ []<ESC>i
:inoremap ] <c-r>=ClosePair(']')<CR>
:inoremap " ""<ESC>i
:inoremap ' ''<ESC>i
function! ClosePair(char)
    if getline('.')[col('.') - 1] == a:char
        return "\<Right>"
    else
        return a:char
    endif
endfunction

map <a-w> :w<CR>
map <a-q> :q<CR>
map <a-r> :source $MYVIMRC<CR>

map si :set splitright<CR>:vsplit<CR>
map se :set splitbelow<CR>:split<CR>

call plug#begin('~/.config/nvim/plugged')
" Pretty Dress
Plug 'theniceboy/vim-deus'

" Status line
Plug 'vim-airline/vim-airline'

" File navigation
Plug 'junegunn/fzf', { 'do': { -> fzf#install() } }
Plug 'kevinhwang91/rnvimr'

" Auto Complete
Plug 'neoclide/coc.nvim', {'branch': 'release'}

" Mini Vim-App
Plug 'mhinz/vim-startify'

" File Tree
Plug 'scrooloose/nerdtree'

" Debuger
"Plug 'puremourning/vimspector', {'do':'./install_gadget.py --enable-c'}
call plug#end()

"
" deus colorscheme
"
set t_Co=256

let &t_8f = "\<Esc>[38;2;%lu;%lu;%lum"
let &t_8b = "\<Esc>[48;2;%lu;%lu;%lum"

set background=dark
colorscheme deus
let g:deus_termccolors=256
hi Normal ctermbg=none

"=========
"=AirLine=
"=========
" Show buffers on top
let g:airline#extensions#tabline#enabled=1
" Show buffers count
let g:airline#extensions#tabline#buffer_nr_show=1
let g:airline_powerline_fonts=1
nmap <tab> :bn<CR>

"==========
"=NERDTree=
"==========
map <F1> :NERDTreeMirror<CR>
map <F1> :NERDTreeToggle<CR>
let NERDTreeMapOpenExpl = ""
let NERDTreeMapUpdir = ""
let NERDTreeMapUpdirKeepOpen = "h"
let NERDTreeMapOpenSplit = ""
let NERDTreeOpenVSplit = ""
let NERDTreeMapActivateNode = "l"
let NERDTreeMapOpenInTab = "o"
let NERDTreeMapPreview = ""
let NERDTreeMapCloseDir = "n"
let NERDTreeMapChangeRoot = "y"

"=====
"=fzf=
"=====
nmap <a-f> :FZF<CR>

"========
"=rnvimr=
"========
nmap <a-a> :RnvimrToggle<CR>

"=========
"=coc.vim=
"=========
let g:coc_global_extensions=['coc-marketplace', 'coc-translator']
set hidden
set updatetime=100
set shortmess+=c
nmap <silent> [g <Plug>(coc-diagnostic-prev)
nmap <silent> ]g <Plug>(coc-diagnostic-next)
inoremap <silent><expr> <TAB>
      \ pumvisible() ? "\<C-n>" :
      \ <SID>check_back_space() ? "\<TAB>" :
      \ coc#refresh()
inoremap <expr><S-TAB> pumvisible() ? "\<C-p>" : "\<C-h>"

function! s:check_back_space() abort
  let col = col('.') - 1
  return !col || getline('.')[col - 1]  =~# '\s'
endfunction
nmap ct :CocCommand translator.popup<CR>


"============
"=vimspector=
"============
"function! s:read_template_into_buffer(template)
"    execute '0r ~/.config/nvim/vimspector_json'
"endfunction
"let g:vimspector_enable_mappings='HUMAN'
