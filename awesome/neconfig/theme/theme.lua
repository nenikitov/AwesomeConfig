-- Load libraries
local awful = require('awful')
local xresources = require('beautiful.xresources')
local dpi = xresources.apply_dpi
local theme_assets = require('beautiful.theme_assets')
local gfs = require('gears.filesystem')
-- Load custom modules
local user_desktop_appearance = require('neconfig.user.appearance.user_desktop_appearance')
local user_apps_appearance = require('neconfig.user.appearance.user_apps_appearance')


-- Get variables
local themes_path = gfs.get_themes_dir()
local config_path = awful.util.getdir('config') .. '/neconfig/'


-- Container for values
local theme = {}


theme.font          = user_desktop_appearance.font .. ' ' .. user_desktop_appearance.font_size

theme.bg_normal     = "#222222"
theme.bg_focus      = "#535d6c"
theme.bg_urgent     = "#ff0000"
theme.bg_minimize   = "#444444"
theme.bg_systray    = theme.bg_normal

theme.fg_normal     = "#aaaaaa"
theme.fg_focus      = "#ffffff"
theme.fg_urgent     = "#ffffff"
theme.fg_minimize   = "#ffffff"

theme.useless_gap   = user_desktop_appearance.gaps
theme.border_width  = user_apps_appearance.borders
theme.border_normal = "#000000"
theme.border_focus  = "#535d6c"
theme.border_marked = "#91231c"

-- theme.tasklist_plain_task_name = not statusbar_user_conf.widgets.tasklist.show_task_props
-- theme.tasklist_disable_task_name = not statusbar_user_conf.widgets.tasklist.show_task_title

theme.tasklist_sticky = '▪ '
theme.tasklist_ontop = '^ '
theme.tasklist_above = '▴ '
theme.tasklist_below = '▾ '
theme.tasklist_floating = '✈ '
theme.tasklist_maximized = '+ '
theme.tasklist_maximized_horizontal = '⬌ '
theme.tasklist_maximized_vertical = '⬍ '

-- There are other variable sets
-- overriding the default one when
-- defined, the sets are:
-- taglist_[bg|fg]_[focus|urgent|occupied|empty|volatile]
-- tasklist_[bg|fg]_[focus|urgent]
-- titlebar_[bg|fg]_[normal|focus]
-- tooltip_[font|opacity|fg_color|bg_color|border_width|border_color]
-- mouse_finder_[color|timeout|animate_timeout|radius|factor]
-- prompt_[fg|bg|fg_cursor|bg_cursor|font]
-- hotkeys_[bg|fg|border_width|border_color|shape|opacity|modifiers_fg|label_bg|label_fg|group_margin|font|description_font]
-- Example:
--theme.taglist_bg_focus = '#ff0000'

-- Generate taglist squares:
--[[
local taglist_square_size = dpi(4)
theme.taglist_squares_sel = theme_assets.taglist_squares_sel(
    taglist_square_size, theme.fg_normal
)
theme.taglist_squares_unsel = theme_assets.taglist_squares_unsel(
    taglist_square_size, theme.fg_normal
)
]]

-- Variables set for theming notifications:
-- notification_font
-- notification_[bg|fg]
-- notification_[width|height|margin]
-- notification_[border_color|border_width|shape|opacity]

-- Variables set for theming the menu:
-- menu_[bg|fg]_[normal|focus]
-- menu_[border_color|border_width]
theme.menu_submenu_icon = themes_path..'default/submenu.png'
theme.menu_height = dpi(15)
theme.menu_width  = dpi(100)

-- You can add as many variables as
-- you wish and access them by using
-- beautiful.variable in your rc.lua
--theme.bg_widget = '#cc0000'

-- Define the image to load
theme.titlebar_close_button_normal = themes_path..'default/titlebar/close_normal.png'
theme.titlebar_close_button_focus  = themes_path..'default/titlebar/close_focus.png'

