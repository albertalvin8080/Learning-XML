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
        <ol>
            <xsl:apply-templates select="//entry">
                <xsl:sort select="count(title/csc)" order="descending" data-type="number"></xsl:sort>
            </xsl:apply-templates>
        </ol>
    </body>
    </html>
    </xsl:template>

    <xsl:template match="entry">
        <li><xsl:value-of select="concat(title, ' =&gt; ', count(title/csc), ' nomes')"></xsl:value-of></li>
    </xsl:template>
</xsl:stylesheet>