local l = require("scripts.logger")
local gui = require("scripts.gui")

--[[ -~ GLOBAL TABLE ~- 

gui[player]
history[player]
verbose


]]

local function initializePlayer(player)
    log(l.info("initializing player " .. player))
end

local function initialize()
    log(l.info("initializing start"))

    global.verbose = settings.global["FOO-enable-debug"].value
    global.gui = {}

    for _, player in pairs(game.connected_players) do
        log(l.info("found player: " .. player.name))
        initializePlayer(player)
    end

    log(l.info("initializing end"))
end


--#region -~[[ EVENT HANDLERS ]]~-

local function on_init(event)
    log(l.info("on init triggered"))
    initialize()
end

local function on_configuration_changed(event)
    if event.mod_changes.Foogle then
        log(l.info("configuration of Foogle changed"))
        initialize()
    end
end

local function on_runtime_mod_setting_changed(event)
    if event.setting_type == "runtime-global" then
        global.verbose = settings.global["FOO-enable-debug"].value
        log(l.info("debug mode is now " .. (l.doD() and "on" or "off")))
    end
end


local function on_open_gui(event)
    log(l.info("on_open_gui shortcut triggered"))

    gui.openGui(event.player_index)
end

local function on_close_gui(event)
    log(l.info("on_close_gui shortcut triggered"))

    gui.closeGui(event.player_index)
end


--#endregion -~[[ EVENT HANDLERS ]]~-

--#region -~[[ EVENT REGISTRATION ]]~-
script.on_init(on_init)
script.on_configuration_changed(on_configuration_changed)
script.on_event(defines.events.on_runtime_mod_setting_changed, on_runtime_mod_setting_changed)


-- shortcuts
script.on_event("FOO-open-gui", on_open_gui)
script.on_event("FOO-close-gui", on_close_gui)

--#endregion -~[[ EVENT REGISTRATION ]]~-