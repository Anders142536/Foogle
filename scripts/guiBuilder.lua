local l = require("logger")
local b = {}

b.main_name = "foo-main"
local owner_tag = { owner_mod = "FOOGLE" }

local function build_main_header(main_frame)
    local header = main_frame.add{ type = "flow"}
    header.style.horizontal_spacing = 8
    header.drag_target = main_frame

    local title = header.add{
        type = "label",
        style = "frame_title",
        caption = "Foogle"
    }
    title.drag_target = main_frame
    local drag_handle = header.add{
        type = "empty-widget",
        style = "foo_draghandle"
    }
    drag_handle.drag_target = main_frame
    header.add{
        type = "sprite-button",
        name = "foo_gui_close",
        style = "frame_action_button",
        sprite = "utility/close_white",
        hovered_sprite = "utility/close_black",
        clicked_sprite = "utility/close_black",
        mouse_button_filter = {"left"},
        tags = owner_tag
    }
    header.add{
        type = "sprite-button",
        name = "foo_settings",
        style = "frame_action_button",
        sprite = "utility/close_white",
        hovered_sprite = "utility/close_black",
        clicked_sprite = "utility/close_black",
        mouse_button_filter = {"left"},
        tags = owner_tag
    }
end


-- #region search
local function build_shortcut_buttons(player, subheader_frame)
    subheader_frame.add{
        type = "sprite-button",
        name = "FOO-recipe-ingredients-button",
        sprite = "FOO-choose-recipe",
        tooltip = {"FOO-recipe-ingredients-button"},
        style = "foo_toolbar_button",
        tags = owner_tag
    }
end

local function build_filter_buttons(player, filter_frame)
    filter_frame.add{
        type = "sprite-button",
        name = "FOO-filter-inventories",
        sprite = "item/steel-chest",
        tooltip = {"FOO-filter-inventories"},
        style = "foo_toolbar_button",
        tags = owner_tag
    }
    filter_frame.add{
        type = "sprite-button",
        name = "FOO-filter-recipes",
        sprite = "FOO-choose-recipe",
        tooltip = {"FOO-filter-recipes"},
        style = "foo_toolbar_button",
        tags = owner_tag
    }
    filter_frame.add{
        type = "sprite-button",
        name = "FOO-filter-buildings",
        sprite = "item/assembling-machine-1",
        tooltip = {"FOO-filter-building"},
        style = "foo_toolbar_button",
        tags = owner_tag
    }
    filter_frame.add{
        type = "sprite-button",
        name = "FOO-filter-floor",
        sprite = "tile/grass-1",
        tooltip = {"FOO-filter-floor"},
        style = "foo_toolbar_button",
        tags = owner_tag
    }
    filter_frame.add{
        type = "sprite-button",
        name = "FOO-filter-requests",
        sprite = "item/logistic-chest-requester",
        style = "foo_toolbar_button",
        tags = owner_tag
    }
end

local function build_tool_buttons(player, subheader_frame)
    subheader_frame.add{
        type = "sprite-button",
        name = "FOO-show-search-history",
        tooltip = {"FOO-show-search-history"},
        style = "foo_toolbar_button",
        tags = owner_tag
    }
end

local function add_vertical_line(subheader_frame)
    subheader_frame.add{
        type = "line",
        direction = "vertical"
    }
end

local function build_search_subheader(player, subheader_frame)
    --build_shortcut_buttons(player, subheader_frame)
    --add_vertical_line(subheader_frame)
    build_filter_buttons(player, subheader_frame.add{
        type = "flow",
        direction = "horizontal",
        style = "foo_filter_flow"
    })
    --add_vertical_line(subheader_frame)
    --build_tool_buttons(player, subheader_frame)
end

local function build_search_table(player, search_item_area)
    local search_table = search_item_area.add{
        type = "table",
        name = "FOO-search-table",
        column_count= 6,
        style = "filter_slot_table"
    }

    search_table.add{
        type = "sprite-button",
        style = "slot_button"
    }
end

local function build_search_content(player, content_frame)
    local search_item_area = content_frame.add{
        type = "frame",
        name = "FOO-search-item-area",
        direction = "horizontal",
        style = "slot_button_deep_frame"
    }
    search_item_area.style.width = 40 * 6
    build_search_table(player, search_item_area)
    content_frame.add{
        type = "sprite-button",
        name = "FOO-search-button",
        sprite = "utility/search_black",
        tooltip = {"FOO-search-button"},
        style = "foo_search_button"
    }
end

local function build_main_content(player, content_frame)
    local search_frame = content_frame.add{
        type = "frame",
        name = "FOO-search-frame",
        direction = "vertical",
        style = "window_content_frame_packed"
    }
    build_search_subheader(player, search_frame.add{
        type = "frame",
        name = "FOO-search-subheader-frame",
        style = "foo_subheader"
    })
    build_search_content(player, search_frame.add{
        type = "frame",
        name = "FOO-search-content-scroll-pane",
        direction = "horizontal",
        style = "foo_frame_under_subheader"
    })

end

-- #endregion search
function b.create_gui(player_ref)
    log(l.info("creating gui for player " .. player_ref.index))

    global.gui[player_ref.index] = {}
    local main_frame = player_ref.gui.screen.add{
        type = "frame",
        name = b.main_name,
        direction = "vertical"
    }
    main_frame.auto_center = true
    global.gui[player_ref.index].main = main_frame

    build_main_header(main_frame)
    build_main_content(player_ref.index, main_frame.add{
        type = "flow",
        name = "FOO-main-content-flow",
        direction = "horizontal"
        -- style = "foo_main_content"
    })
end


return b