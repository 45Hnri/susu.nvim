local M = {}

--- @alias Symbol_type "sub"|"super"

---@class Keybinds table Set custom Keybinds
---@field super_in string|nil Input next character in superscript
---@field sub_in string|nil Input next character in subscript

---@class Config table Configuration options
---@field binds Keybinds|nil
---@field picker boolean|nil Activate .picker, this requires having Telescope installed

local super_chars = {}
local sub_chars = {}

for _,c in pairs(require("symbols")) do
    if c[3] == "superscript" then
        super_chars[c[2]] = c[1]
    elseif c[3] == "subscript" then
        sub_chars[c[2]] = c[1]
    end
end

---Search for the equivalent character under the specified type
---@param char string Character to match for symbol
---@param type Symbol_type Type of symbol list to search
---@return string|nil 
local function get_symbol(char,type)
    local list = type == "sub" and sub_chars or super_chars
    local match_char = list[char]

    if match_char ~= nil then
        return match_char
    end

    print("No match found for: "..char.." ("..(type == "sub" and "subscript" or "superscript")..")")
end

---Next keystroke will be used to place the equivalent symbol under the cursor
---@param s_type Symbol_type Type of symbol list to search
local function put_char(s_type)
    local status,input_char = pcall(vim.fn.getcharstr)
    if not status then
        print((s_type == "super" and "Superscript" or "Subscript").." input aborted.")
        return
    end
    local output_char = get_symbol(input_char,s_type)
    vim.api.nvim_put({output_char},"",true,true)
end

-- Change binds for super-/subscript input
---@param config Config|nil
M.setup = function(config)
    ---@type Keybinds
    local binds = {
        super_in = config and config.binds and config.binds.super_in or "<Leader>S",
        sub_in = config and config.binds and config.binds.sub_in or "<Leader>s",
    }

    vim.keymap.set("n", binds.super_in, function() put_char("super") end,{noremap=true,silent=true})
    vim.keymap.set("n", binds.sub_in, function() put_char("sub") end,{noremap=true,silent=true})

    if config and config.picker then
        M.picker = require("picker").get_symbols
    end
end

return M
