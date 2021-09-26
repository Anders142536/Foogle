local l = require("logger")
local guiBuilder = require("guiBuilder")

local gui = {}

local function isValid(player)
    return global.gui[player]
        and global.gui[player].main
        and global.gui[player].main.valid
end

function gui.initialize(player)
    log(l.info("initializing gui for player " .. player))

    -- currently unused
end

function gui.openGui(player)
    log(l.info("opening gui for player " .. player))
    if not isValid(player) then
        -- destroy gui
        guiBuilder.createGui(player)
    elseif not global.gui[player].main.visible then
        global.gui[player].main.visible = true
    end
end

function gui.closeGui(player)
    log(l.info("closing gui for player " .. player))
    if isValid(player) and global.gui[player].main.visible then
        global.gui[player].main.visible = false
        gui.clearGui(player)
    end
end

function gui.isOpen(player)
    return isValid(player) and global.gui[player].main.visible
end

function gui.clearGui(player)
    log(l.info("clearing gui for player " .. player))
end



return gui