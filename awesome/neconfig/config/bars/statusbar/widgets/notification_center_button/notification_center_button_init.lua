-- Load libraries
local wibox = require('wibox')
-- Load custom modules
local icons = require('neconfig.config.utils.icons')


-- Construct notification center button widget
return wibox.widget {
    widget = wibox.widget.textbox,

    text = icons.message,
    align = 'center',
    valign = 'center'
}
