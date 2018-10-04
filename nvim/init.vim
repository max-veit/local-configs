" --- Plugin setup with Dein --- {{{
set runtimepath^=/home/max/.config/dein/repos/github.com/Shougo/dein.vim

call dein#begin(expand('~/.config/dein'))

" Let dein manage dein
call dein#add('Shougo/dein.vim')

" Add or remove your plugins here:
call dein#add('Shougo/neocomplete.vim')
call dein#add('Shougo/neosnippet.vim')
call dein#add('Shougo/neosnippet-snippets')
call dein#add('vim-scripts/camelcasemotion')
call dein#add('vim-scripts/taglist.vim')
call dein#add('hdima/python-syntax')
call dein#add('benekastah/neomake')
call dein#add('scrooloose/nerdcommenter')
call dein#add('altercation/vim-colors-solarized')
call dein#add('xolox/vim-misc')
call dein#add('xolox/vim-easytags')
"call dein#add('vim-latex/vim-latex')
call dein#add('lervag/vimtex')
call dein#add('ervandew/supertab')
call dein#add('tmhedberg/SimpylFold')
call dein#add('junegunn/fzf')
"Not sure why, but this seems to break the base fzf
"call dein#add('junegunn/fzf.vim')
call dein#add('airblade/vim-gitgutter')
call dein#add('vim-airline/vim-airline')
call dein#add('vim-airline/vim-airline-themes')
call dein#add('tpope/vim-fugitive')
"Sadly, this plugin is just confusing and doesn't work that well.
"call dein#add('terryma/vim-multiple-cursors')

" Python and TeX customizations
call dein#local('/home/max/.vim/bundle', {'script_type': 'ftplugin'}, ['mv-custom'])

" You can specify revision/branch/tag.
"call dein#add('Shougo/vimshell', { 'rev': '3787e5' })

" If you want to install not installed plugins on startup.
if dein#check_install()
  call dein#install()
endif

call dein#end()


"}}}

" --- General Editing Features and Behavior --- {{{
set softtabstop=4
set shiftwidth=4
set expandtab
set smarttab
set smartindent
set autoindent

filetype plugin on

"Someone's been messing with this setting and I don't like it.
set backspace=2

"See whitespace discrepancies
set listchars=tab:>-,trail:=
set list

"Goes without saying.
set encoding=utf-8

set number
set relativenumber
set ruler
set colorcolumn=80

"Backup settings
set nobackup
set writebackup

syntax enable

"Options for printing
set printdevice=pdf
set printoptions=paper:A4,syntax:y,wrap:y,duplex:long

"A sort of autosave
autocmd FocusLost * :wall
autocmd TabLeave * :wall

"Wait time for potentially ambiguous mappings
set timeoutlen=500

" }}}

" Custom settings for various specific filetypes ---- {{{
augroup filetype_custom
    autocmd!
    "F***ing makefiles
    autocmd FileType make setlocal noexpandtab
    autocmd FileType gitcommit setlocal colorcolumn=75
    autocmd FileType vim setlocal foldmethod=marker
augroup END
" }}}

" --- Keybindings --- {{{

"More sensible movement that keeps fingers on the homerow
nnoremap j h
nnoremap k j
nnoremap l k
nnoremap ; l
vnoremap j h
vnoremap k j
vnoremap l k
vnoremap ; l
"And the logical-line movements as well...
nnoremap gk gj
nnoremap gl gk
vnoremap gk gj
vnoremap gl gk

inoremap jk <ESC>
" Just some training wheels...
"inoremap <ESC> <nop>

"So I don't have to hit the shift key EVERY TIME I want to save or quit
nnoremap h :

let mapleader = " "
let maplocalleader = "\\"

"vimrc shortcuts
nnoremap <leader>ev :tabedit $MYVIMRC<CR>
nnoremap <leader>sv :source $MYVIMRC<CR>
" And edit zshrc, why not...
nnoremap <leader>ez :tabedit ~/.zshrc.local<CR>

