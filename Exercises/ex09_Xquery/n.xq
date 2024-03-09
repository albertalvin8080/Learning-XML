let $anos := distinct-values(//book/year)
let $elementos := (
  for $ano in $anos
  order by $ano
  return <ano value="{$ano}">
  {
    for $livro in //book[year=$ano]
    order by $livro/title
    return <livro>{$livro/title}</livro>
  }
  </ano>
)
(: return count($elementos) :)
for $e in $elementos 
return count($e/livro) || ' ' || $e/@value