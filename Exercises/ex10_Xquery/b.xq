let $ano := min(//cd/year)
for $cd in //cd
where $cd/year = $ano
return $cd/title/text()