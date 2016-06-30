set t_Co=256

if has("gui_running")
    " GUI is running or is about to start
    " maximize gvim window
    set lines=50 columns=200
else
    " this is console Vim
    if exists("+lines")
        set lines=50
    endif
    if exists("+columns")
        set columns=100
    endif
endif

set nocompatible              " be iMproved, required
filetype off                  " required

" set the runtime path to include Vundle and initialize
set rtp+=~/.vim/bundle/Vundle.vim
call vundle#begin()
" alternatively, pass a path where Vundle should install plugins
"call vundle#begin('~/some/path/here')

" let Vundle manage Vundle, required
Plugin 'gmarik/Vundle.vim'

" Programming
Plugin 'scrooloose/syntastic' " syntax checker
Plugin 'davidhalter/jedi-vim'
Plugin 'sheerun/vim-polyglot'

"Plugin 'elzr/vim-json' " better than the one included in the vim-polyglot

" File navigation and location
Plugin 'scrooloose/nerdtree' " file system explorer
Plugin 'kien/ctrlp.vim' " fuzzy file finder

" UI enhancements
Plugin 'bling/vim-airline' " nice status line

" new ones
Plugin 'tpope/vim-fugitive'
Plugin 'airblade/vim-gitgutter'
Plugin 'majutsushi/tagbar'
Plugin 'tomtom/tcomment_vim'
Plugin 'tpope/vim-surround'
Plugin 'tpope/vim-unimpaired'
Plugin 'hdima/python-syntax'

" File styleguides
Plugin 'editorconfig/editorconfig-vim'

" Remember
Plugin 'chrisbra/csv.vim'
"Plugin 'godlygeek/tabular'
Plugin 'plasticboy/vim-markdown'


" All of your Plugins must be added before the following line
call vundle#end()            " required
filetype plugin indent on    " required
" To ignore plugin indent changes, instead use:
"filetype plugin on
"
" Brief help
" :PluginList       - lists configured plugins
" :PluginInstall    - installs plugins; append `!` to update or just :PluginUpdate
" :PluginSearch foo - searches for foo; append `!` to refresh local cache
" :PluginClean      - confirms removal of unused plugins; append `!` to auto-approve removal
"
" see :h vundle for more details or wiki for FAQ
" Put your non-Plugin stuff after this line

" vim-markdown
let g:vim_markdown_folding_disabled=1

" NERDtree
let NERDTreeShowBookmarks=1
let NERDTreeIgnore = ['\~$', '\pyc$']
let g:NERDTreeChDirMode = 2 "automatically change CWD whenever the tree root is changed
"autocmd GUIEnter * NERDTree

" enable and configure airline
let g:airline#extensions#tabline#enabled = 1
let g:airline#extensions#tabline#show_buffers = 1
let g:airline#extensions#tabline#left_sep = ' '
let g:airline#extensions#tabline#left_alt_sep = '|'
let g:airline_theme='badwolf'
let g:airline_powerline_fonts = 0

if !exists('g:airline_symbols')
    let g:airline_symbols = {}
endif
let g:airline_symbols.space = "\ua0"

" JSON syntax highlighting and errors
let g:vim_json_warnings = 1

" Syntastic
let g:syntastic_always_populate_loc_list=1 " always populate the location list with the errors found
let g:syntastic_auto_loc_list=1 " when set to 1, error window opens automaticaly when there are errors and closes automatically when there are none

" jedi-vim
" the autocomplete was too slow when using pandas or large files
let g:jedi#show_call_signatures = 0
let g:jedi#popup_on_dot = 0

" python-syntax
let python_highlight_all = 1

"""""""""""""""" General options
set mouse=a " enables mouse
"filetype plugin on

set laststatus=2 " to enable airline on startup

" Search
set hlsearch " highlights all the search results
set incsearch " searches incrementally
set ignorecase " ignores case
set smartcase " ignores case when the search pattern is in lower case

" TAB and indent
set tabstop=4
set softtabstop=4
set shiftwidth=4
set expandtab " insert spaces instead of tabs

set autoindent
set copyindent

" UI
set number
set cursorline " highlight current line

" programming and formatting
set showmatch

set list
set listchars=trail:.,nbsp:.
"autocmd filetype html,xml,todo set listchars-=tab:>-


colorscheme slate

hi PreProc guifg=lightgreen guibg=grey15
hi CursorLine cterm=underline,bold guibg=grey10
hi Search ctermfg=white
hi GitGutterAdd ctermbg=none ctermfg=2 guifg=green
hi GitGutterDelete ctermbg=none ctermfg=1 guifg=red
hi GitGutterChange ctermbg=none ctermfg=3 guifg=orange
hi GitGutterChangeDelete ctermbg=none ctermfg=3 guifg=orange
hi clear SignColumn

" Other stuff
set showcmd	" display incomplete commands


" Key mappings
let mapleader=','

noremap <silent> <Leader>n :tabp<Return>
noremap <silent> <Leader>m :tabn<Return>

noremap <silent> <Leader>c :nohl<Return>

noremap <silent> <Leader>t :NERDTreeToggle<Return>
noremap <silent> <Leader>f :NERDTreeFind<Return>

noremap <silent> <Leader>q :copen<Return>
noremap <silent> * *N

" Fast word replace
nnoremap <Leader>r * :%s///g<left><left>

" use ctrl-p to search for the word under the cursor and the selected text
nmap <Leader>w :CtrlP<CR><C-\>w
vmap <Leader>v <Esc>:CtrlP<CR><C-\>v
nmap <Leader>j vi',v<C-t>

nnoremap K :grep! -r "\b<C-r><C-w>\b" * <CR>
" command -nargs=+ -complete=file -bar Ag silent! grep! <args>|cwindow|redraw!

" 'k' and 'j' navigate in screen lines (wrapped) instead of real lines
noremap <silent> j gj
noremap <silent> k gk

" close buffers instead of 'tabs'/'windows' or wahtever and do not close vim
" after all the buffers are gone
"cnoreabbrev wq w<bar>bd
"cnoreabbrev q bd
"cnoreabbrev x up<bar>bd


" Search for selected text, forwards or backwards.
vnoremap <silent> * :<C-U>
\let old_reg=getreg('"')<Bar>let old_regtype=getregtype('"')<CR>
\gvy/<C-R><C-R>=substitute(
\escape(@", '/\.*$^~['), '\_s\+', '\\_s\\+', 'g')<CR><CR>
\gV:call setreg('"', old_reg, old_regtype)<CR>
vnoremap <silent> # :<C-U>
\let old_reg=getreg('"')<Bar>let old_regtype=getregtype('"')<CR>
\gvy?<C-R><C-R>=substitute(
\escape(@", '?\.*$^~['), '\_s\+', '\\_s\\+', 'g')<CR><CR>
\gV:call setreg('"', old_reg, old_regtype)<CR>


" Enable cut-copy-paste in the usual way
vnoremap <silent> <C-c> "+yi<Esc>
vnoremap <silent> <C-x> "+c<Esc>
inoremap <silent> <C-v> <C-r><C-o>+

" Defines F2 to toggle paste mode
nnoremap <F2> :set invpaste paste?<CR>
set pastetoggle=<F2>
set showmode

" Defines more natural split opening settings
set splitbelow
set splitright

" GitGutter aliases
nnoremap <Leader>gn :GitGutterNextHunk<Return>
nnoremap <Leader>gp :GitGutterPrevHunk<Return>

