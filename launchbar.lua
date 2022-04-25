
local layout = require("wibox.layout")
local beautiful = require("beautiful")
local launcher = require("awful.widget.launcher")
local textbox = require("wibox.widget.textbox")
local gfs = require("gears.filesystem")
local config_path = gfs.get_configuration_dir()

local launchbar = {}

local separator = textbox()
separator:set_markup(" <span foreground='grey'> </span> ")

function launchbar.new()
   local widget = layout.fixed.horizontal()
   
   widget:add( launcher({ command = "chromium", image = "/usr/share/icons/hicolor/48x48/apps/chromium.png" }) )
   widget:add( launcher({ command = "firefox", image = "/usr/share/icons/hicolor/48x48/apps/firefox.png" }) )
   widget:add( launcher({ command = "thunderbird", image = "/usr/share/icons/hicolor/48x48/apps/thunderbird.png" }) )
   widget:add( launcher({ command = "filezilla", image = "/usr/share/icons/hicolor/48x48/apps/filezilla.png" }) )
   widget:add( launcher({ command = "discord", image = "/usr/share/icons/default/discord.png" }) )
   widget:add( separator )
   widget:add( launcher({ command = "code-oss", image = "/usr/share/icons/code-oss.png" }) )
   widget:add( separator )
   widget:add( launcher({ command = "lxterminal", image = "/usr/share/icons/Adwaita/48x48/legacy/utilities-terminal.png" }) )
   widget:add( launcher({ command = "pcmanfm", image = "/usr/share/icons/Adwaita/48x48/places/folder.png" }) )
   widget:add( separator )
   widget:add( launcher({ command = "pavucontrol", image = "/usr/share/icons/Adwaita/48x48/legacy/audio-volume-medium.png" }) )
   widget:add( launcher({ command = "lxrandr", image = "/usr/share/icons/Adwaita/48x48/legacy/view-fullscreen.png" }) )
   --widget:add( launcher({ command = "echo $(zenity --password --display=0) | sudo -S gparted", image = "/usr/share/icons/hicolor/48x48/apps/gparted.png" }) )
   return widget
end

return setmetatable(launchbar, { __call = function(_, ...)
                                    return launchbar.new(...) end })
