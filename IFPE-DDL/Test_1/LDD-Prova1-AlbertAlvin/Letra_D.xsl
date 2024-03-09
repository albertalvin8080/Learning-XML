<?xml version="1.0" encoding="UTF-8"?>
<xsl:stylesheet version="1.0" xmlns:xsl="http://www.w3.org/1999/XSL/Transform">

    <xsl:output method="xml" version="1.0" encoding="UTF-8" indent="yes"></xsl:output>
    <xsl:variable name="continentes" select="distinct-values(//@continent)"></xsl:variable>
    <xsl:variable name="chart" select="//chart"></xsl:variable>

    <xsl:template match="/">
        <results>
            <xsl:for-each select="$continentes">
                <xsl:sort select="." order="ascending" data-type="text"></xsl:sort>
                <xsl:variable name="continente" select="."></xsl:variable>

                <result>
                    <xsl:attribute name="date">
                        <xsl:for-each select="$chart">
                            <xsl:value-of select="(current()[@continent=$continente]/dataset/set[@browser = 'Chrome' and @value > 50.0]/parent::dataset)[1]/@date"></xsl:value-of>
                        </xsl:for-each>
                    </xsl:attribute>
                    
                    <xsl:attribute name="continent">
                        <xsl:value-of select="."></xsl:value-of>
                    </xsl:attribute>
                </result>

            </xsl:for-each>
        </results>
    </xsl:template>
</xsl:stylesheet>