return function(cb, config)
  if config.preLaunchTask then
    vim.notify("Performing pre-launch tasks")
    config.preLaunchTask()
  end
  local adapter = {
    type = "executable",
    command = "netcoredbg",
    args = { "--interpreter=vscode" },
  }
  cb(adapter)
end
