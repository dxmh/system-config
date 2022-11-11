require "scratchpad"

function toggleApp(myApp)
  hs.application.enableSpotlightForNameSearches(true)
  local app = hs.application.find(myApp)
  if app ~= nil and app:isFrontmost() then
    app:hide()
  else
    hs.application.open(myApp)
  end
end

myHotkeys = {
	-- osascript -e 'id of app "Foo"'
  [","] = "com.apple.systempreferences",
  ["c"] = "com.google.Chrome",
  ["d"] = "com.apple.iCal",
  ["e"] = "com.apple.mail",
  ["f"] = "com.apple.finder",
  ["h"] = "org.hammerspoon.Hammerspoon",
  ["i"] = "pro.writer.mac",
  ["k"] = "net.kovidgoyal.kitty",
  ["l"] = "com.tinyspeck.slackmacgap",
  ["m"] = "com.apple.MobileSMS",
  ["p"] = "com.apple.Preview",
  ["s"] = "com.apple.Safari",
  ["t"] = "net.kovidgoyal.kitty", -- t for terminal, for muscle memory
  ["u"] = "com.apple.Music",
  ["x"] = "Passwords",
  ["z"] = "us.zoom.xos",
}

for k, v in pairs(myHotkeys) do
  hs.hotkey.bind({"control", "option", "command"}, k, function() toggleApp(v) end)
end
