# CLAUDE.md

This file provides guidance to Claude Code (claude.ai/code) when working with code in this repository.

## Repo purpose

Personal Neovim configuration (Lua, `lazy.nvim`) plus a separate plugin-free Vim config under `vimrc/` for remote VM use. Comments and notes are written in Brazilian Portuguese — keep that style when editing existing files.

## Entry point and load order

`init.lua` is the entry point. It:
1. Bootstraps `lazy.nvim` into `stdpath("data")/lazy/lazy.nvim`.
2. Sets `<leader>` to space (also reset in `lua/core/keymaps.lua`).
3. Calls `require("lazy").setup("plugins", ...)` — this auto-imports every file in `lua/plugins/` and treats the returned table as a plugin spec. Adding a file there is the only step needed to register a plugin.
4. Loads `core.options` then `core.keymaps`.
5. Loads custom LuaSnip snippets from `lua/snippets/`.

It also monkey-patches `vim.deprecate` to silence `nvim-lspconfig` deprecation warnings until migration to `vim.lsp.config`.

## Where things live

- `lua/core/options.lua` — editor options, autocmds, arrow-key disabling, line-move keymaps. Includes a `BufReadPre/BufNewFile` autocmd that **detaches LSP and disables diagnostics** in `node_modules/`, `dist/`, `build/`, `target/`, `.gradle/`, `jspm_packages/`. Folding uses `vim.treesitter.foldexpr()` and is only enabled on real buffers.
- `lua/core/keymaps.lua` — global keymaps, including LSP (`<leader>g*`, `<leader>d*`, `<leader>r*`), Telescope (`<C-p>`, `<leader>f*`), Harpoon (`<leader>h*`), DAP (`<F5>`–`<F12>`, `<leader>b`), windows/buffers/tabs.
- `lua/plugins/<name>.lua` — one plugin spec per file, auto-discovered by `lazy.nvim`.
- `ftplugin/<lang>.lua` — per-buffer setup that needs filetype context. Runs every time a buffer of that type opens, so guard with `vim.b._foo_loaded` / `vim.g._foo_loaded` to avoid double setup (see `kotlin.lua`, `java.lua`).
- `lua/snippets/<lang>.lua` — LuaSnip Lua-format snippets, loaded via `from_lua` in both `init.lua` and `nvim-cmp.lua`.
- `lua/test-lsp/` — ad-hoc scratch scripts (e.g. `jdtls_test.lua`); not loaded automatically.
- `vimrc/` — standalone plugin-free Vim config for remote VMs. Symlinked from `$HOME` per `vimrc/readme.txt` (`ln -s .config/nvim/vimrc/vim .vim` etc.). Mirrors many of the Neovim leader mappings but uses ctags + Netrw + a hand-rolled "Harpoon" instead of plugins. Treat as independent — changes to `lua/` do not affect it.
- `lazy-lock.json` — `lazy.nvim` plugin version lockfile; commit changes from `:Lazy sync` / `:Lazy update`.
- `.luarc.json` — lua-language-server config so `vim` is a known global when editing this repo.

## LSP architecture (important — split across multiple files)

LSP setup is intentionally split:

- **`lua/plugins/nvim-lspconfig.lua`** sets up Mason and most servers in a loop: `bashls`, `cssls`, `html`, `gradle_ls`, `groovyls`, `lua_ls`, `jsonls`, `lemminx`, `marksman`, `yamlls`, `pyright`, `sqls`, plus `ts_ls` separately (with a 4GB `maxTsServerMemory` cap and 300ms debounce). `mason-lspconfig` is configured with `automatic_enable = false` so Mason-installed servers do **not** auto-attach; only servers explicitly set up here (or in `ftplugin/`) attach.
- **`ftplugin/java.lua`** — JDTLS via `nvim-jdtls`. Resolves project root from the file path (not `getcwd()`) — using `getcwd()` historically caused duplicate workspaces. Workspace lives at `~/.jdtls-workspace/<project-name>`. JAR paths come from Mason (`~/.local/share/nvim/mason/share/jdtls/...`). Bundles `java-debug-adapter` and `java-test` jars (filtering out `runner-jar-with-dependencies.jar` and `jacocoagent.jar`). Configures runtimes for JavaSE-17 and JavaSE-21 at `/usr/lib/jvm/java-{17,21}-openjdk-amd64`. Sets up DAP via `jdtls.setup_dap()` and defers main-class discovery 3s to avoid blocking attach.
- **`ftplugin/python.lua`** — Pyright (`pyright-langserver --stdio`).
- **`ftplugin/kotlin.lua`** — `kotlin_language_server`. **Side effect on first load in a Maven project:** if `pom.xml` exists and `.kls-classpath` does not, it shells out `mvn dependency:build-classpath -Dmdep.outputFile=.kls-classpath` synchronously. Be aware when editing this file or when first opening a Kotlin/Maven project.

