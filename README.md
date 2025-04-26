# susu.nvim

> [!INFO]
> `ˢᵘₛᵤ.nvim` helps typing **Su**perscript and **Su**bscript characters quickly
 

> [!TIP]
> not all characters have a super-/subscript equivalent

## Setup

The default config looks like this:
```lua
require("susu").setup {
    -- this table is optional for changing the default config
    binds = {
        super_in = "<Leader>S", -- next key will be converted to superscript
        sub_in = "<Leader>s", -- next key will be converted to subscript
    },
    picker = false, --optional telescope picker via require("susu").picker
}
```

## Installation

### lazy.nvim

```lua
{
    'HenrisHub/susu.nvim',
    -- only needed if you want to use the picker
    dependencies = {
        'nvim-lua/plenary.nvim',
        'nvim-telescope/telescope-symbols.nvim',
        'nvim-telescope/telescope.nvim',
    }
}
```

## Usage

- `<Leader>S<Key>` to input `<Key>` as a Superscript character
- `<Leader>s<Key>` to input `<Key>` as a Subscript character
    - [[#Setup|change these to your liking]]

- `:lua require("susu").picker()` to view all symbols in Telescope
    - this requires setting `picker = true` in the [[#Setup|Setup]]

