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

  local titulo     = escape(getMeta("title"))
  local asignatura = escape(getMeta("subject"))
  local autor      = escape(getMeta("author"))

  -- 1. Portada
  local portada_tex = string.format(
    "\\pagenumbering{arabic}\n\\setcounter{page}{1}\n\\portada{%s}{%s}{%s}",
    titulo, asignatura, autor
  )

  -- 2. Índice (Situado más arriba y sin línea superior)
  local sin_indice = os.getenv("SIN_INDICE") or ""
  local toc_tex = ""

  if sin_indice ~= "1" then
    toc_tex = table.concat({
      "\\thispagestyle{plain}", -- Quita la línea de cabecera
      "\\vspace*{-1.2cm}",      -- Sube el índice hacia arriba
      "{\\montserratfont\\huge\\bfseries\\color{grisTexto} Índice}",
      "\\vspace{0.4em}",
      "\\begingroup",
      "\\hypersetup{linkcolor=black,linktoc=all}",
      "\\setcounter{tocdepth}{3}",
      "\\tableofcontents",
      "\\endgroup",
      "\\clearpage",
    }, "\n")
  else
    toc_tex = ""
  end

  local bloques = {
    pandoc.RawBlock("latex", portada_tex),
    pandoc.RawBlock("latex", toc_tex),
  }

  for _, b in ipairs(doc.blocks) do
    table.insert(bloques, b)
  end

  return pandoc.Pandoc(bloques, meta)
end
