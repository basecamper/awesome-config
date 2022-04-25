local awful = require("awful")
local wibox = require("wibox")
local textclock = {}

function textclock.new()
   local widget = wibox.widget.textclock( "%H:%M" )
   local cal = wibox.widget.calendar.month(os.date('*t'))
--   local tooltip = awful.tooltip({ objects = { cal },})
   
--   tooltip:add_to_object( widget )
   
--   widget:connect_signal('mouse::enter', function()
      -- tooltip.text = os.date('%A %d.%m.%Y')
--   end)
--   
--   return widget

    local calendar_widget = wibox{ width = 100, height = 100, widget = cal }

    local cal_pop = awful.widget.calendar_popup.month()
    cal_pop:attach(widget, 'tr')

    return widget
    
--    widget:connect_signal("mouse::enter", function()
--        awful.placement.top(calendar_widget, { parent = mouse, offset = { x=1, y=1 }})
--        calendar_widget.visible = true
--    end)
--    widget:connect_signal("mouse::leave", function()
--        calendar_widget.visible = false
--    end)
--
--
--    return widget
end

return setmetatable(textclock, { __call = function(_, ...)
                                    return textclock.new(...) end })
