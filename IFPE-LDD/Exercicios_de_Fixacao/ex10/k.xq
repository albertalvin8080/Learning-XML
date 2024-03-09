let $companies := distinct-values(//cd/company)
let $elementos := (
  for $company in $companies
  order by $company
  return <company>
    <name>{$company}</name>
    <albuns>{
      count(//cd[company=$company])
    }</albuns>
  </company>
)
return serialize($elementos, map{'indent':'yes','method':'xml'})