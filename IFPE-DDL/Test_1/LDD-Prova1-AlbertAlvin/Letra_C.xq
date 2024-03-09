let $chart := (
  for $chart in //chart
  group by $continente := $chart/@continent
  order by $continente
  return <chart continent="{$continente}">{
    for $dataset in $chart/dataset[@date = "2023-10"]
    return <dataset date="{$dataset/@date}">{
      let $temp := (
        for $set in $dataset/set
        order by xs:float($set/@value) descending
        return <set browser="{$set/@browser}" value="{$set/@value}"></set>
      )
      return subsequence($temp, 1, 5)
    }</dataset>
  }</chart>
)

return serialize(<charts>{$chart}</charts>, map{'indent':'yes'})