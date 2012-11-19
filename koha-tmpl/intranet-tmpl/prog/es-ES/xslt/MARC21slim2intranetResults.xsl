
<!-- $Id: MARC21slim2DC.xsl,v 1.1 2003/01/06 08:20:27 adam Exp $ -->
<!DOCTYPE stylesheet [<!ENTITY nbsp "&#160;" >]>
<xsl:stylesheet version="1.0"
  xmlns:marc="http://www.loc.gov/MARC21/slim"
  xmlns:items="http://www.koha-community.org/items"
  xmlns:xsl="http://www.w3.org/1999/XSL/Transform"
  exclude-result-prefixes="marc items">
 <xsl:import href="MARC21slimUtils.xsl"/>
 <xsl:output method = "html" indent="yes" omit-xml-declaration = "yes" encoding="UTF-8"/>
 <xsl:key name="item-by-status" match="items:item" use="items:status"/>
 <xsl:key name="item-by-status-and-branch" match="items:item" use="concat(items:status, ' ', items:homebranch)"/>

 <xsl:template match="/">
 <xsl:apply-templates/>
 </xsl:template>
 <xsl:template match="marc:record">

 <!-- Option: Display Alternate Graphic Representation (MARC 880) -->
 <xsl:variable name="display880" select="boolean(marc:datafield[@tag=880])"/>

 <xsl:variable name="hidelostitems" select="marc:sysprefs/marc:syspref[@name='hidelostitems']"/>
 <xsl:variable name="URLLinkText" select="marc:sysprefs/marc:syspref[@name='URLLinkText']"/>
 <xsl:variable name="Show856uAsImage" select="marc:sysprefs/marc:syspref[@name='Display856uAsImage']"/>
 <xsl:variable name="AlternateHoldingsField" select="substring(marc:sysprefs/marc:syspref[@name='AlternateHoldingsField'], 1, 3)"/>
 <xsl:variable name="AlternateHoldingsSubfields" select="substring(marc:sysprefs/marc:syspref[@name='AlternateHoldingsField'], 4)"/>
 <xsl:variable name="AlternateHoldingsSeparator" select="marc:sysprefs/marc:syspref[@name='AlternateHoldingsSeparator']"/>
 <xsl:variable name="UseAuthoritiesForTracings" select="marc:sysprefs/marc:syspref[@name='UseAuthoritiesForTracings']"/>
 <xsl:variable name="leader" select="marc:leader"/>
 <xsl:variable name="leader6" select="substring($leader,7,1)"/>
 <xsl:variable name="leader7" select="substring($leader,8,1)"/>
 <xsl:variable name="leader19" select="substring($leader,20,1)"/>
 <xsl:variable name="biblionumber" select="marc:datafield[@tag=999]/marc:subfield[@code='c']"/>
 <xsl:variable name="controlField008" select="marc:controlfield[@tag=008]"/>
 <xsl:variable name="typeOf008">
 <xsl:choose>
 <xsl:when test="$leader19='a'">IVA</xsl:when>
 <xsl:when test="$leader6='a'">
 <xsl:choose>
 <xsl:when test="$leader7='a' or $leader7='c' or $leader7='d' or $leader7='m'">BK</xsl:when>
 <xsl:when test="$leader7='b' or $leader7='i' or $leader7='s'">CR</xsl:when>
 </xsl:choose>
 </xsl:when>
 <xsl:when test="$leader6='t'">BK</xsl:when>
 <xsl:when test="$leader6='o' or $leader6='p'">MX</xsl:when>
 <xsl:when test="$leader6='m'">CF</xsl:when>
 <xsl:when test="$leader6='e' or $leader6='f'">MP</xsl:when>
 <xsl:when test="$leader6='g' or $leader6='k' or $leader6='r'">VM</xsl:when>
 <xsl:when test="$leader6='i' or $leader6='j'">MU</xsl:when>
 <xsl:when test="$leader6='c' or $leader6='d'">PR</xsl:when>
 </xsl:choose>
 </xsl:variable>
 <xsl:variable name="controlField008-23" select="substring($controlField008,24,1)"/>
 <xsl:variable name="controlField008-21" select="substring($controlField008,22,1)"/>
 <xsl:variable name="controlField008-22" select="substring($controlField008,23,1)"/>
 <xsl:variable name="controlField008-24" select="substring($controlField008,25,4)"/>
 <xsl:variable name="controlField008-26" select="substring($controlField008,27,1)"/>
 <xsl:variable name="controlField008-29" select="substring($controlField008,30,1)"/>
 <xsl:variable name="controlField008-34" select="substring($controlField008,35,1)"/>
 <xsl:variable name="controlField008-33" select="substring($controlField008,34,1)"/>
 <xsl:variable name="controlField008-30-31" select="substring($controlField008,31,2)"/>

 <xsl:variable name="physicalDescription">
 <xsl:if test="$typeOf008='CF' and marc:controlfield[@tag=007][substring(.,12,1)='a']">
 reformateado digital</xsl:if>
 <xsl:if test="$typeOf008='CF' and marc:controlfield[@tag=007][substring(.,12,1)='b']">
 microfilm digitalizado</xsl:if>
 <xsl:if test="$typeOf008='CF' and marc:controlfield[@tag=007][substring(.,12,1)='d']">
 otro análogo digitalizado</xsl:if>

 <xsl:variable name="check008-23">
 <xsl:if test="$typeOf008='BK' or $typeOf008='MU' or $typeOf008='CR' or $typeOf008='MX'">
 <xsl:value-of select="true()"></xsl:value-of>
 </xsl:if>
 </xsl:variable>
 <xsl:variable name="check008-29">
 <xsl:if test="$typeOf008='MP' or $typeOf008='VM'">
 <xsl:value-of select="true()"></xsl:value-of>
 </xsl:if>
 </xsl:variable>
 <xsl:choose>
 <xsl:when test="($check008-23 and $controlField008-23='f') or ($check008-29 and $controlField008-29='f')">
 braille </xsl:when>
 <xsl:when test="($controlField008-23=' ' and ($leader6='c' or $leader6='d')) or (($typeOf008='BK' or $typeOf008='CR') and ($controlField008-23=' ' or $controlField008='r'))">
 imprimir</xsl:when>
 <xsl:when test="$leader6 = 'm' or ($check008-23 and $controlField008-23='s') or ($check008-29 and $controlField008-29='s')">
 electrónico</xsl:when>
 <xsl:when test="($check008-23 and $controlField008-23='b') or ($check008-29 and $controlField008-29='b')">
 microficha</xsl:when>
 <xsl:when test="($check008-23 and $controlField008-23='a') or ($check008-29 and $controlField008-29='a')">
 microfilm</xsl:when>
 </xsl:choose>

 <xsl:if test="marc:controlfield[@tag=007][substring(text(),1,1)='c'][substring(text(),2,1)='b']">
 cartucho de chip</xsl:if>
 <xsl:if test="marc:controlfield[@tag=007][substring(text(),1,1)='c'][substring(text(),2,1)='j']">
 disco magnético</xsl:if>
 <xsl:if test="marc:controlfield[@tag=007][substring(text(),1,1)='c'][substring(text(),2,1)='m']">
 disco magneto óptico</xsl:if>
 <xsl:if test="marc:controlfield[@tag=007][substring(text(),1,1)='c'][substring(text(),2,1)='r']">
 disponible en línea</xsl:if>
 <xsl:if test="marc:controlfield[@tag=007][substring(text(),1,1)='c'][substring(text(),2,1)='a']">
 cinta de cartucho</xsl:if>
 <xsl:if test="marc:controlfield[@tag=007][substring(text(),1,1)='c'][substring(text(),2,1)='f']">
 cinte de casete</xsl:if>
 <xsl:if test="marc:controlfield[@tag=007][substring(text(),1,1)='c'][substring(text(),2,1)='h']">
 bobina de cinta</xsl:if>

 <xsl:if test="marc:controlfield[@tag=007][substring(text(),1,1)='o'][substring(text(),2,1)='o']">
 equipo</xsl:if>

 <xsl:if test="marc:controlfield[@tag=007][substring(text(),1,1)='a'][substring(text(),2,1)='d']">
 atlas</xsl:if>
 <xsl:if test="marc:controlfield[@tag=007][substring(text(),1,1)='a'][substring(text(),2,1)='g']">
 diagrama</xsl:if>
 <xsl:if test="marc:controlfield[@tag=007][substring(text(),1,1)='a'][substring(text(),2,1)='j']">
 mapa</xsl:if>
 <xsl:if test="marc:controlfield[@tag=007][substring(text(),1,1)='a'][substring(text(),2,1)='q']">
 modelo</xsl:if>
 <xsl:if test="marc:controlfield[@tag=007][substring(text(),1,1)='a'][substring(text(),2,1)='k']">
 perfil</xsl:if>
 <xsl:if test="marc:controlfield[@tag=007][substring(text(),1,1)='a'][substring(text(),2,1)='r']">
 imagen de sensado remoto</xsl:if>
 <xsl:if test="marc:controlfield[@tag=007][substring(text(),1,1)='a'][substring(text(),2,1)='s']">
 sección</xsl:if>
 <xsl:if test="marc:controlfield[@tag=007][substring(text(),1,1)='a'][substring(text(),2,1)='y']">
 ver </xsl:if>

 <xsl:if test="marc:controlfield[@tag=007][substring(text(),1,1)='h'][substring(text(),2,1)='a']">
 tarjeta de apertura</xsl:if>
 <xsl:if test="marc:controlfield[@tag=007][substring(text(),1,1)='h'][substring(text(),2,1)='e']">
 microficha</xsl:if>
 <xsl:if test="marc:controlfield[@tag=007][substring(text(),1,1)='h'][substring(text(),2,1)='f']">
 microficha en casete</xsl:if>
 <xsl:if test="marc:controlfield[@tag=007][substring(text(),1,1)='h'][substring(text(),2,1)='b']">
 microfilm en cartucho</xsl:if>
 <xsl:if test="marc:controlfield[@tag=007][substring(text(),1,1)='h'][substring(text(),2,1)='c']">
 microfilm en casete</xsl:if>
 <xsl:if test="marc:controlfield[@tag=007][substring(text(),1,1)='h'][substring(text(),2,1)='d']">
 microfilm en bobina</xsl:if>
 <xsl:if test="marc:controlfield[@tag=007][substring(text(),1,1)='h'][substring(text(),2,1)='g']">
 microopaco</xsl:if>
 <xsl:if test="marc:controlfield[@tag=007][substring(text(),1,1)='m'][substring(text(),2,1)='c']">
 cartucho de película</xsl:if>
 <xsl:if test="marc:controlfield[@tag=007][substring(text(),1,1)='m'][substring(text(),2,1)='f']">
 casete de película</xsl:if>
 <xsl:if test="marc:controlfield[@tag=007][substring(text(),1,1)='m'][substring(text(),2,1)='r']">
 bobina de película</xsl:if>
 <xsl:if test="marc:controlfield[@tag=007][substring(text(),1,1)='k'][substring(text(),2,1)='c']">
 colage</xsl:if>
 <xsl:if test="marc:controlfield[@tag=007][substring(text(),1,1)='k'][substring(text(),2,1)='f']">
 reproducción fotomecánica</xsl:if>
 <xsl:if test="marc:controlfield[@tag=007][substring(text(),1,1)='k'][substring(text(),2,1)='g']">
 fotonegativo</xsl:if>
 <xsl:if test="marc:controlfield[@tag=007][substring(text(),1,1)='k'][substring(text(),2,1)='h']">
 impresión fotográfica</xsl:if>
 <xsl:if test="marc:controlfield[@tag=007][substring(text(),1,1)='k'][substring(text(),2,1)='j']">
 imprimir</xsl:if>
 <xsl:if test="marc:controlfield[@tag=007][substring(text(),1,1)='k'][substring(text(),2,1)='l']">
 dibujo técnico</xsl:if>
 <xsl:if test="marc:controlfield[@tag=007][substring(text(),1,1)='g'][substring(text(),2,1)='d']">
 película</xsl:if>
 <xsl:if test="marc:controlfield[@tag=007][substring(text(),1,1)='g'][substring(text(),2,1)='c']">
 cartucho de película</xsl:if>
 <xsl:if test="marc:controlfield[@tag=007][substring(text(),1,1)='g'][substring(text(),2,1)='o']">
 rollo de película</xsl:if>
 <xsl:if test="marc:controlfield[@tag=007][substring(text(),1,1)='g'][substring(text(),2,1)='f']">
 otro tipo de película</xsl:if>
 <xsl:if test="marc:controlfield[@tag=007][substring(text(),1,1)='g'][substring(text(),2,1)='t']">
 transparencia</xsl:if>
 <xsl:if test="marc:controlfield[@tag=007][substring(text(),1,1)='r'][substring(text(),2,1)='r']">
 imagen de sensado remoto</xsl:if>
 <xsl:if test="marc:controlfield[@tag=007][substring(text(),1,1)='s'][substring(text(),2,1)='e']">
 cilindro</xsl:if>
 <xsl:if test="marc:controlfield[@tag=007][substring(text(),1,1)='s'][substring(text(),2,1)='q']">
 rollo</xsl:if>
 <xsl:if test="marc:controlfield[@tag=007][substring(text(),1,1)='s'][substring(text(),2,1)='g']">
 cartucho de sonido</xsl:if>
 <xsl:if test="marc:controlfield[@tag=007][substring(text(),1,1)='s'][substring(text(),2,1)='s']">
 casete de sonido</xsl:if>
 <xsl:if test="marc:controlfield[@tag=007][substring(text(),1,1)='s'][substring(text(),2,1)='t']">
 bobina de cinta de sonido</xsl:if>
 <xsl:if test="marc:controlfield[@tag=007][substring(text(),1,1)='s'][substring(text(),2,1)='i']">
 pista de audio de película</xsl:if>
 <xsl:if test="marc:controlfield[@tag=007][substring(text(),1,1)='s'][substring(text(),2,1)='w']">
 grabación en cable</xsl:if>
 <xsl:if test="marc:controlfield[@tag=007][substring(text(),1,1)='f'][substring(text(),2,1)='c']">
 braille </xsl:if>
 <xsl:if test="marc:controlfield[@tag=007][substring(text(),1,1)='f'][substring(text(),2,1)='b']">
 combinación</xsl:if>
 <xsl:if test="marc:controlfield[@tag=007][substring(text(),1,1)='f'][substring(text(),2,1)='a']">
 luna</xsl:if>
 <xsl:if test="marc:controlfield[@tag=007][substring(text(),1,1)='f'][substring(text(),2,1)='d']">
 táctil, sin sistema de escritura</xsl:if>
 <xsl:if test="marc:controlfield[@tag=007][substring(text(),1,1)='t'][substring(text(),2,1)='c']">
 braille </xsl:if>
 <xsl:if test="marc:controlfield[@tag=007][substring(text(),1,1)='t'][substring(text(),2,1)='a']">
 impresión normal</xsl:if>
 <xsl:if test="marc:controlfield[@tag=007][substring(text(),1,1)='t'][substring(text(),2,1)='d']">
 texto en carpetas de hojas sueltas</xsl:if>
 <xsl:if test="marc:controlfield[@tag=007][substring(text(),1,1)='v'][substring(text(),2,1)='c']">
 cartucho de vídeo</xsl:if>
 <xsl:if test="marc:controlfield[@tag=007][substring(text(),1,1)='v'][substring(text(),2,1)='f']">
 casete de vídeo</xsl:if>
 <xsl:if test="marc:controlfield[@tag=007][substring(text(),1,1)='v'][substring(text(),2,1)='r']">
 bonina de vídeo</xsl:if>
