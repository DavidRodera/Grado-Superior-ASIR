-- filtro_notas.lua (Adaptado)
-- Convierte bloques especiales en calloutbox

local mapping = {
  nota = "NOTA",
  tip = "CONSEJO",
  aviso = "ATENCIÓN",
  regla = "REGLA DE ORO",
  logica = "LÓGICA CLAVE",
  importante = "IMPORTANTE"
}

function Div(el)
  for class, title in pairs(mapping) do
    if el.classes:includes(class) then
      local content = pandoc.utils.stringify(el.content)
      local tex = string.format("\\begin{calloutbox}{%s}\n%s\n\\end{calloutbox}", title, content)
      return pandoc.RawBlock("latex", tex)
    end
  end
end
