let $authors := distinct-values(//book/author)
let $iniciais := distinct-values(
  for $x in $authors
order by $x
return substring($x,1,1)
)
for $x in $iniciais
let $nomes := distinct-values(//book/author[starts-with(., $x)])
return '['||$x||', '|| count($nomes) || ']' || ' -> ' ||string-join($nomes, ' | ')