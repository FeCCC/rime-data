-- lua/quote_key.lua
-- 直角引号模式(corner_quotes)下,空编码时按 ' 直接上屏『/』,不用再从候选里选。
-- 弯引号模式 / 西文模式 / 西文标点(ascii_punct) 一律放行,
--   tiger/tigress/flypy 里 ' 原本的临时英文、历史上屏、单字模式不受影响。

local odd = false   -- false = 下一个出『

local function processor(key, env)
  local ctx = env.engine.context
  if key.keycode ~= 0x27 then return 2 end
  if key:release() or key:ctrl() or key:alt() or key:super() then return 2 end
  if ctx:is_composing() then return 2 end
  if ctx:get_option("ascii_mode") then return 2 end
  if ctx:get_option("ascii_punct") then return 2 end
  if not ctx:get_option("corner_quotes") then return 2 end
  env.engine:commit_text(odd and "』" or "『")
  odd = not odd
  return 1
end

return processor
