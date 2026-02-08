return {
  {
    "kdheepak/lazygit.nvim",
    cmd = {
      "LazyGit",
      "LazyGitConfig",
      "LazyGitCurrentFile",
      "LazyGitFilter",
      "LazyGitFilterCurrentFile",
    },
    dependencies = {
      "nvim-lua/plenary.nvim",
    },
    config = function()
      local pager = "less -R"
      if vim.fn.executable("delta") == 1 then
        pager = "delta --dark --paging=never"
      end

      -- Create custom LazyGit configuration
      local lazygit_config = string.format([[
# Managed by Neovim (kdheepak/lazygit.nvim)
gui:
  theme:
    lightTheme: false
    activeBorderColor:
      - white
      - bold
    inactiveBorderColor:
      - white
    selectedLineBgColor:
      - blue
      - bold
    cherryPickedCommitBgColor:
      - blue
      - bold
    cherryPickedCommitFgColor:
      - cyan
    unstagedChangesColor:
      - red
    defaultFgColor:
      - white
  screenMode: "normal"
  sidePanelWidth: 0.3

git:
  pagers:
    - colorArg: always
      pager: %s

customCommands:
  - key: '<c-p>'
    command: 'git push origin {{.Selected.LocalBranch.Name}}'
    context: 'global'
    description: 'Push to origin'
    output: terminal

  - key: '<c-o>'
    command: 'git pull origin {{.Selected.LocalBranch.Name}}'
    context: 'global'
    description: 'Pull from origin'
    output: terminal

  - key: '<c-b>'
    command: 'gh browse {{.SelectedFile.Name}}'
    context: 'files'
    description: 'Browse file on GitHub'
    output: terminal

  - key: '<c-r>'
    command: 'gh pr create --fill'
    context: 'localBranches'
    description: 'Create PR'
    output: terminal

keybinding:
  universal:
    quit: 'q'
    quit-alt1: '<c-c>'
    return: '<esc>'

  files:
    ignore: 'i'

  branches:
    createPullRequest: '<c-r>'
    viewPullRequest: '<c-v>'

  commits:
    cherryPickCopy: 'C'
    cherryPickPaste: 'V'

os:
  edit: 'nvim {{filename}}'
  editInTerminal: true
]], pager)

      -- Create lazygit config directory if it doesn't exist
      local config_dir = vim.fn.expand("~/.config/lazygit")
      vim.fn.system("mkdir -p " .. config_dir)

      -- Write the config file
      local config_file = config_dir .. "/config.yml"
      local should_write = false

      if not vim.loop.fs_stat(config_file) then
        should_write = true
      else
        -- Only overwrite if the file looks like the old schema we generated before.
        local content = table.concat(vim.fn.readfile(config_file), "\n")
        if content:find("windowSize:") then should_write = true end
        if content:find("\ngit:\n  paging:") then should_write = true end
        if content:find("\n%s*subprocess:%s*true") then should_write = true end
        if content:find("editInTerminal:%s*'nvim {{filename}}'") then should_write = true end
        -- If it's already managed by us and not obviously outdated, leave it alone.
      end

      if should_write then
        local file = io.open(config_file, "w")
        if file then
          file:write(lazygit_config)
          file:close()
        end
      end
    end,
    keys = {
      { "<leader>lg", "<cmd>LazyGit<cr>", desc = "Open LazyGit" },
      { "<leader>lc", "<cmd>LazyGitConfig<cr>", desc = "LazyGit Config" },
      { "<leader>lf", "<cmd>LazyGitCurrentFile<cr>", desc = "LazyGit Current File" },
      { "<leader>ls", "<cmd>LazyGitFilterCurrentFile<cr>", desc = "LazyGit File History" },
      { "<leader>gG", "<cmd>LazyGit<cr>", desc = "Open LazyGit (custom)" },
      { "<leader>gd", "<cmd>LazyGitCurrentFile<cr>", desc = "LazyGit for current file" },
      { "<leader>gb", "<cmd>LazyGitFilterCurrentFile<cr>", desc = "LazyGit blame for current file" },
    },
  },
}
