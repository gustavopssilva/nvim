-- Definir a tecla líder para espaço
vim.g.mapleader = " "

local keymap = vim.keymap
local builtin = require('telescope.builtin')
local luasnip = require("luasnip")

local dap = require('dap')
-- mapeando snipperd:
-- Listar e navegar pelas escolhas de snippets com <C-k>
vim.keymap.set("i", "<C-k>", function()
  if luasnip.choice_active() then
    luasnip.change_choice(1)
  end
end)


vim.keymap.set({ "i", "s" }, "<Tab>", function()
  if luasnip.expand_or_jumpable() then
    luasnip.expand_or_jump()
  else
    return "<Tab>"
  end
end, { expr = true })

vim.keymap.set({ "i", "s" }, "<S-Tab>", function()
  if luasnip.jumpable(-1) then
    luasnip.jump(-1)
  else
    return "<S-Tab>"
  end
end, { expr = true })

-- Mapeamentos gerais
keymap.set("n", "<leader>qa", ":qa<CR>")       -- sair de vez
keymap.set("n", "<leader>wq", ":wq!<CR>")       -- salvar e sair
keymap.set("n", "<leader>qq", ":q<CR>")       -- sair sem salvar
keymap.set("n", "<leader>ww", ":w!<CR>")        -- salvar

keymap.set("n", "gx", ":!open <c-r><c-a><CR>") -- abrir URL sob o cursor

-- Gerenciamento de janelas divididas
keymap.set("n", "<leader>wv", "<C-w>v")     -- dividir janela verticalmente
keymap.set("n", "<leader>wh", "<C-w>s")     -- dividir janela horizontalmente:próxima
keymap.set("n", "<leader>wi", "<C-w>=")     -- igualar largura das janelas divididas
keymap.set("n", "<leader>wx", ":close<CR>") -- fechar janela dividida

keymap.set("n", "<leader>ws", "<C-w><5")                   -- diminuir largura das janelas divididas
keymap.set("n", "<leader>wth", ":split<CR>:terminal<CR>")  -- Nova aba horizontal com terminal
keymap.set("n", "<leader>wtv", ":vsplit<CR>:terminal<CR>") -- Nova aba vertical com terminal
keymap.set("n", "<leader>tt", ":!tilix -e nvim -R %<CR>")  -- Abrir o arquivo atual no Tilix com nvim
keymap.set("t", "<Esc>", "<C-\\><C-n>")                    -- Sair do modo terminal com Esc

-- keymap.set("n", "<leader>wh", "<C-w>h")     -- Vai para a janela à esquerda
-- keymap.set("n", "<leader>wj", "<C-w>j")     -- Vai para a janela abaixo
-- keymap.set("n", "<leader>wk", "<C-w>k")     -- Vai para a janela acima
-- keymap.set("n", "<leader>wl", "<C-w>l")     -- Vai para a janela à direita

keymap.set("n", "<leader>bn", ":bnext")     -- Vai para a buffer à direita
keymap.set("n", "<leader>bp", ":bprev")     -- Vai para a buffer à direita
keymap.set("n", "<leader>bl", ":buffers")   -- Vai para a buffer à direita
keymap.set("n", "<leader>bc", ":lua vim.cmd('buffer ' .. vim.fn.input('Buffer: '))<CR>")

-- keymap.set("n", "<leader>sj", "<C-w>-")     -- diminuir altura da janela dividida
-- keymap.set("n", "<leader>sk", "<C-w>+")     -- aumentar altura das janelas divididas
-- keymap.set("n", "<leader>sl", "<C-w>>5")    -- aumentar largura das janelas divididas

-- Gerenciamento de abas
keymap.set("n", "<leader>to", ":tabnew<CR>")   -- abrir uma nova aba
keymap.set("n", "<leader>tx", ":tabclose<CR>") -- fechar uma aba
keymap.set("n", "<leader>tn", ":tabn<CR>")     -- próxima aba
keymap.set("n", "<leader>tp", ":tabp<CR>")     -- aba anterior

-- Mapeamentos para diff passera entre versões...
keymap.set("n", "<leader>cc", ":diffput<CR>")   -- colocar diff de atual para outro durante diff
keymap.set("n", "<leader>cj", ":diffget 1<CR>") -- pegar diff da esquerda (local) durante merge
keymap.set("n", "<leader>ck", ":diffget 3<CR>") -- pegar diff da direita (remoto) durante merge
keymap.set("n", "<leader>cn", "]c")             -- próximo hunk de diff
keymap.set("n", "<leader>cp", "[c")             -- hunk de diff anterior