Across all setups, the LSP `on_attach` disables `documentFormattingProvider` and `documentRangeFormattingProvider` — **formatting is intentionally not done by the LSP**.

## Formatting

- `lua/plugins/conform-nvim.lua` is the primary formatter, bound to `<leader>l`. Map: lua→stylua, kotlin→ktlint, js/ts/json/markdown→prettier, python→black.
- `lua/plugins/none-ls-nvim.lua` adds extras through none-ls/null-ls: `prettierd`, and `pg_format` for SQL with `--spaces 4 --keyword-case 1 --wrap-limit 0`.
- Java formatting goes through JDTLS' own formatter (since LSP formatting is left enabled there via the JDTLS settings, even though the global `on_attach` disables it for everything else).

## Common commands

This repo has no build/test pipeline of its own — work happens through Neovim itself:

- `:Lazy` / `:Lazy sync` / `:Lazy update` — manage plugins; commit resulting `lazy-lock.json` changes.
- `:Mason` — manage LSP servers, linters, formatters, debuggers. Tools auto-installed by `mason-tool-installer`: `java-debug-adapter`, `java-test`, `ktlint` (`run_on_start = false`, so installed on demand).
- `:TSUpdate` / `:TSInstall <lang>` — Treesitter parsers (parsers are also auto-installed for new filetypes).
- `:checkhealth` — diagnose plugin/LSP/DAP issues.
- `:TestFile` / `<Space>tt` — run tests via `vim-test` (Java→maven, Kotlin→gradle, configured in `lua/plugins/vim-test.lua`).
- DAP: `<F5>` continue, `<F10>` step over, `<F11>` step into, `<F12>` step out, `<leader>b` toggle breakpoint, `<leader>B` conditional breakpoint.

## External dependencies expected on the system

Referenced directly by the config:

- `ripgrep` — Telescope live-grep.
- `make` — building `telescope-fzf-native`.
- JDK 17 and JDK 21 at `/usr/lib/jvm/java-{17,21}-openjdk-amd64` — paths hardcoded in `ftplugin/java.lua`.
- `mvn` — invoked by `ftplugin/kotlin.lua` to generate `.kls-classpath`.
- `pg_format` (pgFormatter) — SQL formatting via none-ls.
- `pyright-langserver` (typically via `npm i -g pyright`).
- `kotlin-language-server` on `$PATH`.
- For `vimrc/`: `universal-ctags`, `vim-gtk3`, `jq` (see header of `vimrc/vimrc`).

## Conventions when editing

- Adding a plugin: drop a new `lua/plugins/<name>.lua` returning a `lazy.nvim` spec table. Do not also `require` it from `init.lua`.
- Adding a per-language LSP: prefer adding it to the loop in `lua/plugins/nvim-lspconfig.lua` unless it needs filetype-specific bootstrapping (root resolution, classpath generation, DAP wiring) — then put it in `ftplugin/<lang>.lua` and guard against re-entry.
- New keymaps go in `lua/core/keymaps.lua` unless they're plugin-local (`keys = { ... }` inside the plugin spec, e.g. `claudecode-nvim.lua`).
- Comments and `desc` strings are in Portuguese throughout — match the style.
- Don't re-enable `documentFormattingProvider` on the shared `lsp_attach` — formatting is deliberately routed through conform/none-ls.
