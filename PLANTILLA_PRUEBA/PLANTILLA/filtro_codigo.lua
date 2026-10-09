-- filtro_codigo.lua
-- Convierte bloques de código en tcolorbox diferenciando terminal y bash

function CodeBlock(el)
  local lang = el.classes[1] or ""
  local env = "defaultbox"
  local lstlang = ""

  if lang == "sql" or lang == "mysql" or lang == "SQL" or lang == "MySQL" then
    env = "sqlbox"
    lstlang = "mysql"
  elseif lang == "terminal" or lang == "console" or lang == "ubuntu" then
    env = "terminalbox"
    lstlang = ""
  elseif lang == "bash" or lang == "shell" or lang == "sh" or lang == "zsh" then
    env = "bashbox"
    lstlang = "bash"
  else
    -- Lenguajes que listings conoce
    local known = {python=1,java=1,c=1,cpp=1,javascript=1,html=1,xml=1,json=1}
    if known[lang] then lstlang = lang end
  end

  local tex = ""
  if env == "defaultbox" then
    tex = string.format("\\begin{defaultbox}{%s}\n%s\n\\end{defaultbox}", lstlang, el.text)
  else
    tex = string.format("\\begin{%s}\n%s\n\\end{%s}", env, el.text, env)
  end
  
  return pandoc.RawBlock("latex", tex)
end
