return { 
  "nvim-neo-tree/neo-tree.nvim",  
  dependencies = {
    "nvim-lua/plenary.nvim",
    "nvim-tree/nvim-web-devicons", -- not strictly required, but recommended
    "MunifTanjim/nui.nvim", 
    lazy = false,
  },
  config = function()
    -- Neotree
    vim.keymap.set('n', '<C-n>', ':Neotree filesystem reveal left<CR>', {})
  end
}
 
