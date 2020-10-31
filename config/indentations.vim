" Some code prefer to have it's own indentation
  autocmd FileType javascript set tabstop=2|set softtabstop=2|set shiftwidth=2
  au BufEnter *.js set ai sw=2 ts=2 sta et fo=croql

  autocmd FileType less set tabstop=2|set softtabstop=2|set shiftwidth=2
  au BufEnter *.less set ai sw=2 ts=2 sta et fo=croql
  au BufEnter *.css set ai sw=2 ts=2 sta et fo=croql

  autocmd FileType scss set tabstop=2|set softtabstop=2|set shiftwidth=2
  au BufEnter *.scss set ai sw=2 ts=2 sta et fo=croql

  autocmd FileType groovy set tabstop=2|set softtabstop=2|set shiftwidth=4
  au BufEnter *.groovy set ai sw=4 ts=4 sta et fo=croql
