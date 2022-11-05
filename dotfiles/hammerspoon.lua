function toggleApp(myApp)
  hs.application.enableSpotlightForNameSearches(true)
  local app = hs.application.find(myApp)
  if app and app:isFrontmost() then
    app:hide()
  else
    hs.application.launchOrFocus(myApp)
    hs.mouse.absolutePosition(hs.window.focusedWindow():frame().center)
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
  ["l"] = "Slack",
  ["m"] = "Messages",
  ["p"] = "Preview",
  ["s"] = "Safari",
  ["t"] = "kitty",
  ["u"] = "Music",
  ["x"] = "Passwords",
  ["z"] = "zoom.us",
}

for k, v in pairs(myHotkeys) do
  hs.hotkey.bind({"control", "option", "command"}, k, function() toggleApp(v) end)
end
