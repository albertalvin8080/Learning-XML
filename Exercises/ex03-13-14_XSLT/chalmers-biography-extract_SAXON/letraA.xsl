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
            <table>
                <thead>
                    <tr>
                        <th>Born</th>
                    </tr>
                </thead>
                <tbody>
                    <xsl:for-each select="distinct-values(//entry/@born)">
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

    <xsl:template match="entry/@born">
        <tr>
            <td><xsl:value-of select="."></xsl:value-of></td>
        </tr>
    </xsl:template>
</xsl:stylesheet>