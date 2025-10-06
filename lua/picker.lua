local M = {}

M.get_symbols = function(opts)

local pickers = require "telescope.pickers"
local finders = require "telescope.finders"
local conf = require("telescope.config").values
local actions = require "telescope.actions"
local action_state = require "telescope.actions.state"
local symbols = require "symbols"

  opts = opts or {}
  pickers.new(opts, {
    prompt_title = "sub-/superscript symbols",
    finder = finders.new_table {
      results = symbols,
      entry_maker = function(entry)
        return {
          value = entry,
          display = entry[1] .. " " .. entry[2] .. " " .. entry[3],
          ordinal = entry[2] .. entry[3],
        }
      end
    },
    sorter = conf.generic_sorter(opts),
    attach_mappings = function(prompt_bufnr, map)
      actions.select_default:replace(function()
        actions.close(prompt_bufnr)
        local selection = action_state.get_selected_entry()
        vim.api.nvim_put({ selection.value[1] }, "", false, true)
      end)
      return true
    end,
  }):find()
end
return M