theme.titlebar_minimize_button_normal = themes_path..'default/titlebar/minimize_normal.png'
theme.titlebar_minimize_button_focus  = themes_path..'default/titlebar/minimize_focus.png'

theme.titlebar_ontop_button_normal_inactive = themes_path..'default/titlebar/ontop_normal_inactive.png'
theme.titlebar_ontop_button_focus_inactive  = themes_path..'default/titlebar/ontop_focus_inactive.png'
theme.titlebar_ontop_button_normal_active = themes_path..'default/titlebar/ontop_normal_active.png'
theme.titlebar_ontop_button_focus_active  = themes_path..'default/titlebar/ontop_focus_active.png'

theme.titlebar_sticky_button_normal_inactive = themes_path..'default/titlebar/sticky_normal_inactive.png'
theme.titlebar_sticky_button_focus_inactive  = themes_path..'default/titlebar/sticky_focus_inactive.png'
theme.titlebar_sticky_button_normal_active = themes_path..'default/titlebar/sticky_normal_active.png'
theme.titlebar_sticky_button_focus_active  = themes_path..'default/titlebar/sticky_focus_active.png'

theme.titlebar_floating_button_normal_inactive = themes_path..'default/titlebar/floating_normal_inactive.png'
theme.titlebar_floating_button_focus_inactive  = themes_path..'default/titlebar/floating_focus_inactive.png'
theme.titlebar_floating_button_normal_active = themes_path..'default/titlebar/floating_normal_active.png'
theme.titlebar_floating_button_focus_active  = themes_path..'default/titlebar/floating_focus_active.png'

theme.titlebar_maximized_button_normal_inactive = themes_path..'default/titlebar/maximized_normal_inactive.png'
theme.titlebar_maximized_button_focus_inactive  = themes_path..'default/titlebar/maximized_focus_inactive.png'
theme.titlebar_maximized_button_normal_active = themes_path..'default/titlebar/maximized_normal_active.png'
theme.titlebar_maximized_button_focus_active  = themes_path..'default/titlebar/maximized_focus_active.png'

theme.wallpaper = themes_path..'default/background.png'

-- You can use your own layout icons like this:
theme.layout_fairh = themes_path..'default/layouts/fairhw.png'
theme.layout_fairv = themes_path..'default/layouts/fairvw.png'
theme.layout_floating  = themes_path..'default/layouts/floatingw.png'
theme.layout_magnifier = themes_path..'default/layouts/magnifierw.png'
theme.layout_max = themes_path..'default/layouts/maxw.png'
theme.layout_fullscreen = themes_path..'default/layouts/fullscreenw.png'
theme.layout_tilebottom = themes_path..'default/layouts/tilebottomw.png'
theme.layout_tileleft   = themes_path..'default/layouts/tileleftw.png'
theme.layout_tile = themes_path..'default/layouts/tilew.png'
theme.layout_tiletop = themes_path..'default/layouts/tiletopw.png'
theme.layout_spiral  = themes_path..'default/layouts/spiralw.png'
theme.layout_dwindle = themes_path..'default/layouts/dwindlew.png'
theme.layout_cornernw = themes_path..'default/layouts/cornernww.png'
theme.layout_cornerne = themes_path..'default/layouts/cornernew.png'
theme.layout_cornersw = themes_path..'default/layouts/cornersww.png'
theme.layout_cornerse = themes_path..'default/layouts/cornersew.png'

-- Generate Awesome icon:
theme.awesome_icon = theme_assets.awesome_icon(
    theme.menu_height, theme.bg_focus, theme.fg_focus
)
theme.system_icon = config_path .. 'graphics/icons/system_logo.svg'

-- Define the icon theme for application icons. If not set then the icons
-- from /usr/share/icons and /usr/share/icons/hicolor will be used.
theme.icon_theme = user_desktop_appearance.gtk_icon_theme

return theme
