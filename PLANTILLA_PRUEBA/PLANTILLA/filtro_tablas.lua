-- filtro_tablas.lua
-- Fuerza el centrado, distribuye anchos, estiliza cabeceras (fondo colorNota y texto blanco negrita) y ajusta tamaño para tablas grandes

function Table(el)
  local num_cols = #el.colspecs
  local has_widths = false

  -- Recorremos las especificaciones de columnas (colspecs)
  for i, colspec in ipairs(el.colspecs) do
    colspec[1] = 'AlignCenter'
    -- Verificamos si ya tiene un ancho definido en el Markdown
    if colspec[2] and colspec[2] > 0 then
      has_widths = true
    end
  end

  -- Si no hay anchos definidos, distribuimos equitativamente para forzar el ajuste de texto
  if not has_widths then
    local width = 0.95 / num_cols -- Un poco menos de 1 para dejar margen a los bordes/paddings
    for i, colspec in ipairs(el.colspecs) do
      colspec[2] = width
    end
  end

  -- Estilizar la cabecera (TableHead): fondo colorNota y texto blanco en negrita
  if el.head and el.head.content then
    for r_idx, row in ipairs(el.head.content) do
      if r_idx == 1 and row.content and #row.content > 0 then
        -- Añadir \rowcolor{colorNota} antes de la primera celda
        table.insert(row.content[1].content, 1, pandoc.RawBlock('latex', '\\rowcolor{colorNota}'))
      end
      for _, cell in ipairs(row.content) do
        -- Envolver el contenido de cada celda de la cabecera en \textcolor{white}{\textbf{ ... }}
        table.insert(cell.content, 1, pandoc.RawBlock('latex', '\\textcolor{white}{\\textbf{'))
        table.insert(cell.content, pandoc.RawBlock('latex', '}}'))
      end
    end
  end

  -- Si la tabla es muy ancha (más de 5 columnas), reducimos el tamaño de fuente
  if num_cols > 5 then
    return {
      pandoc.RawBlock('latex', '{\\small'),
      el,
      pandoc.RawBlock('latex', '}')
    }
  end

  return el
end
