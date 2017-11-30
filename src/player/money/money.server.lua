--
-- @Project: FiveM Tools
-- @Author: Samuelds
-- @License: No licence
--

-- Create money
function CreateMoney(name)

  local nameUpper = name.gsub(name, "^%l", name.upper)

  -- Get cash
  AddPlayerMethod("Get" .. nameUpper, function(self)
    return self[name] + 0.0
  end)

  -- Set cash
  AddPlayerMethod("Set" .. nameUpper, function(self, mount)
    mount = Round(mount, 2)
    self:Set(name, mount)
    TriggerClientEvent("ft_base:changeMoney", self.source, self.cash)
  end)

  -- Add cash
  AddPlayerMethod("Add" .. nameUpper, function(self, mount)
    mount = Round(mount, 2)
    local money = self[name] + mount
    self["Set" .. nameUpper](self, money)
    TriggerClientEvent("ft_base:changeMoney", self.source, self.cash)
  end)

  -- Remove cash
  AddPlayerMethod("Remove" .. nameUpper, function(self, mount)
    mount = Round(mount, 2)
    local money = self[name] - mount
    self["Set" .. nameUpper](self, money)
    TriggerClientEvent("ft_base:changeMoney", self.source, self.cash)
  end)

  -- Give cash
  AddPlayerMethod("Give" .. nameUpper, function(self, source, mount)
    mount = Round(mount, 2)
    self["Remove" .. nameUpper](self, mount)
    TriggerClientEvent("ft_base:changeMoney", self.source, self.cash)

    -- Get target player
    local player = Players[source]
    player["Add" .. nameUpper](self, mount)
    TriggerClientEvent("ft_base:changeMoney", player.source, self.cash)
  end)

end