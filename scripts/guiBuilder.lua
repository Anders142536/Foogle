local l = require("logger")
local b = {}

b.main_name = "FOO-main"

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

end

local function build_main_content(player, content_frame)

end

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
        type = "frame",
        name = "FOO-main-content-frame",
        direction = "vertical",
        style = "window_content_frame_deep"
    })
end


return b