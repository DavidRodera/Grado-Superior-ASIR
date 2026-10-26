-- filtro_portada.lua
-- Orden: portada (pág 1) -> índice (pág 2) -> contenido (pág 3+)

function Pandoc(doc)
  local meta = doc.meta

  local function getMeta(key)
    local v = meta[key]
    if not v then return "" end
    return pandoc.utils.stringify(v)
  end

  local function escape(s)
    return s:gsub("%%","\\%%"):gsub("&","\\&"):gsub("#","\\#")
  end

  local tipo    = escape(getMeta("tipo"))
  if tipo == "" then tipo = "GUÍA DE ESTUDIO" end
  local title   = escape(getMeta("title"))
  local author  = escape(getMeta("author"))
  local subject = escape(getMeta("subject"))
  local curso   = escape(getMeta("curso"))
  if curso == "" then curso = escape(getMeta("grado")) end
  if curso == "" then curso = escape(getMeta("date")) end
  local footer  = escape(getMeta("footer"))
  if footer == "" then footer = escape(getMeta("pie")) end
  if footer == "" then footer = "Guía de estudio · ASIR" end

  -- 1. Portada
  local sin_portada = os.getenv("SIN_PORTADA") or ""
  local portada_tex = ""

  if sin_portada ~= "1" then
    portada_tex = string.format(
      "\\pagenumbering{arabic}\n\\setcounter{page}{1}\n\\portada{%s}{%s}{%s}{%s}{%s}{%s}",
      tipo, title, author, subject, curso, footer
    )
  end

  -- 2. Índice
  local sin_indice = os.getenv("SIN_INDICE") or ""
  local toc_tex = ""

  if sin_indice ~= "1" then
    toc_tex = table.concat({
      "\\thispagestyle{plain}",
      "\\vspace*{-1.2cm}",
      "{\\montserratfont\\huge\\bfseries\\color{azulProfundo} Índice}",
      "\\vspace{0.3em}",
      "\\notocruletrue",
      "\\begingroup",
      "\\vspace{-2.5em}",
      "\\hypersetup{linkcolor=black,linktoc=all}",
      "\\setcounter{tocdepth}{2}",
      "\\tableofcontents",
      "\\endgroup",
      "\\notocrulefalse",
      "\\clearpage",
    }, "\n")
  else
    toc_tex = ""
  end

  local footer_tex = string.format("\\renewcommand{\\footercustom}{%s}\n", footer)

  local bloques = {
    pandoc.RawBlock("latex", footer_tex),
    pandoc.RawBlock("latex", portada_tex),
    pandoc.RawBlock("latex", toc_tex),
  }

  for _, b in ipairs(doc.blocks) do
    table.insert(bloques, b)
  end

  return pandoc.Pandoc(bloques, meta)
end
