for $entry in //entry
let $age := $entry/@died - $entry/@born
where $age > 88
order by $age descending
return concat($age, ' ', normalize-space($entry/title))