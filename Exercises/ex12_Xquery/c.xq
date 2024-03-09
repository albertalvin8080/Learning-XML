let $visitantes := distinct-values(//jogo/visitante/time)
let $mandantes := distinct-values(//jogo/mandante/time)
let $times := distinct-values($visitantes, $mandantes)

(: calculando times :)
let $xml := (
  for $time in $times
  let $vitorias := sum(
        for $jogo in //jogo
        let $visitante_gols := $jogo/visitante/gols
        let $mandante_gols := $jogo/mandante/gols
        return 
          if ($jogo/visitante/time = $time and $visitante_gols > $mandante_gols) then 1
          else if ($jogo/mandante/time = $time and $mandante_gols > $visitante_gols) then 1
          else 0
      )
  let $derrotas := sum(
        for $jogo in //jogo
        let $visitante_gols := $jogo/visitante/gols
        let $mandante_gols := $jogo/mandante/gols
        return 
          if ($jogo/visitante/time = $time and $visitante_gols < $mandante_gols) then 1
          else if ($jogo/mandante/time = $time and $mandante_gols < $visitante_gols) then 1
          else 0
       )
  let $empates := sum(
        for $jogo in //jogo
        let $visitante_gols := $jogo/visitante/gols
        let $mandante_gols := $jogo/mandante/gols
        return
          if(($jogo/visitante/time = $time or $jogo/mandante/time = $time) and $visitante_gols = $mandante_gols) then 1
          else 0
      )
  let $gols-marcados := sum(
        for $jogo in //jogo
        let $visitante_gols := $jogo/visitante/gols
        let $mandante_gols := $jogo/mandante/gols
        return
          if ($jogo/visitante/time = $time) then $visitante_gols
          else if ($jogo/mandante/time = $time) then $mandante_gols
          else 0
      )
  let $gols-sofridos := sum(
        for $jogo in //jogo
        let $visitante_gols := $jogo/visitante/gols
        let $mandante_gols := $jogo/mandante/gols
        return
          if ($jogo/visitante/time = $time) then $mandante_gols
          else if ($jogo/mandante/time = $time) then $visitante_gols
          else 0
      )
  let $pontos := xs:integer($vitorias)*3 + xs:integer($empates)*1
  order by $pontos descending, $vitorias descending, $derrotas ascending (:criterios de desempate:)
  return 
  <time>
    <nome>{$time}</nome>
    <vitorias>{$vitorias}</vitorias>
    <derrotas>{$derrotas}</derrotas>
    <empates>{$empates}</empates>
    <gols-marcados>{$gols-marcados}</gols-marcados>
    <gols-sofridos>{$gols-sofridos}</gols-sofridos>
    <saldo-de-gols>{xs:integer($gols-marcados)-xs:integer($gols-sofridos)}</saldo-de-gols>
    <pontos>{$pontos}</pontos>
  </time>
)

(: classificando times :)
let $xml := (
  for $time at $i in $xml
  return
  <time>
      <classificacao>{$i}</classificacao>
      { $time/* }
    </time>
)

let $xml := 
  <table>
    <tr>
    {
      for $element in $xml[1]/*
      return
      <th scope="col">{node-name($element)}</th>
    }
    </tr>
    {
      for $time in $xml
      return 
      <tr>
      {
        for $element in $time/*
        return
        <td>{$element/data()}</td>
      }
      </tr>
    }
  </table>

return serialize($xml, map{'indent':'yes','method':'xml'})