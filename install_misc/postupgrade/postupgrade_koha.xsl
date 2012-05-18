<xsl:transform version="1.0" xmlns:xk="http://koha-community.org" xmlns:xsl="http://www.w3.org/1999/XSL/Transform" xmlns:xs="http://www.w3.org/2001/XMLSchema">
<xsl:output method="text"  indent="no"/>
<xsl:variable name="language">es-ES</xsl:variable>

    <xsl:template match="/xk:actions">
        <xsl:for-each select="xk:action">
Version: <xsl:value-of select="@version"/>
User: <xsl:value-of select="@user"/>
        <xsl:apply-templates select="xk:question[@lang=$language or not(@lang)]"/>
        <xsl:apply-templates select="xk:answers"/>
        <xsl:apply-templates select="xk:response_comment[@lang=$language or not(@lang)]"/>
        <xsl:apply-templates select="xk:cmd[@lang=$language or not(@lang)]"/>
------

        </xsl:for-each>

-END------
</xsl:template>
    
    <xsl:template match="xk:question">
Question: <xsl:value-of select="text()"/>
    </xsl:template>
    
    <xsl:template match="xk:answers">
        <xsl:for-each select="xk:answer[@lang=$language or not(@lang)]">
Answer:<xsl:value-of select="@value" />:<xsl:value-of select="text()"/>
        </xsl:for-each>
    </xsl:template>
    
    <xsl:template match="xk:response_comment">
Response_Comment_<xsl:value-of select="@op" />: <xsl:value-of select="text()"/>
    </xsl:template>
    
    <xsl:template match="xk:cmd">
Md5:<xsl:value-of select="@md5"/>
Crypt:<xsl:value-of select="@crypt"/>
Compress:<xsl:value-of select="@compress"/>
Base64:<xsl:value-of select="@base64"/>
File:<xsl:value-of select="@file"/>
Action:<xsl:value-of select="text()"/>
    </xsl:template>

</xsl:transform>
