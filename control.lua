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

    gui.open_gui(event.player_index)
end

local function on_close_gui(event)
    log(l.info("on_close_gui triggered"))

    gui.close_gui(event.player_index)
end

-- #region gui event handler
local handlers = {}

function handlers.gui_close_click(event)
    
end

-- #endregion gui event handler

-- #region gui event handler picker
local function callHandler(event, suffix)
    -- handler methods have to be called the same as the element that shall trigger them
    local method_name = string.match(event.element.name, "foo_(.*)$") .. suffix
    local handlerMethod = handlers[method_name]

    -- if a handler method exists the gui press was for an element of this mod
    if handlerMethod then
        handlerMethod(event)
	else
		log(l.warn("Couldn't find handler method " .. event.element.name .. suffix))
    end
end

local function event_is_from_foogle(element)
    return string.match(element.name, "^foo_") ~= nil
        and element.tags.owner_mod == "FOOGLE"
end

local function on_gui_click(event)
    if event_is_from_foogle(event.element) then
        log(l.info("on_gui_click triggered with element name " .. event.element.name))
        callHandler(event, "_click")
    end
end

local function on_gui_value_changed(event)
    if event_is_from_foogle(event.element) then
        log(l.info("on_gui_value_changed triggered with element name " .. event.element.name))
        callHandler(event, "_value_changed")
    end
end

local function on_gui_text_changed(event)
    if event_is_from_foogle(event.element) then
        log(l.info("on_gui_text changed triggered with element name " .. event.element.name))
        callHandler(event, "_text_changed")
    end
end

local function on_gui_selection_state_changed(event)
    if event_is_from_foogle(event.element) then
        log(l.info("on_gui_selection_state_changed event triggered with element name " .. event.element.name))
        callHandler(event, "_selection")
    end
end
-- #endregion gui event handler picker

--#endregion -~[[ EVENT HANDLERS ]]~-

--#region -~[[ EVENT REGISTRATION ]]~-
script.on_init(on_init)
script.on_configuration_changed(on_configuration_changed)
script.on_event(defines.events.on_runtime_mod_setting_changed, on_runtime_mod_setting_changed)

-- gui
script.on_event(defines.events.on_gui_click, on_gui_click)

-- shortcuts
script.on_event("FOO-open-gui", on_open_gui)
script.on_event(defines.events.on_gui_closed, on_close_gui)

--#endregion -~[[ EVENT REGISTRATION ]]~-