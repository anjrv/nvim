local lazypath = vim.fn.stdpath("data") .. "/lazy/lazy.nvim"

if not (vim.uv or vim.loop).fs_stat(lazypath) then
	vim.fn.system({
		"git",
		"clone",
		"--filter=blob:none",
		"https://github.com/folke/lazy.nvim.git",
		"--branch=stable", -- latest stable release
		lazypath,
	})
end

vim.opt.rtp:prepend(lazypath)

local status_ok, lazy = pcall(require, "lazy")
if not status_ok then
	return
end

require("lazy").setup({
	"nvim-lua/plenary.nvim",
	{
		"akinsho/bufferline.nvim",
		dependencies = "kyazdani42/nvim-web-devicons",
	},

	{ "windwp/nvim-autopairs", dependencies = { "hrsh7th/nvim-cmp" } },
	"JoosepAlviste/nvim-ts-context-commentstring",
	"numToStr/Comment.nvim",
	"kyazdani42/nvim-web-devicons",
	"moll/vim-bbye",
	"nvim-lualine/lualine.nvim",
	"akinsho/toggleterm.nvim",
	"ahmedkhalf/project.nvim",
	"lewis6991/impatient.nvim",
	"lukas-reineke/indent-blankline.nvim",
	-- "goolord/alpha-nvim",
	{
		"folke/trouble.nvim",
		opts = {}, -- for default options, refer to the configuration section for custom setup.
		cmd = "Trouble",
		keys = {
			{
				"<leader>xx",
				"<cmd>Trouble diagnostics toggle<cr>",
				desc = "Diagnostics (Trouble)",
			},
			{
				"<leader>xX",
				"<cmd>Trouble diagnostics toggle filter.buf=0<cr>",
				desc = "Buffer Diagnostics (Trouble)",
			},
			{
				"<leader>cs",
				"<cmd>Trouble symbols toggle focus=false<cr>",
				desc = "Symbols (Trouble)",
			},
			{
				"<leader>cl",
				"<cmd>Trouble lsp toggle focus=false win.position=right<cr>",
				desc = "LSP Definitions / references / ... (Trouble)",
			},
			{
				"<leader>xL",
				"<cmd>Trouble loclist toggle<cr>",
				desc = "Location List (Trouble)",
			},
			{
				"<leader>xQ",
				"<cmd>Trouble qflist toggle<cr>",
				desc = "Quickfix List (Trouble)",
			},
		},
	},
	{
		"nvim-neo-tree/neo-tree.nvim",
		dependencies = {
			"nvim-lua/plenary.nvim",
			"kyazdani42/nvim-web-devicons",
			"MunifTanjim/nui.nvim",
		},
	},

	-- Colorschemes
	"Mofiqul/dracula.nvim",
	"folke/tokyonight.nvim",

	-- LSP
	"neovim/nvim-lspconfig",
	"williamboman/mason.nvim",
	"williamboman/mason-lspconfig.nvim",
	-- "jose-elias-alvarez/null-ls.nvim",
	"RRethy/vim-illuminate",
	"mfussenegger/nvim-jdtls",
	"simrat39/rust-tools.nvim",
	{ "scalameta/nvim-metals", dependencies = { "nvim-lua/plenary.nvim" } },
	{
		"stevearc/conform.nvim",
		event = { "BufReadPre", "BufNewFile" },
		config = function()
			local conf = require("conform")

			conf.setup({
				log_level = vim.log.levels.DEBUG,
				formatters_by_ft = {
					javascript = { "prettier" },
					typescript = { "prettier" },
					javascriptreact = { "prettier" },
					typescriptreact = { "prettier" },
					css = { "prettier" },
					html = { "prettier" },
					json = { "prettier" },
					yaml = { "prettier" },
					markdown = { "prettier" },
					lua = { "stylua" },
				},
			})

			vim.keymap.set({ "n", "v" }, "<leader>lf", function()
				vim.lsp.buf.format() -- Always run LSP formatters/linters first
				conf.format({
					lsp_fallback = false,
					async = false,
					timeout_ms = 500,
				})
			end, { desc = "Format file or range (in visual mode)" })
		end,
	},
	-- Telescope
	"nvim-telescope/telescope.nvim",

	-- Treesitter
	{
		"nvim-treesitter/nvim-treesitter",
	},
	-- "p00f/nvim-ts-rainbow",

	-- Git
	"lewis6991/gitsigns.nvim",

	-- DAP
	"mfussenegger/nvim-dap",
	"rcarriga/nvim-dap-ui",

	-- Pandoc / Markdown
	"lervag/vimtex",
	"vim-pandoc/vim-pandoc",
	"vim-pandoc/vim-pandoc-syntax",
	"conornewton/vim-pandoc-markdown-preview",
	-- "ellisonleao/glow.nvim",

	{
		"folke/noice.nvim",
		dependencies = {
			"MunifTanjim/nui.nvim",
			-- OPTIONAL:
			--   `nvim-notify` is only needed, if you want to use the notification view.
			--   If not available, we use `mini` as the fallback
			"rcarriga/nvim-notify",
		},
		opts = {
			notify = { enabled = false },
			lsp = {
				progress = { enabled = false },
				message = { enabled = false },
				override = {
					["vim.lsp.util.convert_input_to_markdown_lines"] = true,
					["vim.lsp.util.stylize_markdown"] = true,
					["cmp.entry.get_documentation"] = true, -- requires hrsh7th/nvim-cmp
				},
			},
			presets = {
				bottom_search = true, -- use a classic bottom cmdline for search
				command_palette = true, -- position the cmdline and popupmenu together
				long_message_to_split = true, -- long messages will be sent to a split
				inc_rename = false, -- enables an input dialog for inc-rename.nvim
				lsp_doc_border = true, -- add a border to hover docs and signature help
			},
		},
	},

	{
		"R-nvim/R.nvim",
		-- Only required if you also set defaults.lazy = true
		lazy = false,
		-- R.nvim is still young and we may make some breaking changes from time
		-- to time. For now we recommend pinning to the latest minor version
		-- like so:
		version = "~0.1.0",
	},

	{
		"zbirenbaum/copilot.lua",
		enabled = true,
		cmd = "Copilot",
		event = "InsertEnter",
		opts = {},
	},

	{
		"hrsh7th/nvim-cmp",
		dependencies = {
			"L3MON4D3/LuaSnip",
			"hrsh7th/cmp-emoji",
			"hrsh7th/cmp-buffer",
			"hrsh7th/cmp-path",
			"hrsh7th/cmp-cmdline",
			"hrsh7th/cmp-nvim-lsp",
			"hrsh7th/cmp-nvim-lua",
			"saadparwaiz1/cmp_luasnip",
			{
				"zbirenbaum/copilot-cmp",
				config = function()
					require("copilot_cmp").setup()
				end,
			},
		},
		opts = function()
			vim.api.nvim_set_hl(0, "CmpGhostText", { link = "Comment", default = true })
			local cmp = require("cmp")
			local luasnip = require("luasnip")
			local kind_icons = {
				Text = " ",
				Method = " ",
				Function = " ",
				Constructor = " ",
				Field = " ",
				Variable = " ",
				Class = " ",
				Interface = " ",
				Module = " ",
				Property = " ",
				Unit = " ",
				Value = " ",
				Enum = " ",
				Keyword = " ",
				Snippet = " ",
				Color = " ",
				File = " ",
				Reference = " ",
				Folder = " ",
				EnumMember = " ",
				Constant = " ",
				Struct = " ",
				Event = " ",
				Operator = " ",
				TypeParameter = " ",
				Misc = " ",
			}

			return {
				auto_brackets = {}, -- configure any filetype to auto add brackets
				completion = {
					completeopt = "menu,menuone,noinsert",
				},
				mapping = cmp.mapping.preset.insert({
					["<C-k>"] = cmp.mapping(cmp.mapping.select_prev_item(), { "i", "c" }),
					["<C-j>"] = cmp.mapping(cmp.mapping.select_next_item(), { "i", "c" }),
					["<C-b>"] = cmp.mapping(cmp.mapping.scroll_docs(-1), { "i", "c" }),
					["<C-f>"] = cmp.mapping(cmp.mapping.scroll_docs(1), { "i", "c" }),
					["<C-Tab>"] = cmp.mapping(cmp.mapping.complete(), { "i", "c" }),
					["<m-o>"] = cmp.mapping(cmp.mapping.complete(), { "i", "c" }),
					-- ["<C-y>"] = cmp.config.disable, -- Specify `cmp.config.disable` if you want to remove the default `<C-y>` mapping.
					["<C-c>"] = cmp.mapping({
						i = cmp.mapping.abort(),
						c = cmp.mapping.close(),
					}),
					["<m-j>"] = cmp.mapping({
						i = cmp.mapping.abort(),
						c = cmp.mapping.close(),
					}),
					["<m-k>"] = cmp.mapping({
						i = cmp.mapping.abort(),
						c = cmp.mapping.close(),
					}),
					["<m-c>"] = cmp.mapping({
						i = cmp.mapping.abort(),
						c = cmp.mapping.close(),
					}),
					["<S-CR>"] = cmp.mapping({
						i = cmp.mapping.abort(),
						c = cmp.mapping.close(),
					}),
					-- Accept currently selected item. If none selected, `select` first item.
					-- Set `select` to `false` to only confirm explicitly selected items.
					["<CR>"] = cmp.mapping.confirm({ select = false }),
					["<Right>"] = cmp.mapping.confirm({ select = true }),
					-- ["<Tab>"] = cmp.mapping(function(fallback)
					-- 	if cmp.visible() then
					-- 		cmp.select_next_item()
					-- 	elseif luasnip.jumpable(1) then
					-- 		luasnip.jump(1)
					-- 	elseif luasnip.expand_or_jumpable() then
					-- 		luasnip.expand_or_jump()
					-- 	elseif luasnip.expandable() then
					-- 		luasnip.expand()
					-- 	elseif check_backspace() then
					-- 		-- cmp.complete()
					-- 		fallback()
					-- 	else
					-- 		fallback()
					-- 	end
					-- end, {
					-- 	"i",
					-- 	"s",
					-- }),
					["<S-Tab>"] = cmp.mapping(function(fallback)
						if cmp.visible() then
							cmp.select_prev_item()
						elseif luasnip.jumpable(-1) then
							luasnip.jump(-1)
						else
							fallback()
						end
					end, {
						"i",
						"s",
					}),
				}),
				sources = cmp.config.sources({
					{ name = "crates", group_index = 1 },
					{
						name = "nvim_lsp",
						filter = function(entry, ctx)
							local kind = require("cmp.types.lsp").CompletionItemKind[entry:get_kind()]
							if kind == "Snippet" and ctx.prev_context.filetype == "java" then
								return true
							end

							if kind == "Text" then
								return true
							end
						end,
						group_index = 2,
					},
					{
						name = "copilot",
						group_index = 2,
						-- keyword_length = 0,
						max_item_count = 3,
						trigger_characters = {
							{
								".",
								":",
								"(",
								"'",
								'"',
								"[",
								",",
								"#",
								"*",
								"@",
								"|",
								"=",
								"-",
								"{",
								"/",
								"\\",
								"+",
								"?",
								" ",
								-- "\t",
								-- "\n",
							},
						},
					},
					{
						name = "path",
						group_index = 2,
					},
					{
						name = "emoji",
						group_index = 2,
					},
					{
						name = "buffer",
						group_index = 2,
					},
					{ name = "luasnip", group_index = 2 },
				}),
				formatting = {
					fields = { "kind", "abbr", "menu" },
					format = function(entry, vim_item)
						-- Kind icons
						vim_item.kind = kind_icons[vim_item.kind]

						if entry.source.name == "copilot" then
							vim_item.kind = ""
							vim_item.kind_hl_group = "CmpItemKindCopilot"
						end

						-- NOTE: order matters
						vim_item.menu = ({
							nvim_lsp = "",
							nvim_lua = "",
							luasnip = "",
							buffer = "",
							path = "",
							emoji = "",
						})[entry.source.name]
						return vim_item
					end,
				},
				experimental = {
					ghost_text = {
						hl_group = "CmpGhostText",
					},
				},
				window = {
					-- documentation = false,
					documentation = {
						border = "rounded",
						winhighlight = "NormalFloat:Pmenu,NormalFloat:Pmenu,CursorLine:PmenuSel,Search:None",
					},
					completion = {
						border = "rounded",
						winhighlight = "NormalFloat:Pmenu,NormalFloat:Pmenu,CursorLine:PmenuSel,Search:None",
					},
				},
				snippet = {
					expand = function(args)
						luasnip.lsp_expand(args.body) -- For `luasnip` users.
					end,
				},
			}
		end,
	},
}, opts)
