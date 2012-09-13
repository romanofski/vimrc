" Vim settings
set smartcase
set shiftwidth=4
set tabstop=2
set softtabstop=4
set backspace=2
set ai
set nocompatible
set nobackup
set confirm
set ruler
set syntax=on
set incsearch "jump to search results
set hlsearch
set showmatch
set showmode
set expandtab
set vb
set foldmethod=indent
set foldnestmax=2
set foldlevel=0
" we're using a terminal which supports 256 colors
set t_Co=256
"set encoding=UTF-8
set wildmode=longest,list,full
set wildmenu
" jump 5 lines when we hit bottom
set scrolljump=5
" we don't need to hit the exact bottom to trigger the scrolljump
set scrolloff=3
"see :help wrap
set sidescroll=5
set listchars=tab:_¸,trail:·
set list
set tw=72
set spelllang=en,de,fr
" set the buffer as hidden, so that vim don't pesters evertime about
" saving when switching between buffers
set hidden
set tags=tags;/
" colour the textwidth
set cc=+1
set statusline=%{fugitive#statusline()}<%f%=\ [%1*%M%*%n%R%H]\ %-19(%3l,%02c%03V%)'%02b'%{&enc}%h>
" Always show the status line
set laststatus=2
" I like a fancy cursorline
set cursorline

" enable filetype plugins such those for editing XML files
filetype plugin on
filetype indent on

" for handling mouse events in xterm
set ttymouse=xterm2
colo default
syntax on

" pathogen takes care of easily installing new vim bundles
call pathogen#infect()

"" Map Python trickery to function keys and commands
map <F2> <Esc>:1,$!tidy -q -i --show-errors 0<CR>
map <F7> :BufExplorer<CR>
map <F8> :Explore<CR>
map <F9> :ToggleSliceBuffer<CR>
map ,tex :r !cat /home/roman/.vim/templates/artcl.tex.templ
nnoremap <cr> :noh<cr><cr>
inoremap ,a ä
inoremap ,o ö
inoremap ,u ü
inoremap ,A Ä
inoremap ,O Ö
inoremap ,U Ü
inoremap ,s ß
inoremap jj <Esc>
" handling of parenthesis
vmap g/ :call SortMultipleLines()<CR>

augroup filetypedetect
    au! BufNewFile,BufRead *.pt         set ft=xml shiftwidth=2 softtabstop=2
    au! BufNewFile,BufRead *.zcml       set ft=xml shiftwidth=2 softtabstop=2
    au! BufNewFile,BufRead *.zpt        set ft=xml shiftwidth=2 softtabstop=2
    au! BufNewFile,BufRead *.xml        set ft=xml shiftwidth=2 softtabstop=2
    au! BufNewFile,BufRead *.css.dtml   set syntax=css
    au! BufNewFile,BufRead ChangeLog    set shiftwidth=8 tabstop=8 noexpandtab
    au! BufNewFile,BufRead *.txt        set ft=rst
    autocmd BufRead *.vala set efm=%f:%l.%c-%[%^:]%#:\ %t%[%^:]%#:\ %m
    autocmd BufRead *.vapi set efm=%f:%l.%c-%[%^:]%#:\ %t%[%^:]%#:\ %m
    au! BufRead,BufNewFile *.vala       setfiletype vala
    au! BufRead,BufNewFile *.vapi       setfiletype vala
augroup END

" delete with Strg+D all to signature
autocmd FileType mail map <C-d> :.;/^-- $/d<CR>O-- <UP><End><CR>
" Default Mooball header for python files
autocmd BufNewFile *.py 0r ~/.vim/templates/copyright_mooball.txt
" Automatically delete trailing whitespace in python files
autocmd BufWritePre *.py :%s/\s\+$//e


" abbreviations
ab pdb import pdb; pdb.set_trace()
ab impytest import pytest; pytest.set_trace()
ab cbred border: 1px solid red

" disable F1 for immediately open the help -- make a choice
inoremap <F1> <Esc>
noremap <F1> :call MapF1()<cr>

function! MapF1()
  if &buftype == "help"
    exec 'quit'
  else
    exec 'help'
  endif
endfunction

" Use a differen color for pyflakes
colors relaxedgreen
highlight SpellBad cterm=bold ctermbg=none ctermfg=brown

" Sort multiline imports
function! SortMultipleLines() range
    execute a:firstline . "," . a:lastline . 's/\\\@<=\n/|'
    execute a:firstline . "," . a:lastline . 'sort'
    execute a:firstline . "," . a:lastline . 's/\\\@<=|/\r/g'
    execute "'<"
endfunction
