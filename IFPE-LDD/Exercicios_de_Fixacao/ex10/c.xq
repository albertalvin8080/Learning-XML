let $preco := max(//cd/price)
for $cd in //cd
where $cd/price = $preco
return $cd