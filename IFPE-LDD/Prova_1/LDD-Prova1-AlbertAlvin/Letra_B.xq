let $continentes := distinct-values(//@continent)

let $result := (
  for $continente in $continentes
  let $dataset := //chart[@continent=$continente]/dataset/set[@browser = "Chrome" and @value > 50.0]/parent::dataset
  let $menor-data := min(
    for $date in $dataset/@date return xs:date(concat($date, "-01"))
  )
  order by $continente
  return <result date="{format-date($menor-data, '[Y0001]-[M01]')}" continent="{$continente}" />
)

return serialize(<results>{$result}</results>, map{'indent':'yes'})