-- Mapeamentos de quickfix verificar problemas no codigo
keymap.set("n", "<leader>qo", ":copen<CR>")  -- abrir lista quickfix
keymap.set("n", "<leader>qf", ":cfirst<CR>") -- ir para o primeiro item da lista quickfix
keymap.set("n", "<leader>qn", ":cnext<CR>")  -- ir para o próximo item da lista quickfix
keymap.set("n", "<leader>qp", ":cprev<CR>")  -- ir para o item anterior da lista quickfix
keymap.set("n", "<leader>ql", ":clast<CR>")  -- ir para o último item da lista quickfix
keymap.set("n", "<leader>qc", ":cclose<CR>") -- fechar lista quickfix

-- Vim-maximizer
keymap.set("n", "<leader>sm", ":MaximizerToggle<CR>") -- alternar maximizar aba

-- Nvim-tree
keymap.set("n", "<C-q>", ":NvimTreeToggle<CR>")        -- alternar explorador de arquivos
keymap.set("n", "<leader>er", ":NvimTreeFocus<CR>")    -- alternar foco para explorador de arquivos
keymap.set("n", "<leader>ef", ":NvimTreeFindFile<CR>") -- encontrar arquivo no explorador de arquivos

-- Telescope
keymap.set("n", "<C-p>", builtin.find_files, {})
keymap.set("n", "<leader>fg", builtin.live_grep, {}) -- deveria procurar no conteudo.. sudo apt install ripgrep.
keymap.set("n", "<C-ç>", builtin.live_grep, {})

keymap.set('n', '<leader>pp', '<cmd>Telescope registers<CR>', { noremap = true, silent = true })         -- mostra historicos de clipboard
keymap.set('n', '<leader>fb', builtin.buffers, {})                                                       -- busca fuzzy por buffers abertos
keymap.set('n', '<leader>fh', builtin.help_tags, {})                                                     -- busca fuzzy por tags de ajuda
keymap.set('n', '<leader>fs', builtin.current_buffer_fuzzy_find, {})                                     -- busca fuzzy no buffer do arquivo atual

keymap.set('n', '<leader>fj', '<cmd>Telescope jumplist<CR>', { noremap = true, silent = true })         -- mostra os jumps que já dei
keymap.set('n', '<leader>fs', builtin.current_buffer_fuzzy_find, {})                                     -- busca fuzzy no buffer do arquivo atual
keymap.set('n', '<leader>fc', builtin.colorscheme, {})                                                   -- busca fuzzy por temas com preview
keymap.set('n', '<leader>fo', builtin.lsp_document_symbols, {})                                          -- busca fuzzy por símbolos no arquivo
keymap.set('n', '<leader>fi', builtin.lsp_incoming_calls, {})                                            -- busca fuzzy por chamadas LSP/entrada
keymap.set('n', '<leader>fm', function() builtin.treesitter({ symbols = { 'function', 'method' } }) end) -- busca fuzzy por métodos na classe atual
keymap.set('n', '<leader>ft',
  function()                                                                                             -- buscar conteúdo no arquivo no nó atual do nvim-tree
    local success, node = pcall(function() return require('nvim-tree.lib').get_node_at_cursor() end)
    if not success or not node then return end;
    builtin.live_grep({ search_dirs = { node.absolute_path } })
  end)

-- Git-blame
keymap.set("n", "<leader>gb", ":GitBlameToggle<CR>") -- alternar git blame
keymap.set("n", "<leader>gs", ":Gstatus<CR>")        -- abre status do Git no modo split

-- Harpoon favoritos de arquivos
keymap.set("n", "<leader>ha", require("harpoon.mark").add_file)                    -- adicionar
keymap.set("n", "<leader>hh", require("harpoon.ui").toggle_quick_menu)             -- vizualizar
keymap.set("n", "<leader>hr", function() require("harpoon.mark").rm_file() end)    -- remover
keymap.set("n", "<leader>hcl", function() require("harpoon.mark").clear_all() end) -- limpar tudo
keymap.set("n", "<leader>h1", function() require("harpoon.ui").nav_file(1) end)
keymap.set("n", "<leader>h2", function() require("harpoon.ui").nav_file(2) end)
keymap.set("n", "<leader>h3", function() require("harpoon.ui").nav_file(3) end)
keymap.set("n", "<leader>h4", function() require("harpoon.ui").nav_file(4) end)
keymap.set("n", "<leader>h5", function() require("harpoon.ui").nav_file(5) end)
keymap.set("n", "<leader>h6", function() require("harpoon.ui").nav_file(6) end)
keymap.set("n", "<leader>h7", function() require("harpoon.ui").nav_file(7) end)
keymap.set("n", "<leader>h8", function() require("harpoon.ui").nav_file(8) end)
keymap.set("n", "<leader>h9", function() require("harpoon.ui").nav_file(9) end)

-- Vim REST Console
keymap.set("n", "<leader>xr", ":call VrcQuery()<CR>") -- Executar consulta REST

-- LSP
keymap.set('n', 'K', '<cmd>lua vim.lsp.buf.hover()<CR>')

