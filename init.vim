"=========================
"   Plugin Management
"=========================

" Plugin Manager (vim-plug)
call plug#begin('~/.vim/plugged')

" -- NERDTree Plugins
Plug 'preservim/nerdtree'          	 " Tree
Plug 'Xuyuanp/nerdtree-git-plugin' 	 " Git support
Plug 'ryanoasis/vim-devicons'	   	 " Icon support

" -- Telescope Plugins
Plug 'nvim-lua/plenary.nvim'				 " dependency for Telescope	
Plug 'nvim-telescope/telescope.nvim', { 'tag': '0.1.6' } " Telescope

" -- Editor Plugins
Plug 'tpope/vim-fugitive'     " compare per-line git difs
Plug 'airblade/vim-gitgutter' " symbols per-line git difs 
Plug 'f-person/git-blame.nvim'
" -- Language Server Plugins
Plug 'neovim/nvim-lspconfig' " language server setup

" -- Personalisation Plugins
Plug 'sainnhe/everforest'            " Everforest theme
Plug 'xiyaowong/transparent.nvim'    " nvim transparency :TransparentToggle
Plug 'nvim-lualine/lualine.nvim'     " Lualine
Plug 'skywind3000/vim-terminal-help' " Terminal
call plug#end()



"=========================
"    General Config 
"=========================

" -- Basics
let mapleader = "," " leader key rebind
set relativenumber          " numbered lines 
syntax on           " syntax highlighting

" -- Layout 
let g:NERDTreeWinPos = 'right' " NERDTree position

" -- Colorscheme setup
let g:everforest_background = 'hard' | colorscheme everforest " Theme variant 'soft' | 'medium' | 'hard'



"=========================
"  General Config - LUA 
"=========================

lua << EOF

-- Transparency 
require("transparent").setup({ -- Optional, you don't have to run setup.
  groups = { -- table: default groups
    'Normal', 'NormalNC', 'Comment', 'Constant', 'Special', 'Identifier',
    'Statement', 'PreProc', 'Type', 'Underlined', 'Todo', 'String', 'Function',
    'Conditional', 'Repeat', 'Operator', 'Structure', 'LineNr', 'NonText',
    'SignColumn', 'CursorLine', 'CursorLineNr', 'StatusLine', 'StatusLineNC',
    'EndOfBuffer',
  },
  extra_groups = {}, -- table: additional groups that should be cleared
  exclude_groups = {}, -- table: groups you don't want to clear
})

-- lualine
local colors = {
  blue   = '#80a0ff',
  cyan   = '#79dac8',
  black  = '#282E32', -- everforest - black
  white  = '#D1C6AD', -- everforest - white / yellow
  red    = '#ff5189',
  green  = '#ACBF87', -- everforest - green
  grey   = '#303030',
}

local bubbles_theme = {
  normal = {
    a = { fg = colors.black, bg = colors.green },
    b = { fg = colors.white, bg = colors.grey },
    c = { fg = colors.white },
  },

  insert = { a = { fg = colors.black, bg = colors.blue } },
  visual = { a = { fg = colors.black, bg = colors.cyan } },
  replace = { a = { fg = colors.black, bg = colors.red } },

  inactive = {
    a = { fg = colors.white, bg = colors.black },
    b = { fg = colors.white, bg = colors.black },
    c = { fg = colors.white },
  },
}

require('lualine').setup {
  options = {
    theme = bubbles_theme,
    component_separators = '',
    section_separators = { left = '', right = '' },
  },
  sections = {
    lualine_a = { { 'mode', separator = { left = '' }, right_padding = 2 } },
    lualine_b = { 'filename', 'branch' },
    lualine_c = {
      '%=', --[[ add your center compoentnts here in place of this comment ]]
    },
    lualine_x = {},
    lualine_y = { 'filetype', 'progress' },
    lualine_z = {
      { 'location', separator = { right = '' }, left_padding = 2 },
    },
  },
  inactive_sections = {
    lualine_a = { 'filename' },
    lualine_b = {},
    lualine_c = {},
    lualine_x = {},
    lualine_y = {},
    lualine_z = { 'location' },
  },
  tabline = {},
  extensions = {},
}

-- Language Server Setup



EOF



"=========================
"    Keybinds Config 
"=========================

" -- Generic
nnoremap <leader>w <cmd>q<CR>           " close the focused tab
" case insensitive word search the focused tab 
nnoremap <leader>fw :/\c
let g:terminal_key = '<leader>t'        " vim-terminal
nnoremap <leader>1 <cmd>tabprevious<CR> " prev editor tab
nnoremap <leader>2 <cmd>tabnext<CR>     " next editor tab

" -- NERDTree
nnoremap <leader>ee <cmd>NERDTreeToggle<CR> " toggle
nnoremap <leader>e  <cmd>NERDTreeFocus<CR>  " focus

" -- Telescope
noremap <leader>ff <cmd>Telescope find_files<CR>
" -- make sure ripgrep is installed
noremap <leader>fg <cmd>Telescope live_grep<CR>
" -- show all git changed files
noremap <leader>fd <cmd>Telescope git_status<CR> 
noremap <leader>fb <cmd>Telescope buffers<CR>
noremap <leader>fh <cmd>Telescope help_tags<CR>

" -- Fugitive
nnoremap <Leader>gg :Gdiff<CR> " show file git diff 

" -- git-blame
nnoremap <Leader>gc :GitBlameOpenFileURL<CR> " open the PR url
