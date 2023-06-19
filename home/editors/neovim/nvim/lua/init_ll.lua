local config = {
  options = {
    icons_enabled = true,
    theme = 'auto',
    component_separators = { '', '' },
    section_separators = { '', '' },
    disabled_filetypes = {}
  },
  sections = {
    lualine_a = { 'mode' },
    lualine_b = { 'filename' },
    lualine_c = {},
    lualine_x = {},
    lualine_y = { 'encoding', 'fileformat', 'filetype' },
    lualine_z = { { 'branch' }, { 'progress' } },
  },
  inactive_sections = {
    lualine_a = {},
    lualine_b = {},
    lualine_c = {},
    lualine_x = { 'location' },
    lualine_y = {},
    lualine_z = {}
  },
  tabline = {},
  extensions = {}
}

-- Inserts a component in lualine_c at left section
local function ins_left(component)
  table.insert(config.sections.lualine_c, component)
end

-- Inserts a component in lualine_x ot right section
local function ins_right(component)
  table.insert(config.sections.lualine_x, component)
end

ins_left {
  'lsp_progress',
  display_components = { 'lsp_client_name', { 'title', 'percentage', 'message' } },
  -- With spinner
  -- display_components = { 'lsp_client_name', 'spinner', { 'title', 'percentage', 'message' }},
  separators = {
    component = ' ',
    progress = ' | ',
    message = { pre = '(', post = ')' },
    percentage = { pre = '', post = '%% ' },
    title = { pre = '', post = ': ' },
    lsp_client_name = { pre = '[', post = ']' },
    spinner = { pre = '', post = '' },
  },
  timer = { progress_enddelay = 500, spinner = 1000, lsp_client_name_enddelay = 1000 },
  message = { commenced = 'In Progress', completed = 'Completed' },
}

require('lualine').setup(config)
