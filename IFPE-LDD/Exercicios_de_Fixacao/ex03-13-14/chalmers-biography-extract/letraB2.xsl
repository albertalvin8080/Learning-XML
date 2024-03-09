<?xml version="1.0" encoding="UTF-8"?>
<xsl:stylesheet version="1.0" xmlns:xsl="http://www.w3.org/1999/XSL/Transform">

<xsl:template match="/">
<xsl:variable name="centuries" select="//entry[@born != preceding-sibling::@born]"></xsl:variable>
<html lang="en">
    <head>
        <meta charset="UTF-8"/>
        <meta name="viewport" content="width=device-width, initial-scale=1.0"/>
        <title>B-2</title>
    </head>
    <body>
       <h1>Teste</h1>
       <table border="1">
        <thead>
            <tr>
                <th>Seculo</th>
                <th>Nascidos</th>
                <th>Mortos</th>
            </tr>
        </thead>
        <tbody>
            <xsl:for-each select="$centuries">
                <xsl:sort select="." order="ascending" data-type="number"></xsl:sort>
                <tr>
                    <td><xsl:value-of select="."></xsl:value-of></td>
                </tr>
            </xsl:for-each>
        </tbody>
       </table>
    </body>
    </html>
    </xsl:template>
</xsl:stylesheet>
