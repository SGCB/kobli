
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
<xsl:variable name="DisplayOPACiconsXSLT" select="marc:sysprefs/marc:syspref[@name='DisplayOPACiconsXSLT']"/>
<xsl:variable name="OPACURLOpenInNewWindow" select="marc:sysprefs/marc:syspref[@name='OPACURLOpenInNewWindow']"/>
<xsl:variable name="URLLinkText" select="marc:sysprefs/marc:syspref[@name='URLLinkText']"/>
<xsl:variable name="Show856uAsImage" select="marc:sysprefs/marc:syspref[@name='OPACDisplay856uAsImage']"/>
<xsl:variable name="AlternateHoldingsField" select="substring(marc:sysprefs/marc:syspref[@name='AlternateHoldingsField'], 1, 3)"/>
<xsl:variable name="AlternateHoldingsSubfields" select="substring(marc:sysprefs/marc:syspref[@name='AlternateHoldingsField'], 4)"/>
<xsl:variable name="AlternateHoldingsSeparator" select="marc:sysprefs/marc:syspref[@name='AlternateHoldingsSeparator']"/>
<xsl:variable name="OPACItemLocation" select="marc:sysprefs/marc:syspref[@name='OPACItemLocation']"/>
<xsl:variable name="singleBranchMode" select="marc:sysprefs/marc:syspref[@name='singleBranchMode']"/>
 <xsl:variable name="OPACTrackClicks" select="marc:sysprefs/marc:syspref[@name='TrackClicks']"/>
 <xsl:variable name="BiblioItemtypeImage" select="marc:sysprefs/marc:syspref[@name='BiblioItemtypeImage']"/>
 <xsl:variable name="leader" select="marc:leader"/>
 <xsl:variable name="leader6" select="substring($leader,7,1)"/>
 <xsl:variable name="leader7" select="substring($leader,8,1)"/>
 <xsl:variable name="leader19" select="substring($leader,20,1)"/>
 <xsl:variable name="biblionumber" select="marc:datafield[@tag=999]/marc:subfield[@code='c']"/>
 <xsl:variable name="isbn" select="marc:datafield[@tag=020]/marc:subfield[@code='a']"/>
 <xsl:variable name="controlField008" select="marc:controlfield[@tag=008]"/>
 <xsl:variable name="typeOf008">
 <xsl:choose>
 <xsl:when test="$leader19='a'">ST</xsl:when>
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
 digital reformateado </xsl:if>
 <xsl:if test="$typeOf008='CF' and marc:controlfield[@tag=007][substring(.,12,1)='b']">
 microfilme digitalizado </xsl:if>
 <xsl:if test="$typeOf008='CF' and marc:controlfield[@tag=007][substring(.,12,1)='d']">
 otros analógicos digitalizados </xsl:if>

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
 impreso</xsl:when>
 <xsl:when test="$leader6 = 'm' or ($check008-23 and $controlField008-23='s') or ($check008-29 and $controlField008-29='s')">
 electrónico </xsl:when>
 <xsl:when test="($check008-23 and $controlField008-23='b') or ($check008-29 and $controlField008-29='b')">
 microficha </xsl:when>
 <xsl:when test="($check008-23 and $controlField008-23='a') or ($check008-29 and $controlField008-29='a')">
 microfilme </xsl:when>
 </xsl:choose>
<!--
 <xsl:if test="marc:datafield[@tag=130]/marc:subfield[@code='h']">
 <xsl:call-template name="chopBrackets">
 <xsl:with-param name="chopString">
 <xsl:value-of select="marc:datafield[@tag=130]/marc:subfield[@code='h']"></xsl:value-of>
 </xsl:with-param>
 </xsl:call-template>
 </xsl:if>
 <xsl:if test="marc:datafield[@tag=240]/marc:subfield[@code='h']">
 <xsl:call-template name="chopBrackets">
 <xsl:with-param name="chopString">
 <xsl:value-of select="marc:datafield[@tag=240]/marc:subfield[@code='h']"></xsl:value-of>
 </xsl:with-param>
 </xsl:call-template>
 </xsl:if>
 <xsl:if test="marc:datafield[@tag=242]/marc:subfield[@code='h']">
 <xsl:call-template name="chopBrackets">
 <xsl:with-param name="chopString">
 <xsl:value-of select="marc:datafield[@tag=242]/marc:subfield[@code='h']"></xsl:value-of>
 </xsl:with-param>
 </xsl:call-template>
 </xsl:if>
 <xsl:if test="marc:datafield[@tag=245]/marc:subfield[@code='h']">
 <xsl:call-template name="chopBrackets">
 <xsl:with-param name="chopString">
 <xsl:value-of select="marc:datafield[@tag=245]/marc:subfield[@code='h']"></xsl:value-of>
 </xsl:with-param>
 </xsl:call-template>
 </xsl:if>
 <xsl:if test="marc:datafield[@tag=246]/marc:subfield[@code='h']">
 <xsl:call-template name="chopBrackets">
 <xsl:with-param name="chopString">
 <xsl:value-of select="marc:datafield[@tag=246]/marc:subfield[@code='h']"></xsl:value-of>
 </xsl:with-param>
 </xsl:call-template>
 </xsl:if>
 <xsl:if test="marc:datafield[@tag=730]/marc:subfield[@code='h']">
 <xsl:call-template name="chopBrackets">
 <xsl:with-param name="chopString">
 <xsl:value-of select="marc:datafield[@tag=730]/marc:subfield[@code='h']"></xsl:value-of>
 </xsl:with-param>
 </xsl:call-template>
 </xsl:if>
 <xsl:for-each select="marc:datafield[@tag=256]/marc:subfield[@code='a']">
 <xsl:value-of select="."></xsl:value-of>
 </xsl:for-each>
 <xsl:for-each select="marc:controlfield[@tag=007][substring(text(),1,1)='c']">
 <xsl:choose>
 <xsl:when test="substring(text(),14,1)='a'">
 access
 </xsl:when>
 <xsl:when test="substring(text(),14,1)='p'">
 preservation
 </xsl:when>
 <xsl:when test="substring(text(),14,1)='r'">
 replacement
 </xsl:when>
 </xsl:choose>
 </xsl:for-each>
