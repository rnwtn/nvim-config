local function normalize(plugin)
  if type(plugin) == "string" then
    return {
      src = "https://github.com/" .. plugin,
    }
  end

  return plugin
end

-- Load plugin definitions from lua/plugin-configs
local plugins = {}
local path = vim.fn.stdpath("config") .. "/lua/plugin-configs"

for name, type in vim.fs.dir(path) do
  if type == "file" and name:match("%.lua$") then
    local module = name:gsub("%.lua$", "")
    table.insert(plugins, require("plugin-configs." .. module))
  end
end

-- Collect all plugin sources and dependencies
local seen = {}
local sources = {}

local function collect(plugin)
  plugin = normalize(plugin)

  if seen[plugin.src] then
    return
  end

  seen[plugin.src] = true
  table.insert(sources, plugin.src)

  for _, dep in ipairs(plugin.dependencies or {}) do
    collect(dep)
  end
end

for _, plugin in ipairs(plugins) do
  collect(plugin)
end

-- Install/load plugins
vim.pack.add(sources)

-- Configure plugins in dependency order
local configured = {}

local function configure(plugin)
  plugin = normalize(plugin)

  if configured[plugin.src] then
    return
  end

  for _, dep in ipairs(plugin.dependencies or {}) do
    configure(dep)
  end

  if plugin.config then
    plugin.config()
  end

  configured[plugin.src] = true
end

for _, plugin in ipairs(plugins) do
  configure(plugin)
end
