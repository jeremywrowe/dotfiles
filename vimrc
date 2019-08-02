set backspace=2
set diffopt+=vertical
set expandtab
set exrc
set foldlevel=1
set foldmethod=indent
set foldnestmax=3
set hidden
set history=10
set hlsearch
set incsearch
set laststatus=2
set nobackup
set nofoldenable
set noswapfile
set nowrap
set nowritebackup
set number
set secure
set shiftround
set shiftwidth=2
set showcmd
set tabstop=2
set laststatus=0 " Never display the statusline
set showtabline=2 " Always display the tabline, even if there is only one tab
set clipboard=unnamed
set scrolljump=-50
set redrawtime=10000

let mapleader = " "
let maplocalleader = ";"

let NERDTreeShowExecutableFlag=0
let NERDTreeMinimalUI = 1
let NERDTreeDirArrows = 1
let g:NERDTreeNodeDelimiter = "\u00a0"
let g:golden_ratio_exclude_nonmodifiable = 1

let g:VtrPercentage = 35
let g:VtrOrientation = "h"
let g:VtrClearBeforeSend = 0

let g:airline_statusline_ontop=1
let g:airline_powerline_fonts = 1

if &compatible
  set nocompatible
endif

filetype off
call plug#begin('~/.vim/plugged')

" General Stuff
Plug 'junegunn/fzf', { 'dir': '~/.fzf', 'do': './install --all' }
Plug 'junegunn/fzf.vim'
Plug 'editorconfig/editorconfig-vim'
" Plug 'sheerun/vim-polyglot'
Plug 'tpope/vim-dispatch'
Plug 'tpope/vim-rails', { 'for': 'ruby' }
Plug 'scrooloose/nerdcommenter'
Plug 'scrooloose/nerdtree'
Plug 'christoomey/vim-tmux-navigator'
Plug 'tpope/vim-rhubarb'
Plug 'tpope/vim-fugitive'
Plug 'tpope/vim-surround'
Plug 'terryma/vim-multiple-cursors'
Plug 'w0rp/ale'
Plug 'iamcco/markdown-preview.nvim', { 'do': { -> mkdp#util#install() } }
Plug 'vim-airline/vim-airline'
Plug 'BlakeWilliams/vim-pry'

" Tests
Plug 'janko-m/vim-test', { 'for': 'ruby' }
Plug 'christoomey/vim-tmux-runner', { 'for': 'ruby' }

" Color Schemes
Plug 'fxn/vim-monochrome' 

call plug#end()

filetype plugin indent on
syntax on

colorscheme monochrome

" test runner
let test#strategy = 'vtr'
let test#ruby#use_binstubs = 1

runtime macros/matchit.vim

" ale
let g:ale_set_highlights = 1
let g:ale_fix_on_save = 1
let g:ale_linters_explicit = 1
let g:ale_linters = {
\   'ruby': ['rubocop']
\ }

let g:ale_fixers = {
\   'javascript': ['prettier'],
\   'ruby': ['trim_whitespace', 'remove_trailing_lines']
\ }

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
  let g:ctrlp_user_command = 'rg %s --color=never --files'
  let g:ctrlp_use_caching = 0
  command! -bang -nargs=* Find call fzf#vim#grep('rg --column --line-number --no-heading --fixed-strings --ignore-case --hidden --follow --glob "!.git/*" --glob "!node_modules/*" --color "always" '.shellescape(<q-args>).'| tr -d "\017"', 1, <bang>0)
endif

function! s:check_back_space() abort
  let col = col('.') - 1
  return !col || getline('.')[col - 1]  =~ '\s'
endfunction

inoremap <silent><expr> <Tab>
      \ pumvisible() ? "\<C-n>" :
      \ <SID>check_back_space() ? "\<Tab>" :
      \ coc#refresh()

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
nmap <Leader>p :call pry#insert()<cr>

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
