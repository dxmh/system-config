require "scratchpad"

function toggleApp(myApp)
  hs.application.enableSpotlightForNameSearches(true)
  local app = hs.application.find(myApp)
  if app ~= nil and app:isFrontmost() then
    app:hide()
  else
    hs.application.launchOrFocus(myApp)
  end
end

myHotkeys = {
  [","] = "System Preferences",
  ["c"] = "Google Chrome",
  ["d"] = "Calendar",
  ["e"] = "Mail",
  ["f"] = "Finder",
  ["h"] = "Hammerspoon",
  ["i"] = "iA Writer",
  ["k"] = "kitty",
  ["l"] = "Slack",
  ["m"] = "Messages",
  ["p"] = "Preview",
  ["s"] = "Safari",
  ["t"] = "kitty", -- t for terminal, for muscle memory
  ["u"] = "Music",
  ["x"] = "Passwords",
  ["z"] = "zoom.us",
}

for k, v in pairs(myHotkeys) do
  hs.hotkey.bind({"control", "option", "command"}, k, function() toggleApp(v) end)
end
