-- lua/quote_style.lua
-- 引号字形开关:switches 里的 corner_quotes 打开后把弯引号换成直角引号
-- “” → 「」   ‘’ → 『』
-- 注意:Lua 字符类不能放多字节字符,只能逐个 gsub 替换

local function convert(text)
  return (text:gsub("“", "「"):gsub("”", "」")
              :gsub("‘", "『"):gsub("’", "』"))
end

local function filter(translation, env)
  local corner = env.engine.context:get_option("corner_quotes")
  for cand in translation:iter() do
    if corner and cand.type == "punct" then
      local text = convert(cand.text)
      if text ~= cand.text then
        yield(ShadowCandidate(cand, cand.type, text, cand.comment))
      else
        yield(cand)
      end
    else
      yield(cand)
    end
  end
end

return filter
