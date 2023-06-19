require('lsp_signature').setup({
	bind = true,
	doc_lines = 20,
	floating_window = true,
	floating_window_above_cur_line = true,

	fix_pos = false,
	hint_enable = true,
	hint_scheme = "String",
	max_height = 18,
	max_width = 86,

	handler_opts = { border = "rounded" },
	always_trigger = false,
	auto_close_after = nil,

	zindex = 200,
	padding = '',
	extra_trigger_chars = { "(", ",", "{" },

	transparency = nil,
	timer_interval = 100
})
