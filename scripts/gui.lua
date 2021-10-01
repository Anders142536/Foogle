local l = require("logger")
local gui_builder = require("guiBuilder")

local gui = {}

local function is_valid(player)
    return global.gui[player]
        and global.gui[player].main
        and global.gui[player].main.valid
end

function gui.initialize(player)
    log(l.info("initializing gui for player " .. player))

    -- currently unused
end

function gui.open_gui(player)
    log(l.info("opening gui for player " .. player))

    local playerRef = game.get_player(player)
    local main = playerRef.gui.screen[gui_builder.main_name]

    if l.doD() then log(l.debug("main exists? " .. (main == nil and "no" or "yes"))) end

    if not main then
        gui_builder.create_gui(playerRef)
    else
        global.gui[player].main.visible = true
    end

    playerRef.opened = global.gui[player].main
end

function gui.close_gui(player)
    log(l.info("closing gui for player " .. player))
    if is_valid(player) and global.gui[player].main.visible then
        if l.doD() then log(l.debug("gui was valid and visible")) end
        global.gui[player].main.visible = false
        gui.clear_gui(player)
    end
end

function gui.is_open(player)
    return is_valid(player) and global.gui[player].main.visible
end

function gui.clear_gui(player)
    log(l.info("clearing gui for player " .. player))
end






return gui