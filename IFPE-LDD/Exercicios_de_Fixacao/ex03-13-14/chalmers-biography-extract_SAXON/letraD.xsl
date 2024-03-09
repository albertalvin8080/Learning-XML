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
            <xsl:variable name="birthplaces" select="distinct-values(//entry/@birthplace)"></xsl:variable>
            <xsl:variable name="entries" select="//entry"></xsl:variable>
            <xsl:for-each select="$birthplaces">
                <h1><xsl:value-of select="."></xsl:value-of></h1>
                <xsl:for-each select="$entries[@birthplace = current()]/title">
                    <p><xsl:value-of select="current()"></xsl:value-of></p>
                </xsl:for-each>
            </xsl:for-each>
        </body>
        </html>
    </xsl:template>
</xsl:stylesheet>