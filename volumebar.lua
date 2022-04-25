local widget = require("wibox.widget")
local beautiful = require("beautiful")
local gears = require("gears")
local awful = require("awful")
local naughty = require("naughty")

local volumebar = {}

local test_audio = "paplay /usr/share/sounds/freedesktop/stereo/audio-volume-change.oga"
--local test_audio = "paplay /usr/share/sounds/freedesktop/stereo/complete.oga"

function volumebar.new()
   
   
   volbar = widget{
      value     = 0,
      bar_height   = 10,
      minimum    = 0,
      maximum    = 100,
      bar_color    = beautiful.bg_focus,
      bar_shape   = gears.shape.rounded_rect,
      handle_color  = beautiful.fg_normal,
      handle_border_color = beautiful.bg_normal,
      handle_border_width = 1,
      handle_shape   = gears.shape.circle,
      widget     = widget.slider,
      forced_width = 200
   }
   
   --awful.spawn.easy_async(
   --   "pactl get-sink-volume @DEFAULT_SINK@",
   --   function(stdout, stderr, reason, exit_code)
   --      naughty.notify { text = "v:"..stdout }
   --      naughty.notify { text = "v:"..stdout:gmatch("[^\r\n]+")(0) }
   --      --for line in stdout:gmatch("[^\r\n]+") do
   --      --   naughty.notify { text = "v:"..line }
   --      --end
   --      naughty.notify { text = "v:"..stdout:gmatch("[^\r\n]+")(0):gmatch(".*/.*([0-9]*%).*/.*")() }
   --      volbar.value = tonumber( stdout )
   --   end
   --)
   
   
   local fd = io.popen( "pactl get-sink-volume @DEFAULT_SINK@ | awk 'NR==1 {print $5}' | sed -e 's/%//g'" )
   local initial_vol = fd:read("*all")
   fd:close()
   
   volbar.value = tonumber( initial_vol )
   
   vol_change = function(c)
      -- pactl set-sink-volume @DEFAULT_SINK@ 50%
      --local lcmd = 'amixer sset \'Master\' ' .. c.value .. '% &>>/dev/null'
      local lcmd = 'pactl set-sink-volume @DEFAULT_SINK@ ' .. c.value .. '% &>>/dev/null && ' .. test_audio
      awful.spawn.with_shell(lcmd)
   end

   volbar:connect_signal("widget::redraw_needed",vol_change)
   
   return volbar
end

return setmetatable(volumebar, { __call = function(_, ...)
                                    return volumebar.new(...) end })
