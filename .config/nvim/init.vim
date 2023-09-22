call plug#begin()

  Plug 'preservim/nerdtree'
  " Plug 'fatih/vim-go', { 'do': ':GoUpdateBinaries' }
  Plug 'junegunn/fzf', { 'do': { -> fzf#install() } }
  Plug 'junegunn/fzf.vim'
  Plug 'jlanzarotta/bufexplorer'
  Plug 'qpkorr/vim-bufkill'
  Plug 'vim-autoformat/vim-autoformat'
  if has("linux")
    Plug 'windwp/nvim-projectconfig'
  endif
  Plug 'tpope/vim-fugitive'
  Plug 'tpope/vim-commentary'
  Plug 'neovim/nvim-lspconfig'
  Plug 'mustache/vim-mustache-handlebars'
  
  " colorschemes
  Plug 'crusoexia/vim-monokai'
  Plug 'theacodes/witchhazel'

  " writing mode
  Plug 'reedes/vim-pencil'       " Super-powered writing things
  Plug 'junegunn/limelight.vim'  " Highlights only active paragraph
  Plug 'junegunn/goyo.vim'       " Full screen writing mode
  Plug 'reedes/vim-lexical'      " Better spellcheck mappings
  Plug 'reedes/vim-litecorrect'  " Better autocorrections

  " post install (yarn install | npm install) then load plugin only for editing supported files
  Plug 'sbdchd/neoformat'

  " GitHub Copilot
  Plug 'github/copilot.vim'

call plug#end()

filetype plugin indent on                  " Enable filetype-specific indenting and plugins

set showmatch "show matching surround
set hidden    "allow hiding buffers without save

syntax on " Enable syntax highlighting
set background=dark
colorscheme monokai
" colorscheme witchhazel
hi Normal guibg=black

" don't leave backup files scattered about.
set updatecount=0
set nobackup
set nowritebackup
set backupcopy=yes

set nowrap            "no text wrapping
set selectmode=key    "shifted arrows for selection
set nonu              "don't show line numbers
set foldcolumn=0      "little space on the left.
set nofoldenable      " disable folding
set tabstop=2
set shiftwidth=2
set softtabstop=2
set ai                "auto indent
set expandtab
set smarttab
set smartcase         " ignore case in searches unless specific case is given
set wrapscan          " wrap searches
set ww=<,>,[,],h,l    "wrap on movement keys
set mouse=a           " allow mouse to work in the terminal

let mapleader = ","

" highlight searches, clear with spacebar
set hlsearch
nnoremap <silent> <Space> :nohlsearch<Bar>:echo<CR>

" Always show status line
set laststatus=2

" Intuitive backspacing in insert mode
set backspace=indent,eol,start

" highlight cursor line in INSERT mode.
autocmd InsertLeave * se nocul
autocmd InsertEnter * se cul

let &t_SI = "\e[6 q"
let &t_EI = "\e[2 q"

"tell the term has 256 colors
set t_Co=256

" assume the /g flag on :s substitutions to replace all matches in a line
set gdefault

" keep 3 lines visible at top and bottom
set scrolloff=3

" Tab and Shift-Tab indent and unindent
inoremap <S-Tab> <esc>mp<<2h`pa
noremap <Tab> >>
noremap <S-Tab> <<
vnoremap <Tab> >gv
vnoremap <S-Tab> <gv

" window nav
inoremap <C-h> <esc><C-w><C-h>
inoremap <C-j> <esc><C-w><C-j>
inoremap <C-k> <esc><C-w><C-k>
inoremap <C-l> <esc><C-w><C-l>
noremap <C-h> <C-w><C-h>
noremap <C-j> <C-w><C-j>
noremap <C-k> <C-w><C-k>
noremap <C-l> <C-w><C-l>

" unmap shift-k
vmap K <up>
nmap K <up>

" Enable closetag macro all the time
let b:unaryTagsStack=""
let b:closetag_html_style=1
let b:closetag_disable_synID=1
" source ~/.vim/plugins/closetag.vim
" let b:unaryTagsStack=""
" let b:closetag_html_style=1
" let b:closetag_disable_synID=1

" CTRL-S is Save
noremap <C-s> :w<CR>
inoremap <C-s> <esc>:w<CR>

" leader s also saves
noremap <leader>s :w<CR>
inoremap <leader><leader>s <esc>:w<CR>

" in case of fatfinger
command! W :w

" ,bd to close buffer without changing window layout.
nmap <leader>bd :BW<CR>
imap <C-b>d <esc>:BW<CR>

" toggle numbers
nmap <leader>n :set nonu!<CR>

" hashrocket!
imap hh =>

" esc from insert mode with this uncommon keystroke
imap jj <esc>

" Use modeline overrides
set modeline
set modelines=10

" NerdTree
let NERDTreeShowBookmarks=0
map <leader>d :execute 'NERDTreeToggle ' . getcwd()<CR>

" fzf.vim, ctrl-p to launch
let $FZF_DEFAULT_COMMAND='ag -l --path-to-ignore ~/.ignore --nocolor --hidden -g ""'
map <leader>p :Files<CR>
map <C-p> :Files<CR>

" Ag comes with fzf + apt install the_silver_searcher
map <leader>a :Ag<space>
vmap <leader>a "ay:Ag<space><C-r>a<CR>

" close quickfix buffer
map <leader>x :ccl<CR>

" vim-projectconfig
if has("linux")
  lua require('nvim-projectconfig').setup()
endif

" let g:rufo_auto_formatting = 1
" let g:rufo_executeable = 'bundle exec rufo'

" neoformat
let g:neoformat_try_node_exe = 1" 
map <leader>f :Neoformat<CR>

" lsp configuration
" https://github.com/neovim/nvim-lspconfig#Suggested-configuration
lua <<EOF
  -- Mappings.
  -- See `:help vim.diagnostic.*` for documentation on any of the below functions
  local opts = { noremap=true, silent=true }

  vim.keymap.set('n', '<space>e', vim.diagnostic.open_float, opts)
  vim.keymap.set('n', '[d', vim.diagnostic.goto_prev, opts)
  vim.keymap.set('n', ']d', vim.diagnostic.goto_next, opts)
  vim.keymap.set('n', '<space>q', vim.diagnostic.setloclist, opts)

  -- Use an on_attach function to only map the following keys
  -- after the language server attaches to the current buffer
  local on_attach_all = function(client, bufnr)
    -- Enable completion triggered by <c-x><c-o>
    vim.api.nvim_buf_set_option(bufnr, 'omnifunc', 'v:lua.vim.lsp.omnifunc')

    -- Mappings.
    -- See `:help vim.lsp.*` for documentation on any of the below functions
    local bufopts = { noremap=true, silent=true, buffer=bufnr }
    vim.keymap.set('n', 'gD', vim.lsp.buf.declaration, bufopts)
    vim.keymap.set('n', 'gd', vim.lsp.buf.definition, bufopts)
    vim.keymap.set('n', 'K', vim.lsp.buf.hover, bufopts)
    vim.keymap.set('n', 'gi', vim.lsp.buf.implementation, bufopts)
    vim.keymap.set('n', '<C-k>', vim.lsp.buf.signature_help, bufopts)
    vim.keymap.set('n', '<space>wa', vim.lsp.buf.add_workspace_folder, bufopts)
    vim.keymap.set('n', '<space>wr', vim.lsp.buf.remove_workspace_folder, bufopts)
    vim.keymap.set('n', '<space>wl', function() print(vim.inspect(vim.lsp.buf.list_workspace_folders())) end, bufopts)
    vim.keymap.set('n', '<space>D', vim.lsp.buf.type_definition, bufopts)
    vim.keymap.set('n', '<space>rn', vim.lsp.buf.rename, bufopts)
    vim.keymap.set('n', '<space>ca', vim.lsp.buf.code_action, bufopts)
    vim.keymap.set('n', 'gr', vim.lsp.buf.references, bufopts)
    vim.keymap.set('n', '<space>f', function() vim.lsp.buf.format { async = true } end, bufopts)
  end

  local lsp_flags = {
    -- This is the default in Nvim 0.7+
    debounce_text_changes = 150,
  }
  require('lspconfig')['tsserver'].setup{
    on_attach = function(client, bufnr)
      on_attach_all(client, bufnr)
    end,
    flags = lsp_flags,
    init_options = {
      preferences = {
        disableSuggestions = true,
      },
    },
  }

  require'lspconfig'.eslint.setup{
    on_attach = on_attach_all,
  }

  require('lspconfig')['standardrb'].setup{
    on_attach = on_attach_all,
    cmd = { 'bundle', 'exec', 'standardrb', '--lsp' }
  }
  -- require('lspconfig')['pyright'].setup{
  --   on_attach = on_attach,
  --   flags = lsp_flags,
  -- }
  -- require('lspconfig')['rust_analyzer'].setup{
  --   on_attach = on_attach,
  --   flags = lsp_flags,
  --   -- Server-specific settings...
  --   settings = {
  --     ["rust-analyzer"] = {}
  --   }
  -- }
EOF

" pencil
augroup pencil
 autocmd!
 autocmd filetype markdown,mkd call pencil#init()
     \ | call lexical#init()
     \ | call litecorrect#init()
     \ | setl spell spl=en_us fdl=4 noru nonu nornu
     \ | setl fdo+=search
augroup END

" Pencil / Writing Controls {{{
let g:pencil#wrapModeDefault = 'soft'
let g:pencil#textwidth = 74
let g:pencil#joinspaces = 0
let g:pencil#cursorwrap = 1
let g:pencil#conceallevel = 3
let g:pencil#concealcursor = 'c'
let g:pencil#softDetectSample = 20
let g:pencil#softDetectThreshold = 130
" }}}

" Python
autocmd FileType python map <buffer> <F9> :w<CR>:exec '!python3' shellescape(@%, 1)<CR>
autocmd FileType python imap <buffer> <F9> <esc>:w<CR>:exec '!python3' shellescape(@%, 1)<CR>

if exists("g:neovide")
  " Put anything you want to happen only in Neovide here
  let g:neovide_cursor_animation_length = 0.01
endif

if has("mac")
  set guifont=Menlo:h15

  " create window splits with <Command-w>{s,v}
  map <D-w>s <C-w>s
  " in case I fat finger it
  map <D-w><D-s> <C-w>s
  map <D-w>q <C-w>q
  map <D-w><D-q> <C-w>q
  map <D-w>v <C-w>v
  map <D-w><D-v> <C-w>v
  " create window splits with <Command-w>{s,v}
  imap <D-w>s <esc><C-w>s
  " in case I fat finger it
  imap <D-w><D-s> <esc><C-w>s
  imap <D-w>q <esc><C-w>q
  imap <D-w><D-q> <esc><C-w>q
  imap <D-w>v <esc><C-w>v
  imap <D-w><D-v> <esc><C-w>v
  imap <D-w> <C-w>

  imap <D-p> <C-p>
  imap <D-n> <C-n>

  " map <D-t> :CommandT<CR>
  " noremap <D-t> :CommandT<CR>
  " inoremap <D-t> :CommandT<CR>
  map <D-t> :CtrlP<CR>
  noremap <D-t> :CtrlP<CR>
  inoremap <D-t> :CtrlP<CR>


  " paste current yank buffer
  inoremap <D-V> <esc>""pi

  map <D-s> :w<CR>          " just save
  imap <D-s> <esc>:w<CR>    " save and return to normal mode (saves a keystroke)
  vmap <D-s> <esc>:w<CR>gv  " save and return to previous visual selection

  " navigate splits quickly with the normal movement keys
  inoremap <D-h> <esc><C-w><C-h>
  inoremap <D-j> <esc><C-w><C-j>
  inoremap <D-k> <esc><C-w><C-k>
  inoremap <D-l> <esc><C-w><C-l>
  noremap <D-h> <C-w><C-h>
  noremap <D-j> <C-w><C-j>
  noremap <D-k> <C-w><C-k>
  noremap <D-l> <C-w><C-l>

  " esc
  inoremap <D-[> <esc>

  " format paragraph
  map <D-p> vipgq

  map <leader>w= <C-w>=
  noremap <leader>w= <C-w>=
  noremap <D-w>= <C-w>=

  " https://github.com/mattn/emmet-vim formerly Zen-Coding
  map <D-y> <C-y>
  map <D-y>, <C-y>,
endif