<!--
 <xsl:for-each select="marc:datafield[@tag=856]/marc:subfield[@code='q'][string-length(.)>1]">
 <xsl:value-of select="."></xsl:value-of>
 </xsl:for-each>
 <xsl:for-each select="marc:datafield[@tag=300]">
 <xsl:call-template name="subfieldSelect">
 <xsl:with-param name="codes">abce</xsl:with-param>
 </xsl:call-template>
 </xsl:for-each>
-->
 </xsl:variable>

 <!-- Title Statement: Alternate Graphic Representation (MARC 880) -->
 <xsl:if test="$display880">
 <xsl:call-template name="m880Select">
 <xsl:with-param name="basetags">245</xsl:with-param>
 <xsl:with-param name="codes">abhfgknps</xsl:with-param>
 <xsl:with-param name="bibno"><xsl:value-of  select="$biblionumber"/></xsl:with-param>
 </xsl:call-template>
 </xsl:if>

 <a><xsl:attribute name="href">/cgi-bin/koha/catalogue/detail.pl?biblionumber=<xsl:value-of select="$biblionumber"/></xsl:attribute><xsl:attribute name="class">título</xsl:attribute>

 <xsl:if test="marc:datafield[@tag=245]">
 <xsl:for-each select="marc:datafield[@tag=245]">
 <xsl:variable name="title">
 <xsl:call-template name="subfieldSelect">
 <xsl:with-param name="codes">a</xsl:with-param>
 </xsl:call-template>
 <xsl:if test="marc:subfield[@code='b']">
 <xsl:text> </xsl:text>
 <xsl:call-template name="subfieldSelect">
 <xsl:with-param name="codes">b</xsl:with-param>
 </xsl:call-template>
 </xsl:if>
 <xsl:if test="marc:subfield[@code='h']">
 <xsl:text> [</xsl:text>
 <xsl:call-template name="subfieldSelect">
 <xsl:with-param name="codes">h</xsl:with-param>
 </xsl:call-template>
 <xsl:text>]</xsl:text>
 </xsl:if>
 <xsl:text> </xsl:text>
 <xsl:call-template name="subfieldSelect">
 <xsl:with-param name="codes">fgknps</xsl:with-param>
 </xsl:call-template>
 </xsl:variable>
 <xsl:variable name="titleChop">
 <xsl:call-template name="chopPunctuation">
 <xsl:with-param name="chopString">
 <xsl:value-of select="$title"/>
 </xsl:with-param>
 </xsl:call-template>
 </xsl:variable>
 <xsl:value-of select="$titleChop"/>
 </xsl:for-each>
 </xsl:if>
 </a>

 <!-- Author Statement: Alternate Graphic Representation (MARC 880) -->
 <xsl:if test="$display880">
 <xsl:call-template name="m880Select">
 <xsl:with-param name="basetags">100,110,111,700,710,711</xsl:with-param>
 <xsl:with-param name="codes">abc</xsl:with-param>
 </xsl:call-template>
 </xsl:if>

 <xsl:choose>
 <xsl:when test="marc:datafield[@tag=100] or marc:datafield[@tag=110] or marc:datafield[@tag=111] or marc:datafield[@tag=700] or marc:datafield[@tag=710] or marc:datafield[@tag=711]">
 <p class="author">por <xsl:for-each select="marc:datafield[(@tag=100 or @tag=700) and @ind1!='z']">
 <a>
 <xsl:choose>
 <xsl:when test="marc:subfield[@code=9] and $UseAuthoritiesForTracings='1'">
 <xsl:attribute name="href">/cgi-bin/koha/catalogue/search.pl?q=an:<xsl:value-of select="marc:subfield[@code=9]"/></xsl:attribute>
 </xsl:when>
 <xsl:otherwise>
 <xsl:attribute name="href">/cgi-bin/koha/catalogue/search.pl?q=au:"<xsl:value-of select="marc:subfield[@code='a']"/>"</xsl:attribute>
 </xsl:otherwise>
 </xsl:choose>
 <xsl:call-template name="nameABCDQ"/></a>
 <xsl:choose>
 <xsl:when test="position()=last()"><xsl:text>. </xsl:text></xsl:when><xsl:otherwise><xsl:text>; </xsl:text></xsl:otherwise></xsl:choose>
 </xsl:for-each>

 <xsl:for-each select="marc:datafield[(@tag=110 or @tag=710) and @ind1!='z']">
 <a>
 <xsl:choose>
 <xsl:when test="marc:subfield[@code=9] and $UseAuthoritiesForTracings='1'">
 <xsl:attribute name="href">/cgi-bin/koha/catalogue/search.pl?q=an:<xsl:value-of select="marc:subfield[@code=9]"/></xsl:attribute>
 </xsl:when>
 <xsl:otherwise>
 <xsl:attribute name="href">/cgi-bin/koha/catalogue/search.pl?q=au:"<xsl:value-of select="marc:subfield[@code='a']"/>"</xsl:attribute>
 </xsl:otherwise>
 </xsl:choose>
 <xsl:call-template name="nameABCDN"/></a>
 <xsl:choose><xsl:when test="position()=last()"><xsl:text> </xsl:text></xsl:when><xsl:otherwise><xsl:text>; </xsl:text></xsl:otherwise></xsl:choose>
 </xsl:for-each>

 <xsl:for-each select="marc:datafield[(@tag=111 or @tag=711) and @ind1!='z']">
 <xsl:choose>
 <xsl:when test="marc:subfield[@code='n']">
 <xsl:text> </xsl:text>
 <xsl:call-template name="subfieldSelect">
 <xsl:with-param name="codes">n</xsl:with-param> </xsl:call-template>
 <xsl:text> </xsl:text>
 </xsl:when>
 </xsl:choose>
 <a>
 <xsl:choose>
 <xsl:when test="marc:subfield[@code=9] and $UseAuthoritiesForTracings='1'">
 <xsl:attribute name="href">/cgi-bin/koha/catalogue/search.pl?q=an:<xsl:value-of select="marc:subfield[@code=9]"/></xsl:attribute>
 </xsl:when>
 <xsl:otherwise>
 <xsl:attribute name="href">/cgi-bin/koha/catalogue/search.pl?q=au:"<xsl:value-of select="marc:subfield[@code='a']"/>"</xsl:attribute>
 </xsl:otherwise>
 </xsl:choose>
 <xsl:call-template name="nameACDEQ"/></a>
 <xsl:choose><xsl:when test="position()=last()"><xsl:text>. </xsl:text></xsl:when><xsl:otherwise><xsl:text>; </xsl:text></xsl:otherwise></xsl:choose>

 </xsl:for-each>
 </p>
 </xsl:when>
 </xsl:choose>

 <xsl:if test="marc:datafield[@tag=300]">
 <span class="results_summary description"><span class="label">Descripción: </span>
 <xsl:for-each select="marc:datafield[@tag=300]">
 <xsl:call-template name="chopPunctuation">
 <xsl:with-param name="chopString">
 <xsl:call-template name="subfieldSelect">
 <xsl:with-param name="codes">abceg</xsl:with-param>
 </xsl:call-template>
 </xsl:with-param>
 </xsl:call-template>
 <xsl:choose><xsl:when test="position()=last()"><xsl:text>.</xsl:text></xsl:when><xsl:otherwise><xsl:text>; </xsl:text></xsl:otherwise></xsl:choose>
 </xsl:for-each>
 </span>
 </xsl:if>

 <xsl:if test="marc:datafield[@tag=020]">
 <span class="results_summary isbn"><span class="label">ISBN: </span>
 <xsl:for-each select="marc:datafield[@tag=020]">
 <xsl:variable name="isbn" select="marc:subfield[@code='a']"/>
 <xsl:value-of select="marc:subfield[@code='a']"/>
 <xsl:choose><xsl:when test="position()=last()"><xsl:text>.</xsl:text></xsl:when><xsl:otherwise><xsl:text>; </xsl:text></xsl:otherwise></xsl:choose>
 </xsl:for-each>
 </span>
 </xsl:if>

 <xsl:if test="marc:datafield[@tag=022]">
 <span class="results_summary issn"><span class="label">ISSN: </span>
 <xsl:for-each select="marc:datafield[@tag=022]">
 <xsl:value-of select="marc:subfield[@code='a']"/>
 <xsl:choose><xsl:when test="position()=last()"><xsl:text>.</xsl:text></xsl:when><xsl:otherwise><xsl:text>; </xsl:text></xsl:otherwise></xsl:choose>
 </xsl:for-each>
 </span>
 </xsl:if>

 <xsl:if test="marc:datafield[@tag=250]">
 <span class="results_summary">
 <span class="label">Edición: </span>
 <xsl:for-each select="marc:datafield[@tag=250]">
 <xsl:call-template name="subfieldSelect">
 <xsl:with-param name="codes">ab</xsl:with-param>
 </xsl:call-template>
 </xsl:for-each>
 </span>
 </xsl:if>

 <xsl:if test="marc:datafield[@tag=773]">
 <xsl:for-each select="marc:datafield[@tag=773]">
 <xsl:if test="marc:subfield[@code='t']">
 <span class="results_summary">
 <span class="label">Fuente: </span>
 <xsl:value-of select="marc:subfield[@code='t']"/>
 </span>
 </xsl:if>
 </xsl:for-each>
 </xsl:if>

 <span class="results_summary">
 <xsl:if test="$typeOf008!=''">
 <span class="label">Tipo: </span>
 <xsl:choose>
 <xsl:when test="$leader19='a'"> Establecer</xsl:when>
 <xsl:when test="$leader6='a'">
 <xsl:choose>
 <xsl:when test="$leader7='c' or $leader7='d' or $leader7='m'"> Libro</xsl:when>
 <xsl:when test="$leader7='i' or $leader7='s'"> Recursos continuados</xsl:when>
 <xsl:when test="$leader7='a' or $leader7='b'"> Artículo</xsl:when>
 </xsl:choose>
 </xsl:when>
 <xsl:when test="$leader6='t'"> Libro</xsl:when>
 <xsl:when test="$leader6='o'"> Equipo</xsl:when>
 <xsl:when test="$leader6='p'"> Materiales mixtos</xsl:when>
 <xsl:when test="$leader6='m'"> Archivo electrónico</xsl:when>
 <xsl:when test="$leader6='e' or $leader6='f'"> Mapa</xsl:when>
 <xsl:when test="$leader6='g' or $leader6='k' or $leader6='r'"> Material visual</xsl:when>
 <xsl:when test="$leader6='c' or $leader6='d'"> Partitura</xsl:when>
 <xsl:when test="$leader6='i'"> Sonido</xsl:when>
 <xsl:when test="$leader6='j'"> Música</xsl:when>
 </xsl:choose>
 </xsl:if>
 <xsl:if test="string-length(normalize-space($physicalDescription))">
 <span class="label">; Formato: </span><xsl:copy-of select="$physicalDescription"></xsl:copy-of>
 </xsl:if>

 <xsl:if test="$controlField008-21 or $controlField008-22 or $controlField008-24 or $controlField008-26 or $controlField008-29 or $controlField008-34 or $controlField008-33 or $controlField008-30-31 or $controlField008-33">

 <xsl:if test="$typeOf008='CR'">
 <xsl:if test="$controlField008-21 and $controlField008-21 !='|' and $controlField008-21 !=' '">
 <span class="label">; Tipo de descriptor de recurso continuo: </span>
 </xsl:if>
 <xsl:choose>
 <xsl:when test="$controlField008-21='l'">
 hojas sueltas</xsl:when>
 <xsl:when test="$controlField008-21='m'">
 series</xsl:when>
 <xsl:when test="$controlField008-21='n'">
 periódico</xsl:when>
 <xsl:when test="$controlField008-21='p'">
 periódico</xsl:when>
 </xsl:choose>
 </xsl:if>
 <xsl:if test="$typeOf008='BK' or $typeOf008='CR'">
 <xsl:if test="contains($controlField008-24,'abcdefghijklmnopqrstvwxyz')">
 <span class="label">; Naturaleza de los contenidos: </span>
 </xsl:if>
 <xsl:choose>
 <xsl:when test="contains($controlField008-24,'a')">
 extracto o resumen</xsl:when>
 <xsl:when test="contains($controlField008-24,'b')">
 bibliografía</xsl:when>
 <xsl:when test="contains($controlField008-24,'c')">
 catálogo</xsl:when>
 <xsl:when test="contains($controlField008-24,'d')">
 diccionario</xsl:when>
 <xsl:when test="contains($controlField008-24,'e')">
 enciclopedia</xsl:when>
 <xsl:when test="contains($controlField008-24,'f')">
 manual</xsl:when>
 <xsl:when test="contains($controlField008-24,'g')">
 artículo jurídico</xsl:when>
 <xsl:when test="contains($controlField008-24,'i')">
 índice</xsl:when>
 <xsl:when test="contains($controlField008-24,'k')">
 discografía</xsl:when>
 <xsl:when test="contains($controlField008-24,'l')">
 legislación</xsl:when>
 <xsl:when test="contains($controlField008-24,'m')">
 tesinas</xsl:when>
 <xsl:when test="contains($controlField008-24,'n')">
 revisión de literatura</xsl:when>
 <xsl:when test="contains($controlField008-24,'o')">
 revisión</xsl:when>
 <xsl:when test="contains($controlField008-24,'p')">
 texto programado</xsl:when>
 <xsl:when test="contains($controlField008-24,'q')">
 filmografía</xsl:when>
 <xsl:when test="contains($controlField008-24,'r')">
 directorio</xsl:when>
 <xsl:when test="contains($controlField008-24,'s')">
 estadísticas</xsl:when>
 <xsl:when test="contains($controlField008-24,'v')">
 caso jurídicos y notas del caso</xsl:when>
 <xsl:when test="contains($controlField008-24,'w')">
 informe legal o digesto</xsl:when>
 <xsl:when test="contains($controlField008-24,'z')">
 tratado</xsl:when>
 </xsl:choose>
 <xsl:choose>
 <xsl:when test="$controlField008-29='1'">
 publicación de conferencia</xsl:when>
 </xsl:choose>
 </xsl:if>
 <xsl:if test="$typeOf008='CF'">
 <xsl:if test="$controlField008-26='a' or $controlField008-26='e' or $controlField008-26='f' or $controlField008-26='g'">
 <span class="label">; Tipo de archivo de computadora: </span>
 </xsl:if>
 <xsl:choose>
 <xsl:when test="$controlField008-26='a'">
 datos numéricos</xsl:when>
 </xsl:choose>
 </xsl:if>
 <xsl:if test="$typeOf008='BK'">
 <xsl:if test="(substring($controlField008,25,1)='j') or (substring($controlField008,25,1)='1') or ($controlField008-34='a' or $controlField008-34='b' or $controlField008-34='c' or $controlField008-34='d')">
 <span class="label">; Naturaleza de los contenidos: </span>
 </xsl:if>
 <xsl:if test="substring($controlField008,25,1)='j'">
 patente</xsl:if>
 <xsl:if test="substring($controlField008,31,1)='1'">
 festschrift</xsl:if>

 <xsl:if test="$controlField008-33 and $controlField008-33!='|' and $controlField008-33!='u' and $controlField008-33!=' '">
 <span class="label">; Forma literaria: </span>
 </xsl:if>
 <xsl:choose>
 <xsl:when test="$controlField008-33='0'">
 no ficción</xsl:when>
 <xsl:when test="$controlField008-33='1'">
 ficción</xsl:when>
 <xsl:when test="$controlField008-33='e'">
 ensayo</xsl:when>
 <xsl:when test="$controlField008-33='d'">
 drama</xsl:when>
 <xsl:when test="$controlField008-33='c'">
 tira cómica</xsl:when>
 <xsl:when test="$controlField008-33='l'">
 ficción</xsl:when>
 <xsl:when test="$controlField008-33='h'">
 humor, sátira</xsl:when>
 <xsl:when test="$controlField008-33='i'">
 carta</xsl:when>
 <xsl:when test="$controlField008-33='f'">
 novela</xsl:when>
 <xsl:when test="$controlField008-33='j'">
 historia corta</xsl:when>
 <xsl:when test="$controlField008-33='s'">
 discurso</xsl:when>
 </xsl:choose>
 </xsl:if>
 <xsl:if test="$typeOf008='MU' and $controlField008-30-31 and $controlField008-30-31!='||' and $controlField008-30-31!='  '">
 <span class="label">; Forma literaria: </span> <!-- Literary text for sound recordings -->
 <xsl:if test="contains($controlField008-30-31,'b')">
 biografía</xsl:if>
 <xsl:if test="contains($controlField008-30-31,'c')">
 publicación de conferencia</xsl:if>
 <xsl:if test="contains($controlField008-30-31,'d')">
 drama</xsl:if>
 <xsl:if test="contains($controlField008-30-31,'e')">
 ensayo</xsl:if>
 <xsl:if test="contains($controlField008-30-31,'f')">
 ficción</xsl:if>
 <xsl:if test="contains($controlField008-30-31,'o')">
 cuento popular</xsl:if>
 <xsl:if test="contains($controlField008-30-31,'h')">
 historia</xsl:if>
 <xsl:if test="contains($controlField008-30-31,'k')">
 humor, sátira</xsl:if>
 <xsl:if test="contains($controlField008-30-31,'m')">
 memoria</xsl:if>
 <xsl:if test="contains($controlField008-30-31,'p')">
 poesía</xsl:if>
 <xsl:if test="contains($controlField008-30-31,'r')">
 ensayo</xsl:if>
 <xsl:if test="contains($controlField008-30-31,'g')">
 informando</xsl:if>
 <xsl:if test="contains($controlField008-30-31,'s')">
 sonido</xsl:if>
 <xsl:if test="contains($controlField008-30-31,'l')">
 discurso</xsl:if>
 </xsl:if>
 <xsl:if test="$typeOf008='VM'">
 <span class="label">; Tipo de material visual: </span>
 <xsl:choose>
 <xsl:when test="$controlField008-33='a'">
 arte original</xsl:when>
 <xsl:when test="$controlField008-33='b'">
 equipo</xsl:when>
 <xsl:when test="$controlField008-33='c'">
 reproducción de arte</xsl:when>
 <xsl:when test="$controlField008-33='d'">
 diorama</xsl:when>
 <xsl:when test="$controlField008-33='f'">
 película</xsl:when>
 <xsl:when test="$controlField008-33='g'">
 artículo jurídico</xsl:when>
 <xsl:when test="$controlField008-33='i'">
 pintura</xsl:when>
 <xsl:when test="$controlField008-33='k'">
 gráfico</xsl:when>
 <xsl:when test="$controlField008-33='l'">
 dibujo técnico</xsl:when>
 <xsl:when test="$controlField008-33='m'">
 película de cine</xsl:when>
 <xsl:when test="$controlField008-33='n'">
 mapa</xsl:when>
 <xsl:when test="$controlField008-33='o'">
 tarjeta flash</xsl:when>
 <xsl:when test="$controlField008-33='p'">
 platina de microscopio</xsl:when>
 <xsl:when test="$controlField008-33='q' or marc:controlfield[@tag=007][substring(text(),1,1)='a'][substring(text(),2
