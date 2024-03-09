let $anos := //book/year
let $decadas := distinct-values(
  for $ano in $anos
  return floor(xs:integer($ano) div 10) * 10
)
let $elementos := (
  for $decada in $decadas
  order by $decada
  return
  <decada value="{$decada}">
  {
    for $livro in 
      //book[year >= $decada and year < $decada + 10]
    return <livro>{$livro/title}</livro>
  }
  </decada>
)
return $elementos/count(livro)