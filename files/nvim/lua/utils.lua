-- Merge two tables, overwriting values in `t1` for keys that exists in `t2.
-- Borrowed from https://stackoverflow.com/questions/1283388/how-to-merge-two-tables-overwriting-the-elements-which-are-in-both
function merge_tables_inplace(t1, t2)
    for k,v in pairs(t2) do
        if type(v) == "table" then
            if type(t1[k] or false) == "table" then
                t1[k] = merge_tables_inplace(t1[k] or {}, v or {})
            else
                t1[k] = v
            end
        else
            t1[k] = v
        end
    end
    return t1
end

function merge_tables(t1, t2)
  local merged = copy_table(t1)

  merge_tables_inplace(merged, t2)

  return merged
end

function copy_table(obj)
    if type(obj) ~= 'table' then return obj end
    local res = {}
    for k, v in pairs(obj) do res[copy_table(k)] = copy_table(v) end
    return res
end

function os.capture(cmd, raw)
  local f = assert(io.popen(cmd, 'r'))
  local s = assert(f:read('*a'))
  f:close()
  if raw then return s end
  s = string.gsub(s, '^%s+', '')
  s = string.gsub(s, '%s+$', '')
  s = string.gsub(s, '[\n\r]+', ' ')
  return s
end

function set_dark_colors()
  vim.o.background = 'dark'
  vim.cmd('colorscheme rose-pine')
end

function set_light_colors()
  vim.o.background = 'light'
  vim.cmd('colorscheme rose-pine')
end

function update_colors()
  local is_dark = os.capture('defaults read -g AppleInterfaceStyle') == 'Dark'

  if is_dark then 
    set_dark_colors()
  else
    set_light_colors()
  end
end

function file_exists(name)
   local f = io.open(name, "r")
   return f ~= nil and io.close(f)
end

function file_read(name)
   local f = io.open(name, "r")

   return f:read('*a')
end

-- Below borrowed from Neovim itself.

--- Parse a string of hex characters as a color.
---
--- The string can contain 1 to 4 hex characters. The returned value is
--- between 0.0 and 1.0 (inclusive) representing the intensity of the color.
---
--- For instance, if only a single hex char "a" is used, then this function
--- returns 0.625 (10 / 16), while a value of "aa" would return 0.664 (170 /
--- 256).
---
--- @param c string Color as a string of hex chars
--- @return number? Intensity of the color
function parsecolor(c)
  if #c == 0 or #c > 4 then
    return nil
  end

  local val = tonumber(c, 16)
  if not val then
    return nil
  end

  local max = tonumber(string.rep('f', #c), 16)
  return val / max
end

--- Parse an OSC 11 response
---
--- Either of the two formats below are accepted:
---
---   OSC 11 ; rgb:<red>/<green>/<blue>
---
--- or
---
---   OSC 11 ; rgba:<red>/<green>/<blue>/<alpha>
---
--- where
---
---   <red>, <green>, <blue>, <alpha> := h | hh | hhh | hhhh
---
--- The alpha component is ignored, if present.
---
--- @param resp string OSC 11 response
--- @return string? Red component
--- @return string? Green component
--- @return string? Blue component
function parseosc11(resp)
  local r, g, b
  r, g, b = resp:match('^\027%]11;rgb:(%x+)/(%x+)/(%x+)$')
  if not r and not g and not b then
    local a
    r, g, b, a = resp:match('^\027%]11;rgba:(%x+)/(%x+)/(%x+)/(%x+)$')
    if not a or #a > 4 then
      return nil, nil, nil
    end
  end

  if r and g and b and #r <= 4 and #g <= 4 and #b <= 4 then
    return r, g, b
  end

  return nil, nil, nil
end