,1)='q']">
 modelo</xsl:when>
 <xsl:when test="$controlField008-33='r'">
 realia</xsl:when>
 <xsl:when test="$controlField008-33='s'">
 filmina</xsl:when>
 <xsl:when test="$controlField008-33='t'">
 transparencia</xsl:when>
 <xsl:when test="$controlField008-33='v'">
 grabación de vídeo</xsl:when>
 <xsl:when test="$controlField008-33='w'">
 juguete </xsl:when>
 </xsl:choose>
 </xsl:if>
 </xsl:if>

 <xsl:if test="($typeOf008='BK' or $typeOf008='CF' or $typeOf008='MU' or $typeOf008='VM') and ($controlField008-22='a' or $controlField008-22='b' or $controlField008-22='c' or $controlField008-22='d' or $controlField008-22='e' or $controlField008-22='g' or $controlField008-22='j' or $controlField008-22='f')">
 <span class="label">; Audiencia: </span>
 <xsl:choose>
 <xsl:when test="$controlField008-22='a'">
 Pre-escolar; </xsl:when>
 <xsl:when test="$controlField008-22='b'">
 Primary; </xsl:when>
 <xsl:when test="$controlField008-22='c'">
 Pre-adolescente;</xsl:when>
 <xsl:when test="$controlField008-22='d'">
 Adolescente; </xsl:when>
 <xsl:when test="$controlField008-22='e'">
 Adulto; </xsl:when>
 <xsl:when test="$controlField008-22='g'">
 General; </xsl:when>
 <xsl:when test="$controlField008-22='j'">
 Juvenil; </xsl:when>
 <xsl:when test="$controlField008-22='f'">
 Especializado;</xsl:when>
 </xsl:choose>
 </xsl:if>
