-- Syntax highlighting for Firestore security rules (no treesitter parser exists).
-- Neovim maps *.rules to "hog" by default; claim firestore.rules explicitly.
return {
  "delphinus/vim-firestore",
  ft = "firestore",
  init = function()
    vim.filetype.add({
      filename = { ["firestore.rules"] = "firestore" },
      pattern = { [".*%.firestore%.rules"] = "firestore" },
    })
    -- The plugin's ftdetect claims every *.rules file (udev, polkit, ...).
    -- lazy.nvim sources it during setup, so drop it once setup is done.
    vim.api.nvim_create_autocmd("User", {
      pattern = "LazyDone",
      once = true,
      callback = function()
        vim.api.nvim_clear_autocmds({ group = "filetypedetect", event = { "BufRead", "BufNewFile" }, pattern = "*.rules" })
      end,
    })
  end,
}
