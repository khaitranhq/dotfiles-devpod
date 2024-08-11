local function getVisualSelection()
	vim.cmd('noau normal! "vy"')
	local text = vim.fn.getreg("v")
	vim.fn.setreg("v", {})

	text = string.gsub(text, "\n", "")
	if #text > 0 then
		return text
	else
		return ""
	end
end

function vim.search_with_selected_text()
	local text = getVisualSelection()
	local fzf = require("fzf-lua")
	fzf.grep_visual(text)
end

return {
	{
		"ibhagwan/fzf-lua",
		-- optional for icon support
		dependencies = { "nvim-tree/nvim-web-devicons" },
		config = function()
			-- calling `setup` is optional for customization
			require("fzf-lua").setup({
				grep = {
					rg_opts = "--hidden --no-ignore --color=always --smart-case --no-heading --with-filename --line-number --column",
				},
				code_actions = {
					previewer = "codeaction_native",
				},
			})
		end,
	},
}
