HYPER = {"cmd", "alt", "ctrl", "shift"}
DEBUG = true
NUMBERS = {
  ["1"]=true,
  ["2"]=true,
  ["3"]=true,
  ["4"]=true,
  ["5"]=true,
  ["6"]=true,
  ["7"]=true,
  ["8"]=true,
  ["9"]=true
}

function tablelength(T)
  local count = 0
  for _ in pairs(T) do count = count + 1 end
  return count
end

function run_resizer_tap(axis, edge)
  local vertical = axis == "vertical"
  local leading = edge == "leading"
  local win = hs.window.focusedWindow()
  local screen = win:screen()

  tap = hs.eventtap.new({hs.eventtap.event.types.keyDown}, function(event)
    if DEBUG then
      print("event tap debug got event:")
      print(hs.inspect.inspect(event:getRawEventData()))
    end
    local characters = event:getCharacters()
    if string.len(characters) == 1 and NUMBERS[characters] == true then
      local num = tonumber(characters)
      local ratio = num / 10.0
      resize_to_ratio(ratio, screen, win, vertical, leading)
      if DEBUG then
        print("Resizing to " .. ratio)
      end
    else 
      hs.alert.show("Please press a number between 1 and 9")
    end

    tap:stop()

    return true
  end)
  tap:start()

  hs.timer.doAfter(2, function()
    if tap:isEnabled() then
      tap:stop()

      if DEBUG then
        print("Stopping tap")
      end
    end
  end)
end

function resize_to_ratio(ratio, screen, win, vertical, leading)
  local screen_frame = screen:frame()
  local frame = win:frame()

  if vertical then
    height = frame.h * ratio
    frame.h = height

    if leading then
      frame.y = 0
    else
      frame.y = screen_frame.h - height
    end
  else
    width = frame.w * ratio
    frame.w = width

    if leading then
      frame.x = screen_frame.x
    else
      frame.x = screen_frame.x + screen_frame.w - width
    end
  end


  win:setFrame(frame)
end

-- Movement
hs.hotkey.bind(HYPER, "I", function ()
  local win = hs.window.focusedWindow()
  local frame = win:frame()
  local screen = win:screen()
  local max = screen:frame()

  frame = max
  win:setFrame(frame)
end)

-- Right Half, Full Height
hs.hotkey.bind(HYPER, "L", function ()
  local win = hs.window.focusedWindow()
  local frame = win:frame()
  local screen = win:screen()
  local max = screen:frame()

  frame.x = max.x + (max.w / 2)
  frame.y = max.y
  frame.w = max.w / 2
  frame.h = max.h
  win:setFrame(frame)
end)

-- Left Half, Full Height
hs.hotkey.bind(HYPER, "H", function ()
  local win = hs.window.focusedWindow()
  local frame = win:frame()
  local screen = win:screen()
  local max = screen:frame()

  frame.x = max.x
  frame.y = max.y
  frame.w = max.w / 2
  frame.h = max.h
  win:setFrame(frame)
end)

-- Top Half, Full Width
hs.hotkey.bind(HYPER, "K", function ()
  local win = hs.window.focusedWindow()
  local frame = win:frame()
  local screen = win:screen()
  local max = screen:frame()

  local newFrameWidth = max.w
  local newFrameHeight = max.h / 2

  frame.x = max.x
  frame.y = max.y
  frame.w = newFrameWidth
  frame.h = newFrameHeight
  win:setFrame(frame)
end)

-- Bottom Half, Full Width
hs.hotkey.bind(HYPER, "J", function ()
  local win = hs.window.focusedWindow()
  local frame = win:frame()
  local screen = win:screen()
  local max = screen:frame()

  local newFrameWidth = max.w
  local newFrameHeight = max.h / 2

  frame.x = max.x
  frame.y = max.y + newFrameHeight
  frame.w = newFrameWidth
  frame.h = newFrameHeight
  win:setFrame(frame)
end)

-- Center of screen
hs.hotkey.bind(HYPER, "P", function ()
  local win = hs.window.focusedWindow()
  local frame = win:frame()
  local screen = win:screen()
  local max = screen:frame()

  local newFrameWidth = max.w / 2
  local newFrameHeight = max.h / 2

  frame.x = max.x + (max.w / 2) - (newFrameWidth / 2)
  frame.y = max.y + (max.h / 2) - (newFrameHeight / 2)
  frame.w = newFrameWidth
  frame.h = newFrameHeight
  win:setFrame(frame)
end)

-- Ratio based resizing.
-- These binds facilitate resizing to ratios based on tenths
-- either vertically or horizontally and anchored either on the
-- leading or trailing edge of the axis.
--
-- To use them:
-- 1. Focus the window to resize
-- 2. Invoke the hotkey
-- 3. Press a number between 1 and 9
hs.hotkey.bind(HYPER, "W", function ()
  run_resizer_tap("vertical", "leading")
end)

hs.hotkey.bind(HYPER, "S", function ()
  run_resizer_tap("vertical", "trailing")
end)

hs.hotkey.bind(HYPER, "A", function ()
  run_resizer_tap("horizontal", "leading")
end)

hs.hotkey.bind(HYPER, "D", function ()
  run_resizer_tap("horizontal", "trailing")
end)


-- Moving between screens
function defineScrenThrow(screenIndex)
  hs.hotkey.bind(HYPER, tostring(screenIndex), function ()
    local win = hs.window.focusedWindow()
    if tablelength(hs.screen.allScreens()) < screenIndex then
      return
    end
    local screen = hs.screen.allScreens()[screenIndex]
    local screnFrame = screen:frame()

    win:setFrame(screnFrame)
  end)
end

defineScrenThrow(1)
defineScrenThrow(2)
defineScrenThrow(3)
defineScrenThrow(4)

-- Misc
hs.hotkey.bind(HYPER, "Z", function ()
  hs.reload()
end)
hs.alert.show("Config loaded")
