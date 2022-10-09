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
