local cmd = vim.cmd		-- execute Vim commands
local exec = vim.api.nvim_exec	-- execute Vimscript
local g = vim.g			-- global variables
local opt = vim.opt		-- global /buffer/windows-scoped options
-- Направление перевода с русского на английский
g.translate_source = 'ru'
g.translate_target = 'en'

-------------------------------------------------
-- Главные
-------------------------------------------------
-- opt.colorcolumn = '90'		-- Разделитель на 90 символов
opt.cursorline = true		-- Подсветка строки с курсором
opt.spelllang = {'en_us', 'ru'} -- Словари рус eng
opt.number = true		-- Включаем нумерацию строк
opt.relativenumber = true	-- Вкл. относительную нумерацию строк
opt.undofile = true		-- Возможность отката назад
opt.splitright = true		-- Vertical split вправо
opt.splitbelow = true		-- Horizontal split вниз
opt.scrolloff = 7
opt.mouse=''

-------------------------------------------------
-- Цветовая схема
-------------------------------------------------
opt.termguicolors = true	-- 24-bit RGB colors
cmd'colorscheme gruvbox'

-------------------------------------------------
-- Табы и отступы
-------------------------------------------------
cmd([[
filetype indent plugin on
syntax enable
]])
opt.expandtab = true		-- use spaces instad of tabs
opt.shiftwidth = 4		-- shift 4 spaces when tab
opt.tabstop = 4			-- 1 tab == 4 spaces
opt.smartindent = true		-- autoindent new lines
-- Don't auto commenting new lines
cmd [[au BufEnter * set fo-=c fo-=r fo -=o]]
-- remove line lenght marker for selected filetipes
cmd [[autocmd FileType text,markdown,html,xhtml,javascript setlocal cc=0]]
-- Two spaces for selected filetypes
cmd [[
autocmd FileType h,c,xml,html,xhtml,css,scss,javascript,lua,yaml,htmljinja,c,h,cpp setlocal shiftwidth=2 tabstop=2
]]

--------------------------------------------------
-- Полезные фишки
--------------------------------------------------
-- Запоминает, где nvim последний раз редактировал файл
cmd [[
autocmd BufReadPost * if line("'\"") > 1 && line ("'\"") <= line("$") | exe "normal! g'\"" | endif
]]
-- Подсвечивает на доли секунды скопррованную часть текста
exec([[
augroup YankHighlight
autocmd!
autocmd TextYankPost * silent! lua vim.highlight.on_yank{higroup="InSearch", timeout=700}
augroup end
]], false)


--------------------------------------------------
-- Установки для плагинов
--------------------------------------------------
-- LSP Settings
local lsp_installer = require("nvim-lsp-installer")
lsp_installer.on_server_ready(function(server)
    local option = {}
    if server.name == "sumneko_lua" then
        -- only apply these settings for the "sumneko_lua" server
	    option.settings = {
            Lua = {
                diagnostics = {
                    -- Get the language server to recognize the 'vim, 'use' global
                    global = {'vim', 'use'},
                },
                workspace = {
                    -- Make the server aware of Neovim rumtime files
                    library = vim.api.nvim_get_runtime_file("", true),
                },
                -- Do not send telemetry data containing a randomized but unique identifier
                telemetry = {
                    enable = false,
                },
            },
        }
    end
    server:setup(option)
end)

-- Nvim-cmp supports additional completion capabilities
local capabilities = vim.lsp.protocol.make_client_capabilities()
capabilities = require('cmp_nvim_lsp').default_capabilities(capabilities)
vim.o.completeopt = 'menuone,noselect'
-- Luasnip setup
local luasnip = require 'luasnip'
-- nvim-cmp setup
local cmp = require 'cmp'
cmp.setup {
    snippet = {
        expand = function(args)
            luasnip.lsp_expand(args.body)
        end,
    },
    sources = {
        { name = 'nvim_lsp' },
        { name = 'luasnip' },
        { name = 'path' },
        { name = 'buffer', option = {
            get_bufnrs = function()
                return vim.api.nvim_list_bufs()
            end
        },
    },
},
}
