let $authors := distinct-values(//book/author)
let $quantAuthor := (
  for $a in $authors
  return 
    count(//book[author=$a]) || ' ' || data($a)
)
let $max := 
  max(
    for $x in $quantAuthor 
    return xs:integer(substring-before($x, ' '))
  )
for $x in $quantAuthor 
where xs:integer(substring-before($x, ' ')) = $max
return substring-after($x, ' ') 