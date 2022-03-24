-- Merge two tables, overwriting values in `t1` for keys that exists in `t2.
-- Borrowed from https://stackoverflow.com/questions/1283388/how-to-merge-two-tables-overwriting-the-elements-which-are-in-both
function merge_tables(t1, t2)
    for k,v in pairs(t2) do
        if type(v) == "table" then
            if type(t1[k] or false) == "table" then
                tableMerge(t1[k] or {}, t2[k] or {})
            else
                t1[k] = v
            end
        else
            t1[k] = v
        end
    end
    return t1
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
