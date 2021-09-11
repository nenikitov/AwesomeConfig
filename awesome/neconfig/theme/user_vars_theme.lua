-- Load modules
local dpi = require('beautiful.xresources').apply_dpi


-- Customize this
-- █▀▀ █▀▀ █▄ █ █▀▀ █▀█ ▄▀█ █  
-- █▄█ ██▄ █ ▀█ ██▄ █▀▄ █▀█ █▄▄
local general = {
    font = 'Jost* Regular',
    scaling = {
        contents = 1,
        spacing = 1
    }
}

--- Initialize size values related to widget scale
---@param value number
---@return number
function size(value)
    return dpi(value) * general.scaling.contents
end

--- Initialize size values related to spacing
---@param value number
---@return number
function space(value)
    return dpi(value) * general.scaling.spacing
end

-- █▀▀ █   █ █▀▀ █▄ █ ▀█▀
-- █▄▄ █▄▄ █ ██▄ █ ▀█  █
local client = {
    gaps = space(5)
}


-- █▀ ▀█▀ ▄▀█ ▀█▀ █ █ █▀ █▄▄ ▄▀█ █▀█
-- ▄█  █  █▀█  █  █▄█ ▄█ █▄█ █▀█ █▀▄
local statusbar = {
    position = 'top',
    contents_size = size(24),
    margin = {
        -- Margin between 2 ends of the bar and the corners of the screen
        corners = client.gaps * 2,
        -- Margin between the bar side and the edge of the screen
        edge = client.gaps * 2,
        -- Margin between the bar and its contents
        content = space(4)
    },
    spacing = {
        widget = space(4),
        section = space(16)
    },
    corner_radius = size(12)
}


-- ▄▀█ █▀█ █▀█ █▄▄ ▄▀█ █▀█
-- █▀█ █▀▀ █▀▀ █▄█ █▀█ █▀▄
local appbar = {
    position = 'bottom',
    height = size(36),
    margin = {
        -- Margin between 2 ends of the bar and the corners of the screen
        corner = size(20),
        -- Margin between the bar side and the edge of the screen
        edge = size(6)
    },
    corner_radius = size(8)
}


local user_vars_theme = {
    general = general,
    client = client,
    statusbar = statusbar,
    appbar = appbar
}

return user_vars_theme
