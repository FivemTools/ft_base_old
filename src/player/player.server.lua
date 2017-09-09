--
-- @Project: FiveM Tools
-- @Author: Samuelds
-- @License: GNU General Public License v3.0
-- @Source: https://github.com/FivemTools/ft_base
--

Player = {}
Player.__index = Player

-- Save data in Database
function Player:Save(...)

  local args = {...} -- Get all arguments
  local count = #args -- Count number arguments
  local secure = {
    ['@identifier'] = self.identifier,
  }

  if count == 1 and type(args[1]) == "table" then

    local number = 0
    local str_query = ""

    for _, name in pairs(args[1]) do
      if name ~= "id" and name ~= "identifier" then

        if number ~= 0 then
          str_query = str_query .. ", "
        end

        str_query = str_query .. tostring(name) .. " = @" .. tostring(name)
        secure["@" .. tostring(name)] = self[name]
        number = number + 1

      end
    end

    tprint(secure)

    if number >= 1 then
      MySQL.Sync.execute("UPDATE players SET " .. str_query .. " WHERE identifier = @identifier", secure)
    else
      return false
    end

  elseif count == 1 then

    local name = args[1]

    if name ~= "id" and name ~= "identifier" then
      secure["@" .. name] = self[name]
      MySQL.Sync.execute("UPDATE players SET " .. name .. " = @" .. name .. " WHERE identifier = @identifier", secure)
    else
      return false
    end

  else
    return false
  end

end

-- Get player atributs
function Player:Get(...)

  local args = {...} -- Get all arguments
  local count = #args -- Count number arguments

  if count == 1 and type(args[1]) == "table" then

    local table = {}
    for _, name in pairs(args[1]) do
      table[name] = self[name]
    end
    return table

  elseif count == 1 then

    local name = args[1]
    return self[name]

  else

    return false

  end

end

-- Set player atributs
function Player:Set(...)

  local args = {...} -- Get all arguments
  local count = #args -- Count number arguments

  if count == 1 and type(args[1]) == "table" then

    local save = {}
    for name, data in pairs(args[1]) do
      table.insert(save, name)
      self[name] = value
    end

    self:Save(save) -- Save in Database

  elseif count == 2 then

    local name = args[1]
    local value = args[2]
    self[name] = value

  else

    return false

  end

end