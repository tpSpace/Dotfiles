-- Trending 2026: snacks.nvim - Collection of 30+ quality-of-life utilities
return {
  "folke/snacks.nvim",
  priority = 1000,
  lazy = false,
  ---@type snacks.Config
  opts = {
    bigfile = { enabled = true },
    notification = { enabled = true },
    quickfile = { enabled = true },
    dashboard = {
      enabled = true,
      sections = {
        { section = "header" },
        { title = "Recent Files", section = "recent_files" },
        { title = "Quick Actions", section = "keys", indent = 4, padding = 1 },
        { title = "Projects", section = "projects" },
        { section = "startup" },
      },
    },
    indent = {
      enabled = true,
      scope = { blank = false, enabled = true },
      animate = {
        enabled = true,
        style = "up",
      },
    },
    animate = { enabled = true },
    profiler = { enabled = false },
    git = { enabled = true },
  },
  keys = {
    { "<leader>un", function() Snacks.notifier.hide() end, desc = "Dismiss all notifications" },
    { "<leader>bd", function() Snacks.bufdelete.delete() end, desc = "Delete buffer" },
    { "<leader>cR", function() Snacks.rename.rename_file() end, desc = "Rename file" },
    { "<leader>gB", function() Snacks.gitbrowse() end, desc = "Git browse" },
    { "<leader>gb", function() Snacks.git.blame_line() end, desc = "Git blame line" },
    { "<leader>ss", function() Snacks.scratch() end, desc = "Scratch buffer" },
    { "<leader>pp", function() Snacks.profiler.scratch() end, desc = "Scratch profiler" },
  }
}