<?xml version="1.0" encoding="UTF-8"?>
<xsl:stylesheet version="1.0" xmlns:xsl="http://www.w3.org/1999/XSL/Transform">
    <xsl:template match="/">
        <html>
            <head>
                <meta charset="UTF-8"/>
                <title>Doc Teste</title>
                <style>
                    td, th {
                        padding: 5px;
                    }
                </style>
            </head>
            <body>
                <h1>h1 de teste</h1>
                <table border="1">
                    <thead>
                        <tr>
                            <th>Biografados</th>
                            <th>Ano de Nascimento</th>
                            <th>Ano de Morte</th>
                            <th>Idade</th>
                        </tr>
                    </thead>
                    <tbody>
                        <xsl:apply-templates select="/dictionary/entry/title">
                            <xsl:sort select="./../@died - ./../@born" order="ascending" data-type="number"></xsl:sort>
                        </xsl:apply-templates>
                    </tbody>
                </table>
            </body>
        </html>
    </xsl:template>

    <xsl:template match="title">
        <tr>
            <td>
                <xsl:value-of select="."></xsl:value-of>
            </td>
            <td>
                <xsl:value-of select="number(./../@born)"></xsl:value-of>
            </td>
            <td>
                <xsl:value-of select="number(./../@died)"></xsl:value-of>
            </td>
            <td>
                <xsl:value-of select="./../@died - ./../@born"></xsl:value-of>
            </td>
        </tr>
    </xsl:template>
</xsl:stylesheet>
