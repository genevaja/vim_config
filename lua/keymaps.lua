local map = vim.api.nvim_set_keymap
local default_opts = {noremap = true, silent = true}

-- Set , as the leader key
vim.g.mapleader = ','

-- Системный буфер обмена shift - Y
map('v', '<leader>y', '"+y', {})
map('n', '<leader>p', '"+p', {})
-- Типа "нажимает" на ESC при быстром нажатии jj, чтобы не тянуться
map('i', 'jj', '<Esc>', {noremap = true})
-- Стрелочки отключить. Использовать hjkl
map('', '<up>', ':echoe "Use k"<CR>', {noremap = true, silent = false})
map('', '<down>', ':echoe "Use j"<CR>', {noremap = true, silent = false})
map('', '<left>', ':echoe "Use h"<CR>', {noremap = true, silent = false})
map('', '<right>', ':echoe "Use l"<CR>', {noremap = true, silent = false})
-- Автоформат + сохранение по CTRL-s, как в нормальном, так и в insert режиме
map('n', '<C-s>', ':Autoformat<CR>:w<CR>', default_opts)
map('i', '<C-s>', '<esc>:Autoformat<CR>:w<CR>', default_opts)
-- DOESN'T WORK
-- Переводчик рус -> eng
map('v', 't', '<Plug>(Vtranstale)', {})
-- fzf
map('n', '<C-a>', [[ <cmd>lua require('telescope.builtin').find_files()<cr> ]], default_opts)
map('n', '<C-p>', [[ <cmd>lua require('telescope.builtin').buffers()<cr> ]], default_opts)

------------------------------------------------
-- Фн. клавиши по F1 .. F12
------------------------------------------------
-- F1
map('n', '<F1>', ':nohl<CR>', default_opts)
-- Shift + F1 = удалить пустые строки
map('n', '<S-F1>', ':g/^$/d<CR>', default_opts)
-- F2 для временной вставки из буфера, чтобы отключить авто идент
vim.o.pastetoggle='<F2>'
-- F3 перечитать конфигурацию nvim
map('n', '<F3>', ':so ~/.config/nvim/init.lua<CR>' , {noremap = true})
-- Shift + F3 Открыть всю nvim конфигурацию для редактирования
map('n', '<leader><F3>', ':args ~/.config/nvim/init.lua ~/.config/nvim/lua/plugins.lua ~/.config/nvim/lua/settings.lua ~/.config/nvim/lua/keymaps.lua<CR>', {noremap = true})
-- F4 Поиск слова под курсором
map('n', '<S-F4>', [[<cmd>lua require('telescope.builtin').grep_string()<cr>]], default_opts)
-- Shift + F4 Поиск слова в модальном окошке
map('n', '<F4>', [[<cmd>lua require('telescope.builtin').live_grep()<cr>]], default_opts)
-- F5 Разные вариации нумерации строк, можно переключаться
map('n', '<F5>', ':exec &nu==&rnu? "se nu!" : "se rnu!"<CR>', default_opts)
-- F6 Дерево файлов
map('n', '<F6>', ':NvimTreeRefresh<CR>:NvimTreeToggle<CR>', default_opts)
-- F8 Показ дерева классов и функций, плагин majutsusi/tagbar
-- Оставить филлер
-- F11 Проверка орфографии для русского и английского языка
map('n', '<F11>', ':set spell!<CR>', default_opts)
map('i', '<F11>', '<C-O>:set spell!<CR>', default_opts)

-- Маппинги для буфферов
map("n", "<leader>bd", "<cmd>bdelete %<CR>", default_opts)
-- Переключение вкладок с помощью TAB или shift-tab (akinsho/bufferline.nvim)
map('n', '<leader>l', ':BufferLineCycleNext<CR>', default_opts)
map('n', '<leader>h', ':BufferLineCyclePrev<CR>', default_opts)
-- Закрыть все вкладки, кроме текущей
map('n', '<leader>bo', '<cmd>%bd|e#|bd#<CR>', default_opts)
