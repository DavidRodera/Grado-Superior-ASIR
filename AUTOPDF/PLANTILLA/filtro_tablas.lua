-- filtro_tablas.lua
-- Fuerza el centrado, distribuye anchos y ajusta tamaño para tablas grandes

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
