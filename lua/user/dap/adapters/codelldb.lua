return function(cb, config)
  if config.preLaunchTask then
    vim.notify "Performing pre-launch tasks"
    config.preLaunchTask()
  end
  local adapter = {
    type = "server",
    port = "${port}",
    executable = {
      command = "codelldb",
      args = { "--port", "${port}" },
    },
  }
  cb(adapter)
end