-->
 <xsl:if test="marc:controlfield[@tag=007][substring(text(),1,1)='c'][substring(text(),2,1)='b']">
 cartucho de chip</xsl:if>
 <xsl:if test="marc:controlfield[@tag=007][substring(text(),1,1)='c'][substring(text(),2,1)='c']">
 <img alt="cartucho de disco óptico del ordenador" src="/opac-tmpl/lib/famfamfam/silk/cd.png" title="cartucho de disco óptico del ordenador" class="format" />
 </xsl:if>
 <xsl:if test="marc:controlfield[@tag=007][substring(text(),1,1)='c'][substring(text(),2,1)='j']">
 disco magnético </xsl:if>
 <xsl:if test="marc:controlfield[@tag=007][substring(text(),1,1)='c'][substring(text(),2,1)='m']">
 disco magneto-óptico </xsl:if>
 <xsl:if test="marc:controlfield[@tag=007][substring(text(),1,1)='c'][substring(text(),2,1)='o']">
 <img alt="disco óptico" src="/opac-tmpl/lib/famfamfam/silk/cd.png" title="disco óptico" class="format" />
 </xsl:if>
 <xsl:if test="marc:controlfield[@tag=007][substring(text(),1,1)='c'][substring(text(),2,1)='r']">
 disponible en linea <img alt="remoto" src="/opac-tmpl/lib/famfamfam/silk/drive_web.png" title="remoto" class="format" />
 </xsl:if>
 <xsl:if test="marc:controlfield[@tag=007][substring(text(),1,1)='c'][substring(text(),2,1)='a']">
 cartucho de cinta </xsl:if>
 <xsl:if test="marc:controlfield[@tag=007][substring(text(),1,1)='c'][substring(text(),2,1)='f']">
 cassette de cinta </xsl:if>
 <xsl:if test="marc:controlfield[@tag=007][substring(text(),1,1)='c'][substring(text(),2,1)='h']">
 bobina de cinta </xsl:if>

 <xsl:if test="marc:controlfield[@tag=007][substring(text(),1,1)='d'][substring(text(),2,1)='a']">
 <img alt="globo celeste" src="/opac-tmpl/lib/famfamfam/silk/world.png" title="globo celeste" class="format" />
 </xsl:if>
 <xsl:if test="marc:controlfield[@tag=007][substring(text(),1,1)='d'][substring(text(),2,1)='e']">
 <img alt="globo terráqueo lunar" src="/opac-tmpl/lib/famfamfam/silk/world.png" title="globo terráqueo lunar" class="format" />
 </xsl:if>
 <xsl:if test="marc:controlfield[@tag=007][substring(text(),1,1)='d'][substring(text(),2,1)='b']">
 <img alt="globo planetario o lunar" src="/opac-tmpl/lib/famfamfam/silk/world.png" title="globo planetario o lunar" class="format" />
 </xsl:if>
 <xsl:if test="marc:controlfield[@tag=007][substring(text(),1,1)='d'][substring(text(),2,1)='c']">
 <img alt="globo terrestre" src="/opac-tmpl/lib/famfamfam/silk/world.png" title="globo terrestre" class="format" />
 </xsl:if>

 <xsl:if test="marc:controlfield[@tag=007][substring(text(),1,1)='o'][substring(text(),2,1)='o']">
 equipo </xsl:if>

 <xsl:if test="marc:controlfield[@tag=007][substring(text(),1,1)='a'][substring(text(),2,1)='d']">
 atlas</xsl:if>
 <xsl:if test="marc:controlfield[@tag=007][substring(text(),1,1)='a'][substring(text(),2,1)='g']">
 diagrama </xsl:if>
 <xsl:if test="marc:controlfield[@tag=007][substring(text(),1,1)='a'][substring(text(),2,1)='j']">
 mapa </xsl:if>
 <xsl:if test="marc:controlfield[@tag=007][substring(text(),1,1)='a'][substring(text(),2,1)='q']">
 modelo </xsl:if>
 <xsl:if test="marc:controlfield[@tag=007][substring(text(),1,1)='a'][substring(text(),2,1)='k']">
 perfil </xsl:if>
 <xsl:if test="marc:controlfield[@tag=007][substring(text(),1,1)='a'][substring(text(),2,1)='r']">
 imagen de sensado remoto </xsl:if>
 <xsl:if test="marc:controlfield[@tag=007][substring(text(),1,1)='a'][substring(text(),2,1)='s']">
 sección </xsl:if>
 <xsl:if test="marc:controlfield[@tag=007][substring(text(),1,1)='a'][substring(text(),2,1)='y']">
 vista </xsl:if>

 <xsl:if test="marc:controlfield[@tag=007][substring(text(),1,1)='h'][substring(text(),2,1)='a']">
 tarjeta de apertura </xsl:if>
 <xsl:if test="marc:controlfield[@tag=007][substring(text(),1,1)='h'][substring(text(),2,1)='e']">
 microficha </xsl:if>
 <xsl:if test="marc:controlfield[@tag=007][substring(text(),1,1)='h'][substring(text(),2,1)='f']">
 cassette de microficha </xsl:if>
 <xsl:if test="marc:controlfield[@tag=007][substring(text(),1,1)='h'][substring(text(),2,1)='b']">
 cartucho de microfilme </xsl:if>
 <xsl:if test="marc:controlfield[@tag=007][substring(text(),1,1)='h'][substring(text(),2,1)='c']">
 cassette de microfilme </xsl:if>
 <xsl:if test="marc:controlfield[@tag=007][substring(text(),1,1)='h'][substring(text(),2,1)='d']">
 rollo de microfilme </xsl:if>
 <xsl:if test="marc:controlfield[@tag=007][substring(text(),1,1)='h'][substring(text(),2,1)='g']">
 microopaco </xsl:if>
 <xsl:if test="marc:controlfield[@tag=007][substring(text(),1,1)='m'][substring(text(),2,1)='c']">
 cartucho de película </xsl:if>
 <xsl:if test="marc:controlfield[@tag=007][substring(text(),1,1)='m'][substring(text(),2,1)='f']">
 cassette de película </xsl:if>
 <xsl:if test="marc:controlfield[@tag=007][substring(text(),1,1)='m'][substring(text(),2,1)='r']">
 rollo de película </xsl:if>
 <xsl:if test="marc:controlfield[@tag=007][substring(text(),1,1)='k'][substring(text(),2,1)='n']">
 <img alt="mapa" src="/opac-tmpl/lib/famfamfam/silk/chart_curve.png" title="mapa" class="format" />
 </xsl:if>
 <xsl:if test="marc:controlfield[@tag=007][substring(text(),1,1)='k'][substring(text(),2,1)='c']">
 collage </xsl:if>
 <xsl:if test="marc:controlfield[@tag=007][substring(text(),1,1)='k'][substring(text(),2,1)='d']">
 <img alt="dibujo" src="/opac-tmpl/lib/famfamfam/silk/pencil.png" title="dibujo" class="format" />
 </xsl:if>
 <xsl:if test="marc:controlfield[@tag=007][substring(text(),1,1)='k'][substring(text(),2,1)='o']">
 <img alt="tarjeta flash " src="/opac-tmpl/lib/famfamfam/silk/note.png" title="tarjeta flash " class="format" />
 </xsl:if>
 <xsl:if test="marc:controlfield[@tag=007][substring(text(),1,1)='k'][substring(text(),2,1)='e']">
 <img alt="pintura" src="/opac-tmpl/lib/famfamfam/silk/paintbrush.png" title="pintura" class="format" />
 </xsl:if>
 <xsl:if test="marc:controlfield[@tag=007][substring(text(),1,1)='k'][substring(text(),2,1)='f']">
 impresión fotomecánica </xsl:if>
 <xsl:if test="marc:controlfield[@tag=007][substring(text(),1,1)='k'][substring(text(),2,1)='g']">
 negativo fotográfico </xsl:if>
 <xsl:if test="marc:controlfield[@tag=007][substring(text(),1,1)='k'][substring(text(),2,1)='h']">
 fotoimpresión </xsl:if>
 <xsl:if test="marc:controlfield[@tag=007][substring(text(),1,1)='k'][substring(text(),2,1)='i']">
 <img alt="imagen" src="/opac-tmpl/lib/famfamfam/silk/picture.png" title="imagen" class="format" />
 </xsl:if>
 <xsl:if test="marc:controlfield[@tag=007][substring(text(),1,1)='k'][substring(text(),2,1)='j']">
 impreso</xsl:if>
 <xsl:if test="marc:controlfield[@tag=007][substring(text(),1,1)='k'][substring(text(),2,1)='l']">
 dibujo técnico </xsl:if>
 <xsl:if test="marc:controlfield[@tag=007][substring(text(),1,1)='q'][substring(text(),2,1)='q']">
 <img alt="música notada" src="/opac-tmpl/lib/famfamfam/silk/script.png" title="música notada" class="format" />
 </xsl:if>
 <xsl:if test="marc:controlfield[@tag=007][substring(text(),1,1)='g'][substring(text(),2,1)='d']">
 fragmento de película </xsl:if>
 <xsl:if test="marc:controlfield[@tag=007][substring(text(),1,1)='g'][substring(text(),2,1)='c']">
 cartucho de diapositivas </xsl:if>
 <xsl:if test="marc:controlfield[@tag=007][substring(text(),1,1)='g'][substring(text(),2,1)='o']">
 rollo de diapositiva </xsl:if>
 <xsl:if test="marc:controlfield[@tag=007][substring(text(),1,1)='g'][substring(text(),2,1)='f']">
 otro tipo de película de diapositivas </xsl:if>
 <xsl:if test="marc:controlfield[@tag=007][substring(text(),1,1)='g'][substring(text(),2,1)='s']">
 <img alt="diapositiva" src="/opac-tmpl/lib/famfamfam/silk/pictures.png" title="diapositiva" class="format" />
 </xsl:if>
 <xsl:if test="marc:controlfield[@tag=007][substring(text(),1,1)='g'][substring(text(),2,1)='t']">
 transparencia </xsl:if>
 <xsl:if test="marc:controlfield[@tag=007][substring(text(),1,1)='r'][substring(text(),2,1)='r']">
 imagen de sensado remoto </xsl:if>
 <xsl:if test="marc:controlfield[@tag=007][substring(text(),1,1)='s'][substring(text(),2,1)='e']">
 cilindro </xsl:if>
 <xsl:if test="marc:controlfield[@tag=007][substring(text(),1,1)='s'][substring(text(),2,1)='q']">
 rollo </xsl:if>
 <xsl:if test="marc:controlfield[@tag=007][substring(text(),1,1)='s'][substring(text(),2,1)='g']">
 cartucho de sonido </xsl:if>
 <xsl:if test="marc:controlfield[@tag=007][substring(text(),1,1)='s'][substring(text(),2,1)='s']">
 casette de sonido </xsl:if>
 <xsl:if test="marc:controlfield[@tag=007][substring(text(),1,1)='s'][substring(text(),2,1)='d']">
 <img alt="disco de sonido" src="/opac-tmpl/lib/famfamfam/silk/cd.png" title="disco de sonido" class="format" />
 </xsl:if>
 <xsl:if test="marc:controlfield[@tag=007][substring(text(),1,1)='s'][substring(text(),2,1)='t']">
 bobina de cinta de sonido </xsl:if>
 <xsl:if test="marc:controlfield[@tag=007][substring(text(),1,1)='s'][substring(text(),2,1)='i']">
 banda sonora de película </xsl:if>
 <xsl:if test="marc:controlfield[@tag=007][substring(text(),1,1)='s'][substring(text(),2,1)='w']">
 grabación magnética</xsl:if>
 <xsl:if test="marc:controlfield[@tag=007][substring(text(),1,1)='f'][substring(text(),2,1)='c']">
 braille </xsl:if>
 <xsl:if test="marc:controlfield[@tag=007][substring(text(),1,1)='f'][substring(text(),2,1)='b']">
 combinación </xsl:if>
 <xsl:if test="marc:controlfield[@tag=007][substring(text(),1,1)='f'][substring(text(),2,1)='a']">
 luna </xsl:if>
 <xsl:if test="marc:controlfield[@tag=007][substring(text(),1,1)='f'][substring(text(),2,1)='d']">
 táctil, sin sistema de escritura </xsl:if>
 <xsl:if test="marc:controlfield[@tag=007][substring(text(),1,1)='t'][substring(text(),2,1)='c']">
 braille </xsl:if>
 <xsl:if test="marc:controlfield[@tag=007][substring(text(),1,1)='t'][substring(text(),2,1)='b']">
 <img alt="impresión grande" src="/opac-tmpl/lib/famfamfam/silk/magnifier.png" title="impresión grande" class="format" />
 </xsl:if>
 <xsl:if test="marc:controlfield[@tag=007][substring(text(),1,1)='t'][substring(text(),2,1)='a']">
 impresión regular </xsl:if>
 <xsl:if test="marc:controlfield[@tag=007][substring(text(),1,1)='t'][substring(text(),2,1)='d']">
 texto en carpeta anillada </xsl:if>
 <xsl:if test="marc:controlfield[@tag=007][substring(text(),1,1)='v'][substring(text(),2,1)='c']">
 cartucho de vídeo </xsl:if>
 <xsl:if test="marc:controlfield[@tag=007][substring(text(),1,1)='v'][substring(text(),2,1)='f']">
 videocassette </xsl:if>
 <xsl:if test="marc:controlfield[@tag=007][substring(text(),1,1)='v'][substring(text(),2,1)='d']">
 <img alt="videodisco" src="/opac-tmpl/lib/famfamfam/silk/dvd.png" title="videodisco" class="format" />
 </xsl:if>
 <xsl:if test="marc:controlfield[@tag=007][substring(text(),1,1)='v'][substring(text(),2,1)='r']">
 rollo de video </xsl:if>
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

 <a><xsl:attribute name="href">/cgi-bin/koha/opac-detail.pl?biblionumber=<xsl:value-of select="$biblionumber"/></xsl:attribute><xsl:attribute name="class">título</xsl:attribute>

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
 <p>

 <!-- Author Statement: Alternate Graphic Representation (MARC 880) -->
 <xsl:if test="$display880">
 <xsl:call-template name="m880Select">
 <xsl:with-param name="basetags">100,110,111,700,710,711</xsl:with-param>
 <xsl:with-param name="codes">abc</xsl:with-param>
 </xsl:call-template>
 </xsl:if>

 <xsl:choose>
 <xsl:when test="marc:datafield[@tag=100] or marc:datafield[@tag=110] or marc:datafield[@tag=111] or marc:datafield[@tag=700] or marc:datafield[@tag=710] or marc:datafield[@tag=711]">

 por <span class="author">
 <xsl:for-each select="marc:datafield[(@tag=100 or @tag=700) and @ind1!='z']">
 <xsl:choose>
 <xsl:when test="position()=last()">
 <xsl:call-template name="nameABCQ"/>. </xsl:when>
 <xsl:otherwise>
 <xsl:call-template name="nameABCQ"/>; </xsl:otherwise>
 </xsl:choose>
 </xsl:for-each>

 <xsl:for-each select="marc:datafield[(@tag=110 or @tag=710) and @ind1!='z']">
 <xsl:choose>
 <xsl:when test="position()=1">
 <xsl:text> -- </xsl:text>
 </xsl:when>
 </xsl:choose>
 <xsl:choose>
 <xsl:when test="position()=last()">
 <xsl:call-template name="nameABCDN"/> 
 </xsl:when>
 <xsl:otherwise>
 <xsl:call-template name="nameABCDN"/>; </xsl:otherwise>
 </xsl:choose>
 </xsl:for-each>

 <xsl:for-each select="marc:datafield[(@tag=111 or @tag=711) and @ind1!='z']">
 <xsl:choose>
 <xsl:when test="position()=1">
 <xsl:text> -- </xsl:text>
 </xsl:when>
 </xsl:choose>
 <xsl:choose>
 <xsl:when test="marc:subfield[@code='n']">
 <xsl:text> </xsl:text>
 <xsl:call-template name="subfieldSelect">
 <xsl:with-param name="codes">n</xsl:with-param> 
 </xsl:call-template>
 <xsl:text> </xsl:text>
 </xsl:when>
 </xsl:choose>
 <xsl:choose>
 <xsl:when test="position()=last()">
 <xsl:call-template name="nameACDEQ"/>. </xsl:when>
 <xsl:otherwise>
 <xsl:call-template name="nameACDEQ"/>; </xsl:otherwise>
 </xsl:choose>
 </xsl:for-each>
 </span>
 </xsl:when>
 </xsl:choose>
 </p>

 <xsl:if test="marc:datafield[@tag=250]">
 <span class="results_summary edition">
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
 <span class="results_summary source">
 <span class="label">Fuente:</span>
 <xsl:value-of select="marc:subfield[@code='t']"/>
 </span>
 </xsl:if>
 </xsl:for-each>
 </xsl:if>

