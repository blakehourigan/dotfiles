return {
	"stevearc/conform.nvim",
	config = function()
		require("conform").setup({
			-- Map filetypes to their respective formatters
			formatters_by_ft = {
				lua = { "stylua" },
				python = { "isort", "black" },
				rust = { "rustfmt", "lsp" }, -- Use 'lsp' as a placeholder for LSP formatting
				javascript = { "prettierd", "prettier", stop_after_first = true },
				latex = { "latexindent" },
			},
			-- Define custom formatters with specific arguments
			formatters = {
				black = {
					command = "black",
					args = {
						"--line-length",
						"79", -- Set desired line length
						"--fast", -- Skip sanity checks for speed
						"-",
					},
					stdin = true,
				},
				isort = {
					command = "isort",
					args = {
						"--stdout",
						"--profile",
						"black",
						"--line-length",
						"79",
						"-",
					},
					stdin = true,
				},
			},
			-- Enable format on save
			format_on_save = {
				-- These options will be passed to conform.format()
				timeout_ms = 500,
				lsp_fallback = false, -- Disable LSP fallback to prevent unexpected formatters
			},
		})
	end,
}
