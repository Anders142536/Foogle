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
end


-- #region search
local function build_search_subheader(player, subheader_frame)

end

local function build_search_content(player, content_frame)

end

local function build_search_frame(player, search_frame)
    build_search_subheader(player, search_frame.add{
        type = "frame",
        name = "FOO-search-subheader-frame",
        style = "foo_subheader"
    })
    build_search_content(player, search_frame.add{
        type = "frame",
        name = "FOO-search-content-frame",
        direction = "horizontal"
    })

end

-- #endregion search

-- #region filter
local function build_filter_subheader(player, subheader_frame)

end

local function build_filter_content(player, content_frame)

end

local function build_filter_frame(player, filter_frame)
    build_filter_subheader(player, filter_frame.add{
        type = "frame",
        name = "FOO-filter-subheader-frame",
        style = "foo_subheader"
    })
    build_filter_content(player, filter_frame.add{
        type = "frame",
        name = "FOO-filter_content_frame",
        direction = "horizontal"
    })

end

-- #endregion filter

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
    local content_frame = main_frame.add{
        type = "flow",
        name = "FOO-main-content-flow",
        direction = "horizontal"
       -- style = "window_content_frame_packed"
    }
    build_search_frame(player_ref.index, content_frame.add{
        type = "frame",
        name = "FOO-search-frame",
        direction = "vertical",
        style = "window_content_frame_packed"
    })
    build_filter_frame(player_ref.index, content_frame.add{
        type = "frame",
        name = "FOO-filter-frame",
        direction = "vertical",
        style = "window_content_frame_packed"
    })
end


return b