keymap.set('n', '<leader>gd', '<cmd>lua vim.lsp.buf.definition()<CR>') -- o mesmo que o *
keymap.set('n', 'gd', '<cmd>lua vim.lsp.buf.definition()<CR>')

keymap.set('n', '<leader>gD', '<cmd>lua vim.lsp.buf.declaration()<CR>')     -- Ir para a declaração
keymap.set('n', '<leader>gi', '<cmd>lua vim.lsp.buf.implementation()<CR>')  -- Ir para a implementação
keymap.set('n', '<leader>gt', '<cmd>lua vim.lsp.buf.type_definition()<CR>') -- Ir para a definição do tipo
-- keymap.set('n', '<leader>gr', '<cmd>lua vim.lsp.buf.references()<CR>')           -- Listar referências do símbolo
keymap.set('n', '<leader>gr', '<cmd>Telescope lsp_references<CR>', { noremap = true, silent = true })
keymap.set('n', '<leader>gs', '<cmd>lua vim.lsp.buf.signature_help()<CR>')       -- Mostrar assinatura da função
keymap.set('n', '<leader>rr', '<cmd>lua vim.lsp.buf.rename()<CR>')               -- Renomear símbolo
keymap.set('n', '<leader>gf', '<cmd>lua vim.lsp.buf.format({async = true})<CR>') -- Formatar código
keymap.set('v', '<leader>gf', '<cmd>lua vim.lsp.buf.format({async = true})<CR>') -- Formatar código (seleção)
keymap.set('n', '<F2>', '<cmd>lua vim.lsp.buf.code_action()<CR>')                -- Teste com a tecla F2
keymap.set('n', '<leader>ga', '<cmd>lua vim.lsp.buf.code_action()<CR>')          -- Ações de código (correções)
-- keymap.set('n', '<leader>ga', '<cmd>Telescope lsp_code_actions<CR>', { noremap = true, silent = true })

keymap.set('n', '<leader>dd', '<cmd>lua vim.diagnostic.open_float()<CR>') -- Mostrar erro/aviso
keymap.set('n', '<leader>dp', '<cmd>lua vim.diagnostic.goto_prev()<CR>')  -- Ir para erro anterior
keymap.set('n', '<leader>dn', '<cmd>lua vim.diagnostic.goto_next()<CR>')  -- Ir para próximo erro
keymap.set('n', '<leader>dl', '<cmd>lua vim.diagnostic.setloclist()<CR>') -- Mostrar lista de diagnósticos
keymap.set('n', '<leader>df', '<cmd>lua vim.diagnostic.setqflist()<CR>')  -- Mostrar diagnósticos globais no Quickfix
keymap.set('n', '<leader>dt', '<cmd>Telescope diagnostics<CR>', { noremap = true, silent = true })

keymap.set('n', '<leader>tr', '<cmd>lua vim.lsp.buf.document_symbol()<CR>') -- Mostrar símbolos do documento
keymap.set('i', '<C-Space>', '<cmd>lua vim.lsp.buf.completion()<CR>')       -- Auto-completar

-- Define os mapeamentos para depuração com o nvim-dap
vim.keymap.set('n', '<F5>', function() dap.continue() end)               -- Inicia ou continua a execução do programa
vim.keymap.set('n', '<F10>', function() dap.step_over() end)             -- Avança para a próxima linha (sem entrar em funções)
vim.keymap.set('n', '<F11>', function() dap.step_into() end)             -- Entra dentro da função chamada na linha atual
vim.keymap.set('n', '<F12>', function() dap.step_out() end)              -- Sai da função atual e retorna para o chamador
vim.keymap.set('n', '<Leader>b', function() dap.toggle_breakpoint() end) -- Alterna um breakpoint na linha atual
vim.keymap.set('n', '<Leader>B', function()                              -- Define um breakpoint com condição
  dap.set_breakpoint(vim.fn.input('Breakpoint condition: '))
end)

-- meus, sera que vai??

keymap.set("n", "<leader>path", ":let @+ = expand('%:p')")     -- Copia o path da raiz ate aqui
-- Substituiu meu LspInfo
keymap.set("n", "<leader>info", ":lua for _, c in ipairs(vim.lsp.get_clients()) do print(vim.inspect({ name = c.name, root = c.config.root_dir, cmd = c.config.cmd, filetypes = c.config.filetypes, buffers = c.attached_buffers })) end")

-- Organizar imports no Java
keymap.set("n", "<leader>go", function()
  if vim.bo.filetype == "java" then
    require("jdtls").organize_imports()
  end
end, { desc = "Organizar imports no Java" })

-- Salvar automaticamente ao fechar um buffer modificado
vim.api.nvim_create_autocmd("BufDelete", {
  pattern = "*",
  callback = function()
    if vim.bo.modified then
      -- vim.cmd("write") qualquer coisa libera essa linha aqui...
    end
  end,
})
