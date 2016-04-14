set nocompatible              " be iMproved, required
filetype off                  " required

" set the runtime path to include Vundle and initialize
set rtp+=~/.vim/bundle/Vundle.vim/
let path='~/.vim/bundle'
call vundle#begin(path)

set rtp+=$VIM/vimfiles/bundle/Vundle.vim/

let path='$VIM/vimfiles/bundle'

call vundle#begin(path)

" alternatively, pass a path where Vundle should install plugins
"call vundle#begin('~/some/path/here')

" let Vundle manage Vundle, required
Plugin 'VundleVim/Vundle.vim'

" The following are examples of different formats supported.
" Keep Plugin commands between vundle#begin/end.

" plugin on GitHub repo
Plugin 'tpope/vim-fugitive'

" plugin from http://vim-scripts.org/vim/scripts.html
" Plugin 'L9'

Plugin 'Gundo'
Plugin 'ctrlp.vim'
Plugin 'surround.vim'
Plugin 'Syntastic'
Plugin 'Tabular'
Plugin 'minibufexpl.vim'
"Plugin 'paredit.vim'
Plugin 'xml.vim'
Plugin 'vim-signify'
Plugin 'bling/vim-airline'
Plugin 'solarized'
Plugin 'supertab'
Plugin 'YouCompleteMe'
"Plugin 'AsyncCommand'
Plugin 'Tagbar'
Plugin 'ivanov/vim-ipython'

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
"

let g:airline_powerline_fonts = 1
let g:solarized_italic    =   0
set background=dark
colorscheme solarized
let g:solarized_termtrans=1

set langmenu=zh_CN.UTF-8

set clipboard=unnamed                                                                                                                                                                                          
" Allow cursor keys in insert mode
set esckeys
" Optimize for fast terminal connections
set ttyfast
set binary
set noeol
" Respect modeline in files
set modeline
set modelines=4
" Enable per-directory .vimrc files and disable unsafe commands in them
set exrc
set secure
set lcs=tab:▸\ ,trail:·,eol:¬,nbsp:_
set list

set backspace=indent,eol,start
set browsedir=buffer
set cursorline
set completeopt=preview,menuone
set encoding=utf-8 nobomb
set fencs=ucs-bom,utf-8,default,chinese,big5
"set dir=d:\jtemp\vimbackup
"set backupdir=D:\JTemp\vimundo
" Centralize backups, swapfiles and undo history
set backupdir=~/.vim/backups
set directory=~/.vim/swaps
if exists("&undodir")
    set undodir=~/.vim/undo
endif

