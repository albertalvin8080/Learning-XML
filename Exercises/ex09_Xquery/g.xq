let $r := 
  distinct-values(//book/author[matches(.,'^[Aa]')])
return data($r)