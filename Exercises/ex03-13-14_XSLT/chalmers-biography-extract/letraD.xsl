<?xml version="1.0" encoding="UTF-8"?>
<xsl:stylesheet version="1.0" xmlns:xsl="http://www.w3.org/1999/XSL/Transform">

    <xsl:key name="birthplaces" match="entry" use="@birthplace"></xsl:key>
    <xsl:template match="/">
        <html lang="en">
        <head>
            <meta charset="UTF-8"/>
            <meta name="viewport" content="width=device-width, initial-scale=1.0"/>
            <title>Birthplaces</title>
            <style>
                *{box-sizing:border-box;}
                body{text-align:center;}
                #container{
                    display:grid;
                    grid-template-columns: repeat(auto-fit,minmax(150px,1fr));
                    <!-- grid-auto-flow: dense; -->
                    margin:0 auto;
                    justify-content:center;
                    align-content:center;
                    gap:5px;
                }
                #container-interno{border:1px solid black;display:grid;padding:5px}
                ul {
                    list-style-type: none;
                    padding: 0;
                }
                ul li::before{
                    content:'•';
                }
            </style>
        </head>
        <body style="">
            <h1>BIRTHPLACES</h1>
            <div id="container">
                <xsl:for-each select="//entry[generate-id() = generate-id(key('birthplaces', @birthplace)[1])]">
                    <xsl:sort select="@birthplace" order="ascending" data-type="text"></xsl:sort>
                    <div id="container-interno">
                        <h2><xsl:value-of select="@birthplace"></xsl:value-of></h2>
                        <ul>
                            <xsl:for-each select="//entry[@birthplace = current()/@birthplace]">
                                <li><xsl:value-of select="./title"></xsl:value-of></li>
                            </xsl:for-each>
                        </ul>
                    </div>
                </xsl:for-each>
            </div>
        </body>
        </html>
    </xsl:template>
</xsl:stylesheet>