" Don't create backups when editing files in certain directories
set backupskip=/tmp/*,/private/tmp/*

set fileformats=unix,dos,mac
set fileformat=unix
set fillchars=vert:\ 
set fillchars=fold:\ 
"set foldclose=
"set foldmethod=syntax
"set grepprg="grep -n $*"
set hlsearch
set incsearch

"set guioptions=egmrLtT
set guioptions=egtr
" set relativenumber
set number

set tabstop=4
set shiftwidth=4
set expandtab
set laststatus=2
set display+=lastline
set wrap

set showcmd
set showmatch
set showmode
set showtabline=1

"set statusline=%<%w%f\ %=%y[%{&ff}][%6c][%{printf('%'.strlen(line('$')).'s',line('.'))}/%L][%3p%%]%{'['.(&readonly?'RO':'\ \ ').']'}%{'['.(&modified?'+':'-').']'}

" set noswapfile
set writebackup
set nobackup
set undodir=d:\JTemp\vimundo\
set undofile

"set splitbelow
"set splitright
set noequalalways
set termencoding=cp936
"set wildmenu
"set wildmode=full
"set wildchar=<Tab>
"set wildcharm=<C-Z>
set winminheight=0
set winminwidth=0
set whichwrap=<,>,[,]
"set noerrorbells
"set novisualbell
"set vb t_vb=

set selection=inclusive

" MAPPINGS -----------------

" window jump
nnoremap <c-j> <c-w>j
nnoremap <c-k> <c-w>k
nnoremap <c-l> <c-w>l
nnoremap <c-h> <c-w>h
nnoremap <c-i> <c-a>

" copypaste
nnoremap Y :1,$y +<CR>
"vnoremap <C-X> "+x
vnoremap <C-C> "+y
nnoremap <C-V> "+gP
cnoremap <C-V> <C-R>+
inoremap <C-V> <C-R>+
exe 'inoremap <script> <C-V> <C-G>u' . paste#paste_cmd['i']
exe 'vnoremap <script> <C-V> ' . paste#paste_cmd['v']

nnoremap <C-S> :update<CR>
inoremap <C-S> <C-O>:update<CR>

noremap <F2> :se ic<CR>
inoremap <C-F> <RIGHT>
inoremap <C-BS> <ESC>:call DelBack()<CR>a

let mapleader = ","
let maplocalleader = ','

" When editing a file, always jump to the last known cursor position.
au! BufReadPost * if line("'\"") > 0 && line("'\"") <= line("$") | execute "normal! g'\"" | endif
au! WinLeave * set nocursorline nocursorcolumn
au! WinEnter * set cursorline nocursorcolumn

let g:filesystemencoding="cp936" " when use chinese file name it causes error in cmd
" Color in active status line
autocmd BufEnter * hi statusline guibg=#859900 guifg=Black gui=NONE
autocmd BufEnter * hi wildmenu guibg=DarkGreen gui=NONE


" Backward erasing a character in normal mode, do not check if current form balanced
function! s:PEraseBck( count ) "{{{ new map for easy deletion in insert mode
    let l:any_matched_char   = '(\|)\|\[\|\]\|{\|}\|\"'
    let l:any_matched_pair   = '()\|\[\]\|{}\|\"\"'
    let l:any_opening_char   = '(\|\[\|{'
    let l:any_closing_char   = ')\|\]\|}'
    let l:any_openclose_char = '(\|)\|\[\|\]\|{\|}'
    let l:any_wsopen_char    = '\s\|(\|\[\|{'
    let l:any_wsclose_char   = '\s\|)\|\]\|}'

    "init
    let @" = ''
    let l:p_yank_pos = []

    let line = getline( '.' )
    "let pos = col( '.' ) - 1
    let pos = col( '.' )
    let reg = @"
    "let c = pos  " try to delete the whole line unless delimiter is encountered
    let c = a:count
    while c > 0 && pos > 0
        if pos > 1 && line[pos-2] == '\' && line[pos-1] =~ l:any_matched_char && (pos < 3 || line[pos-3] != '\')
            " Erasing an escaped matched character
            let reg = reg . line[pos-2 : pos-1]
            let line = strpart( line, 0, pos-2 ) . strpart( line, pos )
            normal! h
            let pos = pos - 1
        elseif line[pos-1:pos] =~ l:any_matched_pair
            " Erasing an empty character-pair
            let p2 = 0
            if len(l:p_yank_pos) > 0
                let p2 = l:p_yank_pos[0]
                let l:p_yank_pos = l:p_yank_pos[1:]
            endif

            let reg = strpart( reg, 0, p2 ) . line[pos-1] . strpart( reg, p2 )
            let reg = reg . line[pos]
            let line = strpart( line, 0, pos-1 ) . strpart( line, pos+1 )
        elseif line[pos-1] =~ l:any_matched_char
            " Character-pair is not empty, don't erase
            let l:p_yank_pos = [len(reg)] + l:p_yank_pos
        else
            " Erasing a non-special character
            let reg = reg . line[pos-1]
            let line = strpart( line, 0, pos-1 ) . strpart( line, pos )
        endif
        normal! h
        let pos = pos - 1
        let c = c - 1
    endwhile
    call setline( '.', line )
    let @" = reg
endfunction "}}}
function! DelBack () "{{{
    let l:any_matched_char   = '(\|)\|\[\|\]\|{\|}\|\"'
    let l:any_matched_sep   = '(\|)\|\[\|\]\|{\|}\|\"\| \|,\|.\|;\|!'

     let l:col = col(".")-1
     let l:ln = getline(".")
     let l:current_col = l:col
     let l:cursorchar= strpart( l:ln, l:current_col,1)
     while l:cursorchar =~ l:any_matched_char
         let l:current_col = l:current_col - 1
         let l:cursorchar= strpart( l:ln, l:current_col,1)
         call setpos('.', l:current_col )
         echo l:current_col
     endwhile

     call cursor(line('.'),l:current_col+1)

     let [y2, target_col2] = searchpos('(\|)\|\[\|\]\|{\|}\|\"' , 'nbcW',line("."))
     let [y3, target_col3] = searchpos('[ ,.;!]\+' , 'nbcW',line(".")) "remove and stop and space char index
     "let [y, target_col] = searchpos(l:any_matched_sep, 'nbcW',line("."))
     if target_col3 >= target_col2
         let target_col = target_col3
     else
         let target_col = target_col2
     endif
     let target_col = target_col - 1 " fix position
     if l:current_col >= l:target_col
         call s:PEraseBck( l:current_col - l:target_col + 1 )
     endif

endfunction "}}}
function! s:PareditToggle() " {{{ ToggleParedit
    if  g:paredit_mode == 0
        let g:paredit_mode = 1
    else
        let g:paredit_mode = 0
    endif
endfunction 
command! PareditToggle call s:PareditToggle()
" }}}

nnoremap <Leader>u :GundoToggle<CR>
nnoremap <Leader>t :Tagbar<CR>

let g:ycm_cache_omnifunc = 1
let g:ycm_key_list_select_completion = ['<TAB>', '<Down>']
let g:ycm_key_list_previous_completion = ['<S-TAB>', '<Up>']
let g:ycm_key_invoke_completion = '<C-Space>'
let g:ycm_complete_in_strings = 1
let g:ycm_filetype_blacklist = {
     \ 'tagbar': 1,
     \ 'nerdtree': 1,
     \}
let g:ycm_min_num_of_chars_for_completion=1  
"设置跳转的快捷键，可以跳转到definition和declaration  
nnoremap <leader>gc :YcmCompleter GoToDeclaration<CR>  
nnoremap <leader>gf :YcmCompleter GoToDefinition<CR>  
nnoremap <leader>gg :YcmCompleter GoToDefinitionElseDeclaration<CR>  
"nmap <F4> :YcmDiags<CR>  


" set guifont=DejaVu\ Sans\ Mono\ for\ Powerline:h11
"   if !exists('g:airline_symbols')
"     let g:airline_symbols = {}
"   endif

  " unicode symbols
"   let g:airline_left_sep = '»'
"   let g:airline_left_sep = '▶'
"   let g:airline_right_sep = '«'
"   let g:airline_right_sep = '◀'
"   let g:airline_symbols.crypt = '🔒'
"   let g:airline_symbols.linenr = '␊'
"   let g:airline_symbols.linenr = '␤'
"   let g:airline_symbols.linenr = '¶'
"   let g:airline_symbols.branch = '⎇'
"   let g:airline_symbols.paste = 'ρ'
"   let g:airline_symbols.paste = 'Þ'
"   let g:airline_symbols.paste = '∥'
"   let g:airline_symbols.whitespace = 'Ξ'

  " powerline symbols
"    let g:airline_left_sep = ''
"    let g:airline_left_alt_sep = ''
"    let g:airline_right_sep = ''
"    let g:airline_right_alt_sep = ''
"    let g:airline_symbols.branch = ''
"    let g:airline_symbols.readonly = ''
"    let g:airline_symbols.linenr = ''
 
"    " old vim-powerline symbols
"    let g:airline_left_sep = '⮀'
"    let g:airline_left_alt_sep = '⮁'
"    let g:airline_right_sep = '⮂'
"    let g:airline_right_alt_sep = '⮃'
"    let g:airline_symbols.branch = '⭠'
"    let g:airline_symbols.readonly = '⭤'
"    let g:airline_symbols.linenr = '⭡'

" md-server
" autocmd BufRead,BufNewFile *.{md,mdown,mkd,mkdn,markdown,mdwn} :Silent md-server "%:p"
autocmd BufRead,BufNewFile *.{md,mdown,mkd,mkdn,markdown,mdwn} :AsyncCommand md-server "%:p"
autocmd BufUnload *.{md,mdown,mkd,mkdn,markdown,mdwn} :AsyncCommand curl "http://localhost:9300/shutdown"

syn on 
"  vim: set foldmethod=marker :
