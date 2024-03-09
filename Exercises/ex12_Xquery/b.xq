let $xml := 
<table>
{
  <tr>
    <th>{'Rodada'}</th>
    <th>{'Gols'}</th>
  </tr>
}
{
  for $rodada in //rodada
  order by xs:integer(sum($rodada//gols)) descending
  (: order by xs:integer($rodada/@n) :)
  return 
  <tr>
    <td>{data($rodada/@n)}</td>
    <td>
    {
      (: sum(
        for $jogo in $rodada/jogo
        return $jogo/visitante/gols + $jogo/mandante/gols 
      ) :)
       sum($rodada//gols)
    }
    </td>
  </tr>
}
</table>

return serialize($xml, map{'indent':'yes','method':'xml'})