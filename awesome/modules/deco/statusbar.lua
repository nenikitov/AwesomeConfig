-- Standard Awesome libraries
local gears = require("gears")
local awful = require("awful")
local wibox = require("wibox")
local beautiful = require("beautiful")

-- Load custom modules
wallpaper = require("modules.deco.wallpaper")
-- Get info about complex widgets
local taglist_buttons = require("modules.deco.taglist")()
local tasklist_buttons = require("modules.deco.tasklist")()
local layoutbox_buttons = require("modules.deco.layoutbox")()

-- {{{ Generate widgets that are the same on all the screens
-- Launcher menu
local launcher = awful.widget.launcher({
    image = beautiful.awesome_icon,
    menu = rc.menu
})
-- Current keyboard layout
local keyboardlayout = awful.widget.keyboardlayout()
-- Clock
local textclock = wibox.widget.textclock()
-- Systray for background applications
local systray = wibox.widget.systray()
-- }}}

-- {{{ Send button info to the theme
theme.tasklist_buttons = tasklist_buttons
theme.taglist_buttons = taglist_buttons
-- }}}


awful.screen.connect_for_each_screen(
    -- Set up the status bar (top bar) for each screen
    function(s)
        -- Set wallpaper for each screen
        set_wallpaper(s)

        -- {{{ Generate widgets that are unique for each screen
        -- Promptbox 
        s.promptbox = awful.widget.prompt()
        -- Taglist
        s.taglist = awful.widget.taglist {
            screen = s,
            filter = awful.widget.taglist.filter.all,
            buttons = taglist_buttons,
        }
        -- Tasklist
        s.tasklist = awful.widget.tasklist {
            screen = s,
            filter = awful.widget.tasklist.filter.currenttags,
            buttons = tasklist_buttons,
        }
        -- Current layout indicator
        s.layoutbox = awful.widget.layoutbox(s)
        s.layoutbox:buttons(layoutbox_buttons)
        -- Wibar on top that will display previous widgets
        s.wibox = awful.wibar {
            position = "top",
            screen = s,
            height = 28,
        }
        -- }}}

        -- Add widgets to the wibox
        s.wibox:setup {
            -- Left widgets
            {
                launcher,
                s.taglist,
                s.promptbox,

                layout = wibox.layout.fixed.horizontal,
            },
            -- Middle widget
            s.tasklist, 
            -- Right widgets
            {
                keyboardlayout,
                systray,
                textclock,
                s.layoutbox,

                layout = wibox.layout.fixed.horizontal,
            },

            layout = wibox.layout.align.horizontal,
        }

        -- Let the theme recreate wibox
        if beautiful.at_screen_connect ~= nil
        then
            beautiful.at_screen_connect(s)
        end
    end
)
