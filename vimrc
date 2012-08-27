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
map <F9> :SliceBuffer<CR>
map ,tex :r !cat /home/roman/.vim/templates/artcl.tex.templ
nnoremap <cr> :noh<cr><cr>
inoremap ,a ä
inoremap ,o ö
inoremap ,u ü
inoremap ,A Ä
inoremap ,O Ö
inoremap ,U Ü
inoremap ,s ß
" handling of parenthesis
inoremap ( ()<ESC>i
inoremap [ []<ESC>i
autocmd Syntax html,vim inoremap < <lt>><ESC>i| inoremap > <c-r>=ClosePair('>')<CR>
inoremap ) <c-r>=ClosePair(')')<CR>
inoremap ] <c-r>=ClosePair(']')<CR>
autocmd Syntax css,c inoremap { {<CR>}<ESC>O | inoremap } <c-r>=CloseBracket()<CR>
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

" abbreviations
ab pdb import pdb; pdb.set_trace()
ab impytest import pytest; pytest.set_trace()
ab cbred border: 1px solid red

" mappings to comment something out fast
" lhs comments
map ,# :s/^/#/<CR>
map ,/ :s/^/\/\//<CR>
map ,> :s/^/> /<CR>
map ," :s/^/\"/<CR>
map ,% :s/^/%/<CR>
map ,! :s/^/!/<CR>
map ,; :s/^/;/<CR>
map ,- :s/^/--/<CR>
"map ,c :s/^\/\/\\|^--\\|^> \\|^[#"%!;]//<CR>

" wrapping comments
map ,* :s/^\(.*\)$/\/\* \1 \*\//<CR>
map ,( :s/^\(.*\)$/\(\* \1 \*\)/<CR>
map ,< :s/^\(.*\)$/<!-- \1 -->/<CR>
map ,d :s/^\([/(]\*\\|<!--\) \(.*\) \(\*[/)]\\|-->\)$/\2/<CR>:nohlsearch<CR>

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


function ClosePair(char)
  if getline('.')[col('.') - 1] == a:char
    return "\<Right>"
  else
    return a:char
  endif
endf

function CloseBracket()
  if match(getline(line('.') + 1), '\s*}') < 0
    return "\<CR>}"
  else
    return "\<ESC>j0f}a"
  endif
endf

function QuoteDelim(char)
  let line = getline('.')
  let col = col('.')
  if line[col - 2] == "\\"
    "Inserting a quoted quotation mark into the string
    return a:char
  elseif line[col - 1] == a:char
    "Escaping out of the string
    return "\<Right>"
  else
    "Starting a string
    return a:char.a:char."\<ESC>i"
  endif
endf 

" Use a differen color for pyflakes
colors relaxedgreen
highlight SpellBad cterm=bold ctermbg=none ctermfg=brown

" Default Mooball header for python files
autocmd BufNewFile *.py 0r ~/.vim/templates/copyright_mooball.txt

" Sort multiline imports
function! SortMultipleLines() range
    execute a:firstline . "," . a:lastline . 's/\\\@<=\n/|'
    execute a:firstline . "," . a:lastline . 'sort'
    execute a:firstline . "," . a:lastline . 's/\\\@<=|/\r/g'
endfunction