<xsl:if test="$DisplayOPACiconsXSLT!='0'">
 <span class="results_summary type">

 <xsl:if test="$BiblioItemtypeImage='Control'">

 <xsl:if test="$typeOf008!=''">
 <span class="label">Tipo: </span>
 <xsl:choose>
 <xsl:when test="$leader19='a'"><img alt="libro" src="/opac-tmpl/lib/famfamfam/silk/book_link.png" title="libro" class="materialtype" /> Conjunto</xsl:when>
 <xsl:when test="$leader6='a'">
 <xsl:choose>
 <xsl:when test="$leader7='c' or $leader7='d' or $leader7='m'"><img alt="libro" src="/opac-tmpl/lib/famfamfam/silk/book.png" title="libro" class="materialtype" /> Libro</xsl:when>
 <xsl:when test="$leader7='i' or $leader7='s'"><img alt="publicación periódica" src="/opac-tmpl/lib/famfamfam/silk/newspaper.png" title="publicación periódica" class="materialtype" /> Recursos continuos</xsl:when>
 <xsl:when test="$leader7='a' or $leader7='b'"><img alt="artículo" src="/opac-tmpl/lib/famfamfam/silk/book_open.png" title="artículo" class="materialtype" /> Artículo</xsl:when>
 </xsl:choose>
 </xsl:when>
 <xsl:when test="$leader6='t'"><img alt="libro" src="/opac-tmpl/lib/famfamfam/silk/book.png" title="libro" class="materialtype" /> Libro</xsl:when>
 <xsl:when test="$leader6='o'"><img alt="equipo" src="/opac-tmpl/lib/famfamfam/silk/report_disk.png" title="equipo" class="materialtype" /> Kit</xsl:when>
 <xsl:when test="$leader6='p'"><img alt="material variado" src="/opac-tmpl/lib/famfamfam/silk/report_disk.png" title="material variado" class="materialtype" />Materiales variados</xsl:when>
 <xsl:when test="$leader6='m'"><img alt="archivo informático" src="/opac-tmpl/lib/famfamfam/silk/computer_link.png" title="archivo informático" class="materialtype" /> Archivo de ordenador</xsl:when>
 <xsl:when test="$leader6='e' or $leader6='f'"><img alt="mapa" src="/opac-tmpl/lib/famfamfam/silk/map.png" title="mapa" class="materialtype" /> Mapa</xsl:when>
 <xsl:when test="$leader6='g' or $leader6='k' or $leader6='r'"><img alt="material visual" src="/opac-tmpl/lib/famfamfam/silk/film.png" title="material visual" class="materialtype" /> Material visual</xsl:when>
 <xsl:when test="$leader6='c' or $leader6='d'"><img alt="puntuación" src="/opac-tmpl/lib/famfamfam/silk/music.png" title="puntuación" class="materialtype" /> Puntuación</xsl:when>
 <xsl:when test="$leader6='i'"><img alt="sonido" src="/opac-tmpl/lib/famfamfam/silk/sound.png" title="sonido" class="materialtype" /> Sonido</xsl:when>
 <xsl:when test="$leader6='j'"><img alt="música" src="/opac-tmpl/lib/famfamfam/silk/sound.png" title="música" class="materialtype" /> Música</xsl:when>
 </xsl:choose>
 </xsl:if>
 <xsl:if test="string-length(normalize-space($physicalDescription))">
 <span class="label">; Formato: </span><xsl:copy-of select="$physicalDescription"></xsl:copy-of>
 </xsl:if>

 <xsl:if test="$controlField008-21 or $controlField008-22 or $controlField008-24 or $controlField008-26 or $controlField008-29 or $controlField008-34 or $controlField008-33 or $controlField008-30-31 or $controlField008-33">

 <xsl:if test="$typeOf008='CR'">
 <xsl:if test="$controlField008-21 and $controlField008-21 !='|' and $controlField008-21 !=' '">
 <span class="label">; Tipo de recurso contínuo: </span>
 </xsl:if>
 <xsl:choose>
 <xsl:when test="$controlField008-21='d'">
 <img alt="base de datos" src="/opac-tmpl/lib/famfamfam/silk/database.png" title="base de datos" class="format" />
 </xsl:when>
 <xsl:when test="$controlField008-21='l'">
 hojas sueltas </xsl:when>
 <xsl:when test="$controlField008-21='m'">
 series </xsl:when>
 <xsl:when test="$controlField008-21='n'">
 periódico </xsl:when>
 <xsl:when test="$controlField008-21='p'">
 publicación periódica</xsl:when>
 <xsl:when test="$controlField008-21='w'">
 <img alt="sitio web" src="/opac-tmpl/lib/famfamfam/silk/world_link.png" title="sitio web" class="format" />
 </xsl:when>
 </xsl:choose>
 </xsl:if>
 <xsl:if test="$typeOf008='BK' or $typeOf008='CR'">
 <xsl:if test="contains($controlField008-24,'abcdefghijklmnopqrstvwxyz')">
 <span class="label">; Naturaleza de los contenidos: </span>
 </xsl:if>
 <xsl:choose>
 <xsl:when test="contains($controlField008-24,'a')">
 resumen o sumario </xsl:when>
 <xsl:when test="contains($controlField008-24,'b')">
 bibliografía <img alt="bibliografía" src="/opac-tmpl/lib/famfamfam/silk/text_list_bullets.png" title="bibliografía" class="natureofcontents" />
 </xsl:when>
 <xsl:when test="contains($controlField008-24,'c')">
 catálogo </xsl:when>
 <xsl:when test="contains($controlField008-24,'d')">
 diccionario </xsl:when>
 <xsl:when test="contains($controlField008-24,'e')">
 enciclopedia </xsl:when>
 <xsl:when test="contains($controlField008-24,'f')">
 manual </xsl:when>
 <xsl:when test="contains($controlField008-24,'g')">
 artículo legal </xsl:when>
 <xsl:when test="contains($controlField008-24,'i')">
 índice </xsl:when>
 <xsl:when test="contains($controlField008-24,'k')">
 discografía </xsl:when>
 <xsl:when test="contains($controlField008-24,'l')">
 legislación </xsl:when>
 <xsl:when test="contains($controlField008-24,'m')">
 tesis </xsl:when>
 <xsl:when test="contains($controlField008-24,'n')">
 estudio de literatura</xsl:when>
 <xsl:when test="contains($controlField008-24,'o')">
 revisión</xsl:when>
 <xsl:when test="contains($controlField008-24,'p')">
 textos programados </xsl:when>
 <xsl:when test="contains($controlField008-24,'q')">
 filmografía </xsl:when>
 <xsl:when test="contains($controlField008-24,'r')">
 directorio </xsl:when>
 <xsl:when test="contains($controlField008-24,'s')">
 estadísticas </xsl:when>
 <xsl:when test="contains($controlField008-24,'t')">
 <img alt="informe técnico" src="/opac-tmpl/lib/famfamfam/silk/report.png" title="informe técnico" class="natureofcontents" />
 </xsl:when>
 <xsl:when test="contains($controlField008-24,'v')">
 casos y notas legales </xsl:when>
 <xsl:when test="contains($controlField008-24,'w')">
 informe legal </xsl:when>
 <xsl:when test="contains($controlField008-24,'z')">
 tratado </xsl:when>
 </xsl:choose>
 <xsl:choose>
 <xsl:when test="$controlField008-29='1'">
 publicación de conferencia </xsl:when>
 </xsl:choose>
 </xsl:if>
 <xsl:if test="$typeOf008='CF'">
 <xsl:if test="$controlField008-26='a' or $controlField008-26='e' or $controlField008-26='f' or $controlField008-26='g'">
 <span class="label">; Tipo de archivo informático: </span>
 </xsl:if>
 <xsl:choose>
 <xsl:when test="$controlField008-26='a'">
 dato numérico </xsl:when>
 <xsl:when test="$controlField008-26='e'">
 <img alt="base de datos" src="/opac-tmpl/lib/famfamfam/silk/database.png" title="base de datos" class="format" />
 </xsl:when>
 <xsl:when test="$controlField008-26='f'">
 <img alt="fuente" src="/opac-tmpl/lib/famfamfam/silk/font.png" title="fuente" class="format" />
 </xsl:when>
 <xsl:when test="$controlField008-26='g'">
 <img alt="juego" src="/opac-tmpl/lib/famfamfam/silk/controller.png" title="juego" class="format" />
 </xsl:when>
 </xsl:choose>
 </xsl:if>
 <xsl:if test="$typeOf008='BK'">
 <xsl:if test="(substring($controlField008,25,1)='j') or (substring($controlField008,25,1)='1') or ($controlField008-34='a' or $controlField008-34='b' or $controlField008-34='c' or $controlField008-34='d')">
 <span class="label">; Naturaleza de los contenidos: </span>
 </xsl:if>
 <xsl:if test="substring($controlField008,25,1)='j'">
 patente </xsl:if>
 <xsl:if test="substring($controlField008,31,1)='1'">
 festschrift </xsl:if>
 <xsl:if test="$controlField008-34='a' or $controlField008-34='b' or $controlField008-34='c' or $controlField008-34='d'">
 <img alt="biografía" src="/opac-tmpl/lib/famfamfam/silk/user.png" title="biografía" class="natureofcontents" />
 </xsl:if>

 <xsl:if test="$controlField008-33 and $controlField008-33!='|' and $controlField008-33!='u' and $controlField008-33!=' '">
 <span class="label">; Forma literaria: </span>
 </xsl:if>
 <xsl:choose>
 <xsl:when test="$controlField008-33='0'">
 no ficción </xsl:when>
 <xsl:when test="$controlField008-33='1'">
 ficción </xsl:when> 
 <xsl:when test="$controlField008-33='e'">
 ensayo </xsl:when>
 <xsl:when test="$controlField008-33='d'">
 drama </xsl:when>
 <xsl:when test="$controlField008-33='c'">
 tira cómica</xsl:when>
 <xsl:when test="$controlField008-33='l'">
 ficción </xsl:when>
 <xsl:when test="$controlField008-33='h'">
 humor, sátira </xsl:when>
 <xsl:when test="$controlField008-33='i'">
 carta </xsl:when>
 <xsl:when test="$controlField008-33='f'">
 novela </xsl:when>
 <xsl:when test="$controlField008-33='j'">
 historia corta </xsl:when>
 <xsl:when test="$controlField008-33='s'">
 discurso </xsl:when>
 </xsl:choose>
 </xsl:if> 
 <xsl:if test="$typeOf008='MU' and $controlField008-30-31 and $controlField008-30-31!='||' and $controlField008-30-31!='  '">
 <span class="label">; Forma literaria: </span> <!-- Literary text for sound recordings -->
 <xsl:if test="contains($controlField008-30-31,'b')">
 biografía </xsl:if>
 <xsl:if test="contains($controlField008-30-31,'c')">
 publicación de conferencia </xsl:if>
 <xsl:if test="contains($controlField008-30-31,'d')">
 drama </xsl:if>
 <xsl:if test="contains($controlField008-30-31,'e')">
 ensayo </xsl:if>
 <xsl:if test="contains($controlField008-30-31,'f')">
 ficción </xsl:if>
 <xsl:if test="contains($controlField008-30-31,'o')">
 cuento popular </xsl:if>
 <xsl:if test="contains($controlField008-30-31,'h')">
 historia </xsl:if>
 <xsl:if test="contains($controlField008-30-31,'k')">
 humor, sátira </xsl:if>
 <xsl:if test="contains($controlField008-30-31,'m')">
 memoria </xsl:if>
 <xsl:if test="contains($controlField008-30-31,'p')">
 poesía </xsl:if>
 <xsl:if test="contains($controlField008-30-31,'r')">
 ensayo </xsl:if>
 <xsl:if test="contains($controlField008-30-31,'g')">
 informe </xsl:if>
 <xsl:if test="contains($controlField008-30-31,'s')">
 sonido </xsl:if>
 <xsl:if test="contains($controlField008-30-31,'l')">
 discurso </xsl:if>
 </xsl:if>
 <xsl:if test="$typeOf008='VM'">
 <span class="label">; Tipo de material visual: </span>
 <xsl:choose>
 <xsl:when test="$controlField008-33='a'">
 arte original </xsl:when>
 <xsl:when test="$controlField008-33='b'">
 equipo </xsl:when>
 <xsl:when test="$controlField008-33='c'">
 reproducción artística</xsl:when>
 <xsl:when test="$controlField008-33='d'">
 diorama </xsl:when>
 <xsl:when test="$controlField008-33='f'">
 diapositiva</xsl:when>
 <xsl:when test="$controlField008-33='g'">
 artículo legal </xsl:when>
 <xsl:when test="$controlField008-33='i'">
 imagen </xsl:when>
 <xsl:when test="$controlField008-33='k'">
 gráfico </xsl:when>
 <xsl:when test="$controlField008-33='l'">
 dibujo técnico </xsl:when>
 <xsl:when test="$controlField008-33='m'">
 película</xsl:when>
 <xsl:when test="$controlField008-33='n'">
 mapa </xsl:when>
 <xsl:when test="$controlField008-33='o'">
 tarjeta flash </xsl:when>
 <xsl:when test="$controlField008-33='p'">
 platina de microscopio </xsl:when>
 <xsl:when test="$controlField008-33='q' or marc:controlfield[@tag=007][substring(text(),1,1)='a'][substring(text(),2
