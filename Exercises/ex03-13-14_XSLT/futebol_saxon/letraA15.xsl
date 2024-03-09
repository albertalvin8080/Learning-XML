<?xml version="1.0" encoding="UTF-8"?>
<xsl:stylesheet version="1.0" xmlns:xsl="http://www.w3.org/1999/XSL/Transform">

    <xsl:variable name="times" select="distinct-values(//time)"></xsl:variable>
    <xsl:variable name="jogos" select="//jogo"></xsl:variable>
    <xsl:template match="/">
        <html lang="en">
        <head>
            <meta charset="UTF-8"/>
            <meta name="viewport" content="width=device-width, initial-scale=1.0"/>
            <title>Document</title>
        </head>
        <body>
            <table border="1">
                <thead>
                    <tr>
                        <th>Colocacao</th>
                        <th>Time</th>
                        <th>Pontos</th>
                        <th>Vitorias</th>
                        <th>Derrotas</th>
                        <th>Empates</th>
                        <th>Gols Marcados</th>
                        <th>Gols Sofridos</th>
                        <th>Saldo de Gols</th>
                    </tr>
                </thead>
                <tbody>
                    <xsl:variable name="timesV2">
                        <xsl:for-each select="$times">
                            <xsl:variable name="timeAtual" select="."></xsl:variable>
                            <!-- vitorias -->
                            <xsl:variable name="vitorias">
                                <xsl:for-each select="$jogos">
                                    <xsl:choose>
                                        <xsl:when test="./mandante/time = $timeAtual and ./mandante/gols &gt; ./visitante/gols">1</xsl:when>
                                        <xsl:when test="./visitante/time = $timeAtual and ./visitante/gols &gt; ./mandante/gols">1</xsl:when>
                                        <xsl:otherwise></xsl:otherwise>
                                    </xsl:choose>
                                </xsl:for-each>
                            </xsl:variable>
                            <!-- derrotas -->
                            <xsl:variable name="derrotas">
                                <xsl:for-each select="$jogos">
                                    <xsl:choose>
                                        <xsl:when test="./mandante/time = $timeAtual and ./mandante/gols &lt; ./visitante/gols">1</xsl:when>
                                        <xsl:when test="./visitante/time = $timeAtual and ./visitante/gols &lt; ./mandante/gols">1</xsl:when>
                                        <xsl:otherwise></xsl:otherwise>
                                    </xsl:choose>
                                </xsl:for-each>
                            </xsl:variable>
                            <!-- empates -->
                            <xsl:variable name="empates">
                                <xsl:for-each select="$jogos">
                                    <xsl:choose>
                                        <xsl:when test="./mandante/time = $timeAtual and ./mandante/gols = ./visitante/gols">1</xsl:when>
                                        <xsl:when test="./visitante/time = $timeAtual and ./visitante/gols = ./mandante/gols">1</xsl:when>
                                        <xsl:otherwise></xsl:otherwise>
                                    </xsl:choose>
                                </xsl:for-each>
                            </xsl:variable>
                            <!-- gols-marcados -->
                            <xsl:variable name="gols-marcados">
                                <xsl:for-each select="$jogos">
                                    <gols>
                                        <xsl:choose>
                                            <xsl:when test="./mandante/time = $timeAtual">
                                                <xsl:value-of select="./mandante/gols"></xsl:value-of>
                                            </xsl:when>
                                            <xsl:when test="./visitante/time = $timeAtual">
                                                <xsl:value-of select="./visitante/gols"></xsl:value-of>
                                            </xsl:when>
                                            <xsl:otherwise><xsl:value-of select="0" /></xsl:otherwise>
                                        </xsl:choose>
                                    </gols>
                                </xsl:for-each>
                            </xsl:variable>
                            <!-- gols sofridos -->
                            <xsl:variable name="gols-sofridos">
                                <xsl:for-each select="$jogos">
                                    <gols>
                                        <xsl:choose>
                                            <xsl:when test="./mandante/time = $timeAtual">
                                                <xsl:value-of select="./visitante/gols"></xsl:value-of>
                                            </xsl:when>
                                            <xsl:when test="./visitante/time = $timeAtual">
                                                <xsl:value-of select="./mandante/gols"></xsl:value-of>
                                            </xsl:when>
                                            <xsl:otherwise><xsl:value-of select="0"></xsl:value-of></xsl:otherwise>
                                        </xsl:choose>
                                    </gols>
                                </xsl:for-each>
                            </xsl:variable>
                            <!-- pontos -->
                            <xsl:variable name="pontos" select="string-length($vitorias)*3 + string-length($empates)"></xsl:variable>
                            <!-- saldo de gols -->
                            <xsl:variable name="saldo-de-gols" select="number(sum($gols-marcados/gols)) - number(sum($gols-sofridos/gols))"></xsl:variable>
                            <!-- xml retornado -->
                            <time>
                                <colocacao></colocacao> <!-- inutil -->
                                <nome><xsl:value-of select="."></xsl:value-of></nome>
                                <pontos><xsl:value-of select="$pontos"></xsl:value-of></pontos>
                                <vitorias><xsl:value-of select="string-length($vitorias)" /></vitorias>
                                <derrotas><xsl:value-of select="string-length($derrotas)"></xsl:value-of></derrotas>
                                <empates><xsl:value-of select="string-length($empates)"></xsl:value-of></empates>
                                <gols-marcados><xsl:value-of select="sum($gols-marcados/gols)"></xsl:value-of></gols-marcados>
                                <gols-sofridos><xsl:value-of select="sum($gols-sofridos/gols)"></xsl:value-of></gols-sofridos>
                                <saldo-de-gols><xsl:value-of select="$saldo-de-gols"></xsl:value-of></saldo-de-gols>
                            </time>
                        </xsl:for-each>
                    </xsl:variable>

                    <xsl:for-each select="$timesV2/time">
                        <xsl:sort select="./pontos" order="descending" data-type="number"></xsl:sort>
                        <xsl:sort select="./vitorias" order="descending" data-type="number"></xsl:sort>
                        <xsl:sort select="./derrotas" order="ascending" data-type="number"></xsl:sort>
                        <tr>
                            <!-- position() funcionou aqui, diferente do 'for $x at $y in...' de xquery -->
                            <td><xsl:value-of select="position()" /></td>
                            <td><xsl:value-of select="./nome"></xsl:value-of></td>
                            <td><xsl:value-of select="./pontos"></xsl:value-of></td>
                            <td><xsl:value-of select="./vitorias"></xsl:value-of></td>
                            <td><xsl:value-of select="./derrotas"></xsl:value-of></td>
                            <td><xsl:value-of select="./empates"></xsl:value-of></td>
                            <td><xsl:value-of select="./gols-marcados"></xsl:value-of></td>
                            <td><xsl:value-of select="./gols-sofridos"></xsl:value-of></td>
                            <td><xsl:value-of select="./saldo-de-gols"></xsl:value-of></td>
                        </tr>
                    </xsl:for-each>
                </tbody>
            </table>
        </body>
        </html>
    </xsl:template>
</xsl:stylesheet>