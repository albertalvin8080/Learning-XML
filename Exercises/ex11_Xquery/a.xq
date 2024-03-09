let $xml := <results>
{
  for $entry in //entry[@died<1600]
  let $names := normalize-space($entry/title)
  let $died := xs:integer($entry/@died)
  order by $died
  return 
  <dude>{concat($names, ' (', $died, ')')}</dude>
}
</results>
return serialize($xml, map{'indent':'yes','method':'xml'})
