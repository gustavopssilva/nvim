-- Configuração específica de SQL.
-- Centraliza fontes de autocompletar (dadbod + dicionário de palavras-chave + buffer).

-- Setup do cmp pra SQL: registrado uma única vez por sessão.
if not vim.g._sql_cmp_setup_done then
  vim.g._sql_cmp_setup_done = true

  -- Caminho do dicionário compartilhado com o vimrc remoto.
  local dict_path = vim.fn.stdpath('config') .. '/vimrc/vim/dict/sql.txt'

  -- Bootstrap: cria o dict file com keywords padrão se ele não existir.
  -- Espelha o bloco em vimrc/vimrc:498-538 — pode editar livremente depois,
  -- só recria quando o arquivo está ausente.
  if vim.fn.filereadable(dict_path) == 0 then
    vim.fn.mkdir(vim.fn.fnamemodify(dict_path, ':h'), 'p')
    vim.fn.writefile({
      'SELECT', 'FROM', 'WHERE', 'INSERT', 'INTO', 'VALUES', 'UPDATE',
      'SET', 'DELETE', 'TRUNCATE',
      'CREATE', 'ALTER', 'DROP', 'TABLE', 'VIEW', 'INDEX', 'SEQUENCE',
      'SCHEMA', 'DATABASE', 'FUNCTION', 'PROCEDURE', 'TRIGGER',
      'CONSTRAINT', 'COLUMN',
      'PRIMARY', 'KEY', 'FOREIGN', 'REFERENCES', 'UNIQUE', 'CHECK',
      'DEFAULT', 'NOT', 'NULL',
      'INNER', 'LEFT', 'RIGHT', 'FULL', 'OUTER', 'CROSS', 'NATURAL',
      'JOIN', 'ON', 'USING',
      'GROUP', 'BY', 'ORDER', 'HAVING', 'LIMIT', 'OFFSET', 'DISTINCT',
      'UNION', 'INTERSECT', 'EXCEPT', 'ALL', 'ANY', 'SOME', 'AS',
      'AND', 'OR', 'IN', 'EXISTS', 'BETWEEN', 'LIKE', 'ILIKE', 'IS',
      'TRUE', 'FALSE', 'UNKNOWN',
      'CASE', 'WHEN', 'THEN', 'ELSE', 'END',
      'WITH', 'RECURSIVE', 'RETURNING',
      'COUNT', 'SUM', 'AVG', 'MIN', 'MAX', 'COALESCE', 'NULLIF',
      'GREATEST', 'LEAST',
      'CAST', 'CONVERT', 'EXTRACT', 'SUBSTRING', 'TRIM', 'UPPER',
      'LOWER', 'LENGTH', 'CONCAT', 'REPLACE', 'POSITION',
      'ROW_NUMBER', 'RANK', 'DENSE_RANK', 'LEAD', 'LAG', 'OVER',
      'PARTITION',
      'INTEGER', 'INT', 'BIGINT', 'SMALLINT', 'NUMERIC', 'DECIMAL',
      'REAL', 'DOUBLE', 'PRECISION', 'FLOAT',
      'VARCHAR', 'CHAR', 'TEXT', 'DATE', 'TIME', 'TIMESTAMP',
      'INTERVAL', 'BOOLEAN', 'BYTEA', 'JSON', 'JSONB', 'UUID',
      'SERIAL', 'BIGSERIAL',
      'BEGIN', 'COMMIT', 'ROLLBACK', 'SAVEPOINT', 'TRANSACTION',
      'GRANT', 'REVOKE', 'ROLE', 'USER',
      'ASC', 'DESC', 'NULLS', 'FIRST', 'LAST',
      'CONFLICT', 'DO', 'NOTHING', 'EXCLUDED',
      'IF', 'ELSIF', 'LOOP', 'FOR', 'WHILE', 'DECLARE', 'RAISE',
      'NOTICE', 'EXCEPTION', 'LANGUAGE', 'RETURNS', 'RETURN',
    }, dict_path)
  end

  local ok, cmp = pcall(require, 'cmp')
  if ok then
    -- Lê palavras de um arquivo de dicionário (uma por linha) e devolve
    -- como itens de completion. Resultado fica em cache na primeira leitura.
    local dict_cache = {}
    local function load_dict(path)
      if dict_cache[path] then return dict_cache[path] end
      local items = {}
      local f = io.open(path, 'r')
      if not f then
        dict_cache[path] = items
        return items
      end
      for line in f:lines() do
        local word = line:match('^%s*(.-)%s*$')
        if word and word ~= '' then
          table.insert(items, {
            label = word,
            kind = cmp.lsp.CompletionItemKind.Keyword,
          })
        end
      end
      f:close()
      dict_cache[path] = items
      return items
    end

    -- Source customizado de cmp que serve o conteúdo do dict file.
    local dict_source = {}
    function dict_source.new(path)
      return setmetatable({ path = path }, { __index = dict_source })
    end
    function dict_source:complete(_, callback)
      callback({ items = load_dict(self.path), isIncomplete = false })
    end

    -- Reaproveita o mesmo dicionário usado pelo vimrc remoto.
    cmp.register_source('dict_sql', dict_source.new(dict_path))

    cmp.setup.filetype({ 'sql', 'mysql', 'plsql' }, {
      sources = cmp.config.sources({
        { name = 'vim-dadbod-completion' },
        { name = 'dict_sql' },
        { name = 'buffer' },
      }),
    })
  end
end
