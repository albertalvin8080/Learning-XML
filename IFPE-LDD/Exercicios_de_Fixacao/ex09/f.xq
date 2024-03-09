let $autores := distinct-values(
  //book/author[matches(., '^[Aa]')]
)
return for $t at $p in $autores
  return count($autores) || ' ' || $t || ' ' || $p