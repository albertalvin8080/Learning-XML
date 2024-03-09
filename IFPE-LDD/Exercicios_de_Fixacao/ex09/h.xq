let $r := (
  for $x in //book/title
where $x/attribute::lang = "pt-br"
return data($x) || ' @lang=' || $x/@lang
)
return $r