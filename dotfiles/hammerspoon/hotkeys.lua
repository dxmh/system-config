-- Hammerspoon hotkeys on right command only, thanks to:
-- https://github.com/Hammerspoon/hammerspoon/discussions/3113

local hotkey   = require("hs.hotkey")
local eventtap = require("hs.eventtap")
local keycodes = require("hs.keycodes")

local myKeys = {
  hotkey.new({ "cmd" }, ",", function() hs.application.open("com.apple.systempreferences") end),
  hotkey.new({ "cmd" }, "c", function() hs.application.open("com.google.Chrome") end),
  hotkey.new({ "cmd" }, "d", function() hs.application.open("com.apple.iCal") end),
  hotkey.new({ "cmd" }, "e", function() hs.application.open("com.apple.mail") end),
  hotkey.new({ "cmd" }, "f", function() hs.application.open("com.apple.finder") end),
  hotkey.new({ "cmd" }, "g", function() hs.application.open("org.whispersystems.signal-desktop") end),
  hotkey.new({ "cmd" }, "h", function() hs.application.open("com.apple.Home") end),
  hotkey.new({ "cmd" }, "i", function() hs.application.open("pro.writer.mac") end),
  hotkey.new({ "cmd" }, "k", function() hs.application.open("net.kovidgoyal.kitty") end),
  hotkey.new({ "cmd" }, "l", function() hs.application.open("com.tinyspeck.slackmacgap") end),
  hotkey.new({ "cmd" }, "m", function() hs.application.open("com.apple.MobileSMS") end),
  hotkey.new({ "cmd" }, "n", function() hs.application.open("com.apple.Notes") end),
  hotkey.new({ "cmd" }, "p", function() hs.application.open("org.hammerspoon.Hammerspoon") end),
  hotkey.new({ "cmd" }, "r", function() hs.application.open("com.apple.reminders") end),
  hotkey.new({ "cmd" }, "s", function() hs.application.open("com.apple.Safari") end),
  hotkey.new({ "cmd" }, "t", function() hs.application.open("net.kovidgoyal.kitty") end),
  hotkey.new({ "cmd" }, "u", function() hs.application.open("com.apple.Music") end),
  hotkey.new({ "cmd" }, "z", function() hs.application.open("us.zoom.xos") end),
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
