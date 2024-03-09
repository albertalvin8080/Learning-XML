<?xml version="1.0" encoding="UTF-8"?>
<xsl:stylesheet version="1.0" xmlns:xsl="http://www.w3.org/1999/XSL/Transform">
    <xsl:output method="html" indent="yes"/>
    
    <!-- Defina chaves para nascidos e mortos por século -->
    <xsl:key name="nascidosPorSeculo" match="entry" use="ceiling(@born div 100)"/>
    <xsl:key name="mortosPorSeculo" match="entry" use="ceiling(@died div 100)"/>
    
    <!-- Template para agrupar biografados por século -->
    <xsl:template match="/">
        <html>
            <head>
                <style>table{float:left;}</style>
                <title>Quantidade de Biografados por Século</title>
            </head>
            <body>
                <h1>Quantidade de Biografados por Século</h1>
                <table border="1">
                    <tr>
                        <th>Século</th>
                        <th>Nascidos</th>
                    </tr>
                    <xsl:for-each select="//entry">

                    </xsl:for-each>
                    <xsl:for-each select="//entry[generate-id() = generate-id(key('nascidosPorSeculo', ceiling(@born div 100))[1])]">
                        <xsl:sort select="ceiling(@born div 100)" order="ascending" data-type="number"></xsl:sort>
                        <tr>
                            <td><xsl:value-of select="ceiling(@born div 100)"></xsl:value-of></td>
                            <td><xsl:value-of select="count(key('nascidosPorSeculo', ceiling(@born div 100)))"></xsl:value-of></td>
                        </tr>
                    </xsl:for-each>
                </table>

                <table border="1" style="margin-left:10px;">
                    <tr>
                        <th>Século</th>
                        <th>Mortos</th>
                    </tr>
                    <xsl:for-each select="//entry[generate-id() = generate-id(key('mortosPorSeculo', ceiling(@died div 100))[1])]">
                        <xsl:sort select="ceiling(@died div 100)" order="ascending" data-type="number"></xsl:sort>
                        <tr>
                            <td><xsl:value-of select="ceiling(@died div 100)"></xsl:value-of></td>
                            <td><xsl:value-of select="count(key('mortosPorSeculo', ceiling(@died div 100)))"></xsl:value-of></td>
                        </tr>
                    </xsl:for-each>
                </table>
            </body>
        </html>
    </xsl:template>
</xsl:stylesheet>
