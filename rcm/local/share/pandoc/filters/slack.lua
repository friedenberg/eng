function Header(el)
  local content = "*" .. pandoc.utils.stringify(el) .. "*"
  return pandoc.List{pandoc.RawInline("markdown", content)}
end

function Strong(el)
  local content = "*" .. pandoc.utils.stringify(el) .. "*"
  return pandoc.List{pandoc.RawInline("markdown", content)}
end

function Emph(el)
  local content = "_" .. pandoc.utils.stringify(el) .. "_"
  return pandoc.List{pandoc.RawInline("markdown", content)}
end
