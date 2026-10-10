-- filtro_codigo.lua
-- Convierte bloques de código en tcolorbox diferenciando sql, terminal, bash, html, python y otros

function CodeBlock(el)
  local lang = el.classes[1] or ""
  local env = "defaultbox"
  local lstlang = ""

  if lang == "sql" or lang == "mysql" or lang == "SQL" or lang == "MySQL" then
    env = "sqlbox"
    lstlang = "mysql"
  elseif lang == "html" or lang == "htm" or lang == "HTML" then
    env = "htmlbox"
    lstlang = ""
  elseif lang == "python" or lang == "py" or lang == "PYTHON" then
    env = "pythonbox"
    lstlang = ""
  elseif lang == "terminal" or lang == "console" or lang == "ubuntu" then
    env = "terminalbox"
    lstlang = ""
    -- Añadir automáticamente el prompt usuario@PC-usuario:~$\u0020 a las líneas de comandos
    local processed_lines = {}
    for line in el.text:gmatch("([^\r\n]*)[\r\n]?") do
      if line ~= "" and not line:match("^%s*#") and not line:match("^%s*%(*\\textcolor") then
        local prompt = "(*\\textcolor{emeraldGreen}{usuario@PC-usuario}\\textcolor{white}{:}\\textcolor{darkBlue}{\\sim}\\textcolor{white}{\\$} *)"
        table.insert(processed_lines, prompt .. line)
      else
        table.insert(processed_lines, line)
      end
    end
    el.text = table.concat(processed_lines, "\n")
  elseif lang == "bash" or lang == "shell" or lang == "sh" or lang == "zsh" then
    env = "bashbox"
    lstlang = "bash"
  else
    -- Lenguajes que listings conoce
    local known = {java=1,c=1,cpp=1,javascript=1,xml=1,json=1}
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
