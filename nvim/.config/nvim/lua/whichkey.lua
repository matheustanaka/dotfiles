-- Whichkey.lua
local wk = require("which-key")

wk.add({
	--
	-- Local Mappings -> How to find files, open plugin manager save and quit.
	--
	{ "<leader>p", "<cmd>Lazy<CR>", desc = "Plugin Manager", nowait = true, remap = false },
	{ "<leader>q", "<cmd>wqall!<CR>", desc = "Quit", nowait = true, remap = false },
	{ "<leader>w", "<cmd>w!<CR>", desc = "Save", nowait = true, remap = false },
	{ "<leader>s", group = "Search", nowait = true, remap = false },
	{ "<leader>e", "<cmd>NvimTreeToggle<cr>", desc = "Explorer", nowait = true, remap = false },
	{ "<leader>f", group = "File Search", nowait = true, remap = false },
	{ "<leader>k", "<cmd>bdelete<CR>", desc = "Kill Buffer", nowait = true, remap = false },
	--
	-- Telescope mappings
	--
	{ "<leader>fc", "<cmd>Telescope colorscheme<cr>", desc = "Colorscheme", nowait = true, remap = false },
	{
		"<leader>ff",
		"<cmd>lua require('telescope.builtin').find_files()<cr>",
		desc = "Find files",
		nowait = true,
		remap = false,
	},
	{ "<leader>fr", "<cmd>Telescope oldfiles<cr>", desc = "Open Recent File", nowait = true, remap = false },
	{
		"<leader>ft",
		"<cmd>Telescope live_grep <cr>",
		desc = "Find Text Pattern In All Files",
		nowait = true,
		remap = false,
	},
	{ "<leader>sc", "<cmd>Telescope commands<cr>", desc = "Commands", nowait = true, remap = false },
	{ "<leader>sh", "<cmd>Telescope help_tags<cr>", desc = "Find Help", nowait = true, remap = false },
	{ "<leader>sk", "<cmd>Telescope keymaps<cr>", desc = "Keymaps", nowait = true, remap = false },
	{ "<leader>sm", "<cmd>Telescope man_pages<cr>", desc = "Man Pages", nowait = true, remap = false },
	{ "<leader>sr", "<cmd>Telescope registers<cr>", desc = "Registers", nowait = true, remap = false },
	--
	-- LSP mappings
	--
	{ "<leader>l", group = "LSP", nowait = true, remap = false },
	{
		"<leader>lS",
		"<cmd>Telescope lsp_dynamic_workspace_symbols<cr>",
		desc = "Workspace Symbols",
		nowait = true,
		remap = false,
	},
	{ "<leader>li", "<cmd>LspInfo<cr>", desc = "Info", nowait = true, remap = false },
	{ "<leader>lr", "<cmd>lua vim.lsp.buf.rename()<cr>", desc = "Rename", nowait = true, remap = false },
	{
		"<leader>ls",
		"<cmd>Telescope lsp_document_symbols<cr>",
		desc = "Document Symbols",
		nowait = true,
		remap = false,
	},
	--
	-- Terminal Integrated mappings
	--
	{ "<leader>t", group = "Terminal", nowait = true, remap = false },
	{ "<leader>tf", "<cmd>ToggleTerm direction=float<cr>", desc = "Float", nowait = true, remap = false },
	{
		"<leader>th",
		"<cmd>ToggleTerm size=10 direction=horizontal<cr>",
		desc = "Horizontal",
		nowait = true,
		remap = false,
	},
	{ "<leader>tn", "<cmd>lua _NODE_TOGGLE()<cr>", desc = "Node", nowait = true, remap = false },
	{ "<leader>tp", "<cmd>lua _PYTHON_TOGGLE()<cr>", desc = "Python", nowait = true, remap = false },
	{
		"<leader>tv",
		"<cmd>ToggleTerm size=80 direction=vertical<cr>",
		desc = "Vertical",
		nowait = true,
		remap = false,
	},
})
