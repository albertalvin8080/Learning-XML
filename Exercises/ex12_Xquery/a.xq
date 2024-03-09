(: resposta diferente do StAX porque alterei o xml :)

let $maxGols := max(
  for $jogo in //jogo
  return $jogo/visitante/gols + $jogo/mandante/gols
)

for $jogo in //jogo
where $jogo/visitante/gols + $jogo/mandante/gols = $maxGols
return $jogo