-- Load libraries
local awful = require('awful')
-- Load custom modules
local tasklist_buttons = require('neconfig.config.bars.statusbar.widgets.tasklist.tasklist_buttons')()


-- Generate tasklist widget
local function get_tasklist(screen, bar_info)
        -- Get style from the theme
        local widget_info = bar_info.widgets.taglist
        local style = {
            bar_pos = bar_info.position,
            corner_radius = bar_info.corner_radius.sections,
            size = bar_info.contents_size,
            decoration_size = widget_info.decoration_size,
            spacing = widget_info.spacing,
            max_client_count = widget_info.max_client_count,
            max_size = widget_info.max_size
        }

    local tasklist_widget = require('neconfig.config.bars.statusbar.widgets.tasklist.tasklist_widget')(style)

    local tasklist = awful.widget.tasklist {
        screen = screen,
        filter = awful.widget.tasklist.filter.currenttags,
        buttons = tasklist_buttons,
        style = tasklist_widget.style,
        layout = tasklist_widget.layout,
        widget_template = tasklist_widget.widget_template
    }

    return tasklist
end

return setmetatable(
    {},
    {  __call = function(_, ...) return get_tasklist(...) end }
)
