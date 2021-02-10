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
set mmp=5000
set tabstop=2
set omnifunc=syntaxcomplete#Complete
set cmdheight=2
set updatetime=300
set shortmess+=c
set signcolumn=yes

if !has('gui_running')
  set t_Co=256
endif

let mapleader = " "
let maplocalleader = ";"

let g:golden_ratio_exclude_nonmodifiable = 1

let g:VtrPercentage = 35
let g:VtrOrientation = "v"
let g:VtrClearBeforeSend = 0

let g:airline_statusline_ontop=1
let g:airline_powerline_fonts = 1
let g:airline#extensions#tabline#enabled = 1

let g:go_def_mode='gopls'
let g:go_info_mode='gopls'

let g:sneak#label=1

if &compatible
  set nocompatible
endif

filetype off

if !exists('g:vscode')
  call plug#begin('~/.vim/plugged')

  " General Stuff
  Plug 'junegunn/fzf', { 'dir': '~/.fzf', 'do': './install --all' }
  Plug 'junegunn/fzf.vim'
  Plug 'editorconfig/editorconfig-vim'
  Plug 'sheerun/vim-polyglot'
  Plug 'fatih/vim-go'
  Plug 'preservim/nerdtree'
  Plug 'scrooloose/nerdcommenter'
  Plug 'vifm/vifm.vim'
  Plug 'christoomey/vim-tmux-navigator'
  Plug 'tpope/vim-bundler', { 'for': 'ruby' }
  Plug 'tpope/vim-endwise', { 'for': 'ruby' }
  Plug 'tpope/vim-fugitive'
  Plug 'tpope/vim-rails', { 'for': 'ruby' }
  Plug 'tpope/vim-rhubarb'
  Plug 'tpope/vim-surround'
  Plug 'w0rp/ale'
  Plug 'itchyny/lightline.vim'
  Plug 'mg979/vim-visual-multi', {'branch': 'master'}
  Plug 'justinmk/vim-sneak'
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
  Plug 'neoclide/coc-solargraph'
  Plug 'iamcco/coc-tailwindcss',  {'do': 'yarn install --frozen-lockfile && yarn run build'}

  " Tests
  Plug 'janko-m/vim-test'
  Plug 'christoomey/vim-tmux-runner'

  " Color Schemes
  Plug 'dracula/vim', { 'as': 'dracula' }

  call plug#end()
endif


filetype plugin indent on

syntax enable
set background=dark
colorscheme dracula

" test runner
if has("gui_vimr")
  let test#strategy = 'neovim'
else
  let test#strategy = 'vtr'
endif


let test#ruby#use_binstubs = 1

runtime macros/matchit.vim

" ale
highlight ALEErrorSign ctermbg=NONE ctermfg=red
highlight ALEWarningSign ctermbg=NONE ctermfg=yellow
let g:ale_sign_error = '✘'
let g:ale_sign_warning = '⚠'
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

nmap <Leader>p :call pry#insert()<cr>

nnoremap <leader>n :NERDTreeToggle<cr>
nnoremap <leader>m :NERDTreeFind<cr>

nnoremap <leader>ra :VtrAttachToPane<cr>
nnoremap <leader>rf :VtrFocusRunner<cr>
nnoremap <leader>rr :VtrSendLinesToRunner<cr>
nnoremap <leader>rd :VtrSendCtrlD<cr>

map <Leader>t :TestNearest<CR>
map <Leader>T :TestFile<CR>
map <Leader>l :TestLast<CR>
map <Leader>v :TestVisit<CR>
map <Leader>s :TestSuite<CR>
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

" Use <c-space> to trigger completion.
inoremap <silent><expr> <c-space> coc#refresh()

" Use `[c` and `]c` to navigate diagnostics
nmap <silent> [c <Plug>(coc-diagnostic-prev)
nmap <silent> ]c <Plug>(coc-diagnostic-next)

" Remap keys for gotos
nmap <silent> gd <Plug>(coc-definition)
nmap <silent> gy <Plug>(coc-type-definition)
nmap <silent> gi <Plug>(coc-implementation)
nmap <silent> gr <Plug>(coc-references)

" Use U to show documentation in preview window
nnoremap <silent> U :call <SID>show_documentation()<CR>

" Remap for rename current word
nmap <leader>rn <Plug>(coc-rename)

" Remap for format selected region
vmap <leader>f  <Plug>(coc-format-selected)
nmap <leader>f  <Plug>(coc-format-selected)
" Show all diagnostics
nnoremap <silent> <space>a  :<C-u>CocList diagnostics<cr>
" Manage extensions
nnoremap <silent> <space>e  :<C-u>CocList extensions<cr>
" Show commands
nnoremap <silent> <space>c  :<C-u>CocList commands<cr>
" Find symbol of current document
nnoremap <silent> <space>o  :<C-u>CocList outline<cr>
" Search workspace symbols
nnoremap <silent> <space>s  :<C-u>CocList -I symbols<cr>
" Do default action for next item.
nnoremap <silent> <space>j  :<C-u>CocNext<CR>
" Do default action for previous item.
nnoremap <silent> <space>k  :<C-u>CocPrev<CR>
" Resume latest coc list
nnoremap <silent> <space>p  :<C-u>CocListResume<CR>

" copy current file name (relative/absolute) to system clipboard
" relative path  (src/foo.txt)
nnoremap <leader>cf :let @*=expand("%")<CR>
" absolute path  (/something/src/foo.txt)
nnoremap <leader>cF :let @*=expand("%:p")<CR>
" filename       (foo.txt)
nnoremap <leader>ct :let @*=expand("%:t")<CR>
" directory name (/something/src)
nnoremap <leader>ch :let @*=expand("%:p:h")<CR>
