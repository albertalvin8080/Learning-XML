let $birthPlaces := distinct-values(//entry/@birthplace)
let $xml :=
<groups>
{
  for $place in $birthPlaces
  order by $place
  return 
  <group birthplace="{$place}">
  {
    for $entry in //entry[@birthplace=$place]
    order by $entry/title
    return
    <person born="{$entry/@born}" died="{$entry/@died}">
    {normalize-space($entry/title)}
    </person>
  }
  </group>
}
</groups>
return 
  serialize($xml, map{'indent':'yes', 'method':'xml'})