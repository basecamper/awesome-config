local awful = require("awful")
local wibox = require("wibox")
local textclock = {}

function textclock.new()
    local widget = wibox.widget.textclock( "%H:%M" )
    local cal_pop = awful.widget.calendar_popup.month()
    cal_pop:attach(widget, 'tr')
    return widget
end

return setmetatable(textclock, { __call = function(_, ...)
                                    return textclock.new(...) end })
