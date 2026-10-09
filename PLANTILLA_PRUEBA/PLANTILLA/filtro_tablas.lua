-- filtro_tablas.lua
-- Convierte tablas de Pandoc a longtable con cabecera oscura (colorNota), texto blanco, filas alternas y anchos iguales

local function blocks_to_latex(blocks)
  local doc = pandoc.Pandoc(blocks)
  local s = pandoc.write(doc, 'latex')
  s = s:gsub("[\r\n]+$", "")
  s = s:gsub("[\r\n]+", " ")
  return s
end

function Table(el)
  local num_cols = #el.colspecs
  local width = string.format("%.4f", 0.95 / num_cols)

  local latex = {}
  table.insert(latex, "\\arrayrulecolor{colorNota}")
  table.insert(latex, "\\setlength{\\arrayrulewidth}{0.8pt}")
  table.insert(latex, "\\begin{longtable}[]{@{}")
  for i = 1, num_cols do
    table.insert(latex, ">{\\centering\\arraybackslash}p{" .. width .. "\\columnwidth}")
  end
  table.insert(latex, "@{}}")
  table.insert(latex, "\\hline")

  -- Header row
  if el.head and el.head.content then
    for _, row in ipairs(el.head.content) do
      table.insert(latex, "\\rowcolor{colorNota}")
      local cells = {}
      for _, cell in ipairs(row.content) do
        local cell_text = blocks_to_latex(cell.content)
        table.insert(cells, "\\textcolor{white}{\\textbf{" .. cell_text .. "}}")
      end
      table.insert(latex, table.concat(cells, " & ") .. " \\\\ \\hline")
    end
  end

  table.insert(latex, "\\endhead")

  -- Body rows
  if el.bodies then
    local row_idx = 0
    for _, body in ipairs(el.bodies) do
      if body.content then
        for _, row in ipairs(body.content) do
          row_idx = row_idx + 1
          if row_idx % 2 == 1 then
            table.insert(latex, "\\rowcolor{white}")
          else
            table.insert(latex, "\\rowcolor{bgNota}")
          end
          local cells = {}
          for _, cell in ipairs(row.content) do
            local cell_text = blocks_to_latex(cell.content)
            table.insert(cells, cell_text)
          end
          table.insert(latex, table.concat(cells, " & ") .. " \\\\ \\hline")
        end
      end
    end
  end

  table.insert(latex, "\\end{longtable}")

  local latex_code = table.concat(latex, "\n")

  if num_cols > 5 then
    return {
      pandoc.RawBlock('latex', '{\\small'),
      pandoc.RawBlock('latex', latex_code),
      pandoc.RawBlock('latex', '}')
    }
  else
    return pandoc.RawBlock('latex', latex_code)
  end
end
