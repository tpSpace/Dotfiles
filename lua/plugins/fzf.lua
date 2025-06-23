return { 
    "ibhagwan/fzf-lua", 
    dependencies = { "nvim-tree/nvim-web-devicons" }, 
    config = function() 
      -- fzf-lua
      local fzf = require("fzf-lua")

      fzf.setup({'fzf-native'})

      -- Keymaps   
      vim.keymap.set("n", "<leader>ff", fzf.files,        { desc = "Find Files" })
      vim.keymap.set("n", "<leader>fg", fzf.live_grep,    { desc = "Live Grep" })
      vim.keymap.set("n", "<leader>fb", fzf.buffers,      { desc = "Open Buffers" })
      vim.keymap.set("n", "<leader>fh", fzf.help_tags,    { desc = "Help Tags" })
      vim.keymap.set("n", "<leader>fc", fzf.commands,     { desc = "Vim Commands" })
      vim.keymap.set("n", "<leader>fk", fzf.keymaps,      { desc = "Keymaps" })
      vim.keymap.set("n", "<leader>ft", fzf.builtin,      { desc = "FZF Built-ins" })
    end
}
