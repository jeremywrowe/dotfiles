set backspace=2
set clipboard=unnamed
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
set redrawtime=10000
set relativenumber
set scrolljump=-50
set secure
set shiftround
set shiftwidth=2
set showcmd
set showtabline=2 " Always display the tabline, even if there is only one tab
set clipboard=unnamed
set scrolljump=-50
set redrawtime=10000
set relativenumber
set mmp=5000
set termguicolors
set tabstop=2

if !has('gui_running')
  set t_Co=256
endif

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
let g:airline#extensions#tabline#enabled = 1

if &compatible
  set nocompatible
endif

filetype off
call plug#begin('~/.vim/plugged')

" General Stuff
Plug 'junegunn/fzf', { 'dir': '~/.fzf', 'do': './install --all' }
Plug 'junegunn/fzf.vim'
Plug 'editorconfig/editorconfig-vim'
Plug 'sheerun/vim-polyglot'
Plug 'tpope/vim-rails', { 'for': 'ruby' }
Plug 'scrooloose/nerdcommenter'
Plug 'scrooloose/nerdtree'
Plug 'vifm/vifm.vim'
Plug 'christoomey/vim-tmux-navigator'
Plug 'tpope/vim-rhubarb'
Plug 'tpope/vim-fugitive'
Plug 'tpope/vim-surround'
Plug 'w0rp/ale'
Plug 'iamcco/markdown-preview.nvim', { 'do': { -> mkdp#util#install() } }
Plug 'itchyny/lightline.vim'
Plug 'prettier/vim-prettier', {
  \ 'do': 'yarn install',
  \ 'branch': 'release/1.x',
  \ 'for': [
    \ 'javascript',
    \ 'typescript',
    \ 'css',
    \ 'less',
    \ 'scss',
    \ 'json',
    \ 'graphql',
    \ 'markdown',
    \ 'vue',
    \ 'lua',
    \ 'php',
    \ 'python',
    \ 'ruby',
    \ 'html',
    \ 'swift' ] }

" Language Server
Plug 'neoclide/coc.nvim', {'branch': 'release'}
Plug 'neoclide/coc-rls'


" Tests
Plug 'janko-m/vim-test', { 'for': 'ruby' }
Plug 'christoomey/vim-tmux-runner', { 'for': 'ruby' }

" Color Schemes
Plug 'liuchengxu/space-vim-theme'
Plug 'altercation/vim-colors-solarized'
Plug 'morhetz/gruvbox'
Plug 'dracula/vim', { 'as': 'dracula' }
Plug 'danilo-augusto/vim-afterglow'
Plug 'whatyouhide/vim-gotham'
Plug 'ayu-theme/ayu-vim'

call plug#end()

filetype plugin indent on
syntax on

let ayucolor="dark"
colorscheme dracula

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

" lightline
let g:lightline = {
\ 'colorscheme': 'wombat',
\ }

" fzf
set rtp+=~/.fzf

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
  ".shellescape(<q-args>),
  set grepprg=rg\ --vimgrep
  " Find File w/Preview
  command! -bang -nargs=* Find 
    \ call fzf#vim#grep(
    \ 'rg --column --line-number --no-heading --fixed-strings --ignore-case --hidden --follow --glob "!.git/*" --color "always" '.shellescape(<q-args>).'| tr -d "\017"',
    \ 1, 
    \ fzf#vim#with_preview({'options': '--color fg:252,bg:233,hl:67,fg+:252,bg+:235,hl+:81 --color info:144,prompt:68,spinner:135,pointer:135,marker:118'}, 'right:50%', '?'),
    \ <bang>0)

  " Search Word w/Preview
  nnoremap <C-G> :FzfRg<CR>
  command! -bang -nargs=* FzfRg
    \ call fzf#vim#grep(
    \   'rg --column --line-number --no-heading --color=always --smart-case '.shellescape(<q-args>),
    \   1,
    \   fzf#vim#with_preview({'options': '-q '.shellescape(expand('<cword>')).' --color fg:252,bg:233,hl:67,fg+:252,bg+:235,hl+:81 --color info:144,prompt:68,spinner:135,pointer:135,marker:118'}, 'right:50%', '?'),
    \   <bang>0)

  nnoremap <C-p> :Files<Cr>
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

function! s:buflist()
  redir => ls
  silent ls
  redir END
  return split(ls, '\n')
endfunction

function! s:bufopen(e)
  execute 'buffer' matchstr(a:e, '^[ 0-9]*')
endfunction

nnoremap <silent> <Leader><Enter> :call fzf#run({
\   'source':  reverse(<sid>buflist()),
\   'sink':    function('<sid>bufopen'),
\   'options': '+m',
\   'down':    len(<sid>buflist()) + 2
\ })<CR>

function! PromoteToLet()
    :normal! dd
    :normal! P
    :.s/\(\w\+\) = \(.*\)$/let(:\1) { \2 }/
    :normal ==
endfunction
:command! PromoteToLet :call PromoteToLet()
:nmap <leader>pl :PromoteToLet<cr>

function PromoteToFetch()
  :normal! dd
  :normal! P
  :.s/\v(\w+)\[(:?\w+)\]/\1\.fetch\(\2\)/
  :normal ==
endfunction
command! -range PromoteToFetch <line1>,<line2>:call PromoteToFetch()
map <leader>pf :PromoteToFetch<cr>

inoremap <silent><expr> <TAB>
      \ pumvisible() ? "\<C-n>" :
      \ <SID>check_back_space() ? "\<TAB>" :
      \ coc#refresh()
inoremap <expr><S-TAB> pumvisible() ? "\<C-p>" : "\<C-h>"

function! s:check_back_space() abort
  let col = col('.') - 1
  return !col || getline('.')[col - 1]  =~# '\s'
endfunction

