-- filtro_titulos.lua — Da formato de recuadro redondeado a los números de los títulos H1 (#)

function Header(el)
  if el.level == 1 and #el.content > 0 then
    local first = el.content[1]
    if first.t == "Str" then
      local digits = first.text:match("^(%d+[%d%.]*)[%.:]?$")
      if digits then
        local new_content = {
          pandoc.RawInline("latex", string.format("\\sectionnumberboxinline{%s}", digits))
        }
        for i = 2, #el.content do
          table.insert(new_content, el.content[i])
        end
        return pandoc.Header(1, el.attr, new_content)
      end
    end
  end
  return el
end
