runtime! config/plugins.vim
runtime! config/coc.vim
runtime! config/treesitter.vim
runtime! config/functions.vim
runtime! config/mappings.vim
runtime! config/general.vim
runtime! config/indentations.vim

" for git, add spell checking and automatic wrapping at 72 columns
autocmd Filetype gitcommit setlocal spell textwidth=72
