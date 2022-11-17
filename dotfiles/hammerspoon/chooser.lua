-- Empty table that external functions can add to
otherChoices = {}

-- List of window arrangements that aren't quite important enough for a hotkey
arrangements = {
  {
    ["text"] = "Zoom meeting",
    ["subText"] = "Arrange the screen for a Zoom meeting",
    ["type"] = "arrangement",
    ["value"] = "zoomMeeting",
    ["image"] = hs.image.imageFromAppBundle("us.zoom.xos"),
  },
  {
    ["text"] = "Timesheets",
    ["subText"] = "Arrange the screen for completing timesheets",
    ["type"] = "arrangement",
    ["value"] = "timesheets",
    ["image"] = hs.image.imageFromAppBundle("com.google.Chrome"),
  },
}

-- List of open tabs in Safari
function getSafariTabs()
  if hs.application.find("com.apple.Safari") ~= nil then
    local success, result = hs.osascript.javascript([[
      (function() {
        var safari = Application('Safari');
        var tabsList = [];
        for (win of safari.windows()) {
          for (tab of win.tabs()) {
            tabsList[tab.index()] = {
              index: tab.index(),
              title: tab.name(),
              url: tab.url()
            };
          }
        }
        return tabsList;
      })();
    ]])
    return result
  else
    return {}
  end
end

function focusSafariTabByIndex(index)
  hs.osascript.applescript(string.format([[
    tell application "Safari"
      tell window 1
        set current tab to tab %d
      end tell
      activate
    end tell
  ]], index))
end

-- Populate the list of choices in the fuzzy chooser
function populateChoices()
  local c = {}

  -- Safari tabs
  hs.fnutils.map(getSafariTabs(), function(result)
    table.insert(c, {
      text = result.title,
      subText = result.url,
      type = "safariTab",
      value = result.index,
      image = hs.image.imageFromAppBundle("com.apple.Safari"),
    })
  end)

  -- Application windows
  hs.fnutils.map(hs.window.filter.default:getWindows(), function(win)
    if win ~= hs.window.focusedWindow() and win:application():bundleID() ~= "com.apple.Safari" then
      table.insert(c, {
        text = win:title(),
        subText = win:application():title(),
        image = hs.image.imageFromAppBundle(win:application():bundleID()),
        value = win,
        type = "window",
      })
    end
  end)

  -- Other choices
  for _, v in pairs(otherChoices) do
    table.insert(c, v)
  end

  -- Arrangements
  for _, v in pairs(arrangements) do
    table.insert(c, v)
  end

  return c
end

-- Create the chooser and handle the choices
chooser = hs.chooser.new(function(choice)
  if choice == nil then
    return false

  elseif choice.type == "url" then
    hs.urlevent.openURL(choice.value)

  elseif choice.type == "window" then
    choice.value:focus()

  elseif choice.type == "safariTab" then
    focusSafariTabByIndex(choice.value)

  elseif choice.type == "arrangement" then

    if choice == nil then
      return false

    elseif choice.value == "zoomMeeting" then
      hideAppsExcept({"us.zoom.xos", "pro.writer.mac", "com.google.Chrome"})
      hs.grid.set(hs.application.open("us.zoom.xos"):getWindow('Zoom Meeting'), screenPositions.left_top)
      hs.grid.set(hs.application.open("pro.writer.mac"):mainWindow(), screenPositions.left_bottom)
      hs.grid.set(hs.application.open("com.google.Chrome"):mainWindow(), screenPositions.right)
      hs.application.get("us.zoom.xos"):getWindow('Zoom'):close()
      openChromeTab("app.slack.com")

    elseif choice.value == "timesheets" then
      hideAppsExcept({"pro.writer.mac", "com.google.Chrome"})
      hs.grid.set(hs.application.open("com.google.Chrome"):mainWindow(), screenPositions.left)
      hs.grid.set(hs.application.open("pro.writer.mac"):mainWindow(), screenPositions.right)
      openChromeTab("harvestapp.com")

    end
  end
end)

-- Configure the chooser
chooser
  :bgDark(true)
  :placeholderText("Launch something")
  :rows(10)
  :searchSubText(true)

-- Launch the chooser via a hotkey
m:bind("", "space", function()
  m:exit()
  chooser:choices(populateChoices())
  chooser:query('')
  chooser:refreshChoicesCallback()
  chooser:show()
end)
