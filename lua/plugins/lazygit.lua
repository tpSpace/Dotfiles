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
      -- Create custom LazyGit configuration
      local lazygit_config = [[
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
  windowSize: "normal"
  sidePanelWidth: 0.3

git:
  paging:
    colorArg: always
    pager: delta --dark --paging=never

customCommands:
  - key: '<c-p>'
    command: 'git push origin {{.Selected.LocalBranch.Name}}'
    subprocess: true
    context: 'global'
    description: 'Push to origin'

  - key: '<c-o>'
    command: 'git pull origin {{.Selected.LocalBranch.Name}}'
    subprocess: true
    context: 'global'
    description: 'Pull from origin'

  - key: '<c-b>'
    command: 'gh browse {{.SelectedFile.Name}}'
    subprocess: true
    context: 'files'
    description: 'Browse file on GitHub'

  - key: '<c-r>'
    command: 'gh pr create --fill'
    subprocess: true
    context: 'localBranches'
    description: 'Create PR'

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
  editInTerminal: 'nvim {{filename}}'
]]

      -- Create lazygit config directory if it doesn't exist
      local config_dir = vim.fn.expand("~/.config/lazygit")
      vim.fn.system("mkdir -p " .. config_dir)

      -- Write the config file
      local config_file = config_dir .. "/config.yml"
      local file = io.open(config_file, "w")
      if file then
        file:write(lazygit_config)
        file:close()
        print("✅ Custom LazyGit config created at: " .. config_file)
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