local M = {}

function M.highlight(group, hl)
  vim.api.nvim_set_hl(0, group, hl)
end

---@param c  string
local function hexToRgb(c)
  c = string.lower(c)
  return { tonumber(c:sub(2, 3), 16), tonumber(c:sub(4, 5), 16), tonumber(c:sub(6, 7), 16) }
end

---@param foreground string foreground color
---@param background string background color
---@param alpha number|string number between 0 and 1. 0 results in bg, 1 results in fg
function M.blend(foreground, background, alpha)
  alpha = type(alpha) == "string" and (tonumber(alpha, 16) / 0xff) or alpha
  local bg = hexToRgb(background)
  local fg = hexToRgb(foreground)

  local blendChannel = function(i)
    local ret = (alpha * fg[i] + ((1 - alpha) * bg[i]))
    return math.floor(math.min(math.max(0, ret), 255) + 0.5)
  end

  return string.format("#%02x%02x%02x", blendChannel(1), blendChannel(2), blendChannel(3))
end

---@param hex string
---@param amount number
---@return string
function M.darken(hex, amount)
  return M.blend(hex, "#000000", amount)
end

---@param hex string
---@param amount number
---@return string
function M.lighten(hex, amount)
  return M.blend(hex, "#FFFFFF", amount)
end

return M