,1)='q']">
 modelo </xsl:when>
 <xsl:when test="$controlField008-33='r'">
 realia </xsl:when>
 <xsl:when test="$controlField008-33='s'">
 diapositiva </xsl:when>
 <xsl:when test="$controlField008-33='t'">
 transparencia </xsl:when>
 <xsl:when test="$controlField008-33='v'">
 grabación de vídeo </xsl:when>
 <xsl:when test="$controlField008-33='w'">
 juguete </xsl:when>
 </xsl:choose>
 </xsl:if>
 </xsl:if> 

 <xsl:if test="($typeOf008='BK' or $typeOf008='CF' or $typeOf008='MU' or $typeOf008='VM') and ($controlField008-22='a' or $controlField008-22='b' or $controlField008-22='c' or $controlField008-22='d' or $controlField008-22='e' or $controlField008-22='g' or $controlField008-22='j' or $controlField008-22='f')">
 <span class="label">; Lectores: </span>
 <xsl:choose>
 <xsl:when test="$controlField008-22='a'">
 Preescolar; </xsl:when>
 <xsl:when test="$controlField008-22='b'">
 Primaria; </xsl:when>
 <xsl:when test="$controlField008-22='c'">
 Preadolescente; </xsl:when>
 <xsl:when test="$controlField008-22='d'">
 Adolescente; </xsl:when>
 <xsl:when test="$controlField008-22='e'">
 Adulto; </xsl:when>
 <xsl:when test="$controlField008-22='g'">
 General; </xsl:when>
 <xsl:when test="$controlField008-22='j'">
 Juvenil; </xsl:when>
 <xsl:when test="$controlField008-22='f'">
 Especializado; </xsl:when>
 </xsl:choose>
 </xsl:if>
 </xsl:if>
