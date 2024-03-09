let $xml := <ul>
{
  for $entry in //entry
  where $entry/body/p[contains(., 'Oxford')]
  return <li>{normalize-space($entry/title)}</li>  
}
</ul>
return serialize($xml, map{'indent':'yes','method':'xml'})