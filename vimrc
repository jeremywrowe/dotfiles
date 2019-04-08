set backspace=2
set diffopt+=vertical
set expandtab
set exrc
set foldlevel=1
set foldmethod=indent
set foldnestmax=5
set hidden
set history=10
set hlsearch
set incsearch
set laststatus=2
set nobackup
set nocompatible
set nofoldenable
set noswapfile
set nowrap
set nowritebackup
set number
set ruler
set secure
set shell=/bin/bash
set shiftround
set shiftwidth=2
set showcmd
set tabstop=2
set laststatus=2 " Always display the statusline in all windows
set showtabline=2 " Always display the tabline, even if there is only one tab
set title
set clipboard=unnamed
set guicursor=
set t_Co=

let mapleader = " "
let maplocalleader = ";"

let NERDTreeShowExecutableFlag=0
let NERDTreeMinimalUI = 1
let NERDTreeDirArrows = 1
let g:NERDTreeNodeDelimiter = "\u00a0"
let g:NERDTreeWinSize = 42

let g:VtrPercentage = 35
let g:VtrOrientation = "h"
let g:VtrClearBeforeSend = 0

source ~/.vimrc.bundles

if (has("termguicolors"))
  let &t_8f = "\<Esc>[38;2;%lu;%lu;%lum"
  let &t_8b = "\<Esc>[48;2;%lu;%lu;%lum"
  set termguicolors
endif

set background=dark
colorscheme material

filetype plugin indent on
syntax on

" test runner
let test#strategy = 'vtr'
let test#ruby#use_binstubs = 1

runtime macros/matchit.vim

" ale
let b:ale_linters = []
let b:ale_fixers = ['prettier', 'eslint']
let b:ale_fix_on_save = 1
let g:ale_linters_explicit = 1

" fzf
set rtp+=~/.fzf
nnoremap <C-p> :Files<cr>

" make git commit messages good
autocmd Filetype gitcommit setlocal spell textwidth=80
autocmd Filetype markdown setlocal spell

" tab navigation
nnoremap <C-t> :tabnew<CR>
nnoremap <C-n> :tabnext<CR>

filetype plugin indent on

" Wrap Markdown files at 80 Characters
au BufRead,BufNewFile *.md setlocal textwidth=80

if executable('rg')
  set grepprg=rg\ --vimgrep
  let g:ctrlp_user_command = 'rg %s --color=never --files --glob ""'
  let g:ctrlp_use_caching = 0
  command! -bang -nargs=* Find call fzf#vim#grep('rg --column --line-number --no-heading --fixed-strings --ignore-case --no-ignore --hidden --follow --glob "!.git/*" --color "always" '.shellescape(<q-args>).'| tr -d "\017"', 1, <bang>0)
endif

nnoremap \ :Find<SPACE>

nnoremap <C-j> <C-w>j
nnoremap <C-k> <C-w>k
nnoremap <C-h> <C-w>h
nnoremap <C-l> <C-w>l

nnoremap <Leader>rr :%s/\<<C-r><C-w>\>/

imap jk <esc>

vmap <Leader>jj !python -m json.tool<cr>
vmap <Leader>yy "+y
vmap <Leader>pp "+p

nmap <Leader>e :split <C-R>=expand("%:p:h") . "/" <CR>
map <Leader>h :noh<cr>
nmap <Leader><Leader> :b#<CR>

nmap <Leader>n :Vexplore<CR>

nnoremap <leader>ra :VtrAttachToPane<cr>
nnoremap <leader>rf :VtrFocusRunner<cr>
nnoremap <leader>rr :VtrSendLinesToRunner<cr>
nnoremap <leader>rd :VtrSendCtrlD<cr>

map <Leader>t :TestNearest<CR>
map <Leader>T :TestFile<CR>
map <Leader>l :TestLast<CR>
map <Leader>v :TestVisit<CR>
map <Leader>s :TestSuite<CR>
map <Leader>n :NERDTreeToggle<CR>
map <Leader>m :NERDTreeFind<CR>
map <Leader>c :g/\s*#/d<CR>
nmap <silent> <leader>d <Plug>DashSearch
