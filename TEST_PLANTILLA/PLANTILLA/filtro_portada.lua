-- filtro_portada.lua adaptado para la nueva plantilla
function Meta(meta)
  local title = meta.title and pandoc.utils.stringify(meta.title) or "Sin Título"
  local subtitle = meta.subtitle and pandoc.utils.stringify(meta.subtitle) or ""
  local author = meta.author and pandoc.utils.stringify(meta.author) or ""
  local date = meta.date and pandoc.utils.stringify(meta.date) or ""
  
  -- Intentar obtener el nombre del archivo de una variable de entorno o metadatos
  local filename = os.getenv("PANDOC_FILENAME") or title

  local tex = ""
  
  -- Definir el nombre del archivo para el footer
  tex = tex .. "\\renewcommand{\\footerfilename}{" .. filename .. "}\n"

  if not os.getenv("SIN_PORTADA") then
    tex = tex .. string.format("\\portadaGuia{%s}{%s}{%s}{%s}\n", title, subtitle, author, date)
  end

  if not os.getenv("SIN_INDICE") then
    tex = tex .. "\\opensansfont\\small\n\\tableofcontents\n\\clearpage\n"
  end

  return pandoc.Meta{
    ['header-includes'] = pandoc.MetaList{
      pandoc.RawBlock('latex', tex)
    }
  }
end
