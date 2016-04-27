require "util"
require "defines"

script.on_init(function() On_Load() end)
script.on_load(function() On_Load() end)


function message(mes)
  for i, player in ipairs(game.players) do
    player.print(mes)
  end
end

function On_Load()
    if not global.fish_sent then
	  global.fish_sent = 0
	end
end


script.on_event(defines.events.on_rocket_launched, function(event)
  local force = event.rocket.force
  if event.rocket.get_item_count("raw-fish") > 0 then
    global.fish_sent = global.fish_sent + 1
  	message("Congratulation at sending up another fish! ")
	  message("Number of Fish in space: "..global.fish_sent)
    for index, player in pairs(force.players) do
      if player.gui.left.fish_score == nil then
        local frame = player.gui.left.add{name = "fish_score", type = "frame", direction = "horizontal", caption={"score"}}
        frame.add{name="fish_count_label", type = "label", caption={"", {"global.fish_sent"}, ""}}
        frame.add{name="fish_count", type = "label", caption="1"}
      else
        player.gui.left.fish_score.fish_count.caption = tostring(global.fish_sent)
      end
    end
  end
end)

