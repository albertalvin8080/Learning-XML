<?xml version="1.0" encoding="UTF-8"?>
<xsl:stylesheet version="1.0" xmlns:xsl="http://www.w3.org/1999/XSL/Transform">

    <xsl:key name="mandantesKey" match="mandante" use="time"></xsl:key>
    <xsl:key name="visitantesKey" match="visitante" use="time"></xsl:key>
    <xsl:template match="/">
        <html lang="en">
        <head>
            <meta charset="UTF-8"/>
            <meta name="viewport" content="width=device-width, initial-scale=1.0"/>
            <title>Classificação</title>
        </head>
        <body>
            <table border="1">
                <xsl:variable name="visitantes" select="//jogo/visitante[generate-id() = generate-id(key('visitantesKey', time)[1])]"></xsl:variable>
                <xsl:for-each select="$visitantes">
                    <xsl:sort select="time" order="ascending" data-type="text"></xsl:sort>
                    
                    <!-- gols sofridos -->
                    <xsl:variable name="gols-sofridos" select="sum(//jogo/visitante[time = current()/time]/../mandante/gols | //jogo/mandante[time = current()/time]/../visitante/gols)"></xsl:variable>
                    <!-- gols marcados -->
                    <xsl:variable name="gols-marcados" select="sum(//jogo/visitante[time=current()/time]/gols | //jogo/mandante[time = current()/time]/gols)"></xsl:variable>
                    <!-- saldo de gols -->
                    <xsl:variable name="saldo-gols" select="number($gols-marcados)-number($gols-sofridos)"></xsl:variable>

                    <!-- vitorias -->
                    <xsl:variable name="vitorias">
                        <!-- vitorias como visitante -->
                        <xsl:for-each select="//jogo/visitante[time=current()/time]">
                            <xsl:choose>
                                <xsl:when test="./gols &gt; ./../mandante/gols">
                                    <xsl:value-of select="1"></xsl:value-of>
                                </xsl:when>
                                <xsl:otherwise>
                                    <xsl:value-of select="''"></xsl:value-of>
                                </xsl:otherwise>
                            </xsl:choose>
                        </xsl:for-each>
                        <!-- vitorias como mandante -->
                        <xsl:for-each select="//jogo/mandante[time=current()/time]">
                            <xsl:choose>
                                <xsl:when test="./gols &gt; ./../visitante/gols">
                                    <xsl:value-of select="1"></xsl:value-of>
                                </xsl:when>
                                <xsl:otherwise>
                                    <xsl:value-of select="''"></xsl:value-of>
                                </xsl:otherwise>
                            </xsl:choose>
                        </xsl:for-each>
                    </xsl:variable>

                    <!-- derrotas -->
                    <xsl:variable name="derrotas">
                        <!-- derrotas como visitante -->
                        <xsl:for-each select="//jogo/visitante[time=current()/time]">
                            <xsl:choose>
                                <xsl:when test="./gols &lt; ./../mandante/gols">
                                    <xsl:value-of select="1"></xsl:value-of>
                                </xsl:when>
                            </xsl:choose>
                        </xsl:for-each>
                        <!-- derrotas como mandante -->
                        <xsl:for-each select="//jogo/mandante[time=current()/time]">
                            <xsl:if test="./gols &lt; ./../visitante/gols">
                                <xsl:value-of select="1"></xsl:value-of>
                            </xsl:if>
                        </xsl:for-each>
                    </xsl:variable>

                    <!-- empates -->
                    <xsl:variable name="empates">
                        <!-- empates como visitante -->
                        <xsl:for-each select="//jogo/visitante[time = current()/time]">
                            <xsl:if test="./gols = ./../mandante/gols">
                                <xsl:value-of select="1"></xsl:value-of>
                            </xsl:if>
                        </xsl:for-each>
                        <!-- empates como mandante -->
                        <xsl:for-each select="//jogo/mandante[time = current()/time]">
                            <xsl:if test="./gols = ./../visitante/gols">
                                <xsl:value-of select="1"></xsl:value-of>
                            </xsl:if>
                        </xsl:for-each>
                    </xsl:variable>

                    <tr>
                        <td><xsl:value-of select="time"></xsl:value-of></td>
                        <td><xsl:value-of select="$gols-sofridos"></xsl:value-of></td>
                        <td><xsl:value-of select="$gols-marcados"></xsl:value-of></td>
                        <td><xsl:value-of select="$saldo-gols"></xsl:value-of></td>
                        <td><xsl:value-of select="string-length($vitorias)"></xsl:value-of></td>
                        <td><xsl:value-of select="string-length($derrotas)"></xsl:value-of></td>
                        <td><xsl:value-of select="string-length($empates)"></xsl:value-of></td>
                    </tr>
                </xsl:for-each>
            </table>
        </body>
        </html>
    </xsl:template>
</xsl:stylesheet>