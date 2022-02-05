-- Ensure that LuaRocks is installed
pcall(require, 'luarocks.loader')
-- Load libraries
local awful = require('awful')
local beautiful = require('beautiful')
local menubar = require('menubar')
local naughty = require('naughty')

-- Init error handling
require('neconfig.config.main.error_handling')


-- TODO implement if statement to enable / disable from config
require('awful.autofocus')

local desktop_user_conf = require('neconfig.config.user.desktop_user_conf')
local apps_user_conf = require('neconfig.config.user.apps_user_conf')


-- Load the theme
beautiful.init(desktop_user_conf.theme_path)

require('neconfig.config.main.wallpaper')


require('neconfig.config.main.tag')


-- Load key binds
local global_keys = require('neconfig.user.config.binds.user_global_binds').keys
local global_buttons = require('neconfig.user.config.binds.user_global_binds').buttons
root.keys(global_keys)
root.buttons(global_buttons)


-- Init layouts
awful.layout.layouts = desktop_user_conf.layouts


-- Set the terminal for applications that require it
menubar.utils.terminal = apps_user_conf.default_apps.terminal

-- Init wibar
require('neconfig.config.widgets.statusbar.statusbar_init')


-- TODO move to separate module?
local rules = require('neconfig.config.client.client_rules')
local client_buttons = require('neconfig.user.config.binds.user_client_binds').buttons
local client_keys = require('neconfig.user.config.binds.user_client_binds').keys
awful.rules.rules = rules(client_keys, client_buttons)
require('neconfig.config.client.client_signals')

-- Autostart
require('neconfig.config.main.autostart')
