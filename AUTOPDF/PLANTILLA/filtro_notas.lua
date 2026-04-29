-- filtro_notas.lua
-- Convierte bloques Div con clases .note, .tip, .warning en tcolorbox de LaTeX

function Div(el)
  local env = nil
  if el.classes:includes("note") then
    env = "notabox"
  elseif el.classes:includes("tip") then
    env = "tipbox"
  elseif el.classes:includes("warning") then
    env = "warningbox"
  end

  if env then
    local begin_tex = pandoc.RawBlock("latex", "\\begin{" .. env .. "}")
    local end_tex   = pandoc.RawBlock("latex", "\\end{" .. env .. "}")
    
    local content = {begin_tex}
    for _, block in ipairs(el.content) do
      table.insert(content, block)
    end
    table.insert(content, end_tex)
    
    return content
  end
end
