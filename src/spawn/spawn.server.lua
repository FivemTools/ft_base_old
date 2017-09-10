--
-- @Project: FiveM Tools
-- @Author: Samuelds
-- @License: GNU General Public License v3.0
-- @Source: https://github.com/FivemTools/ft_base
--


RegisterServerEvent("ft_base:onResourceReady")
AddEventHandler('ft_base:onResourceReady', function(data)

  AddPlayerDropCallback(function(player)

    player:Save({
      "posX",
      "posY",
      "posZ",
      "heading",
    })

  end)

end)