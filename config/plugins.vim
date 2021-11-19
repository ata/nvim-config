" Plugins are managed by Plug. Once VIM is open run :BundleInstall to
" install plugins.
call plug#begin()

" Nerd commenter using default align left
Plug 'scrooloose/nerdcommenter'
let g:NERDDefaultAlign = 'left'

" Plugins requiring no additional configuration or keymaps
Plug 'tpope/vim-endwise'
Plug 'tpope/vim-fugitive'
Plug 'tpope/vim-rake'
Plug 'tpope/vim-repeat'
Plug 'vim-ruby/vim-ruby'
Plug 'vim-scripts/ruby-matchit'
Plug 'tpope/vim-abolish'
Plug 'mattn/emmet-vim'
Plug 'junegunn/fzf', { 'dir': '~/.fzf', 'do': './install --all' }
Plug 'junegunn/fzf.vim'
function! Strip(var)
  return substitute(a:var, '^\s*\(.\{-}\)\s*\n', '\1', '')
endfunction

function! SimpleFZF()
  let gitdir = Strip(system('git rev-parse --is-inside-work-tree'))
  if gitdir == 'true'
    call fzf#run(fzf#wrap({'source': 'git ls-files --exclude-standard --others --cached'}))
  else
    :FZF
  endif
endfunction
command! SimpleFZF call SimpleFZF()
map <Leader>t :SimpleFZF<cr>
map <C-P> :SimpleFZF<cr>
map <Leader>b :Buffers<cr>
map <C-B> :Buffers<cr>

Plug 'digitaltoad/vim-pug'
Plug 'leafgarland/typescript-vim'


" Vim airline configs
Plug 'vim-airline/vim-airline'
Plug 'vim-airline/vim-airline-themes'
let g:airline#extensions#tabline#enabled = 1
let g:airline#extensions#branch#enabled = 0
let g:airline_powerline_fonts = 1
let g:airline_theme='minimalist'

" Easy motion config
Plug 'easymotion/vim-easymotion'

" Linter
Plug 'dense-analysis/ale'
let g:ale_disable_lsp = 1
let b:ale_linters = ['eslint']

" For highlighting
Plug 'nvim-treesitter/nvim-treesitter', {'do': ':TSUpdate'}

" Code completion
Plug 'neoclide/coc.nvim', {'branch': 'release'}
" All config is in config/coc.vim


" Slim
Plug 'slim-template/vim-slim'
au BufNewFile,BufRead *.slim set filetype=slim

" AG aka The Silver Searcher
Plug 'rking/ag.vim'
nmap g/ :Ag!<space>
nmap g* :Ag! -w <C-R><C-W><space>
nmap ga :AgAdd!<space>
nmap gn :cnext<CR>
nmap gp :cprev<CR>
nmap gq :ccl<CR>
nmap gl :cwindow<CR>


" Tagbar for navigation by tags using CTags
Plug 'majutsushi/tagbar'
let g:tagbar_autofocus = 1
map <Leader>rt :!ctags --extra=+f -R *<CR><CR>
map <Leader>. :TagbarToggle<CR>

" Markdown syntax highlighting
Plug 'tpope/vim-markdown'
augroup mkd
  autocmd BufNewFile,BufRead *.mkd      set ai formatoptions=tcroqn2 comments=n:> filetype=markdown
  autocmd BufNewFile,BufRead *.md       set ai formatoptions=tcroqn2 comments=n:> filetype=markdown
  autocmd BufNewFile,BufRead *.markdown set ai formatoptions=tcroqn2 comments=n:> filetype=markdown
augroup END

" NERDTree for project drawer
Plug 'scrooloose/nerdtree'
let NERDTreeHijackNetrw = 0
nmap <leader>g :NERDTreeToggle<CR>
nmap <leader>G :NERDTreeFind<CR>
let NERDTreeIgnore = ['\.pyc$']

" NERDTree Plugin
Plug 'Xuyuanp/nerdtree-git-plugin'

" GitGutter
Plug 'airblade/vim-gitgutter'

" Unimpaired for keymaps for quicky manipulating lines and files
Plug 'tpope/vim-unimpaired'
" Bubble single lines
nmap <C-Up> [e
nmap <C-Down> ]e

" Bubble multiple lines
vmap <C-Up> [egv
vmap <C-Down> ]egv

" Format Code
Plug 'sbdchd/neoformat'

" Ansible
Plug 'pearofducks/ansible-vim'
au BufRead,BufNewFile */provisioning/**/*.yml set filetype=yaml.ansible

" gundo for awesome undo tree visualization
Plug 'sjl/gundo.vim'
map <Leader>h :GundoToggle<CR>


" rails.vim, nuff' said
Plug 'tpope/vim-rails'
map <Leader>oc :Rcontroller<Space>
map <Leader>ov :Rview<Space>
map <Leader>om :Rmodel<Space>
map <Leader>oh :Rhelper<Space>
map <Leader>oj :Rjavascript<Space>
map <Leader>os :Rstylesheet<Space>
map <Leader>oi :Rintegration<Space>


" surround for adding surround 'physics'
Plug 'tpope/vim-surround'
" # to surround with ruby string interpolation
let g:surround_35 = "#{\r}"
" - to surround with no-output erb tag
let g:surround_45 = "<% \r %>"
" = to surround with output erb tag
let g:surround_61 = "<%= \r %>"


" Easy async RSpec running
Plug 'thoughtbot/vim-rspec'
Plug 'tpope/vim-dispatch'
let g:rspec_command = "Dispatch rspec --format=progress --no-profile {spec}"
nmap <Leader>rc :wa<CR> :call RunCurrentSpecFile()<CR>
nmap <Leader>rn :wa<CR> :call RunNearestSpec()<CR>
nmap <Leader>rl :wa<CR> :call RunLastSpec()<CR>
nmap <Leader>ra :wa<CR> :call RunAllSpecs()<CR>

" MultipleCursor
Plug 'terryma/vim-multiple-cursors'

" Vertical Line
Plug 'Yggdroot/indentLine'

" php-cs-fixer (for indentation)
Plug 'stephpy/vim-php-cs-fixer'

" Toml
Plug 'cespare/vim-toml'

" Color indentation
Plug 'nathanaelkane/vim-indent-guides'

" Locate test file
Plug 'janko-m/vim-test'

nmap <silent> <leader>T :TestFile<CR>
nmap <silent> <leader>F :TestNearest<CR>

Plug 'modille/groovy.vim'

call plug#end()

filetype plugin indent on
