let $c := (
  for $x in //book
where $x/@category="LP"
  and $x/title/@lang="en"
return $x
)
return count(
  $c
)