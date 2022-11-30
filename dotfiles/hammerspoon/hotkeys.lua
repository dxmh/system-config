-- Hammerspoon hotkeys on right command only, thanks to:
-- https://github.com/Hammerspoon/hammerspoon/discussions/3113

local hotkey   = require("hs.hotkey")
local eventtap = require("hs.eventtap")
local keycodes = require("hs.keycodes")

if hs.host.operatingSystemVersion().major >= 13 then
  passPane = "x-apple.systempreferences:com.apple.Passwords-Settings.extension"
else
  passPane = "/System/Library/PreferencePanes/Passwords.prefPane"
end

local myKeys = {
  hotkey.new({ "cmd" }, ",", function() hs.application.open("com.apple.systempreferences") end),
  hotkey.new({ "cmd" }, "x", function() hs.task.new("/usr/bin/open", nil, function() return true end, { passPane }):start() end),
}
local myKeysActive = false

-- This determines whether or not to enable/disable the keys depending on
-- whether the right command key is pressed:
et = eventtap.new(
    { eventtap.event.types.flagsChanged },
    function(e)
        local flags = e:rawFlags()
        if flags & eventtap.event.rawFlagMasks.deviceRightCommand > 0 then
            if not myKeysActive then
                for _, v in ipairs(myKeys) do
                    v:enable()
                end
                myKeysActive = true
            end
        else
            if myKeysActive then
                for _, v in ipairs(myKeys) do
                    v:disable()
                end
                myKeysActive = false
            end
        end
    end
):start()
