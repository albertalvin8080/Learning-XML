let $livros := (
  for $x in //book
  where $x/year >= 2010 
    and $x/price > 150
  return $x
)
return $livros