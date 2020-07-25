let plug_install = 0
let autoload_plug_path = stdpath('config') . '/autoload/plug.vim'
if !filereadable(autoload_plug_path)
    silent exe '!curl -fL --create-dirs -o ' . autoload_plug_path .
        \ ' https://raw.github.com/junegunn/vim-plug/master/plug.vim'
    execute 'source ' . fnameescape(autoload_plug_path)
    let plug_install = 1
endif
unlet autoload_plug_path

call plug#begin('~/.config/nvim/plugins')
" To edit files in sudo mode
" TODO

" Autocomplitions
Plug 'neoclide/coc.nvim', {'branch': 'release'}

" show +/- in line numbers of a file under git
Plug 'airblade/vim-gitgutter'

" Comments
Plug 'tpope/vim-commentary'

call plug#end()

if plug_install
    PlugInstall --sync
endif
unlet plug_install

set number
set clipboard+=unnamedplus
