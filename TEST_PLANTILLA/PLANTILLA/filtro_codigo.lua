-- filtro_codigo.lua (Adaptado)
-- Convierte bloques de código en codebox (arc=0pt)

function CodeBlock(el)
  local tex = string.format("\\begin{codebox}\n%s\n\\end{codebox}", el.text)
  return pandoc.RawBlock("latex", tex)
end
