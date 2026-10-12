-- filtro_grid.lua
-- Permite crear rejillas de imágenes estilo CSS Grid en Markdown
-- Uso: 
-- ::: {.grid cols=3}
-- ![](img1.png)
-- ![](img2.png){span=2}
-- :::

function Div(el)
  if el.classes:includes('grid') then
    local cols = el.attributes['cols'] or '2'
    local blocks = {}
    
    table.insert(blocks, pandoc.RawBlock('latex', '\\begin{imggrid}{' .. cols .. '}'))
    
    for _, block in ipairs(el.content) do
      local images = {}
      
      -- Extraer todas las imágenes si están en un párrafo, plain, o son directas
      if block.t == 'Para' or block.t == 'Plain' then
        for _, inline in ipairs(block.content) do
          if inline.t == 'Image' then
            table.insert(images, inline)
          end
        end
      elseif block.t == 'Image' then
        table.insert(images, block)
      end
      
      for _, img in ipairs(images) do
        local span = img.attributes['span']
        local row_span = img.attributes['rowspan']
        local options = {}
        
        if span then
          table.insert(options, 'raster column span=' .. span)
        end
        if row_span then
          table.insert(options, 'raster row span=' .. row_span)
        end
        
        local opt_str = ""
        if #options > 0 then
          opt_str = "[" .. table.concat(options, ", ") .. "]"
        end
        
        table.insert(blocks, pandoc.RawBlock('latex', '\\gridimg' .. opt_str .. '{' .. img.src .. '}'))
      end
    end
    
    table.insert(blocks, pandoc.RawBlock('latex', '\\end{imggrid}'))
    return blocks
  end
end
