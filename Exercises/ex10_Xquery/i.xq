for $country in distinct-values(//cd/country)
order by $country
return $country