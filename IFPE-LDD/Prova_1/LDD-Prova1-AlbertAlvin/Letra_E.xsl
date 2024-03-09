<?xml version="1.0" encoding="UTF-8"?>
<xsl:stylesheet version="1.0" xmlns:xsl="http://www.w3.org/1999/XSL/Transform">

    <xsl:output method="xml" indent="yes" encoding="UTF-8" version="1.0"></xsl:output>
    <xsl:variable name="continentes" select="distinct-values(//@continent)"></xsl:variable>
    <xsl:variable name="chart" select="//chart"></xsl:variable>

    <xsl:template match="/">
        <charts>
            <xsl:for-each select="$continentes">
                <xsl:sort select="." order="ascending" data-type="text"></xsl:sort>
                <xsl:variable name="continente" select="."></xsl:variable>
                <xsl:variable name="myDate" select="'2023-10'"></xsl:variable>

                <chart>
                    <xsl:attribute name="continent">
                        <xsl:value-of select="$continente"></xsl:value-of>
                    </xsl:attribute>

                    <dataset>
                        <xsl:attribute name="date">
                          <xsl:value-of select="$myDate"></xsl:value-of>
                        </xsl:attribute>

                        <xsl:for-each select="$chart[@continent=$continente]/dataset[@date = $myDate]/set">
                            <xsl:sort select="./@value" order="descending" data-type="number"></xsl:sort>
                            <xsl:if test="position() &lt;= 5">
                                <set>
                                    <xsl:attribute name="browser">
                                      <xsl:value-of select="./@browser" />
                                    </xsl:attribute>
                                    <xsl:attribute name="value">
                                      <xsl:value-of select="./@value" />
                                    </xsl:attribute>
                                </set>
                            </xsl:if>
                        </xsl:for-each>
                    </dataset>
                    
                </chart>
            </xsl:for-each>
        </charts>
    </xsl:template>
</xsl:stylesheet>