<xsl:text> </xsl:text> <!-- added blank space to fix font display problem, see Bug 3671 -->
 </span>

 <!-- Publisher Statement: Alternate Graphic Representation (MARC 880) -->
 <xsl:if test="$display880">
 <xsl:call-template name="m880Select">
 <xsl:with-param name="basetags">260</xsl:with-param>
 <xsl:with-param name="codes">abcg</xsl:with-param>
 <xsl:with-param name="class">results_summary</xsl:with-param>
 <xsl:with-param name="label">Editor: </xsl:with-param>
 </xsl:call-template>
 </xsl:if>

 <xsl:if test="marc:datafield[@tag=260]">
 <span class="results_summary publisher"><span class="label">Editor: </span>
 <xsl:for-each select="marc:datafield[@tag=260]">
 <xsl:if test="marc:subfield[@code='a']">
 <xsl:call-template name="subfieldSelect">
 <xsl:with-param name="codes">a</xsl:with-param>
 </xsl:call-template>
 </xsl:if>
 <xsl:text> </xsl:text>
 <xsl:if test="marc:subfield[@code='b']">
 <xsl:call-template name="subfieldSelect">
 <xsl:with-param name="codes">b</xsl:with-param>
 </xsl:call-template>
 </xsl:if>
 <xsl:text> </xsl:text>
 <xsl:call-template name="chopPunctuation">
 <xsl:with-param name="chopString">
 <xsl:call-template name="subfieldSelect">
 <xsl:with-param name="codes">cg</xsl:with-param>
 </xsl:call-template>
 </xsl:with-param>
 </xsl:call-template>
 <xsl:choose><xsl:when test="position()=last()"><xsl:text></xsl:text></xsl:when><xsl:otherwise><xsl:text>; </xsl:text></xsl:otherwise></xsl:choose>
 </xsl:for-each>
 </span>
 </xsl:if>

 <!-- Other Title Statement: Alternate Graphic Representation (MARC 880) -->
 <xsl:if test="$display880">
 <xsl:call-template name="m880Select">
 <xsl:with-param name="basetags">246</xsl:with-param>
 <xsl:with-param name="codes">ab</xsl:with-param>
 <xsl:with-param name="class">results_summary</xsl:with-param>
 <xsl:with-param name="label">Otro título: </xsl:with-param>
 </xsl:call-template>
 </xsl:if>

 <xsl:if test="marc:datafield[@tag=246]">
 <span class="results_summary">
 <span class="label">Otro título: </span>
 <xsl:for-each select="marc:datafield[@tag=246]">
 <xsl:call-template name="subfieldSelect">
 <xsl:with-param name="codes">ab</xsl:with-param>
 </xsl:call-template>
 <xsl:choose><xsl:when test="position()=last()"><xsl:text>.</xsl:text></xsl:when><xsl:otherwise><xsl:text>; </xsl:text></xsl:otherwise></xsl:choose>
 </xsl:for-each>
 </span>
 </xsl:if>
 <xsl:if test="marc:datafield[@tag=856]">
 <span class="results_summary">
 <span class="label">Acceso en línea: </span>
 <xsl:for-each select="marc:datafield[@tag=856]">
 <xsl:variable name="SubqText"><xsl:value-of select="marc:subfield[@code='q']"/></xsl:variable>
 <a><xsl:attribute name="href"><xsl:value-of select="marc:subfield[@code='u']"/></xsl:attribute>
 <xsl:choose>
 <xsl:when test="($Show856uAsImage='Results' or $Show856uAsImage='Both') and (substring($SubqText,1,6)='image/' or $SubqText='img' or $SubqText='bmp' or $SubqText='cod' or $SubqText='gif' or $SubqText='ief' or $SubqText='jpe' or $SubqText='jpeg' or $SubqText='jpg' or $SubqText='jfif' or $SubqText='png' or $SubqText='svg' or $SubqText='tif' or $SubqText='tiff' or $SubqText='ras' or $SubqText='cmx' or $SubqText='ico' or $SubqText='pnm' or $SubqText='pbm' or $SubqText='pgm' or $SubqText='ppm' or $SubqText='rgb' or $SubqText='xbm' or $SubqText='xpm' or $SubqText='xwd')">
 <xsl:element name="img"><xsl:attribute name="src"><xsl:value-of select="marc:subfield[@code='u']"/></xsl:attribute><xsl:attribute name="alt"><xsl:value-of select="marc:subfield[@code='y']"/></xsl:attribute><xsl:attribute name="height">100</xsl:attribute></xsl:element><xsl:text></xsl:text>
 </xsl:when>
 <xsl:when test="marc:subfield[@code='y' or @code='3' or @code='z']">
 <xsl:call-template name="subfieldSelect">
 <xsl:with-param name="codes">y3z</xsl:with-param>
 </xsl:call-template>
 </xsl:when>
 <xsl:when test="not(marc:subfield[@code='y']) and not(marc:subfield[@code='3']) and not(marc:subfield[@code='z'])">
 <xsl:choose>
 <xsl:when test="$URLLinkText!=''">
 <xsl:value-of select="$URLLinkText"/>
 </xsl:when>
 <xsl:otherwise>
 <xsl:text>Haga clic para acceso en línea</xsl:text>
 </xsl:otherwise>
 </xsl:choose>
 </xsl:when>
 </xsl:choose>
 </a>
 <xsl:choose>
 <xsl:when test="position()=last()"><xsl:text> </xsl:text></xsl:when>
 <xsl:otherwise> | </xsl:otherwise>
 </xsl:choose>
 </xsl:for-each>
 </span>
 </xsl:if>
 </xsl:template>

 <xsl:template name="nameABCDQ">
 <xsl:call-template name="chopPunctuation">
 <xsl:with-param name="chopString">
 <xsl:call-template name="subfieldSelect">
 <xsl:with-param name="codes">aq</xsl:with-param>
 </xsl:call-template>
 </xsl:with-param>
 <xsl:with-param name="punctuation">
 <xsl:text>:,;/ </xsl:text>
 </xsl:with-param>
 </xsl:call-template>
 <xsl:call-template name="termsOfAddress"/>
 </xsl:template>

 <xsl:template name="nameABCDN">
 <xsl:for-each select="marc:subfield[@code='a']">
 <xsl:call-template name="chopPunctuation">
 <xsl:with-param name="chopString" select="."/>
 </xsl:call-template>
 </xsl:for-each>
 <xsl:for-each select="marc:subfield[@code='b']">
 <xsl:value-of select="."/>
 </xsl:for-each>
 <xsl:if test="marc:subfield[@code='c'] or marc:subfield[@code='d'] or marc:subfield[@code='n']">
 <xsl:call-template name="subfieldSelect">
 <xsl:with-param name="codes">cdn</xsl:with-param>
 </xsl:call-template>
 </xsl:if>
 </xsl:template>

 <xsl:template name="nameACDEQ">
 <xsl:call-template name="subfieldSelect">
 <xsl:with-param name="codes">acdeq</xsl:with-param>
 </xsl:call-template>
 </xsl:template>

 <xsl:template name="termsOfAddress">
 <xsl:if test="marc:subfield[@code='b' or @code='c']">
 <xsl:call-template name="chopPunctuation">
 <xsl:with-param name="chopString">
 <xsl:call-template name="subfieldSelect">
 <xsl:with-param name="codes">bc</xsl:with-param>
 </xsl:call-template>
 </xsl:with-param>
 </xsl:call-template>
 </xsl:if>
 </xsl:template>

 <xsl:template name="nameDate">
 <xsl:for-each select="marc:subfield[@code='d']">
 <xsl:call-template name="chopPunctuation">
 <xsl:with-param name="chopString" select="."/>
 </xsl:call-template>
 </xsl:for-each>
 </xsl:template>

 <xsl:template name="role">
 <xsl:for-each select="marc:subfield[@code='e']">
 <xsl:value-of select="."/>
 </xsl:for-each>
 <xsl:for-each select="marc:subfield[@code='4']">
 <xsl:value-of select="."/>
 </xsl:for-each>
 </xsl:template>

 <xsl:template name="specialSubfieldSelect">
 <xsl:param name="anyCodes"/>
 <xsl:param name="axis"/>
 <xsl:param name="beforeCodes"/>
 <xsl:param name="afterCodes"/>
 <xsl:variable name="str">
 <xsl:for-each select="marc:subfield">
 <xsl:if test="contains($anyCodes, @code) or (contains($beforeCodes,@code) and following-sibling::marc:subfield[@code=$axis]) or (contains($afterCodes,@code) and preceding-sibling::marc:subfield[@code=$axis])">
 <xsl:value-of select="text()"/>
 <xsl:text> </xsl:text>
 </xsl:if>
 </xsl:for-each>
 </xsl:variable>
 <xsl:value-of select="substring($str,1,string-length($str)-1)"/>
 </xsl:template>

 <xsl:template name="subtitle">
 <xsl:if test="marc:subfield[@code='b']">
 <xsl:call-template name="chopPunctuation">
 <xsl:with-param name="chopString">
 <xsl:value-of select="marc:subfield[@code='b']"/>

 <!--<xsl:call-template name="subfieldSelect">
 <xsl:with-param name="codes">b</xsl:with-param>
 </xsl:call-template>-->
 </xsl:with-param>
 </xsl:call-template>
 </xsl:if>
 </xsl:template>

 <xsl:template name="chopBrackets">
 <xsl:param name="chopString"></xsl:param>
 <xsl:variable name="string">
 <xsl:call-template name="chopPunctuation">
 <xsl:with-param name="chopString" select="$chopString"></xsl:with-param>
 </xsl:call-template>
 </xsl:variable>
 <xsl:if test="substring($string, 1,1)='['">
 <xsl:value-of select="substring($string,2, string-length($string)-2)"></xsl:value-of>
 </xsl:if>
 <xsl:if test="substring($string, 1,1)!='['">
 <xsl:value-of select="$string"></xsl:value-of>
 </xsl:if>
 </xsl:template>

</xsl:stylesheet>
