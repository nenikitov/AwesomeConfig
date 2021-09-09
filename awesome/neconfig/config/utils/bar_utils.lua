-- Load libraries
local awful = require('awful')
local wibox = require('wibox')
-- Load custom modules
require('neconfig.config.utils.widget_utils')


-- Add, initialize and draw a section onto a custom bar
function add_section_to_bar(args)
    local sections = args.info_table.sections

    -- Init the section
    sections[args.name] = {
        popup = {},
        contents = {}
    }

    -- Create the popup
    sections[args.name].popup = awful.popup {
        screen = args.screen,
        placement = function(widget)
            local position = args.position.vertical .. '_' .. args.position.horizontal
            local margins = {}
            margins[args.position.vertical] = args.position.vertical_offset
            margins[args.position.horizontal] = args.position.horizontal_offset
            return awful.placement[position](
                widget,
                { margins = margins }
            )
        end,
        widget = {}
    }

    -- Populate it with widgets
    local section_layout = wibox.layout.fixed.horizontal()
    for _, widget in pairs(args.widgets)
    do
        section_layout:add(resize_vert_widget(widget, args.style.size))
    end
    local section_final_widget = {
        section_layout,
        forced_height = args.style.size,
        widget = wibox.container.background
    }

    sections[args.name].widgets = args.widgets
    
    sections[args.name].popup:setup {
        section_final_widget,

        layout = wibox.layout.fixed.horizontal
    }
end

function add_section(args)
    local name = args.name
    local widgets = args.widgets
    local position = args.position
    local style = args.style
    local screen = args.screen
    local info_table = args.info_table

    local position_info = generate_positon(position.side, position.section)
    local section_position = position_info.combined

    -- Init the section
    if (not info_table[section_position])
    then
        info_table[section_position] = {
            last_section = nil
        }
    end
    local last_section = info_table[section_position].last_section


    info_table[section_position][name] = {
        popup = {},
        contents = {}
    }


    -- Create the popup
    info_table[section_position][name].popup = awful.popup {
        screen = screen,
        placement = function(wi)
            local margins = find_margins_for_position(position_info, position.side, last_section, style, screen, info_table)

            return awful.placement[section_position](
                wi,
                { margins = margins }
            )
        end,
        widget = {}
    }

    -- Populate it with widgets
    local section_layout = wibox.layout.fixed.horizontal()
    for _, widget in pairs(widgets)
    do
        section_layout:add(resize_vert_widget(widget, style.contents_size))
    end
    local section_final_widget = {
        section_layout,
        forced_height = style.contents_size,
        widget = wibox.container.background
    }

    info_table[section_position][name].widgets = widgets
    
    info_table[section_position][name].popup:setup {
        section_final_widget,

        layout = wibox.layout.fixed.horizontal
    }

    info_table[section_position].last_section = name
end


-- Generates the position string from a side where the bar is attached and section index
-- Side is 'top', 'bottom', 'left', 'right'
-- Section is 1, 2, 3 where, in case of 'top' side, 1 is left corner, 2 is middle and 3 is right corner
function generate_positon(side, section)
    local lookup = {
        ['top'] = {
            [1] = { 'top_left', 'right' },
            [2] = { 'top', 'right' },
            [3] = { 'top_right', 'left' }
        },
        ['bottom'] = {
            [1] = { 'bottom_left', 'right' },
            [2] = { 'bottom', 'right' },
            [3] = { 'bottom_right', 'left' }
        },
        ['left'] = {
            [1] = { 'top_left', 'bottom' },
            [2] = { 'left', 'bottom' },
            [3] = { 'bottom_left', 'top' }
        },
        ['right'] = {
            [1] = { 'top_right', 'bottom' },
            [2] = { 'right', 'bottom' },
            [3] = { 'bottom_right', 'top' }
        }
    }

    return {
        combined = lookup[side][section][1],
        next_direction = lookup[side][section][2]
    }
end

-- Generate the margin table for the section position so it is after the previous one
function find_margins_for_position(position_info, bar_position_dir, last_section, style, screen, info_table)
    local dir = position_info.next_direction
    local pos = position_info.combined

    -- Calculate the margin to the side of the screen where the section (and the bar) are attached
    local margins_to_bar = style.bar_margins + style.contents_margins_to_bar


    -- Calculate the margin to the corner where the section is attached
    -- Find its location
    local lookup_margin_before = {
        ['top'] = 'bottom',
        ['bottom'] = 'top',
        ['left'] = 'right',
        ['right'] = 'left'
    }
    local margin_before_dir = lookup_margin_before[dir]
    -- Calculate the offset of this margin (depends on the section that was placed before)
    local margin_content_offset = 0
    -- Check last placed section
    
    if (not last_section)
    then
        -- There was no sections placed in this corner, the margin depends on the bar
        margin_content_offset = style.bar_margins
    else
        -- Offset the current section so it does not overlap with previous
        -- Find info parameters to calculate content offset
        local section_size_param
        local section_position_param
        if (dir == 'top' or dir == 'bottom')
        then
            section_size_param = 'height'
            section_position_param = 'y'
        else
            section_size_param = 'width'
            section_position_param = 'x'
        end
        -- Get info
        local section_size = info_table[pos][last_section].popup[section_size_param]
        local section_position = info_table[pos][last_section].popup[section_position_param]
        local screen_size = screen.geometry[section_size_param]



        -- Calculate the offset
        if (dir == 'bottom' or dir == 'right')
        then
            -- The current section is placed after (on the right or below)
            margin_content_offset = section_position + section_size
        else
            -- The current section is placed before (on the left or above) 
            margin_content_offset = screen_size - section_position
        end
    end
    -- Add spacing between last and current section
    local margin_to_content = margin_content_offset + style.contents_margins_to_content

    return {
        [bar_position_dir] = margins_to_bar,
        [margin_before_dir] = margin_to_content
    }
end