<xsl:text> </xsl:text> <!-- added blank space to fix font display problem, see Bug 3671 -->
 </span>
</xsl:if>

 <!-- Publisher Statement: Alternate Graphic Representation (MARC 880) -->
 <xsl:if test="$display880">
 <xsl:call-template name="m880Select">
 <xsl:with-param name="basetags">260</xsl:with-param>
 <xsl:with-param name="codes">abcg</xsl:with-param>
 <xsl:with-param name="class">results_summary publisher</xsl:with-param>
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
 <xsl:with-param name="class">results_summary other_title</xsl:with-param>
 <xsl:with-param name="label">Otro título: </xsl:with-param>
 </xsl:call-template>
 </xsl:if>
 
 <xsl:if test="marc:datafield[@tag=246]">
 <span class="results_summary other_title">
 <span class="label">Otro título: </span>
 <xsl:for-each select="marc:datafield[@tag=246]">
 <xsl:call-template name="subfieldSelect">
 <xsl:with-param name="codes">ab</xsl:with-param>
 </xsl:call-template>
 <xsl:choose><xsl:when test="position()=last()"><xsl:text>.</xsl:text></xsl:when><xsl:otherwise><xsl:text>; </xsl:text></xsl:otherwise></xsl:choose>
 </xsl:for-each>
 </span>
 </xsl:if>
 <xsl:if test="marc:datafield[@tag=242]">
 <span class="results_summary translated_title">
 <span class="label">Título traducido:</span>
 <xsl:for-each select="marc:datafield[@tag=242]">
 <xsl:call-template name="subfieldSelect">
 <xsl:with-param name="codes">abh</xsl:with-param>
 </xsl:call-template>
 <xsl:choose><xsl:when test="position()=last()"><xsl:text>.</xsl:text></xsl:when><xsl:otherwise><xsl:text>; </xsl:text></xsl:otherwise></xsl:choose>
 </xsl:for-each>
 </span>
 </xsl:if>
 <xsl:if test="marc:datafield[@tag=856]">
 <span class="results_summary online_resources">
 <span class="label">Acceso online: </span>
 <xsl:for-each select="marc:datafield[@tag=856]">
 <xsl:variable name="SubqText"><xsl:value-of select="marc:subfield[@code='q']"/></xsl:variable>
 <xsl:if test="$OPACURLOpenInNewWindow='0'">
 <a>
 <xsl:choose>
 <xsl:when test="$OPACTrackClicks='track'">
 <xsl:attribute name="href">/cgi-bin/koha/tracklinks.pl?uri=<xsl:value-of select="marc:subfield[@code='u']"/>;biblionumber=<xsl:value-of select="$biblionumber"/></xsl:attribute>
 </xsl:when>
 <xsl:when test="$OPACTrackClicks='anonymous'">
 <xsl:attribute name="href">/cgi-bin/koha/tracklinks.pl?uri=<xsl:value-of select="marc:subfield[@code='u']"/>;biblionumber=<xsl:value-of select="$biblionumber"/></xsl:attribute>
 </xsl:when>
 <xsl:otherwise>
 <xsl:attribute name="href"><xsl:value-of select="marc:subfield[@code='u']"/></xsl:attribute>
 </xsl:otherwise>
 </xsl:choose>
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
 <xsl:text>Haga clic aquí para acceder en línea</xsl:text>
 </xsl:otherwise>
 </xsl:choose>
 </xsl:when>
 </xsl:choose>
 </a>
 </xsl:if>
 <xsl:if test="$OPACURLOpenInNewWindow='1'">
 <a target='_blank'>
 <xsl:choose>
 <xsl:when test="$OPACTrackClicks='track'">
 <xsl:attribute name="href">/cgi-bin/koha/tracklinks.pl?uri=<xsl:value-of select="marc:subfield[@code='u']"/>;biblionumber=<xsl:value-of select="$biblionumber"/></xsl:attribute>
 </xsl:when>
 <xsl:when test="$OPACTrackClicks='anonymous'">
 <xsl:attribute name="href">/cgi-bin/koha/tracklinks.pl?uri=<xsl:value-of select="marc:subfield[@code='u']"/>;biblionumber=<xsl:value-of select="$biblionumber"/></xsl:attribute>
 </xsl:when>
 <xsl:otherwise>
 <xsl:attribute name="href"><xsl:value-of select="marc:subfield[@code='u']"/></xsl:attribute>
 </xsl:otherwise>
 </xsl:choose>
 <xsl:choose>
 <xsl:when test="($Show856uAsImage='Results' or $Show856uAsImage='Both') and ($SubqText='img' or $SubqText='bmp' or $SubqText='cod' or $SubqText='gif' or $SubqText='ief' or $SubqText='jpe' or $SubqText='jpeg' or $SubqText='jpg' or $SubqText='jfif' or $SubqText='png' or $SubqText='svg' or $SubqText='tif' or $SubqText='tiff' or $SubqText='ras' or $SubqText='cmx' or $SubqText='ico' or $SubqText='pnm' or $SubqText='pbm' or $SubqText='pgm' or $SubqText='ppm' or $SubqText='rgb' or $SubqText='xbm' or $SubqText='xpm' or $SubqText='xwd')">
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
 <xsl:text>Haga clic aquí para acceder en línea</xsl:text>
 </xsl:otherwise>
 </xsl:choose>
 </xsl:when>
 </xsl:choose>
 </a>
 </xsl:if>
 <xsl:choose>
 <xsl:when test="position()=last()"><xsl:text> </xsl:text></xsl:when>
 <xsl:otherwise> | </xsl:otherwise>
 </xsl:choose>
 </xsl:for-each>
 </span>
 </xsl:if>
 <span class="results_summary availability">
 <span class="label">Disponibilidad: </span>
 <xsl:choose>
 <xsl:when test="count(key('item-by-status', 'available'))=0 and count(key('item-by-status', 'reference'))=0">
 <xsl:choose>
 <xsl:when test="string-length($AlternateHoldingsField)=3 and marc:datafield[@tag=$AlternateHoldingsField]">
 <xsl:variable name="AlternateHoldingsCount" select="count(marc:datafield[@tag=$AlternateHoldingsField])"/>
 <xsl:for-each select="marc:datafield[@tag=$AlternateHoldingsField][1]">
 <xsl:call-template select="marc:datafield[@tag=$AlternateHoldingsField]" name="subfieldSelect">
 <xsl:with-param name="codes"><xsl:value-of select="$AlternateHoldingsSubfields"/></xsl:with-param>
 <xsl:with-param name="delimeter"><xsl:value-of select="$AlternateHoldingsSeparator"/></xsl:with-param>
 </xsl:call-template>
 </xsl:for-each>
 (<xsl:value-of select="$AlternateHoldingsCount"/>) </xsl:when>
 <xsl:otherwise>No hay copias disponibles </xsl:otherwise>
 </xsl:choose>
 </xsl:when>
 <xsl:when test="count(key('item-by-status', 'available'))>0">
 <span class="available">
 <b><xsl:text>Copias disponibles para préstamo: </xsl:text></b>
 <xsl:variable name="available_items"
                           select="key('item-by-status', 'available')"/>
 <xsl:choose>
 <xsl:when test="$singleBranchMode=1">
 <xsl:for-each select="$available_items[generate-id() = generate-id(key('item-by-status-and-branch', concat(items:status, ' ', items:homebranch))[1])]">
 <xsl:if test="items:itemcallnumber != '' and items:itemcallnumber"> [<xsl:value-of select="items:itemcallnumber"/>]</xsl:if>
 <xsl:text> (</xsl:text>
 <xsl:value-of select="count(key('item-by-status-and-branch', concat(items:status, ' ', items:homebranch)))"/>
 <xsl:text>) </xsl:text>
 <xsl:choose><xsl:when test="position()=last()"><xsl:text>. </xsl:text></xsl:when><xsl:otherwise><xsl:text>, </xsl:text></xsl:otherwise></xsl:choose>
 </xsl:for-each>
 </xsl:when>
 <xsl:otherwise>
 <xsl:for-each select="$available_items[generate-id() = generate-id(key('item-by-status-and-branch', concat(items:status, ' ', items:homebranch))[1])]">
 <xsl:value-of select="items:homebranch"/>
 <xsl:if test="items:itemcallnumber != '' and items:itemcallnumber and $OPACItemLocation='callnum'"> [<xsl:value-of select="items:itemcallnumber"/>]</xsl:if>
 <xsl:text> (</xsl:text>
 <xsl:value-of select="count(key('item-by-status-and-branch', concat(items:status, ' ', items:homebranch)))"/>
 <xsl:text>) </xsl:text>
 <xsl:choose><xsl:when test="position()=last()"><xsl:text>. </xsl:text></xsl:when><xsl:otherwise><xsl:text>, </xsl:text></xsl:otherwise></xsl:choose>
 </xsl:for-each>
 </xsl:otherwise>
 </xsl:choose>

 </span>
 </xsl:when>
 </xsl:choose>

 <xsl:choose>
 <xsl:when test="count(key('item-by-status', 'reference'))>0">
 <span class="available">
 <b><xsl:text>Copias disponibles para referencia: </xsl:text></b>
 <xsl:variable name="reference_items" select="key('item-by-status', 'reference')"/>
 <xsl:for-each select="$reference_items[generate-id() = generate-id(key('item-by-status-and-branch', concat(items:status, ' ', items:homebranch))[1])]">
 <xsl:value-of select="items:homebranch"/>
 <xsl:if test="items:itemcallnumber != '' and items:itemcallnumber"> [<xsl:value-of select="items:itemcallnumber"/>]</xsl:if>
 <xsl:text> (</xsl:text>
 <xsl:value-of select="count(key('item-by-status-and-branch', concat(items:status, ' ', items:homebranch)))"/>
 <xsl:text> ) </xsl:text>
 <xsl:choose><xsl:when test="position()=last()"><xsl:text>. </xsl:text></xsl:when><xsl:otherwise><xsl:text>, </xsl:text></xsl:otherwise></xsl:choose>
 </xsl:for-each>
 </span>
 </xsl:when>
 </xsl:choose>

 <xsl:choose> <xsl:when test="count(key('item-by-status', 'available'))>0">
 <xsl:choose><xsl:when test="count(key('item-by-status', 'reference'))>0">
 <br/>
 </xsl:when></xsl:choose>
 </xsl:when> </xsl:choose>

 <xsl:if test="count(key('item-by-status', 'Checked out'))>0">
 <span class="unavailable">
 <xsl:text>Prestado (</xsl:text>
 <xsl:value-of select="count(key('item-by-status', 'Checked out'))"/>
 <xsl:text>). </xsl:text>
 </span>
 </xsl:if>
 <xsl:if test="count(key('item-by-status', 'Withdrawn'))>0">
 <span class="unavailable">
 <xsl:text>Retirado (</xsl:text>
 <xsl:value-of select="count(key('item-by-status', 'Withdrawn'))"/>
 <xsl:text>). </xsl:text> </span>
 </xsl:if>
 <xsl:if test="$hidelostitems='0' and count(key('item-by-status', 'Lost'))>0">
 <span class="unavailable">
 <xsl:text>Perdido (</xsl:text>
 <xsl:value-of select="count(key('item-by-status', 'Lost'))"/>
 <xsl:text>). </xsl:text> </span>
 </xsl:if>
 <xsl:if test="count(key('item-by-status', 'Damaged'))>0">
 <span class="unavailable">
 <xsl:text>Dañado (</xsl:text>
 <xsl:value-of select="count(key('item-by-status', 'Damaged'))"/>
 <xsl:text>). </xsl:text> </span>
 </xsl:if>
 <xsl:if test="count(key('item-by-status', 'On order'))>0">
 <span class="unavailable">
 <xsl:text>Pedido (</xsl:text>
 <xsl:value-of select="count(key('item-by-status', 'On order'))"/>
 <xsl:text>). </xsl:text> </span>
 </xsl:if>
 <xsl:if test="count(key('item-by-status', 'In transit'))>0">
 <span class="unavailable">
 <xsl:text>En ruta (</xsl:text>
 <xsl:value-of select="count(key('item-by-status', 'In transit'))"/>
 <xsl:text>). </xsl:text> </span>
 </xsl:if>
 <xsl:if test="count(key('item-by-status', 'Waiting'))>0">
 <span class="unavailable">
 <xsl:text>Reservado (</xsl:text>
 <xsl:value-of select="count(key('item-by-status', 'Waiting'))"/>
 <xsl:text>). </xsl:text> </span>
 </xsl:if>
 </span>
 <xsl:choose>
 <xsl:when test="($OPACItemLocation='location' or $OPACItemLocation='ccode') and (count(key('item-by-status', 'available'))!=0 or count(key('item-by-status', 'reference'))!=0)">
 <span class="results_summary" id="location">
 <span class="label">Ubicación(es):</span>
 <xsl:choose>
 <xsl:when test="count(key('item-by-status', 'available'))>0">
 <span class="available">
 <xsl:variable name="available_items" select="key('item-by-status', 'available')"/>
 <xsl:for-each select="$available_items[generate-id() = generate-id(key('item-by-status-and-branch', concat(items:status, ' ', items:homebranch))[1])]">
 <xsl:choose>
 <xsl:when test="$OPACItemLocation='location'"><b><xsl:value-of select="concat(items:location,' ')"/></b></xsl:when>
 <xsl:when test="$OPACItemLocation='ccode'"><b><xsl:value-of select="concat(items:ccode,' ')"/></b></xsl:when>
 </xsl:choose>
 <xsl:if test="items:itemcallnumber != '' and items:itemcallnumber"> <xsl:value-of select="items:itemcallnumber"/></xsl:if>
 <xsl:choose><xsl:when test="position()=last()"><xsl:text>. </xsl:text></xsl:when><xsl:otherwise><xsl:text>, </xsl:text></xsl:otherwise></xsl:choose>
 </xsl:for-each>
 </span>
 </xsl:when>
 <xsl:when test="count(key('item-by-status', 'reference'))>0">
 <span class="available">
 <xsl:variable name="reference_items" select="key('item-by-status', 'reference')"/>
 <xsl:for-each select="$reference_items[generate-id() = generate-id(key('item-by-status-and-branch', concat(items:status, ' ', items:homebranch))[1])]">
 <xsl:choose>
 <xsl:when test="$OPACItemLocation='location'"><b><xsl:value-of select="concat(items:location,' ')"/></b></xsl:when>
 <xsl:when test="$OPACItemLocation='ccode'"><b><xsl:value-of select="concat(items:ccode,' ')"/></b></xsl:when>
 </xsl:choose>
 <xsl:if test="items:itemcallnumber != '' and items:itemcallnumber"> <xsl:value-of select="items:itemcallnumber"/></xsl:if>
 <xsl:choose><xsl:when test="position()=last()"><xsl:text>. </xsl:text></xsl:when><xsl:otherwise><xsl:text>, </xsl:text></xsl:otherwise></xsl:choose>
 </xsl:for-each>
 </span>
 </xsl:when>
 </xsl:choose>
 </span>
 </xsl:when>
 </xsl:choose>
 </xsl:template>

 <xsl:template name="nameABCQ">
 <xsl:call-template name="chopPunctuation">
 <xsl:with-param name="chopString">
 <xsl:call-template name="subfieldSelect">
 <xsl:with-param name="codes">abcq</xsl:with-param>
 </xsl:call-template>
 </xsl:with-param>
 <xsl:with-param name="punctuation">
 <xsl:text>:,;/ </xsl:text>
 </xsl:with-param>
 </xsl:call-template>
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
