<?xml version="1.0" encoding="UTF-8"?>
<xsl:stylesheet version="1.0" xmlns:xsl="http://www.w3.org/1999/XSL/Transform">
<xsl:template match="/">
<html lang="en">
    <head>
        <meta charset="UTF-8"/>
        <meta name="viewport" content="width=device-width, initial-scale=1.0"/>
        <title>Document</title>
    </head>
    <body>
        <xsl:variable name="seculos">
            <xsl:for-each select="//entry">
                <seculo><xsl:value-of select="ceiling(@born div 100)"></xsl:value-of></seculo>
                <seculo><xsl:value-of select="ceiling(@died div 100)"></xsl:value-of></seculo>
            </xsl:for-each>
        </xsl:variable>
        <xsl:variable name="entries" select="//entry"></xsl:variable>
        <table border="1">
            <thead>
                <tr>
                    <th>Seculo</th>
                    <th>Qt. Nascidos</th>
                    <th>Qt. Mortos</th>
                </tr>
                <xsl:for-each select="distinct-values($seculos/seculo)">
                    <xsl:sort select="current()" order="ascending" data-type="number"></xsl:sort>
                    <tr>
                        <td><xsl:value-of select="current()"></xsl:value-of></td>
                        <td><xsl:value-of select="count($entries[ceiling(@born div 100) = current()])"></xsl:value-of></td>
                        <td><xsl:value-of select="count($entries[ceiling(@died div 100) = current()])"></xsl:value-of></td>
                    </tr>
                </xsl:for-each>
            </thead>
        </table>
    </body>
    </html>
    </xsl:template>
</xsl:stylesheet>