"Faster window and movement commands
nnoremap <leader>j <C-W>h
nnoremap <leader>k <C-W>j
nnoremap <leader>l <C-W>k
nnoremap <leader>; <C-W>l

nnoremap <leader>tn :tabnext<CR>
nnoremap <leader>tp :tabprevious<CR>
nnoremap <leader>tj :tabmove<SPACE>-1<CR>
nnoremap <leader>t; :tabmove<SPACE>+1<CR>
nnoremap <leader>te :tabe<SPACE>

" Lazy tab and session closing
nnoremap <leader>tq :tabclose<CR>
if has('gui_running')
    nnoremap <leader>qq :mksession!<SPACE>~/.lastguisession.vim<CR>:confirm qa<CR>
else
    nnoremap <leader>qq :confirm qa<CR>
endif

"Move lines up and down
nnoremap <leader>u :m .-2==<CR>
nnoremap <leader>d :m .+1==<CR>

"Delete a comma-delimited argument ("kill argument")
"Needs fixing; doesn't do well across line breaks or inside parens.
"The right way to do this would be to define a motion - how can do?
"Maybe take a look at how camelcasemotion is implemented?
nnoremap <leader>xa F,dt,
"Add space around a single binary operator
nnoremap <leader>bs i<SPACE><ESC>lei<SPACE><ESC>

"Uppercase the current word
inoremap <C-U><C-U> <ESC>viwUea

" --- Plugin keybindings --- {{{

" Quickly toggle the taglist
nnoremap <localleader>t :TlistToggle<CR>

" Fuzzy finder FTW!
nnoremap <leader>ff :FZF<CR>

" TODO
" Need to work on this. Mappings in multicursor mode work in really weird ways.
if !exists("g:multi_cursor_insert_maps")
    let g:multi_cursor_insert_maps = {'<ESC>': 1}
else
    let g:multi_cursor_insert_maps['<ESC>'] = 1
endif
let g:multi_cursor_quit_key='<C-j>'
" #$%@#$#$% quitting doesn't actually work using the designated quit key!
let g:multi_cursor_exit_from_insert_mode = 0
let g:multi_cursor_exit_from_visual_mode = 0

" }}}

" }}}

" --- Color and Theme --- {{{
colorscheme solarized

" --- Vary light/dark depending on time of day --- {{{
let s:dawnTimeHour = 7
let s:duskTimeHour = 19
function! s:setColorSchemeTime()
    let hour = str2nr(strftime('%H'))
    if (hour < s:dawnTimeHour) || (hour >= s:duskTimeHour)
        if &background != 'dark'
            set background=dark
        endif
    else
        if &background != 'light'
            set background=light
        endif
    endif
endfunction

nnoremap <F2> :ToggleBG<CR>

augroup change_theme
    autocmd!
    if has('gui_running')
        autocmd FocusGained * call s:setColorSchemeTime()
    endif
augroup END

" If no GUI, 'dark' actually just uses the current terminal colors
if !has('gui_running')
    set background=dark
endif

" }}}

"Font
if has('gui_running')
    " Portability - Only uncomment if this font is installed.
    set guifont=Inconsolata\ Medium\ 13
    "set guifont=Droid\ Sans\ Mono\ 12
endif
" }}}

" --- Plugins --- {{{

" Fancy symbols for the status line
let g:airline_powerline_fonts = 1

" --- Easytags and Completion --- {{{

let g:easytags_cmd='/usr/bin/ctags'
let g:easytags_by_filetype='~/.vimtags'

" }}}

" Snippets
let g:snips_author = "Max Veit"

" vimtex
let g:vimtex_view_method='zathura'
let g:vimtex_compiler_progname='nvr'
" Autocompletion for vimtex
if !exists('g:neocomplete#sources#omni#input_patterns')
  let g:neocomplete#sources#omni#input_patterns = {}
endif
let g:neocomplete#sources#omni#input_patterns.tex =
    \ g:vimtex#re#neocomplete

" }}}
