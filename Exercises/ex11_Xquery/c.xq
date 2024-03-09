for $entry in //entry
where $entry/body[count(p) >= 3]
return $entry