filetype plugin indent on
syntax on

noremap <Up> <NOP>
noremap <Down> <NOP>
noremap <Left> <NOP>
noremap <Right> <NOP>

set number nu
set cursorline
set autoindent
set smartindent
set nowrap
set backspace=indent,eol,start

set tabstop=4
set shiftwidth=4
set softtabstop=4
set expandtab

set incsearch
set hlsearch

set background=dark
colorscheme solarized

let mapleader=','

autocmd BufWritePre * :%s/\s\+$//e

function! EnsureFolderExists(dir)
    if !isdirectory(a:dir)
        call mkdir(a:dir, 'p')
    endif
endfunction

call EnsureFolderExists($HOME . '/.vim/backup/')
set backupdir=~/.vim/backup//
call EnsureFolderExists($HOME . '/.vim/swap/')
set directory=~/.vim/swap//
call EnsureFolderExists($HOME . '/.vim/undo/')
set undodir=~/.vim/undo//

if empty(glob('~/.vim/autoload/plug.vim'))
    silent !curl -fLo ~/.vim/autoload/plug.vim --create-dirs https://raw.githubusercontent.com/junegunn/vim-plug/master/plug.vim
    autocmd VimEnter * PlugInstall | source $MYVIMRC
endif

call plug#begin('~/.vim/plugged')

Plug 'scrooloose/nerdtree'
Plug 'ctrlpvim/ctrlp.vim'
Plug 'StanAngeloff/php.vim'
Plug 'altercation/vim-colors-solarized'
Plug 'tpope/vim-fugitive'
Plug 'tpope/vim-surround'
Plug 'raimondi/delimitmate'
Plug 'bling/vim-airline'
Plug 'scrooloose/syntastic'
Plug 'scrooloose/nerdcommenter'
Plug 'docteurklein/php-getter-setter.vim'
Plug 'arnaud-lb/vim-php-namespace'

call plug#end()

""" NerdTree
nmap <C-e> :NERDTreeToggle<cr>
nmap <leader>e :NERDTreeFind<CR>
let NERDTreeIgnore = ['\.pyc$']

" Automatically open & close quickfix window
autocmd QuickFixCmdPost [^l]* nested cwindow

"""""""""""""""""""""""""""""""""""""
""             PHP                 ""
"""""""""""""""""""""""""""""""""""""

"augroup PHP
    "autocmd!
    "autocmd BufWritePost {*.php} echom system("php -l ".expand('%'))
"augroup END

function! PhpImplementations(word)
    exe 'Ack "implements.*' . a:word . ' *($|{)"'
endfunction

function! PhpSubclasses(word)
    exe 'Ack "extends.*' . a:word . ' *($|{)"'
endfunction

function! PhpUsage(word)
    exe 'Ack "::' . a:word . '\(|>' . a:word . '\("'
endfunction

noremap <Leader>fu :call PhpUsage('<cword>')<CR>
noremap <Leader>fi :call PhpImplementations('<cword>')<CR>
noremap <Leader>fe :call PhpSubclasses('<cword>')<CR>

let g:syntastic_php_phpcs_args = '--standard=Symfony'
