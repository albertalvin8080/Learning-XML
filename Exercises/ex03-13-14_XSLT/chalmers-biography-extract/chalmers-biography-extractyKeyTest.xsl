<?xml version="1.0" encoding="UTF-8"?>
<xsl:stylesheet version="1.0" xmlns:xsl="http://www.w3.org/1999/XSL/Transform">

    <xsl:key name="bornValues" match="entry" use="@born"></xsl:key>
    <xsl:key name="diedValues" match="entry" use="@died"></xsl:key>

    <xsl:template match="/">
        <html lang="en">
        <head>
            <meta charset="UTF-8"/>
            <!-- <meta http-equiv="refresh" content="30" /> -->
            <!-- <meta name="viewport" content="width=device-width, initial-scale=1.0"/> -->
            <title>Key Test</title>
        </head>
        <body>
            <table border="0">
                <thead>
                    <tr>
                        <th>Século</th>
                        <th>Nascidos</th>
                        <th>Mortos</th>
                    </tr>
                </thead>
                <tbody>
                    <xsl:variable name="cBorn" select="//entry[generate-id() = generate-id(key('bornValues', @born)[1])]/@born"></xsl:variable>
                    <xsl:for-each select="//entry[generate-id() = generate-id(key('bornValues', @born)[1])]">
                    <!-- <xsl:for-each select="//entry"> -->
                        <xsl:sort select="@born" order="ascending" data-type="number"></xsl:sort>
                        <xsl:sort select="@died" order="ascending" data-type="number"></xsl:sort>
                        <tr>
                            <td><xsl:value-of select="title"></xsl:value-of></td>
                            <td><xsl:value-of select="@born"></xsl:value-of></td>
                            <td><xsl:value-of select="@died"></xsl:value-of></td>
                            <td><xsl:value-of select="$cBorn[2]"></xsl:value-of></td>
                        </tr>
                    </xsl:for-each>
                </tbody>
            </table>
        </body>
        </html>
    </xsl:template>
</xsl:stylesheet>