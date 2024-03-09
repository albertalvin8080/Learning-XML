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
            <table style="text-align: center;" border="1">
                <thead>
                    <tr>
                        <th>Biografados</th>
                        <th>Quant. Nomes</th>
                    </tr>
                </thead>
                <tbody>
                    <xsl:apply-templates select="//entry">
                        <xsl:sort select="count(./title/csc)" order="descending"></xsl:sort>
                    </xsl:apply-templates>
                </tbody>
            </table>
        </body>
        </html>
    </xsl:template>

    <xsl:template match="entry">
        <tr>
            <td><xsl:value-of select="./title"></xsl:value-of></td>
            <td><xsl:value-of select="count(./title/csc)"></xsl:value-of></td>
        </tr>
    </xsl:template>
</xsl:stylesheet>