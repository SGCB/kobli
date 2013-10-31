<!DOCTYPE stylesheet [<!ENTITY nbsp "&#160;" >]>
<xsl:stylesheet xmlns="http://www.loc.gov/mods/v3" xmlns:marc="http://www.loc.gov/MARC21/slim" xmlns:xlink="http://www.w3.org/1999/xlink" xmlns:xsl="http://www.w3.org/1999/XSL/Transform" exclude-result-prefixes="xlink marc" version="1.0">
 <xsl:include href="MARC21slimUtils.xsl"/>
 <xsl:output encoding="UTF-8" indent="yes" method="xml"/>
<!--
Revision 1.14 - Fixed template isValid and fields 010, 020, 022, 024, 028, and 037 to output additional identifier elements 
 with corresponding @type and @invalid == 'yes' when subfields z or y (in the case of 022) exist in the MARCXML ::: 2007/01/04 17:35:20 cred

Revision 1.13 - Changed order of output under cartographics to reflect schema 2006/11/28 tmee
 
Revision 1.12 - Updated to reflect MODS 3.2 Mapping 2006/10/11 tmee
 
Revision 1.11 - The attribute objectPart moved from <languageTerm> to <language>
 2006/04/08 jrad

Revision 1.10 MODS 3.1 revisions to language and classification elements 
 (plus ability to find marc:collection embedded in wrapper elements such as SRU zs: wrappers)
 2006/02/06 ggar

Revision 1.9 subfield $y was added to field 242 2004/09/02 10:57 jrad

Revision 1.8 Subject chopPunctuation expanded and attribute fixes 2004/08/12 jrad

Revision 1.7 2004/03/25 08:29 jrad

Revision 1.6 various validation fixes 2004/02/20 ntra

Revision 1.5 2003/10/02 16:18:58 ntra
MODS2 to MODS3 updates, language unstacking and 
de-duping, chopPunctuation expanded

Revision 1.3 2003/04/03 00:07:19 ntra
Revision 1.3 Additional Changes not related to MODS Version 2.0 by ntra

Revision 1.2 2003/03/24 19:37:42 ckeith
Added Log Comment

-->
 <xsl:template match="/">
 <xsl:choose>
 <xsl:when test="//marc:collection">
 <modsCollection xmlns:xsi="http://www.w3.org/2001/XMLSchema-instance" xsi:schemaLocation="http://www.loc.gov/mods/v3 http://www.loc.gov/standards/mods/v3/mods-3-2.xsd">
 <xsl:for-each select="//marc:collection/marc:record">
 <mods version="3.2">
 <xsl:call-template name="marcRecord"/>
 </mods>
 </xsl:for-each>
 </modsCollection>
 </xsl:when>
 <xsl:otherwise>
 <mods xmlns:xsi="http://www.w3.org/2001/XMLSchema-instance" version="3.2" xsi:schemaLocation="http://www.loc.gov/mods/v3 http://www.loc.gov/standards/mods/v3/mods-3-2.xsd">
 <xsl:for-each select="//marc:record">
 <xsl:call-template name="marcRecord"/>
 </xsl:for-each>
 </mods>
 </xsl:otherwise>
 </xsl:choose>
 </xsl:template>
 <xsl:template name="marcRecord">
 <xsl:variable name="leader" select="marc:leader"/>
 <xsl:variable name="leader6" select="substring($leader,7,1)"/>
 <xsl:variable name="leader7" select="substring($leader,8,1)"/>
 <xsl:variable name="controlField008" select="marc:controlfield[@tag='008']"/>
 <xsl:variable name="typeOf008">
 <xsl:choose>
 <xsl:when test="$leader6='a'">
 <xsl:choose>
 <xsl:when test="$leader7='a' or $leader7='c' or $leader7='d' or $leader7='m'">BK</xsl:when>
 <xsl:when test="$leader7='b' or $leader7='i' or $leader7='s'">SE</xsl:when>
 </xsl:choose>
 </xsl:when>
 <xsl:when test="$leader6='t'">BK</xsl:when>
 <xsl:when test="$leader6='p'">MM</xsl:when>
 <xsl:when test="$leader6='m'">CF</xsl:when>
 <xsl:when test="$leader6='e' or $leader6='f'">MP</xsl:when>
 <xsl:when test="$leader6='g' or $leader6='k' or $leader6='o' or $leader6='r'">VM</xsl:when>
 <xsl:when test="$leader6='c' or $leader6='d' or $leader6='i' or $leader6='j'">MU</xsl:when>
 </xsl:choose>
 </xsl:variable>
 <xsl:for-each select="marc:datafield[@tag='245']">
 <titleInfo>
 <xsl:variable name="title">
 <xsl:choose>
 <xsl:when test="marc:subfield[@code='b']">
 <xsl:call-template name="specialSubfieldSelect">
 <xsl:with-param name="axis">b</xsl:with-param>
 <xsl:with-param name="beforeCodes">afgk</xsl:with-param>
 </xsl:call-template>
 </xsl:when>
 <xsl:otherwise>
 <xsl:call-template name="subfieldSelect">
 <xsl:with-param name="codes">abfgk</xsl:with-param>
 </xsl:call-template>
 </xsl:otherwise>
 </xsl:choose>
 </xsl:variable>
 <xsl:variable name="titleChop">
 <xsl:call-template name="chopPunctuation">
 <xsl:with-param name="chopString">
 <xsl:value-of select="$title"/>
 </xsl:with-param>
 </xsl:call-template>
 </xsl:variable>
 <xsl:choose>
 <xsl:when test="@ind2>0">
 <nonSort>
 <xsl:value-of select="substring($titleChop,1,@ind2)"/>
 </nonSort>
 <title>
 <xsl:value-of select="substring($titleChop,@ind2+1)"/> </title>
 </xsl:when>
 <xsl:otherwise>
 <title>
 <xsl:value-of select="$titleChop"/>
 </title>
 </xsl:otherwise>
 </xsl:choose>
 <xsl:if test="marc:subfield[@code='b']">
 <subTitle>
 <xsl:call-template name="chopPunctuation">
 <xsl:with-param name="chopString">
 <xsl:call-template name="specialSubfieldSelect">
 <xsl:with-param name="axis">b</xsl:with-param>
 <xsl:with-param name="anyCodes">b</xsl:with-param>
 <xsl:with-param name="afterCodes">afgk</xsl:with-param>
 </xsl:call-template>
 </xsl:with-param>
 </xsl:call-template>
 </subTitle>
 </xsl:if>
 <xsl:call-template name="part"></xsl:call-template>
 </titleInfo>
 </xsl:for-each>
 <xsl:for-each select="marc:datafield[@tag='210']">
 <titleInfo type="abbreviated">
 <title>
 <xsl:call-template name="chopPunctuation"> <xsl:with-param name="chopString"> <xsl:call-template name="subfieldSelect"> <xsl:with-param name="codes">a</xsl:with-param> </xsl:call-template> </xsl:with-param> </xsl:call-template> </title>
 <xsl:call-template name="subtitle"/>
 </titleInfo>
 </xsl:for-each>
 <xsl:for-each select="marc:datafield[@tag='242']">
 <titleInfo type="translated">
 <!--09/01/04 Added subfield $y-->
 <xsl:for-each select="marc:subfield[@code='y']">
 <xsl:attribute name="lang">
 <xsl:value-of select="text()"/>
 </xsl:attribute>
 </xsl:for-each>
 <title>
 <xsl:call-template name="chopPunctuation">
 <xsl:with-param name="chopString">
 <xsl:call-template name="subfieldSelect">
 <!-- 1/04 removed $h, b -->
 <xsl:with-param name="codes">a</xsl:with-param>
 </xsl:call-template>
 </xsl:with-param>
 </xsl:call-template>
 </title>
 <!-- 1/04 fix -->
 <xsl:call-template name="subtitle"/>
 <xsl:call-template name="part"/>
 </titleInfo>
 </xsl:for-each>
 <xsl:for-each select="marc:datafield[@tag='246']">
 <titleInfo type="alternative">
 <xsl:for-each select="marc:subfield[@code='i']">
 <xsl:attribute name="displayLabel">
 <xsl:value-of select="text()"/>
 </xsl:attribute>
 </xsl:for-each>
 <title>
 <xsl:call-template name="chopPunctuation">
 <xsl:with-param name="chopString">
 <xsl:call-template name="subfieldSelect">
 <!-- 1/04 removed $h, $b -->
 <xsl:with-param name="codes">af</xsl:with-param>
 </xsl:call-template>
 </xsl:with-param>
 </xsl:call-template>
 </title>
 <xsl:call-template name="subtitle"/>
 <xsl:call-template name="part"/>
 </titleInfo>
 </xsl:for-each>
 <xsl:for-each select="marc:datafield[@tag='130']|marc:datafield[@tag='240']|marc:datafield[@tag='730'][@ind2!='2']">
 <titleInfo type="uniform">
 <title>
 <xsl:variable name="str">
 <xsl:for-each select="marc:subfield">
 <xsl:if test="(contains('adfklmor',@code) and (not(../marc:subfield[@code='n' or @code='p']) or (following-sibling::marc:subfield[@code='n' or @code='p'])))">
 <xsl:value-of select="text()"/>
 <xsl:text> </xsl:text>
 </xsl:if>
 </xsl:for-each>
 </xsl:variable>
 <xsl:call-template name="chopPunctuation">
 <xsl:with-param name="chopString">
 <xsl:value-of select="substring($str,1,string-length($str)-1)"/>
 </xsl:with-param>
 </xsl:call-template>
 </title>
 <xsl:call-template name="part"/>
 </titleInfo>
 </xsl:for-each>
 <xsl:for-each select="marc:datafield[@tag='740'][@ind2!='2']">
 <titleInfo type="alternative">
 <title>
 <xsl:call-template name="chopPunctuation"> <xsl:with-param name="chopString"> <xsl:call-template name="subfieldSelect"> <xsl:with-param name="codes">ah</xsl:with-param> </xsl:call-template> </xsl:with-param> </xsl:call-template> </title>
 <xsl:call-template name="part"/>
 </titleInfo>
 </xsl:for-each>
 <xsl:for-each select="marc:datafield[@tag='100']">
 <name type="personal">
 <xsl:call-template name="nameABCDQ"/>
 <xsl:call-template name="affiliation"/>
 <role>
 <roleTerm authority="marcrelator" type="text">creador</roleTerm>
 </role>
 <xsl:call-template name="role"/>
 </name>
 </xsl:for-each>
 <xsl:for-each select="marc:datafield[@tag='110']">
 <name type="corporate">
 <xsl:call-template name="nameABCDN"/>
 <role>
 <roleTerm authority="marcrelator" type="text">creador</roleTerm>
 </role>
 <xsl:call-template name="role"/>
 </name>
 </xsl:for-each>
 <xsl:for-each select="marc:datafield[@tag='111']">
 <name type="conference">
 <xsl:call-template name="nameACDEQ"/>
 <role>
 <roleTerm authority="marcrelator" type="text">creador</roleTerm>
 </role>
 <xsl:call-template name="role"/>
 </name>
 </xsl:for-each>
 <xsl:for-each select="marc:datafield[@tag='700'][not(marc:subfield[@code='t'])]">
 <name type="personal">
 <xsl:call-template name="nameABCDQ"/>
 <xsl:call-template name="affiliation"/>
 <xsl:call-template name="role"/>
 </name>
 </xsl:for-each>
 <xsl:for-each select="marc:datafield[@tag='710'][not(marc:subfield[@code='t'])]">
 <name type="corporate">
 <xsl:call-template name="nameABCDN"/>
 <xsl:call-template name="role"/>
 </name>
 </xsl:for-each>
 <xsl:for-each select="marc:datafield[@tag='711'][not(marc:subfield[@code='t'])]">
 <name type="conference">
 <xsl:call-template name="nameACDEQ"/>
 <xsl:call-template name="role"/>
 </name>
 </xsl:for-each>
 <xsl:for-each select="marc:datafield[@tag='720'][not(marc:subfield[@code='t'])]">
 <name>
 <xsl:if test="@ind1=1">
 <xsl:attribute name="type">
 <xsl:text>personal</xsl:text>
 </xsl:attribute>
 </xsl:if>
 <namePart>
 <xsl:value-of select="marc:subfield[@code='a']"/>
 </namePart>
 <xsl:call-template name="role"/>
 </name>
 </xsl:for-each>
 <typeOfResource>
 <xsl:if test="$leader7='c'">
 <xsl:attribute name="collection">Sí</xsl:attribute>
 </xsl:if>
 <xsl:if test="$leader6='d' or $leader6='f' or $leader6='p' or $leader6='t'">
 <xsl:attribute name="manuscript">Sí</xsl:attribute>
 </xsl:if>
 <xsl:choose>
 <xsl:when test="$leader6='a' or $leader6='t'">texto</xsl:when>
 <xsl:when test="$leader6='e' or $leader6='f'">cartográfico</xsl:when>
 <xsl:when test="$leader6='c' or $leader6='d'">Música anotada</xsl:when>
 <xsl:when test="$leader6='i'">grabación sonora no musical</xsl:when>
 <xsl:when test="$leader6='j'">grabación sonora musical</xsl:when>
 <xsl:when test="$leader6='k'">still image</xsl:when>
 <xsl:when test="$leader6='g'">imagen en movimiento</xsl:when>
 <xsl:when test="$leader6='r'">objeto tridimensional</xsl:when>
 <xsl:when test="$leader6='m'">software, multimedia interactivo </xsl:when>
 <xsl:when test="$leader6='p'">Materiales mixtos</xsl:when>
 </xsl:choose>
 </typeOfResource>
 <xsl:if test="substring($controlField008,26,1)='d'">
 <genre authority="marc">globo</genre>
 </xsl:if>
 <xsl:if test="marc:controlfield[@tag='007'][substring(text(),1,1)='a'][substring(text(),2,1)='r']">
 <genre authority="marc">Imagen de sensor remoto</genre>
 </xsl:if>
 <xsl:if test="$typeOf008='MP'">
 <xsl:variable name="controlField008-25" select="substring($controlField008,26,1)"></xsl:variable>
 <xsl:choose>
 <xsl:when test="$controlField008-25='a' or $controlField008-25='b' or $controlField008-25='c' or marc:controlfield[@tag=007][substring(text(),1,1)='a'][substring(text(),2,1)='j']">
 <genre authority="marc">Mapa</genre>
 </xsl:when>
 <xsl:when test="$controlField008-25='e' or marc:controlfield[@tag=007][substring(text(),1,1)='a'][substring(text(),2,1)='d']">
 <genre authority="marc">atlas</genre>
 </xsl:when>
 </xsl:choose>
 </xsl:if>
 <xsl:if test="$typeOf008='SE'">
 <xsl:variable name="controlField008-21" select="substring($controlField008,22,1)"></xsl:variable>
 <xsl:choose>
 <xsl:when test="$controlField008-21='d'">
 <genre authority="marc">base de datos</genre>
 </xsl:when>
 <xsl:when test="$controlField008-21='l'">
 <genre authority="marc">hojas sueltas</genre>
 </xsl:when>
 <xsl:when test="$controlField008-21='m'">
 <genre authority="marc">series </genre>
 </xsl:when>
 <xsl:when test="$controlField008-21='n'">
 <genre authority="marc">periódico</genre>
 </xsl:when>
 <xsl:when test="$controlField008-21='p'">
 <genre authority="marc">Periódica</genre>
 </xsl:when>
 <xsl:when test="$controlField008-21='w'">
 <genre authority="marc">Sitio Web </genre>
 </xsl:when>
 </xsl:choose>
 </xsl:if>
 <xsl:if test="$typeOf008='BK' or $typeOf008='SE'">
 <xsl:variable name="controlField008-24" select="substring($controlField008,25,4)"></xsl:variable>
 <xsl:choose>
 <xsl:when test="contains($controlField008-24,'a')">
 <genre authority="marc">extracto o resumen</genre>
 </xsl:when>
 <xsl:when test="contains($controlField008-24,'b')">
 <genre authority="marc">bibliografía</genre>
 </xsl:when>
 <xsl:when test="contains($controlField008-24,'c')">
 <genre authority="marc">catálogo</genre>
 </xsl:when>
 <xsl:when test="contains($controlField008-24,'d')">
 <genre authority="marc">diccionario</genre>
 </xsl:when>
 <xsl:when test="contains($controlField008-24,'e')">
 <genre authority="marc">enciclopedia</genre>
 </xsl:when>
 <xsl:when test="contains($controlField008-24,'f')">
 <genre authority="marc">manual</genre>
 </xsl:when>
 <xsl:when test="contains($controlField008-24,'g')">
 <genre authority="marc">artículo jurídico</genre>
 </xsl:when>
 <xsl:when test="contains($controlField008-24,'i')">
 <genre authority="marc">índice</genre>
 </xsl:when>
 <xsl:when test="contains($controlField008-24,'k')">
 <genre authority="marc">discografía</genre>
 </xsl:when>
 <xsl:when test="contains($controlField008-24,'l')">
 <genre authority="marc">legislación</genre>
 </xsl:when>
 <xsl:when test="contains($controlField008-24,'m')">
 <genre authority="marc">tesis</genre>
 </xsl:when>
 <xsl:when test="contains($controlField008-24,'n')">
 <genre authority="marc">estudio del arte de literatura</genre>
 </xsl:when>
 <xsl:when test="contains($controlField008-24,'o')">
 <genre authority="marc">revisión</genre>
 </xsl:when>
 <xsl:when test="contains($controlField008-24,'p')">
 <genre authority="marc">Textos programados</genre>
 </xsl:when>
 <xsl:when test="contains($controlField008-24,'q')">
 <genre authority="marc">filmografía</genre>
 </xsl:when>
 <xsl:when test="contains($controlField008-24,'r')">
 <genre authority="marc">directorio</genre>
 </xsl:when>
 <xsl:when test="contains($controlField008-24,'s')">
 <genre authority="marc">Estadísticas</genre>
 </xsl:when>
 <xsl:when test="contains($controlField008-24,'t')">
 <genre authority="marc">informes técnicos </genre>
 </xsl:when>
 <xsl:when test="contains($controlField008-24,'v')">
 <genre authority="marc">caso jurídicos y notas del caso</genre>
 </xsl:when>
 <xsl:when test="contains($controlField008-24,'w')">
 <genre authority="marc">informe legal o resumen</genre>
 </xsl:when>
 <xsl:when test="contains($controlField008-24,'z')">
 <genre authority="marc">acuerdo</genre>
 </xsl:when>
 </xsl:choose>
 <xsl:variable name="controlField008-29" select="substring($controlField008,30,1)"></xsl:variable>
 <xsl:choose>
 <xsl:when test="$controlField008-29='1'">
 <genre authority="marc">publicación de conferencia</genre>
 </xsl:when>
 </xsl:choose>
 </xsl:if>
 <xsl:if test="$typeOf008='CF'">
 <xsl:variable name="controlField008-26" select="substring($controlField008,27,1)"></xsl:variable>
 <xsl:choose>
 <xsl:when test="$controlField008-26='a'">
 <genre authority="marc">Datos numéricos</genre>
 </xsl:when>
 <xsl:when test="$controlField008-26='e'">
 <genre authority="marc">base de datos</genre>
 </xsl:when>
 <xsl:when test="$controlField008-26='f'">
 <genre authority="marc">fuente</genre>
 </xsl:when>
 <xsl:when test="$controlField008-26='g'">
 <genre authority="marc">juego</genre>
 </xsl:when>
 </xsl:choose>
 </xsl:if>
 <xsl:if test="$typeOf008='BK'">
 <xsl:if test="substring($controlField008,25,1)='j'">
 <genre authority="marc">patente</genre>
 </xsl:if>
 <xsl:if test="substring($controlField008,31,1)='1'">
 <genre authority="marc">homenaje</genre>
 </xsl:if>
 <xsl:variable name="controlField008-34" select="substring($controlField008,35,1)"></xsl:variable>
 <xsl:if test="$controlField008-34='a' or $controlField008-34='b' or $controlField008-34='c' or $controlField008-34='d'">
 <genre authority="marc">biografía</genre>
 </xsl:if>
 <xsl:variable name="controlField008-33" select="substring($controlField008,34,1)"></xsl:variable>
 <xsl:choose>
 <xsl:when test="$controlField008-33='e'">
 <genre authority="marc">ensayo</genre>
 </xsl:when>
 <xsl:when test="$controlField008-33='d'">
 <genre authority="marc">drama</genre>
 </xsl:when>
 <xsl:when test="$controlField008-33='c'">
 <genre authority="marc">tira cómica</genre>
 </xsl:when>
 <xsl:when test="$controlField008-33='l'">
 <genre authority="marc">ficción</genre>
 </xsl:when>
 <xsl:when test="$controlField008-33='h'">
 <genre authority="marc">humor, sátira</genre>
 </xsl:when>
 <xsl:when test="$controlField008-33='i'">
 <genre authority="marc">carta</genre>
 </xsl:when>
 <xsl:when test="$controlField008-33='f'">
 <genre authority="marc">Novelas</genre>
 </xsl:when>
 <xsl:when test="$controlField008-33='j'">
 <genre authority="marc">cuentos</genre>
 </xsl:when>
 <xsl:when test="$controlField008-33='s'">
 <genre authority="marc">discurso</genre>
 </xsl:when>
 </xsl:choose>
 </xsl:if>
 <xsl:if test="$typeOf008='MU'">
 <xsl:variable name="controlField008-30-31" select="substring($controlField008,31,2)"></xsl:variable>
 <xsl:if test="contains($controlField008-30-31,'b')">
 <genre authority="marc">biografía</genre>
 </xsl:if>
 <xsl:if test="contains($controlField008-30-31,'c')">
 <genre authority="marc">publicación de conferencia</genre>
 </xsl:if>
 <xsl:if test="contains($controlField008-30-31,'d')">
 <genre authority="marc">drama</genre>
 </xsl:if>
 <xsl:if test="contains($controlField008-30-31,'e')">
 <genre authority="marc">ensayo</genre>
 </xsl:if>
 <xsl:if test="contains($controlField008-30-31,'f')">
 <genre authority="marc">ficción</genre>
 </xsl:if>
 <xsl:if test="contains($controlField008-30-31,'o')">
 <genre authority="marc">cuento popular</genre>
 </xsl:if>
 <xsl:if test="contains($controlField008-30-31,'h')">
 <genre authority="marc">historia</genre>
 </xsl:if>
 <xsl:if test="contains($controlField008-30-31,'k')">
 <genre authority="marc">humor, sátira</genre>
 </xsl:if>
 <xsl:if test="contains($controlField008-30-31,'m')">
 <genre authority="marc">Memorias</genre>
 </xsl:if>
 <xsl:if test="contains($controlField008-30-31,'p')">
 <genre authority="marc">Poesía</genre>
 </xsl:if>
 <xsl:if test="contains($controlField008-30-31,'r')">
 <genre authority="marc">Ensayos</genre>
 </xsl:if>
 <xsl:if test="contains($controlField008-30-31,'g')">
 <genre authority="marc">Presentación de informes</genre>
 </xsl:if>
 <xsl:if test="contains($controlField008-30-31,'s')">
 <genre authority="marc">sonido</genre>
 </xsl:if>
 <xsl:if test="contains($controlField008-30-31,'l')">
 <genre authority="marc">discurso</genre>
 </xsl:if>
 </xsl:if>
 <xsl:if test="$typeOf008='VM'">
 <xsl:variable name="controlField008-33" select="substring($controlField008,34,1)"></xsl:variable>
 <xsl:choose>
 <xsl:when test="$controlField008-33='a'">
 <genre authority="marc">arte original</genre>
 </xsl:when>
 <xsl:when test="$controlField008-33='b'">
 <genre authority="marc">equipo</genre>
 </xsl:when>
 <xsl:when test="$controlField008-33='c'">
 <genre authority="marc">reproducción de arte</genre>
 </xsl:when>
 <xsl:when test="$controlField008-33='d'">
 <genre authority="marc">diorama</genre>
 </xsl:when>
 <xsl:when test="$controlField008-33='f'">
 <genre authority="marc">película</genre>
 </xsl:when>
 <xsl:when test="$controlField008-33='g'">
 <genre authority="marc">artículo jurídico</genre>
 </xsl:when>
 <xsl:when test="$controlField008-33='i'">
 <genre authority="marc">imagen</genre>
 </xsl:when>
 <xsl:when test="$controlField008-33='k'">
 <genre authority="marc">gráfico</genre>
 </xsl:when>
 <xsl:when test="$controlField008-33='l'">
 <genre authority="marc">dibujo técnico </genre>
 </xsl:when>
 <xsl:when test="$controlField008-33='m'">
 <genre authority="marc">Película </genre>
 </xsl:when>
 <xsl:when test="$controlField008-33='n'">
 <genre authority="marc">mapa</genre>
 </xsl:when>
 <xsl:when test="$controlField008-33='o'">
 <genre authority="marc">tarjeta flash</genre>
 </xsl:when>
 <xsl:when test="$controlField008-33='p'">
 <genre authority="marc">Microdiapositiva</genre>
 </xsl:when>
 <xsl:when test="$controlField008-33='q' or marc:controlfield[@tag=007][substring(text(),1,1)='a'][substring(text(),2,1)='q']">
 <genre authority="marc">Modelo</genre>
 </xsl:when>
 <xsl:when test="$controlField008-33='r'">
 <genre authority="marc">realia</genre>
 </xsl:when>
 <xsl:when test="$controlField008-33='s'">
 <genre authority="marc">diapositiva  </genre>
 </xsl:when>
 <xsl:when test="$controlField008-33='t'">
 <genre authority="marc">diapositiva</genre>
 </xsl:when>
 <xsl:when test="$controlField008-33='v'">
 <genre authority="marc">Grabación de vídeo</genre>
 </xsl:when>
 <xsl:when test="$controlField008-33='w'">
 <genre authority="marc">juguete</genre>
 </xsl:when>
 </xsl:choose>
 </xsl:if>
 <xsl:for-each select="marc:datafield[@tag=655]">
 <genre authority="marc">
 <xsl:attribute name="authority">
 <xsl:value-of select="marc:subfield[@code='2']"/>
 </xsl:attribute>
 <xsl:call-template name="subfieldSelect">
 <xsl:with-param name="codes">abvxyz</xsl:with-param>
 <xsl:with-param name="delimeter">-</xsl:with-param>
 </xsl:call-template>
 </genre>
 </xsl:for-each>
 <originInfo>
 <xsl:variable name="MARCpublicationCode" select="normalize-space(substring($controlField008,16,3))"></xsl:variable>
 <xsl:if test="translate($MARCpublicationCode,'|','')">
 <place>
 <placeTerm>
 <xsl:attribute name="type">código</xsl:attribute>
 <xsl:attribute name="authority">marccountry</xsl:attribute>
 <xsl:value-of select="$MARCpublicationCode"/>
 </placeTerm>
 </place>
 </xsl:if>
 <xsl:for-each select="marc:datafield[@tag=044]/marc:subfield[@code='c']">
 <place>
 <placeTerm>
 <xsl:attribute name="type">código</xsl:attribute>
 <xsl:attribute name="authority">iso3166</xsl:attribute>
 <xsl:value-of select="."/>
 </placeTerm>
 </place>
 </xsl:for-each>
 <xsl:for-each select="marc:datafield[@tag=260]/marc:subfield[@code='a']">
 <place>
 <placeTerm>
 <xsl:attribute name="type">texto</xsl:attribute>
 <xsl:call-template name="chopPunctuationFront">
 <xsl:with-param name="chopString">
 <xsl:call-template name="chopPunctuation">
 <xsl:with-param name="chopString" select="."/>
 </xsl:call-template>
 </xsl:with-param>
 </xsl:call-template>
 </placeTerm>
 </place>
 </xsl:for-each>
 <xsl:for-each select="marc:datafield[@tag=046]/marc:subfield[@code='m']">
 <dateValid point="start">
 <xsl:value-of select="."/>
 </dateValid>
 </xsl:for-each>
 <xsl:for-each select="marc:datafield[@tag=046]/marc:subfield[@code='n']">
 <dateValid point="end">
 <xsl:value-of select="."/>
 </dateValid>
 </xsl:for-each>
 <xsl:for-each select="marc:datafield[@tag=046]/marc:subfield[@code='j']">
 <dateModified>
 <xsl:value-of select="."/>
 </dateModified>
 </xsl:for-each>
 <xsl:for-each select="marc:datafield[@tag=260]/marc:subfield[@code='b' or @code='c' or @code='g']">
 <xsl:choose>
 <xsl:when test="@code='b'">
 <publisher>
 <xsl:call-template name="chopPunctuation">
 <xsl:with-param name="chopString" select="."/>
 <xsl:with-param name="punctuation">
 <xsl:text>:,;/ </xsl:text>
 </xsl:with-param>
 </xsl:call-template>
 </publisher>
 </xsl:when>
 <xsl:when test="@code='c'">
 <dateIssued>
 <xsl:call-template name="chopPunctuation">
 <xsl:with-param name="chopString" select="."/>
 </xsl:call-template>
 </dateIssued>
 </xsl:when>
 <xsl:when test="@code='g'">
 <dateCreated>
 <xsl:value-of select="."/>
 </dateCreated>
 </xsl:when>
 </xsl:choose>
 </xsl:for-each>
 <xsl:variable name="dataField260c">
 <xsl:call-template name="chopPunctuation">
 <xsl:with-param name="chopString" select="marc:datafield[@tag=260]/marc:subfield[@code='c']"></xsl:with-param>
 </xsl:call-template>
 </xsl:variable>
 <xsl:variable name="controlField008-7-10" select="normalize-space(substring($controlField008, 8, 4))"></xsl:variable>
 <xsl:variable name="controlField008-11-14" select="normalize-space(substring($controlField008, 12, 4))"></xsl:variable>
 <xsl:variable name="controlField008-6" select="normalize-space(substring($controlField008, 7, 1))"></xsl:variable>
 <xsl:if test="$controlField008-6='e' or $controlField008-6='p' or $controlField008-6='r' or $controlField008-6='t' or $controlField008-6='s'">
 <xsl:if test="$controlField008-7-10 and ($controlField008-7-10 != $dataField260c)">
 <dateIssued encoding="marc">
 <xsl:value-of select="$controlField008-7-10"/>
 </dateIssued>
 </xsl:if>
 </xsl:if>
 <xsl:if test="$controlField008-6='c' or $controlField008-6='d' or $controlField008-6='i' or $controlField008-6='k' or $controlField008-6='m' or $controlField008-6='q' or $controlField008-6='u'">
 <xsl:if test="$controlField008-7-10">
 <dateIssued encoding="marc" point="start">
 <xsl:value-of select="$controlField008-7-10"/>
 </dateIssued>
 </xsl:if>
 </xsl:if>
 <xsl:if test="$controlField008-6='c' or $controlField008-6='d' or $controlField008-6='i' or $controlField008-6='k' or $controlField008-6='m' or $controlField008-6='q' or $controlField008-6='u'">
 <xsl:if test="$controlField008-11-14">
 <dateIssued encoding="marc" point="end">
 <xsl:value-of select="$controlField008-11-14"/>
 </dateIssued>
 </xsl:if>
 </xsl:if>
 <xsl:if test="$controlField008-6='q'">
 <xsl:if test="$controlField008-7-10">
 <dateIssued encoding="marc" point="start" qualifier="questionable">
 <xsl:value-of select="$controlField008-7-10"/>
 </dateIssued>
 </xsl:if>
 </xsl:if>
 <xsl:if test="$controlField008-6='q'">
 <xsl:if test="$controlField008-11-14">
 <dateIssued encoding="marc" point="end" qualifier="questionable">
 <xsl:value-of select="$controlField008-11-14"/>
 </dateIssued>
 </xsl:if>
 </xsl:if>
 <xsl:if test="$controlField008-6='t'">
 <xsl:if test="$controlField008-11-14">
 <copyrightDate encoding="marc">
 <xsl:value-of select="$controlField008-11-14"/>
 </copyrightDate>
 </xsl:if>
 </xsl:if>
 <xsl:for-each select="marc:datafield[@tag=033][@ind1=0 or @ind1=1]/marc:subfield[@code='a']">
 <dateCaptured encoding="iso8601">
 <xsl:value-of select="."/>
 </dateCaptured>
 </xsl:for-each>
 <xsl:for-each select="marc:datafield[@tag=033][@ind1=2]/marc:subfield[@code='a'][1]">
 <dateCaptured encoding="iso8601" point="start">
 <xsl:value-of select="."/>
 </dateCaptured>
 </xsl:for-each>
 <xsl:for-each select="marc:datafield[@tag=033][@ind1=2]/marc:subfield[@code='a'][2]">
 <dateCaptured encoding="iso8601" point="end">
 <xsl:value-of select="."/>
 </dateCaptured>
 </xsl:for-each>
 <xsl:for-each select="marc:datafield[@tag=250]/marc:subfield[@code='a']">
 <edition>
 <xsl:value-of select="."/>
 </edition>
 </xsl:for-each>
 <xsl:for-each select="marc:leader">
 <issuance>
 <xsl:choose>
 <xsl:when test="$leader7='a' or $leader7='c' or $leader7='d' or $leader7='m'">monográfico</xsl:when>
 <xsl:when test="$leader7='b' or $leader7='i' or $leader7='s'">continuado</xsl:when>
 </xsl:choose>
 </issuance>
 </xsl:for-each>
 <xsl:for-each select="marc:datafield[@tag=310]|marc:datafield[@tag=321]">
 <frequency>
 <xsl:call-template name="subfieldSelect">
 <xsl:with-param name="codes">ab</xsl:with-param>
 </xsl:call-template>
 </frequency>
 </xsl:for-each>
 </originInfo>
 <xsl:variable name="controlField008-35-37" select="normalize-space(translate(substring($controlField008,36,3),'|#',''))"></xsl:variable>
 <xsl:if test="$controlField008-35-37">
 <language>
 <languageTerm authority="iso639-2b" type="code">
 <xsl:value-of select="substring($controlField008,36,3)"/>
 </languageTerm>
 </language>
 </xsl:if>
 <xsl:for-each select="marc:datafield[@tag=041]">
 <xsl:for-each select="marc:subfield[@code='a' or @code='b' or @code='d' or @code='e' or @code='f' or @code='g' or @code='h']">
 <xsl:variable name="langCodes" select="."/>
 <xsl:choose>
 <xsl:when test="../marc:subfield[@code='2']='rfc3066'">
 <!-- not stacked but could be repeated -->
 <xsl:call-template name="rfcLanguages">
 <xsl:with-param name="nodeNum">
 <xsl:value-of select="1"/>
 </xsl:with-param>
 <xsl:with-param name="usedLanguages">
 <xsl:text></xsl:text>
 </xsl:with-param>
 <xsl:with-param name="controlField008-35-37">
 <xsl:value-of select="$controlField008-35-37"></xsl:value-of>
 </xsl:with-param>
 </xsl:call-template>
 </xsl:when>
 <xsl:otherwise>
 <!-- iso -->
 <xsl:variable name="allLanguages">
 <xsl:copy-of select="$langCodes"></xsl:copy-of>
 </xsl:variable>
 <xsl:variable name="currentLanguage">
 <xsl:value-of select="substring($allLanguages,1,3)"></xsl:value-of>
 </xsl:variable>
 <xsl:call-template name="isoLanguage">
 <xsl:with-param name="currentLanguage">
 <xsl:value-of select="substring($allLanguages,1,3)"></xsl:value-of>
 </xsl:with-param>
 <xsl:with-param name="remainingLanguages">
 <xsl:value-of select="substring($allLanguages,4,string-length($allLanguages)-3)"></xsl:value-of>
 </xsl:with-param>
 <xsl:with-param name="usedLanguages">
 <xsl:if test="$controlField008-35-37">
 <xsl:value-of select="$controlField008-35-37"></xsl:value-of>
 </xsl:if>
 </xsl:with-param>
 </xsl:call-template>
 </xsl:otherwise>
 </xsl:choose>
 </xsl:for-each>
 </xsl:for-each>
 <xsl:variable name="physicalDescription">
 <!--3.2 change tmee 007/11 -->
 <xsl:if test="$typeOf008='CF' and marc:controlfield[@tag=007][substring(.,12,1)='a']">
 <digitalOrigin>reformateado digital</digitalOrigin>
 </xsl:if>
 <xsl:if test="$typeOf008='CF' and marc:controlfield[@tag=007][substring(.,12,1)='b']">
 <digitalOrigin>microfilm digitalizado</digitalOrigin>
 </xsl:if>
 <xsl:if test="$typeOf008='CF' and marc:controlfield[@tag=007][substring(.,12,1)='d']">
 <digitalOrigin>otro análogo digitalizado</digitalOrigin>
 </xsl:if>
 <xsl:variable name="controlField008-23" select="substring($controlField008,24,1)"></xsl:variable>
 <xsl:variable name="controlField008-29" select="substring($controlField008,30,1)"></xsl:variable>
 <xsl:variable name="check008-23">
 <xsl:if test="$typeOf008='BK' or $typeOf008='MU' or $typeOf008='SE' or $typeOf008='MM'">
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
 <form authority="marcform">Braille</form>
 </xsl:when>
 <xsl:when test="($controlField008-23=' ' and ($leader6='c' or $leader6='d')) or (($typeOf008='BK' or $typeOf008='SE') and ($controlField008-23=' ' or $controlField008='r'))">
 <form authority="marcform">Impreso</form>
 </xsl:when>
 <xsl:when test="$leader6 = 'm' or ($check008-23 and $controlField008-23='s') or ($check008-29 and $controlField008-29='s')">
 <form authority="marcform">electrónico</form>
 </xsl:when>
 <xsl:when test="($check008-23 and $controlField008-23='b') or ($check008-29 and $controlField008-29='b')">
 <form authority="marcform">Microficha</form>
 </xsl:when>
 <xsl:when test="($check008-23 and $controlField008-23='a') or ($check008-29 and $controlField008-29='a')">
 <form authority="marcform">Microfilm</form>
 </xsl:when>
 </xsl:choose>
 <!-- 1/04 fix -->
 <xsl:if test="marc:datafield[@tag=130]/marc:subfield[@code='h']">
 <form authority="gmd">
 <xsl:call-template name="chopBrackets">
 <xsl:with-param name="chopString">
 <xsl:value-of select="marc:datafield[@tag=130]/marc:subfield[@code='h']"></xsl:value-of>
 </xsl:with-param>
 </xsl:call-template>
 </form>
 </xsl:if>
 <xsl:if test="marc:datafield[@tag=240]/marc:subfield[@code='h']">
 <form authority="gmd">
 <xsl:call-template name="chopBrackets">
 <xsl:with-param name="chopString">
 <xsl:value-of select="marc:datafield[@tag=240]/marc:subfield[@code='h']"></xsl:value-of>
 </xsl:with-param>
 </xsl:call-template>
 </form>
 </xsl:if>
 <xsl:if test="marc:datafield[@tag=242]/marc:subfield[@code='h']">
 <form authority="gmd">
 <xsl:call-template name="chopBrackets">
 <xsl:with-param name="chopString">
 <xsl:value-of select="marc:datafield[@tag=242]/marc:subfield[@code='h']"></xsl:value-of>
 </xsl:with-param>
 </xsl:call-template>
 </form>
 </xsl:if>
 <xsl:if test="marc:datafield[@tag=245]/marc:subfield[@code='h']">
 <form authority="gmd">
 <xsl:call-template name="chopBrackets">
 <xsl:with-param name="chopString">
 <xsl:value-of select="marc:datafield[@tag=245]/marc:subfield[@code='h']"></xsl:value-of>
 </xsl:with-param>
 </xsl:call-template>
 </form>
 </xsl:if>
 <xsl:if test="marc:datafield[@tag=246]/marc:subfield[@code='h']">
 <form authority="gmd">
 <xsl:call-template name="chopBrackets">
 <xsl:with-param name="chopString">
 <xsl:value-of select="marc:datafield[@tag=246]/marc:subfield[@code='h']"></xsl:value-of>
 </xsl:with-param>
 </xsl:call-template>
 </form>
 </xsl:if>
 <xsl:if test="marc:datafield[@tag=730]/marc:subfield[@code='h']">
 <form authority="gmd">
 <xsl:call-template name="chopBrackets">
 <xsl:with-param name="chopString">
 <xsl:value-of select="marc:datafield[@tag=730]/marc:subfield[@code='h']"></xsl:value-of>
 </xsl:with-param>
 </xsl:call-template>
 </form>
 </xsl:if>
 <xsl:for-each select="marc:datafield[@tag=256]/marc:subfield[@code='a']">
 <form>
 <xsl:value-of select="."></xsl:value-of>
 </form>
 </xsl:for-each>
 <xsl:for-each select="marc:controlfield[@tag=007][substring(text(),1,1)='c']">
 <xsl:choose>
 <xsl:when test="substring(text(),14,1)='a'">
 <reformattingQuality>acceso</reformattingQuality>
 </xsl:when>
 <xsl:when test="substring(text(),14,1)='p'">
 <reformattingQuality>preservación</reformattingQuality>
 </xsl:when>
 <xsl:when test="substring(text(),14,1)='r'">
 <reformattingQuality>reposición</reformattingQuality>
 </xsl:when>
 </xsl:choose>
 </xsl:for-each>
 <!--3.2 change tmee 007/01 -->
 <xsl:if test="marc:controlfield[@tag=007][substring(text(),1,1)='c'][substring(text(),2,1)='b']">
 <form authority="smd">cartucho de chip</form>
 </xsl:if>
 <xsl:if test="marc:controlfield[@tag=007][substring(text(),1,1)='c'][substring(text(),2,1)='c']">
 <form authority="smd">cartucho de discos ópticos de ordenador</form>
 </xsl:if>
 <xsl:if test="marc:controlfield[@tag=007][substring(text(),1,1)='c'][substring(text(),2,1)='j']">
 <form authority="smd">disco magnético </form>
 </xsl:if>
 <xsl:if test="marc:controlfield[@tag=007][substring(text(),1,1)='c'][substring(text(),2,1)='m']">
 <form authority="smd">Disco magneto-óptico</form>
 </xsl:if>
 <xsl:if test="marc:controlfield[@tag=007][substring(text(),1,1)='c'][substring(text(),2,1)='o']">
 <form authority="smd">disco óptico</form>
 </xsl:if>
 <xsl:if test="marc:controlfield[@tag=007][substring(text(),1,1)='c'][substring(text(),2,1)='r']">
 <form authority="smd">remoto</form>
 </xsl:if>
 <xsl:if test="marc:controlfield[@tag=007][substring(text(),1,1)='c'][substring(text(),2,1)='a']">
 <form authority="smd">cartucho de cinta </form>
 </xsl:if>
 <xsl:if test="marc:controlfield[@tag=007][substring(text(),1,1)='c'][substring(text(),2,1)='f']">
 <form authority="smd">cinta de casete</form>
 </xsl:if>
 <xsl:if test="marc:controlfield[@tag=007][substring(text(),1,1)='c'][substring(text(),2,1)='h']">
 <form authority="smd">cinta de bobina</form>
 </xsl:if>
 
 <xsl:if test="marc:controlfield[@tag=007][substring(text(),1,1)='d'][substring(text(),2,1)='a']">
 <form authority="smd">globo celeste</form>
 </xsl:if>
 <xsl:if test="marc:controlfield[@tag=007][substring(text(),1,1)='d'][substring(text(),2,1)='e']">
 <form authority="smd">globo tierra luna</form>
 </xsl:if>
 <xsl:if test="marc:controlfield[@tag=007][substring(text(),1,1)='d'][substring(text(),2,1)='b']">
 <form authority="smd">Globo planetario o lunar</form>
 </xsl:if>
 <xsl:if test="marc:controlfield[@tag=007][substring(text(),1,1)='d'][substring(text(),2,1)='c']">
 <form authority="smd">globo terrestre</form>
 </xsl:if>
 
 <xsl:if test="marc:controlfield[@tag=007][substring(text(),1,1)='o'][substring(text(),2,1)='o']">
 <form authority="smd">equipo</form>
 </xsl:if>
 
 <xsl:if test="marc:controlfield[@tag=007][substring(text(),1,1)='a'][substring(text(),2,1)='d']">
 <form authority="smd">atlas</form>
 </xsl:if>
 <xsl:if test="marc:controlfield[@tag=007][substring(text(),1,1)='a'][substring(text(),2,1)='g']">
 <form authority="smd">diagrama</form>
 </xsl:if>
 <xsl:if test="marc:controlfield[@tag=007][substring(text(),1,1)='a'][substring(text(),2,1)='j']">
 <form authority="smd">Mapa</form>
 </xsl:if>
 <xsl:if test="marc:controlfield[@tag=007][substring(text(),1,1)='a'][substring(text(),2,1)='q']">
 <form authority="smd">Modelo</form>
 </xsl:if>
 <xsl:if test="marc:controlfield[@tag=007][substring(text(),1,1)='a'][substring(text(),2,1)='k']">
 <form authority="smd">perfil</form>
 </xsl:if>
 <xsl:if test="marc:controlfield[@tag=007][substring(text(),1,1)='a'][substring(text(),2,1)='r']">
 <form authority="smd">Imagen de sensor remoto</form>
 </xsl:if>
 <xsl:if test="marc:controlfield[@tag=007][substring(text(),1,1)='a'][substring(text(),2,1)='s']">
 <form authority="smd">sección</form>
 </xsl:if>
 <xsl:if test="marc:controlfield[@tag=007][substring(text(),1,1)='a'][substring(text(),2,1)='y']">
 <form authority="smd">Vista</form>
 </xsl:if>
 
 <xsl:if test="marc:controlfield[@tag=007][substring(text(),1,1)='h'][substring(text(),2,1)='a']">
 <form authority="smd">tarjeta de apertura</form>
 </xsl:if>
 <xsl:if test="marc:controlfield[@tag=007][substring(text(),1,1)='h'][substring(text(),2,1)='e']">
 <form authority="smd">Microficha</form>
 </xsl:if>
 <xsl:if test="marc:controlfield[@tag=007][substring(text(),1,1)='h'][substring(text(),2,1)='f']">
 <form authority="smd">Microficha en casete</form>
 </xsl:if>
 <xsl:if test="marc:controlfield[@tag=007][substring(text(),1,1)='h'][substring(text(),2,1)='b']">
 <form authority="smd">Cartucho de microfilm</form>
 </xsl:if>
 <xsl:if test="marc:controlfield[@tag=007][substring(text(),1,1)='h'][substring(text(),2,1)='c']">
 <form authority="smd">Microfilm en casete</form>
 </xsl:if>
 <xsl:if test="marc:controlfield[@tag=007][substring(text(),1,1)='h'][substring(text(),2,1)='d']">
 <form authority="smd">Rollo de microfilm</form>
 </xsl:if>
 <xsl:if test="marc:controlfield[@tag=007][substring(text(),1,1)='h'][substring(text(),2,1)='g']">
 <form authority="smd">Microopaco</form>
 </xsl:if>
 
 <xsl:if test="marc:controlfield[@tag=007][substring(text(),1,1)='m'][substring(text(),2,1)='c']">
 <form authority="smd">cartucho de película</form>
 </xsl:if>
 <xsl:if test="marc:controlfield[@tag=007][substring(text(),1,1)='m'][substring(text(),2,1)='f']">
 <form authority="smd">casete de película</form>
 </xsl:if>
 <xsl:if test="marc:controlfield[@tag=007][substring(text(),1,1)='m'][substring(text(),2,1)='r']">
 <form authority="smd">bobina de película</form>
 </xsl:if>
 
 <xsl:if test="marc:controlfield[@tag=007][substring(text(),1,1)='k'][substring(text(),2,1)='n']">
 <form authority="smd">mapa</form>
 </xsl:if>
 <xsl:if test="marc:controlfield[@tag=007][substring(text(),1,1)='k'][substring(text(),2,1)='c']">
 <form authority="smd">colage</form>
 </xsl:if>
 <xsl:if test="marc:controlfield[@tag=007][substring(text(),1,1)='k'][substring(text(),2,1)='d']">
 <form authority="smd">dibujo</form>
 </xsl:if>
 <xsl:if test="marc:controlfield[@tag=007][substring(text(),1,1)='k'][substring(text(),2,1)='o']">
 <form authority="smd">tarjeta flash</form>
 </xsl:if>
 <xsl:if test="marc:controlfield[@tag=007][substring(text(),1,1)='k'][substring(text(),2,1)='e']">
 <form authority="smd">pintura</form>
 </xsl:if>
 <xsl:if test="marc:controlfield[@tag=007][substring(text(),1,1)='k'][substring(text(),2,1)='f']">
 <form authority="smd">Impreso fotomecánico</form>
 </xsl:if>
 <xsl:if test="marc:controlfield[@tag=007][substring(text(),1,1)='k'][substring(text(),2,1)='g']">
 <form authority="smd">negativo fotográfico</form>
 </xsl:if>
 <xsl:if test="marc:controlfield[@tag=007][substring(text(),1,1)='k'][substring(text(),2,1)='h']">
 <form authority="smd">impresión fotográfica</form>
 </xsl:if>
 <xsl:if test="marc:controlfield[@tag=007][substring(text(),1,1)='k'][substring(text(),2,1)='i']">
 <form authority="smd">imagen</form>
 </xsl:if>
 <xsl:if test="marc:controlfield[@tag=007][substring(text(),1,1)='k'][substring(text(),2,1)='j']">
 <form authority="smd">Impreso</form>
 </xsl:if>
 <xsl:if test="marc:controlfield[@tag=007][substring(text(),1,1)='k'][substring(text(),2,1)='l']">
 <form authority="smd">dibujo técnico </form>
 </xsl:if>
 
 <xsl:if test="marc:controlfield[@tag=007][substring(text(),1,1)='q'][substring(text(),2,1)='q']">
 <form authority="smd">Música anotada</form>
 </xsl:if>
 
 <xsl:if test="marc:controlfield[@tag=007][substring(text(),1,1)='g'][substring(text(),2,1)='d']">
 <form authority="smd">película</form>
 </xsl:if>
 <xsl:if test="marc:controlfield[@tag=007][substring(text(),1,1)='g'][substring(text(),2,1)='c']">
 <form authority="smd">cartucho de película</form>
 </xsl:if>
 <xsl:if test="marc:controlfield[@tag=007][substring(text(),1,1)='g'][substring(text(),2,1)='o']">
 <form authority="smd">rollo de película</form>
 </xsl:if>
 <xsl:if test="marc:controlfield[@tag=007][substring(text(),1,1)='g'][substring(text(),2,1)='f']">
 <form authority="smd">otro tipo de película</form>
 </xsl:if>
 <xsl:if test="marc:controlfield[@tag=007][substring(text(),1,1)='g'][substring(text(),2,1)='s']">
 <form authority="smd">diapositiva  </form>
 </xsl:if>
 <xsl:if test="marc:controlfield[@tag=007][substring(text(),1,1)='g'][substring(text(),2,1)='t']">
 <form authority="smd">diapositiva</form>
 </xsl:if>
 <xsl:if test="marc:controlfield[@tag=007][substring(text(),1,1)='r'][substring(text(),2,1)='r']">
 <form authority="smd">Imagen de sensor remoto</form>
 </xsl:if>
 <xsl:if test="marc:controlfield[@tag=007][substring(text(),1,1)='s'][substring(text(),2,1)='e']">
 <form authority="smd">cilindro</form>
 </xsl:if>
 <xsl:if test="marc:controlfield[@tag=007][substring(text(),1,1)='s'][substring(text(),2,1)='q']">
 <form authority="smd">rollo</form>
 </xsl:if>
 <xsl:if test="marc:controlfield[@tag=007][substring(text(),1,1)='s'][substring(text(),2,1)='g']">
 <form authority="smd">cartucho de sonido</form>
 </xsl:if>
 <xsl:if test="marc:controlfield[@tag=007][substring(text(),1,1)='s'][substring(text(),2,1)='s']">
 <form authority="smd">casete de soniado</form>
 </xsl:if>
 <xsl:if test="marc:controlfield[@tag=007][substring(text(),1,1)='s'][substring(text(),2,1)='d']">
 <form authority="smd">disco de sonido</form>
 </xsl:if>
 <xsl:if test="marc:controlfield[@tag=007][substring(text(),1,1)='s'][substring(text(),2,1)='t']">
 <form authority="smd">Cinta de bobina de sonido</form>
 </xsl:if>
 <xsl:if test="marc:controlfield[@tag=007][substring(text(),1,1)='s'][substring(text(),2,1)='i']">
 <form authority="smd">banda sonora de película</form>
 </xsl:if>
 <xsl:if test="marc:controlfield[@tag=007][substring(text(),1,1)='s'][substring(text(),2,1)='w']">
 <form authority="smd">Grabación de vídeo </form>
 </xsl:if>
 
 <xsl:if test="marc:controlfield[@tag=007][substring(text(),1,1)='f'][substring(text(),2,1)='c']">
 <form authority="smd">Braille</form>
 </xsl:if>
 <xsl:if test="marc:controlfield[@tag=007][substring(text(),1,1)='f'][substring(text(),2,1)='b']">
 <form authority="smd">combinación</form>
 </xsl:if>
 <xsl:if test="marc:controlfield[@tag=007][substring(text(),1,1)='f'][substring(text(),2,1)='a']">
 <form authority="smd">luna</form>
 </xsl:if>
 <xsl:if test="marc:controlfield[@tag=007][substring(text(),1,1)='f'][substring(text(),2,1)='d']">
 <form authority="smd">táctil, sin sistema de escritura</form>
 </xsl:if>
 
 <xsl:if test="marc:controlfield[@tag=007][substring(text(),1,1)='t'][substring(text(),2,1)='c']">
 <form authority="smd">Braille</form>
 </xsl:if>
 <xsl:if test="marc:controlfield[@tag=007][substring(text(),1,1)='t'][substring(text(),2,1)='b']">
 <form authority="smd">impresión grande</form>
 </xsl:if>
 <xsl:if test="marc:controlfield[@tag=007][substring(text(),1,1)='t'][substring(text(),2,1)='a']">
 <form authority="smd">Impresión normal</form>
 </xsl:if>
 <xsl:if test="marc:controlfield[@tag=007][substring(text(),1,1)='t'][substring(text(),2,1)='d']">
 <form authority="smd">texto en carpeta de hojas sueltas </form>
 </xsl:if>
 
 <xsl:if test="marc:controlfield[@tag=007][substring(text(),1,1)='v'][substring(text(),2,1)='c']">
 <form authority="smd">cartucho de vídeo</form>
 </xsl:if>
 <xsl:if test="marc:controlfield[@tag=007][substring(text(),1,1)='v'][substring(text(),2,1)='f']">
 <form authority="smd">videocassette</form>
 </xsl:if>
 <xsl:if test="marc:controlfield[@tag=007][substring(text(),1,1)='v'][substring(text(),2,1)='d']">
 <form authority="smd">videodisco</form>
 </xsl:if>
 <xsl:if test="marc:controlfield[@tag=007][substring(text(),1,1)='v'][substring(text(),2,1)='r']">
 <form authority="smd">videocinta</form>
 </xsl:if>
 
 <xsl:for-each select="marc:datafield[@tag=856]/marc:subfield[@code='q'][string-length(.)>1]">
 <internetMediaType>
 <xsl:value-of select="."></xsl:value-of>
 </internetMediaType>
 </xsl:for-each>
 <xsl:for-each select="marc:datafield[@tag=300]">
 <extent>
 <xsl:call-template name="subfieldSelect">
 <xsl:with-param name="codes">abce</xsl:with-param>
 </xsl:call-template>
 </extent>
 </xsl:for-each>
 </xsl:variable>
 <xsl:if test="string-length(normalize-space($physicalDescription))">
 <physicalDescription>
 <xsl:copy-of select="$physicalDescription"></xsl:copy-of>
 </physicalDescription>
 </xsl:if>
 <xsl:for-each select="marc:datafield[@tag=520]">
 <abstract>
 <xsl:call-template name="uri"></xsl:call-template>
 <xsl:call-template name="subfieldSelect">
 <xsl:with-param name="codes">ab</xsl:with-param>
 </xsl:call-template>
 </abstract>
 </xsl:for-each>
 <xsl:for-each select="marc:datafield[@tag=505]">
 <tableOfContents>
 <xsl:call-template name="uri"></xsl:call-template>
 <xsl:call-template name="subfieldSelect">
 <xsl:with-param name="codes">agrt</xsl:with-param>
 </xsl:call-template>
 </tableOfContents>
 </xsl:for-each>
 <xsl:for-each select="marc:datafield[@tag=521]">
 <targetAudience>
 <xsl:call-template name="subfieldSelect">
 <xsl:with-param name="codes">ab</xsl:with-param>
 </xsl:call-template>
 </targetAudience>
 </xsl:for-each>
 <xsl:if test="$typeOf008='BK' or $typeOf008='CF' or $typeOf008='MU' or $typeOf008='VM'">
 <xsl:variable name="controlField008-22" select="substring($controlField008,23,1)"></xsl:variable>
 <xsl:choose>
 <!-- 01/04 fix -->
 <xsl:when test="$controlField008-22='d'">
 <targetAudience authority="marctarget">adolescente</targetAudience>
 </xsl:when>
 <xsl:when test="$controlField008-22='e'">
 <targetAudience authority="marctarget">adulto</targetAudience>
 </xsl:when>
 <xsl:when test="$controlField008-22='g'">
 <targetAudience authority="marctarget">general</targetAudience>
 </xsl:when>
 <xsl:when test="$controlField008-22='b' or $controlField008-22='c' or $controlField008-22='j'">
 <targetAudience authority="marctarget">juvenil</targetAudience>
 </xsl:when>
 <xsl:when test="$controlField008-22='a'">
 <targetAudience authority="marctarget">Preescolar</targetAudience>
 </xsl:when>
 <xsl:when test="$controlField008-22='f'">
 <targetAudience authority="marctarget">especializado</targetAudience>
 </xsl:when>
 </xsl:choose>
 </xsl:if>
 <xsl:for-each select="marc:datafield[@tag=245]/marc:subfield[@code='c']">
 <note type="statement of responsibility">
 <xsl:value-of select="."></xsl:value-of>
 </note>
 </xsl:for-each>
 <xsl:for-each select="marc:datafield[@tag=500]">
 <note>
 <xsl:value-of select="marc:subfield[@code='a']"></xsl:value-of>
 <xsl:call-template name="uri"></xsl:call-template>
 </note>
 </xsl:for-each>
 
 <!--3.2 change tmee additional note fields-->
 
 <xsl:for-each select="marc:datafield[@tag=506]">
 <note type="restrictions">
 <xsl:call-template name="uri"></xsl:call-template>
 <xsl:variable name="str">
 <xsl:for-each select="marc:subfield[@code!='6' or @code!='8']">
 <xsl:value-of select="."></xsl:value-of>
 <xsl:text> </xsl:text>
 </xsl:for-each>
 </xsl:variable>
 <xsl:value-of select="substring($str,1,string-length($str)-1)"></xsl:value-of>
 </note>
 </xsl:for-each>
 
 <xsl:for-each select="marc:datafield[@tag=510]">
 <note  type="citation/reference">
 <xsl:call-template name="uri"></xsl:call-template>
 <xsl:variable name="str">
 <xsl:for-each select="marc:subfield[@code!='6' or @code!='8']">
 <xsl:value-of select="."></xsl:value-of>
 <xsl:text> </xsl:text>
 </xsl:for-each>
 </xsl:variable>
 <xsl:value-of select="substring($str,1,string-length($str)-1)"></xsl:value-of>
 </note>
 </xsl:for-each>
 
 
 <xsl:for-each select="marc:datafield[@tag=511]">
 <note type="performers">
 <xsl:call-template name="uri"></xsl:call-template>
 <xsl:value-of select="marc:subfield[@code='a']"></xsl:value-of>
 </note>
 </xsl:for-each>
 <xsl:for-each select="marc:datafield[@tag=518]">
 <note type="venue">
 <xsl:call-template name="uri"></xsl:call-template>
 <xsl:value-of select="marc:subfield[@code='a']"></xsl:value-of>
 </note>
 </xsl:for-each>
 
 <xsl:for-each select="marc:datafield[@tag=530]">
 <note  type="additional physical form">
 <xsl:call-template name="uri"></xsl:call-template>
 <xsl:variable name="str">
 <xsl:for-each select="marc:subfield[@code!='6' or @code!='8']">
 <xsl:value-of select="."></xsl:value-of>
 <xsl:text> </xsl:text>
 </xsl:for-each>
 </xsl:variable>
 <xsl:value-of select="substring($str,1,string-length($str)-1)"></xsl:value-of>
 </note>
 </xsl:for-each>
 
 <xsl:for-each select="marc:datafield[@tag=533]">
 <note  type="reproduction">
 <xsl:call-template name="uri"></xsl:call-template>
 <xsl:variable name="str">
 <xsl:for-each select="marc:subfield[@code!='6' or @code!='8']">
 <xsl:value-of select="."></xsl:value-of>
 <xsl:text> </xsl:text>
 </xsl:for-each>
 </xsl:variable>
 <xsl:value-of select="substring($str,1,string-length($str)-1)"></xsl:value-of>
 </note>
 </xsl:for-each>
 
 <xsl:for-each select="marc:datafield[@tag=534]">
 <note  type="original version">
 <xsl:call-template name="uri"></xsl:call-template>
 <xsl:variable name="str">
 <xsl:for-each select="marc:subfield[@code!='6' or @code!='8']">
 <xsl:value-of select="."></xsl:value-of>
 <xsl:text> </xsl:text>
 </xsl:for-each>
 </xsl:variable>
 <xsl:value-of select="substring($str,1,string-length($str)-1)"></xsl:value-of>
 </note>
 </xsl:for-each>
 
 <xsl:for-each select="marc:datafield[@tag=538]">
 <note  type="system details">
 <xsl:call-template name="uri"></xsl:call-template>
 <xsl:variable name="str">
 <xsl:for-each select="marc:subfield[@code!='6' or @code!='8']">
 <xsl:value-of select="."></xsl:value-of>
 <xsl:text> </xsl:text>
 </xsl:for-each>
 </xsl:variable>
 <xsl:value-of select="substring($str,1,string-length($str)-1)"></xsl:value-of>
 </note>
 </xsl:for-each>
 
 <xsl:for-each select="marc:datafield[@tag=583]">
 <note type="action">
 <xsl:call-template name="uri"></xsl:call-template>
 <xsl:variable name="str">
 <xsl:for-each select="marc:subfield[@code!='6' or @code!='8']">
 <xsl:value-of select="."></xsl:value-of>
 <xsl:text> </xsl:text>
 </xsl:for-each>
 </xsl:variable>
 <xsl:value-of select="substring($str,1,string-length($str)-1)"></xsl:value-of>
 </note>
 </xsl:for-each>
 

 
 
 
 <xsl:for-each select="marc:datafield[@tag=501 or @tag=502 or @tag=504 or @tag=507 or @tag=508 or  @tag=513 or @tag=514 or @tag=515 or @tag=516 or @tag=522 or @tag=524 or @tag=525 or @tag=526 or @tag=535 or @tag=536 or @tag=540 or @tag=541 or @tag=544 or @tag=545 or @tag=546 or @tag=547 or @tag=550 or @tag=552 or @tag=555 or @tag=556 or @tag=561 or @tag=562 or @tag=565 or @tag=567 or @tag=580 or @tag=581 or @tag=584 or @tag=585 or @tag=586]">
 <note>
 <xsl:call-template name="uri"></xsl:call-template>
 <xsl:variable name="str">
 <xsl:for-each select="marc:subfield[@code!='6' or @code!='8']">
 <xsl:value-of select="."></xsl:value-of>
 <xsl:text> </xsl:text>
 </xsl:for-each>
 </xsl:variable>
 <xsl:value-of select="substring($str,1,string-length($str)-1)"></xsl:value-of>
 </note>
 </xsl:for-each>
 <xsl:for-each select="marc:datafield[@tag=034][marc:subfield[@code='d' or @code='e' or @code='f' or @code='g']]">
 <subject>
 <cartographics>
 <coordinates>
 <xsl:call-template name="subfieldSelect">
 <xsl:with-param name="codes">defg</xsl:with-param>
 </xsl:call-template>
 </coordinates>
 </cartographics>
 </subject>
 </xsl:for-each>
 <xsl:for-each select="marc:datafield[@tag=043]">
 <subject>
 <xsl:for-each select="marc:subfield[@code='a' or @code='b' or @code='c']">
 <geographicCode>
 <xsl:attribute name="authority">
 <xsl:if test="@code='a'">
 <xsl:text>marcgac</xsl:text>
 </xsl:if>
 <xsl:if test="@code='b'">
 <xsl:value-of select="following-sibling::marc:subfield[@code=2]"></xsl:value-of>
 </xsl:if>
 <xsl:if test="@code='c'">
 <xsl:text>iso3166</xsl:text>
 </xsl:if>
 </xsl:attribute>
 <xsl:value-of select="self::marc:subfield"></xsl:value-of>
 </geographicCode>
 </xsl:for-each>
 </subject>
 </xsl:for-each>
 <!-- tmee 2006/11/27 -->
 <xsl:for-each select="marc:datafield[@tag=255]">
 <subject>
 <xsl:for-each select="marc:subfield[@code='a' or @code='b' or @code='c']">
 <cartographics>
 <xsl:if test="@code='a'">
 <scale>
 <xsl:value-of select="."></xsl:value-of>
 </scale>
 </xsl:if>
 <xsl:if test="@code='b'">
 <projection>
 <xsl:value-of select="."></xsl:value-of>
 </projection>
 </xsl:if>
 <xsl:if test="@code='c'">
 <coordinates>
 <xsl:value-of select="."></xsl:value-of>
 </coordinates>
 </xsl:if>
 </cartographics>
 </xsl:for-each>
 </subject>
 </xsl:for-each>
 
 <xsl:apply-templates select="marc:datafield[653 >= @tag and @tag >= 600]"></xsl:apply-templates>
 <xsl:apply-templates select="marc:datafield[@tag=656]"></xsl:apply-templates>
 <xsl:for-each select="marc:datafield[@tag=752]">
 <subject>
 <hierarchicalGeographic>
 <xsl:for-each select="marc:subfield[@code='a']">
 <country>
 <xsl:call-template name="chopPunctuation">
 <xsl:with-param name="chopString" select="."></xsl:with-param>
 </xsl:call-template>
 </country>
 </xsl:for-each>
 <xsl:for-each select="marc:subfield[@code='b']">
 <state>
 <xsl:call-template name="chopPunctuation">
 <xsl:with-param name="chopString" select="."></xsl:with-param>
 </xsl:call-template>
 </state>
 </xsl:for-each>
 <xsl:for-each select="marc:subfield[@code='c']">
 <county>
 <xsl:call-template name="chopPunctuation">
 <xsl:with-param name="chopString" select="."></xsl:with-param>
 </xsl:call-template>
 </county>
 </xsl:for-each>
 <xsl:for-each select="marc:subfield[@code='d']">
 <city>
 <xsl:call-template name="chopPunctuation">
 <xsl:with-param name="chopString" select="."></xsl:with-param>
 </xsl:call-template>
 </city>
 </xsl:for-each>
 </hierarchicalGeographic>
 </subject>
 </xsl:for-each>
 <xsl:for-each select="marc:datafield[@tag=045][marc:subfield[@code='b']]">
 <subject>
 <xsl:choose>
 <xsl:when test="@ind1=2">
 <temporal encoding="iso8601" point="start">
 <xsl:call-template name="chopPunctuation">
 <xsl:with-param name="chopString">
 <xsl:value-of select="marc:subfield[@code='b'][1]"></xsl:value-of>
 </xsl:with-param>
 </xsl:call-template>
 </temporal>
 <temporal encoding="iso8601" point="end">
 <xsl:call-template name="chopPunctuation">
 <xsl:with-param name="chopString">
 <xsl:value-of select="marc:subfield[@code='b'][2]"></xsl:value-of>
 </xsl:with-param>
 </xsl:call-template>
 </temporal>
 </xsl:when>
 <xsl:otherwise>
 <xsl:for-each select="marc:subfield[@code='b']">
 <temporal encoding="iso8601">
 <xsl:call-template name="chopPunctuation">
 <xsl:with-param name="chopString" select="."></xsl:with-param>
 </xsl:call-template>
 </temporal>
 </xsl:for-each>
 </xsl:otherwise>
 </xsl:choose>
 </subject>
 </xsl:for-each>
 <xsl:for-each select="marc:datafield[@tag=050]">
 <xsl:for-each select="marc:subfield[@code='b']">
 <classification authority="lcc">
 <xsl:if test="../marc:subfield[@code='3']">
 <xsl:attribute name="displayLabel">
 <xsl:value-of select="../marc:subfield[@code='3']"></xsl:value-of>
 </xsl:attribute>
 </xsl:if>
 <xsl:value-of select="preceding-sibling::marc:subfield[@code='a'][1]"></xsl:value-of>
 <xsl:text> </xsl:text>
 <xsl:value-of select="text()"></xsl:value-of>
 </classification>
 </xsl:for-each>
 <xsl:for-each select="marc:subfield[@code='a'][not(following-sibling::marc:subfield[@code='b'])]">
 <classification authority="lcc">
 <xsl:if test="../marc:subfield[@code='3']">
 <xsl:attribute name="displayLabel">
 <xsl:value-of select="../marc:subfield[@code='3']"></xsl:value-of>
 </xsl:attribute>
 </xsl:if>
 <xsl:value-of select="text()"></xsl:value-of>
 </classification>
 </xsl:for-each>
 </xsl:for-each>
 <xsl:for-each select="marc:datafield[@tag=082]">
 <classification authority="ddc">
 <xsl:if test="marc:subfield[@code='2']">
 <xsl:attribute name="edition">
 <xsl:value-of select="marc:subfield[@code='2']"></xsl:value-of>
 </xsl:attribute>
 </xsl:if>
 <xsl:call-template name="subfieldSelect">
 <xsl:with-param name="codes">ab</xsl:with-param>
 </xsl:call-template>
 </classification>
 </xsl:for-each>
 <xsl:for-each select="marc:datafield[@tag=080]">
 <classification authority="udc">
 <xsl:call-template name="subfieldSelect">
 <xsl:with-param name="codes">abx</xsl:with-param>
 </xsl:call-template>
 </classification>
 </xsl:for-each>
 <xsl:for-each select="marc:datafield[@tag=060]">
 <classification authority="nlm">
 <xsl:call-template name="subfieldSelect">
 <xsl:with-param name="codes">ab</xsl:with-param>
 </xsl:call-template>
 </classification>
 </xsl:for-each>
 <xsl:for-each select="marc:datafield[@tag=086][@ind1=0]">
 <classification authority="sudocs">
 <xsl:value-of select="marc:subfield[@code='a']"></xsl:value-of>
 </classification>
 </xsl:for-each>
 <xsl:for-each select="marc:datafield[@tag=086][@ind1=1]">
 <classification authority="candoc">
 <xsl:value-of select="marc:subfield[@code='a']"></xsl:value-of>
 </classification>
 </xsl:for-each>
 <xsl:for-each select="marc:datafield[@tag=086]">
 <classification>
 <xsl:attribute name="authority">
 <xsl:value-of select="marc:subfield[@code='2']"></xsl:value-of>
 </xsl:attribute>
 <xsl:value-of select="marc:subfield[@code='a']"></xsl:value-of>
 </classification>
 </xsl:for-each>
 <xsl:for-each select="marc:datafield[@tag=084]">
 <classification>
 <xsl:attribute name="authority">
 <xsl:value-of select="marc:subfield[@code='2']"></xsl:value-of>
 </xsl:attribute>
 <xsl:call-template name="subfieldSelect">
 <xsl:with-param name="codes">ab</xsl:with-param>
 </xsl:call-template>
 </classification>
 </xsl:for-each>
 <xsl:for-each select="marc:datafield[@tag=440]">
 <relatedItem type="series">
 <titleInfo>
 <title>
 <xsl:call-template name="chopPunctuation"> <xsl:with-param name="chopString"> <xsl:call-template name="subfieldSelect"> <xsl:with-param name="codes">av</xsl:with-param> </xsl:call-template> </xsl:with-param> </xsl:call-template> </title>
 <xsl:call-template name="part"></xsl:call-template>
 </titleInfo>
 </relatedItem>
 </xsl:for-each>
 <xsl:for-each select="marc:datafield[@tag=490][@ind1=0]">
 <relatedItem type="series">
 <titleInfo>
 <title>
 <xsl:call-template name="chopPunctuation"> <xsl:with-param name="chopString"> <xsl:call-template name="subfieldSelect"> <xsl:with-param name="codes">av</xsl:with-param> </xsl:call-template> </xsl:with-param> </xsl:call-template> </title>
 <xsl:call-template name="part"></xsl:call-template>
 </titleInfo>
 </relatedItem>
 </xsl:for-each>
 <xsl:for-each select="marc:datafield[@tag=510]">
 <relatedItem type="isReferencedBy">
 <note>
 <xsl:call-template name="subfieldSelect">
 <xsl:with-param name="codes">abcx3</xsl:with-param>
 </xsl:call-template>
 </note>
 </relatedItem>
 </xsl:for-each>
 <xsl:for-each select="marc:datafield[@tag=534]">
 <relatedItem type="original">
 <xsl:call-template name="relatedTitle"></xsl:call-template>
 <xsl:call-template name="relatedName"></xsl:call-template>
 <xsl:if test="marc:subfield[@code='b' or @code='c']">
 <originInfo>
 <xsl:for-each select="marc:subfield[@code='c']">
 <publisher>
 <xsl:value-of select="."></xsl:value-of>
 </publisher>
 </xsl:for-each>
 <xsl:for-each select="marc:subfield[@code='b']">
 <edition>
 <xsl:value-of select="."></xsl:value-of>
 </edition>
 </xsl:for-each>
 </originInfo>
 </xsl:if>
 <xsl:call-template name="relatedIdentifierISSN"></xsl:call-template>
 <xsl:for-each select="marc:subfield[@code='z']">
 <identifier type="isbn">
 <xsl:value-of select="."></xsl:value-of>
 </identifier>
 </xsl:for-each>
 <xsl:call-template name="relatedNote"></xsl:call-template>
 </relatedItem>
 </xsl:for-each>
 <xsl:for-each select="marc:datafield[@tag=700][marc:subfield[@code='t']]">
 <relatedItem>
 <xsl:call-template name="constituentOrRelatedType"></xsl:call-template>
 <titleInfo>
 <title>
 <xsl:call-template name="chopPunctuation"> <xsl:with-param name="chopString"> <xsl:call-template name="specialSubfieldSelect"> <xsl:with-param name="anyCodes">tfklmorsv</xsl:with-param> <xsl:with-param name="axis">t</xsl:with-param> <xsl:with-param name="afterCodes">g</xsl:with-param> </xsl:call-template> </xsl:with-param> </xsl:call-template> </title>
 <xsl:call-template name="part"></xsl:call-template>
 </titleInfo>
 <name type="personal">
 <namePart>
 <xsl:call-template name="specialSubfieldSelect">
 <xsl:with-param name="anyCodes">aq</xsl:with-param>
 <xsl:with-param name="axis">t</xsl:with-param>
 <xsl:with-param name="beforeCodes">g</xsl:with-param>
 </xsl:call-template>
 </namePart>
 <xsl:call-template name="termsOfAddress"></xsl:call-template>
 <xsl:call-template name="nameDate"></xsl:call-template>
 <xsl:call-template name="role"></xsl:call-template>
 </name>
 <xsl:call-template name="relatedForm"></xsl:call-template>
 <xsl:call-template name="relatedIdentifierISSN"></xsl:call-template>
 </relatedItem>
 </xsl:for-each>
 <xsl:for-each select="marc:datafield[@tag=710][marc:subfield[@code='t']]">
 <relatedItem>
 <xsl:call-template name="constituentOrRelatedType"></xsl:call-template>
 <titleInfo>
 <title>
 <xsl:call-template name="chopPunctuation"> <xsl:with-param name="chopString"> <xsl:call-template name="specialSubfieldSelect"> <xsl:with-param name="anyCodes">tfklmorsv</xsl:with-param> <xsl:with-param name="axis">t</xsl:with-param> <xsl:with-param name="afterCodes">dg</xsl:with-param> </xsl:call-template> </xsl:with-param> </xsl:call-template> </title>
 <xsl:call-template name="relatedPartNumName"></xsl:call-template>
 </titleInfo>
 <name type="corporate">
 <xsl:for-each select="marc:subfield[@code='a']">
 <namePart>
 <xsl:value-of select="."></xsl:value-of>
 </namePart>
 </xsl:for-each>
 <xsl:for-each select="marc:subfield[@code='b']">
 <namePart>
 <xsl:value-of select="."></xsl:value-of>
 </namePart>
 </xsl:for-each>
 <xsl:variable name="tempNamePart">
 <xsl:call-template name="specialSubfieldSelect">
 <xsl:with-param name="anyCodes">c</xsl:with-param>
 <xsl:with-param name="axis">t</xsl:with-param>
 <xsl:with-param name="beforeCodes">dgn</xsl:with-param>
 </xsl:call-template>
 </xsl:variable>
 <xsl:if test="normalize-space($tempNamePart)">
 <namePart>
 <xsl:value-of select="$tempNamePart"></xsl:value-of>
 </namePart>
 </xsl:if>
 <xsl:call-template name="role"></xsl:call-template>
 </name>
 <xsl:call-template name="relatedForm"></xsl:call-template>
 <xsl:call-template name="relatedIdentifierISSN"></xsl:call-template>
 </relatedItem>
 </xsl:for-each>
 <xsl:for-each select="marc:datafield[@tag=711][marc:subfield[@code='t']]">
 <relatedItem>
 <xsl:call-template name="constituentOrRelatedType"></xsl:call-template>
 <titleInfo>
 <title>
 <xsl:call-template name="chopPunctuation"> <xsl:with-param name="chopString"> <xsl:call-template name="specialSubfieldSelect"> <xsl:with-param name="anyCodes">tfklsv</xsl:with-param> <xsl:with-param name="axis">t</xsl:with-param> <xsl:with-param name="afterCodes">g</xsl:with-param> </xsl:call-template> </xsl:with-param> </xsl:call-template> </title>
 <xsl:call-template name="relatedPartNumName"></xsl:call-template>
 </titleInfo>
 <name type="conference">
 <namePart>
 <xsl:call-template name="specialSubfieldSelect">
 <xsl:with-param name="anyCodes">aqdc</xsl:with-param>
 <xsl:with-param name="axis">t</xsl:with-param>
 <xsl:with-param name="beforeCodes">gn</xsl:with-param>
 </xsl:call-template>
 </namePart>
 </name>
 <xsl:call-template name="relatedForm"></xsl:call-template>
 <xsl:call-template name="relatedIdentifierISSN"></xsl:call-template>
 </relatedItem>
 </xsl:for-each>
 <xsl:for-each select="marc:datafield[@tag=730][@ind2=2]">
 <relatedItem>
 <xsl:call-template name="constituentOrRelatedType"></xsl:call-template>
 <titleInfo>
 <title>
 <xsl:call-template name="chopPunctuation"> <xsl:with-param name="chopString"> <xsl:call-template name="subfieldSelect"> <xsl:with-param name="codes">adfgklmorsv</xsl:with-param> </xsl:call-template> </xsl:with-param> </xsl:call-template> </title>
 <xsl:call-template name="part"></xsl:call-template>
 </titleInfo>
 <xsl:call-template name="relatedForm"></xsl:call-template>
 <xsl:call-template name="relatedIdentifierISSN"></xsl:call-template>
 </relatedItem>
 </xsl:for-each>
 <xsl:for-each select="marc:datafield[@tag=740][@ind2=2]">
 <relatedItem>
 <xsl:call-template name="constituentOrRelatedType"></xsl:call-template>
 <titleInfo>
 <title>
 <xsl:call-template name="chopPunctuation">
 <xsl:with-param name="chopString">
 <xsl:value-of select="marc:subfield[@code='a']"></xsl:value-of>
 </xsl:with-param>
 </xsl:call-template>
 </title>
 <xsl:call-template name="part"></xsl:call-template>
 </titleInfo>
 <xsl:call-template name="relatedForm"></xsl:call-template>
 </relatedItem>
 </xsl:for-each>
 <xsl:for-each select="marc:datafield[@tag=760]|marc:datafield[@tag=762]">
 <relatedItem type="series">
 <xsl:call-template name="relatedItem76X-78X"></xsl:call-template>
 </relatedItem>
 </xsl:for-each>
 <xsl:for-each select="marc:datafield[@tag=765]|marc:datafield[@tag=767]|marc:datafield[@tag=777]|marc:datafield[@tag=787]">
 <relatedItem>
 <xsl:call-template name="relatedItem76X-78X"></xsl:call-template>
 </relatedItem>
 </xsl:for-each>
 <xsl:for-each select="marc:datafield[@tag=775]">
 <relatedItem type="otherVersion">
 <xsl:call-template name="relatedItem76X-78X"></xsl:call-template>
 </relatedItem>
 </xsl:for-each>
 <xsl:for-each select="marc:datafield[@tag=770]|marc:datafield[@tag=774]">
 <relatedItem type="constituent">
 <xsl:call-template name="relatedItem76X-78X"></xsl:call-template>
 </relatedItem>
 </xsl:for-each>
 <xsl:for-each select="marc:datafield[@tag=772]|marc:datafield[@tag=773]">
 <relatedItem type="host">
 <xsl:call-template name="relatedItem76X-78X"></xsl:call-template>
 </relatedItem>
 </xsl:for-each>
 <xsl:for-each select="marc:datafield[@tag=776]">
 <relatedItem type="otherFormat">
 <xsl:call-template name="relatedItem76X-78X"></xsl:call-template>
 </relatedItem>
 </xsl:for-each>
 <xsl:for-each select="marc:datafield[@tag=780]">
 <relatedItem type="preceding">
 <xsl:call-template name="relatedItem76X-78X"></xsl:call-template>
 </relatedItem>
 </xsl:for-each>
 <xsl:for-each select="marc:datafield[@tag=785]">
 <relatedItem type="succeeding">
 <xsl:call-template name="relatedItem76X-78X"></xsl:call-template>
 </relatedItem>
 </xsl:for-each>
 <xsl:for-each select="marc:datafield[@tag=786]">
 <relatedItem type="original">
 <xsl:call-template name="relatedItem76X-78X"></xsl:call-template>
 </relatedItem>
 </xsl:for-each>
 <xsl:for-each select="marc:datafield[@tag=800]">
 <relatedItem type="series">
 <titleInfo>
 <title>
 <xsl:call-template name="chopPunctuation"> <xsl:with-param name="chopString"> <xsl:call-template name="specialSubfieldSelect"> <xsl:with-param name="anyCodes">tfklmorsv</xsl:with-param> <xsl:with-param name="axis">t</xsl:with-param> <xsl:with-param name="afterCodes">g</xsl:with-param> </xsl:call-template> </xsl:with-param> </xsl:call-template> </title>
 <xsl:call-template name="part"></xsl:call-template>
 </titleInfo>
 <name type="personal">
 <namePart>
 <xsl:call-template name="chopPunctuation">
 <xsl:with-param name="chopString">
 <xsl:call-template name="specialSubfieldSelect">
 <xsl:with-param name="anyCodes">aq</xsl:with-param>
 <xsl:with-param name="axis">t</xsl:with-param>
 <xsl:with-param name="beforeCodes">g</xsl:with-param>
 </xsl:call-template>
 </xsl:with-param>
 </xsl:call-template>
 </namePart>
 <xsl:call-template name="termsOfAddress"></xsl:call-template>
 <xsl:call-template name="nameDate"></xsl:call-template>
 <xsl:call-template name="role"></xsl:call-template>
 </name>
 <xsl:call-template name="relatedForm"></xsl:call-template>
 </relatedItem>
 </xsl:for-each>
 <xsl:for-each select="marc:datafield[@tag=810]">
 <relatedItem type="series">
 <titleInfo>
 <title>
 <xsl:call-template name="chopPunctuation"> <xsl:with-param name="chopString"> <xsl:call-template name="specialSubfieldSelect"> <xsl:with-param name="anyCodes">tfklmorsv</xsl:with-param> <xsl:with-param name="axis">t</xsl:with-param> <xsl:with-param name="afterCodes">dg</xsl:with-param> </xsl:call-template> </xsl:with-param> </xsl:call-template> </title>
 <xsl:call-template name="relatedPartNumName"></xsl:call-template>
 </titleInfo>
 <name type="corporate">
 <xsl:for-each select="marc:subfield[@code='a']">
 <namePart>
 <xsl:value-of select="."></xsl:value-of>
 </namePart>
 </xsl:for-each>
 <xsl:for-each select="marc:subfield[@code='b']">
 <namePart>
 <xsl:value-of select="."></xsl:value-of>
 </namePart>
 </xsl:for-each>
 <namePart>
 <xsl:call-template name="specialSubfieldSelect">
 <xsl:with-param name="anyCodes">c</xsl:with-param>
 <xsl:with-param name="axis">t</xsl:with-param>
 <xsl:with-param name="beforeCodes">dgn</xsl:with-param>
 </xsl:call-template>
 </namePart>
 <xsl:call-template name="role"></xsl:call-template>
 </name>
 <xsl:call-template name="relatedForm"></xsl:call-template>
 </relatedItem>
 </xsl:for-each>
 <xsl:for-each select="marc:datafield[@tag=811]">
 <relatedItem type="series">
 <titleInfo>
 <title>
 <xsl:call-template name="chopPunctuation"> <xsl:with-param name="chopString"> <xsl:call-template name="specialSubfieldSelect"> <xsl:with-param name="anyCodes">tfklsv</xsl:with-param> <xsl:with-param name="axis">t</xsl:with-param> <xsl:with-param name="afterCodes">g</xsl:with-param> </xsl:call-template> </xsl:with-param> </xsl:call-template> </title>
 <xsl:call-template name="relatedPartNumName"/>
 </titleInfo>
 <name type="conference">
 <namePart>
 <xsl:call-template name="specialSubfieldSelect">
 <xsl:with-param name="anyCodes">aqdc</xsl:with-param>
 <xsl:with-param name="axis">t</xsl:with-param>
 <xsl:with-param name="beforeCodes">gn</xsl:with-param>
 </xsl:call-template>
 </namePart>
 <xsl:call-template name="role"/>
 </name>
 <xsl:call-template name="relatedForm"/>
 </relatedItem>
 </xsl:for-each>
 <xsl:for-each select="marc:datafield[@tag='830']">
 <relatedItem type="series">
 <titleInfo>
 <title>
 <xsl:call-template name="chopPunctuation"> <xsl:with-param name="chopString"> <xsl:call-template name="subfieldSelect"> <xsl:with-param name="codes">adfgklmorsv</xsl:with-param> </xsl:call-template> </xsl:with-param> </xsl:call-template> </title>
 <xsl:call-template name="part"/>
 </titleInfo>
 <xsl:call-template name="relatedForm"/>
 </relatedItem>
 </xsl:for-each>
 <xsl:for-each select="marc:datafield[@tag='856'][@ind2='2']/marc:subfield[@code='q']">
 <relatedItem>
 <internetMediaType>
 <xsl:value-of select="."/>
 </internetMediaType>
 </relatedItem>
 </xsl:for-each>
 <xsl:for-each select="marc:datafield[@tag='020']">
 <xsl:call-template name="isInvalid">
 <xsl:with-param name="type">isbn</xsl:with-param>
 </xsl:call-template>
 <xsl:if test="marc:subfield[@code='a']">
 <identifier type="isbn">
 <xsl:value-of select="marc:subfield[@code='a']"/>
 </identifier>
 </xsl:if>
 </xsl:for-each>
 <xsl:for-each select="marc:datafield[@tag='024'][@ind1='0']">
 <xsl:call-template name="isInvalid">
 <xsl:with-param name="type">isrc</xsl:with-param>
 </xsl:call-template>
 <xsl:if test="marc:subfield[@code='a']">
 <identifier type="isrc">
 <xsl:value-of select="marc:subfield[@code='a']"/>
 </identifier>
 </xsl:if>
 </xsl:for-each>
 <xsl:for-each select="marc:datafield[@tag='024'][@ind1='2']">
 <xsl:call-template name="isInvalid">
 <xsl:with-param name="type">ismn</xsl:with-param>
 </xsl:call-template>
 <xsl:if test="marc:subfield[@code='a']">
 <identifier type="ismn">
 <xsl:value-of select="marc:subfield[@code='a']"/>
 </identifier>
 </xsl:if>
 </xsl:for-each>
 <xsl:for-each select="marc:datafield[@tag='024'][@ind1='4']">
 <xsl:call-template name="isInvalid">
 <xsl:with-param name="type">sici</xsl:with-param>
 </xsl:call-template>
 <identifier type="sici">
 <xsl:call-template name="subfieldSelect">
 <xsl:with-param name="codes">ab</xsl:with-param>
 </xsl:call-template>
 </identifier>
 </xsl:for-each>
 <xsl:for-each select="marc:datafield[@tag='022']">
 <xsl:call-template name="isInvalid">
 <xsl:with-param name="type">issn</xsl:with-param>
 </xsl:call-template>
 <identifier type="issn">
 <xsl:value-of select="marc:subfield[@code='a']"/>
 </identifier>
 </xsl:for-each>
 <xsl:for-each select="marc:datafield[@tag='010']">
 <xsl:call-template name="isInvalid">
 <xsl:with-param name="type">lccn</xsl:with-param>
 </xsl:call-template>
 <identifier type="lccn">
 <xsl:value-of select="normalize-space(marc:subfield[@code='a'])"/>
 </identifier>
 </xsl:for-each>
 <xsl:for-each select="marc:datafield[@tag='028']">
 <identifier>
 <xsl:attribute name="type">
 <xsl:choose>
 <xsl:when test="@ind1='0'">número de ejemplar</xsl:when>
 <xsl:when test="@ind1='1'">Número de Carnet</xsl:when>
 <xsl:when test="@ind1='2'">plancha musical</xsl:when>
 <xsl:when test="@ind1='3'">editor musical</xsl:when>
 <xsl:when test="@ind1='4'">identificador de grabación</xsl:when>
 </xsl:choose>
 </xsl:attribute>
 <!--<xsl:call-template name="isInvalid"/>--> <!-- no $z in 028 -->
 <xsl:call-template name="subfieldSelect">
 <xsl:with-param name="codes">
 <xsl:choose>
 <xsl:when test="@ind1='0'">ba</xsl:when>
 <xsl:otherwise>ab</xsl:otherwise>
 </xsl:choose>
 </xsl:with-param>
 </xsl:call-template>
 </identifier>
 </xsl:for-each>
 <xsl:for-each select="marc:datafield[@tag='037']">
 <identifier type="stock number">
 <!--<xsl:call-template name="isInvalid"/>--> <!-- no $z in 037 -->
 <xsl:call-template name="subfieldSelect">
 <xsl:with-param name="codes">ab</xsl:with-param>
 </xsl:call-template>
 </identifier>
 </xsl:for-each>
 <xsl:for-each select="marc:datafield[@tag='856'][marc:subfield[@code='u']]">
 <identifier>
 <xsl:attribute name="type">
 <xsl:choose>
 <xsl:when test="starts-with(marc:subfield[@code='u'],'urn:doi') or starts-with(marc:subfield[@code='u'],'doi')">doi</xsl:when>
 <xsl:when test="starts-with(marc:subfield[@code='u'],'urn:hdl') or starts-with(marc:subfield[@code='u'],'hdl') or starts-with(marc:subfield[@code='u'],'http://hdl.loc.gov')">hdl</xsl:when>
 <xsl:otherwise>uri</xsl:otherwise>
 </xsl:choose>
 </xsl:attribute>
 <xsl:choose>
 <xsl:when test="starts-with(marc:subfield[@code='u'],'urn:hdl') or starts-with(marc:subfield[@code='u'],'hdl') or starts-with(marc:subfield[@code='u'],'http://hdl.loc.gov') ">
 <xsl:value-of select="concat('hdl:',substring-after(marc:subfield[@code='u'],'http://hdl.loc.gov/'))"></xsl:value-of>
 </xsl:when>
 <xsl:otherwise>
 <xsl:value-of select="marc:subfield[@code='u']"></xsl:value-of>
 </xsl:otherwise>
 </xsl:choose>
 </identifier>
 <xsl:if test="starts-with(marc:subfield[@code='u'],'urn:hdl') or starts-with(marc:subfield[@code='u'],'hdl')">
 <identifier type="hdl">
 <xsl:if test="marc:subfield[@code='y' or @code='3' or @code='z']">
 <xsl:attribute name="displayLabel">
 <xsl:call-template name="subfieldSelect">
 <xsl:with-param name="codes">y3z</xsl:with-param>
 </xsl:call-template>
 </xsl:attribute>
 </xsl:if>
 <xsl:value-of select="concat('hdl:',substring-after(marc:subfield[@code='u'],'http://hdl.loc.gov/'))"></xsl:value-of>
 </identifier>
 </xsl:if>
 </xsl:for-each>
 <xsl:for-each select="marc:datafield[@tag=024][@ind1=1]">
 <identifier type="upc">
 <xsl:call-template name="isInvalid"/>
 <xsl:value-of select="marc:subfield[@code='a']"/>
 </identifier>
 </xsl:for-each>
 <!-- 1/04 fix added $y -->
 <xsl:for-each select="marc:datafield[@tag=856][marc:subfield[@code='u']]">
 <location>
 <url>
 <xsl:if test="marc:subfield[@code='y' or @code='3']">
 <xsl:attribute name="displayLabel">
 <xsl:call-template name="subfieldSelect">
 <xsl:with-param name="codes">y3</xsl:with-param>
 </xsl:call-template>
 </xsl:attribute>
 </xsl:if>
 <xsl:if test="marc:subfield[@code='z' ]">
 <xsl:attribute name="note">
 <xsl:call-template name="subfieldSelect">
 <xsl:with-param name="codes">z</xsl:with-param>
 </xsl:call-template>
 </xsl:attribute>
 </xsl:if>
 <xsl:value-of select="marc:subfield[@code='u']"></xsl:value-of>

 </url>
 </location>
 </xsl:for-each>
 
 <!-- 3.2 change tmee 856z -->

 
 <xsl:for-each select="marc:datafield[@tag=852]">
 <location>
 <physicalLocation>
 <xsl:call-template name="displayLabel"></xsl:call-template>
 <xsl:call-template name="subfieldSelect">
 <xsl:with-param name="codes">abje</xsl:with-param>
 </xsl:call-template>
 </physicalLocation>
 </location>
 </xsl:for-each>
 <xsl:for-each select="marc:datafield[@tag=506]">
 <accessCondition type="restrictionOnAccess">
 <xsl:call-template name="subfieldSelect">
 <xsl:with-param name="codes">abcd35</xsl:with-param>
 </xsl:call-template>
 </accessCondition>
 </xsl:for-each>
 <xsl:for-each select="marc:datafield[@tag=540]">
 <accessCondition type="useAndReproduction">
 <xsl:call-template name="subfieldSelect">
 <xsl:with-param name="codes">abcde35</xsl:with-param>
 </xsl:call-template>
 </accessCondition>
 </xsl:for-each>
 <recordInfo>
 <xsl:for-each select="marc:datafield[@tag=040]">
 <recordContentSource authority="marcorg">
 <xsl:value-of select="marc:subfield[@code='a']"></xsl:value-of>
 </recordContentSource>
 </xsl:for-each>
 <xsl:for-each select="marc:controlfield[@tag=008]">
 <recordCreationDate encoding="marc">
 <xsl:value-of select="substring(.,1,6)"></xsl:value-of>
 </recordCreationDate>
 </xsl:for-each>
 <xsl:for-each select="marc:controlfield[@tag=005]">
 <recordChangeDate encoding="iso8601">
 <xsl:value-of select="."></xsl:value-of>
 </recordChangeDate>
 </xsl:for-each>
 <xsl:for-each select="marc:controlfield[@tag=001]">
 <recordIdentifier>
 <xsl:if test="../marc:controlfield[@tag=003]">
 <xsl:attribute name="source">
 <xsl:value-of select="../marc:controlfield[@tag=003]"></xsl:value-of>
 </xsl:attribute>
 </xsl:if>
 <xsl:value-of select="."></xsl:value-of>
 </recordIdentifier>
 </xsl:for-each>
 <xsl:for-each select="marc:datafield[@tag=040]/marc:subfield[@code='b']">
 <languageOfCataloging>
 <languageTerm authority="iso639-2b" type="code">
 <xsl:value-of select="."></xsl:value-of>
 </languageTerm>
 </languageOfCataloging>
 </xsl:for-each>
 </recordInfo>
 </xsl:template>
 <xsl:template name="displayForm">
 <xsl:for-each select="marc:subfield[@code='c']">
 <displayForm>
 <xsl:value-of select="."></xsl:value-of>
 </displayForm>
 </xsl:for-each>
 </xsl:template>
 <xsl:template name="affiliation">
 <xsl:for-each select="marc:subfield[@code='u']">
 <affiliation>
 <xsl:value-of select="."></xsl:value-of>
 </affiliation>
 </xsl:for-each>
 </xsl:template>
 <xsl:template name="uri">
 <xsl:for-each select="marc:subfield[@code='u']">
 <xsl:attribute name="xlink:href">
 <xsl:value-of select="."></xsl:value-of>
 </xsl:attribute>
 </xsl:for-each>
 </xsl:template>
 <xsl:template name="role">
 <xsl:for-each select="marc:subfield[@code='e']">
 <role>
 <roleTerm type="text">
 <xsl:value-of select="."></xsl:value-of>
 </roleTerm>
 </role>
 </xsl:for-each>
 <xsl:for-each select="marc:subfield[@code='4']">
 <role>
 <roleTerm authority="marcrelator" type="code">
 <xsl:value-of select="."></xsl:value-of>
 </roleTerm>
 </role>
 </xsl:for-each>
 </xsl:template>
 <xsl:template name="part">
 <xsl:variable name="partNumber">
 <xsl:call-template name="specialSubfieldSelect">
 <xsl:with-param name="axis">n</xsl:with-param>
 <xsl:with-param name="anyCodes">n</xsl:with-param>
 <xsl:with-param name="afterCodes">fgkdlmor</xsl:with-param>
 </xsl:call-template>
 </xsl:variable>
 <xsl:variable name="partName">
 <xsl:call-template name="specialSubfieldSelect">
 <xsl:with-param name="axis">p</xsl:with-param>
 <xsl:with-param name="anyCodes">p</xsl:with-param>
 <xsl:with-param name="afterCodes">fgkdlmor</xsl:with-param>
 </xsl:call-template>
 </xsl:variable>
 <xsl:if test="string-length(normalize-space($partNumber))">
 <partNumber>
 <xsl:call-template name="chopPunctuation">
 <xsl:with-param name="chopString" select="$partNumber"></xsl:with-param>
 </xsl:call-template>
 </partNumber>
 </xsl:if>
 <xsl:if test="string-length(normalize-space($partName))">
 <partName>
 <xsl:call-template name="chopPunctuation">
 <xsl:with-param name="chopString" select="$partName"></xsl:with-param>
 </xsl:call-template>
 </partName>
 </xsl:if>
 </xsl:template>
 <xsl:template name="relatedPart">
 <xsl:if test="@tag=773">
 <xsl:for-each select="marc:subfield[@code='g']">
 <part>
 <text>
 <xsl:value-of select="."></xsl:value-of>
 </text>
 </part>
 </xsl:for-each>
 <xsl:for-each select="marc:subfield[@code='q']">
 <part>
 <xsl:call-template name="parsePart"></xsl:call-template>
 </part>
 </xsl:for-each>
 </xsl:if>
 </xsl:template>
 <xsl:template name="relatedPartNumName">
 <xsl:variable name="partNumber">
 <xsl:call-template name="specialSubfieldSelect">
 <xsl:with-param name="axis">g</xsl:with-param>
 <xsl:with-param name="anyCodes">g</xsl:with-param>
 <xsl:with-param name="afterCodes">pst</xsl:with-param>
 </xsl:call-template>
 </xsl:variable>
 <xsl:variable name="partName">
 <xsl:call-template name="specialSubfieldSelect">
 <xsl:with-param name="axis">p</xsl:with-param>
 <xsl:with-param name="anyCodes">p</xsl:with-param>
 <xsl:with-param name="afterCodes">fgkdlmor</xsl:with-param>
 </xsl:call-template>
 </xsl:variable>
 <xsl:if test="string-length(normalize-space($partNumber))">
 <partNumber>
 <xsl:value-of select="$partNumber"></xsl:value-of>
 </partNumber>
 </xsl:if>
 <xsl:if test="string-length(normalize-space($partName))">
 <partName>
 <xsl:value-of select="$partName"></xsl:value-of>
 </partName>
 </xsl:if>
 </xsl:template>
 <xsl:template name="relatedName">
 <xsl:for-each select="marc:subfield[@code='a']">
 <name>
 <namePart>
 <xsl:value-of select="."></xsl:value-of>
 </namePart>
 </name>
 </xsl:for-each>
 </xsl:template>
 <xsl:template name="relatedForm">
 <xsl:for-each select="marc:subfield[@code='h']">
 <physicalDescription>
 <form>
 <xsl:value-of select="."></xsl:value-of>
 </form>
 </physicalDescription>
 </xsl:for-each>
 </xsl:template>
 <xsl:template name="relatedExtent">
 <xsl:for-each select="marc:subfield[@code='h']">
 <physicalDescription>
 <extent>
 <xsl:value-of select="."></xsl:value-of>
 </extent>
 </physicalDescription>
 </xsl:for-each>
 </xsl:template>
 <xsl:template name="relatedNote">
 <xsl:for-each select="marc:subfield[@code='n']">
 <note>
 <xsl:value-of select="."></xsl:value-of>
 </note>
 </xsl:for-each>
 </xsl:template>
 <xsl:template name="relatedSubject">
 <xsl:for-each select="marc:subfield[@code='j']">
 <subject>
 <temporal encoding="iso8601">
 <xsl:call-template name="chopPunctuation">
 <xsl:with-param name="chopString" select="."></xsl:with-param>
 </xsl:call-template>
 </temporal>
 </subject>
 </xsl:for-each>
 </xsl:template>
 <xsl:template name="relatedIdentifierISSN">
 <xsl:for-each select="marc:subfield[@code='x']">
 <identifier type="issn">
 <xsl:value-of select="."></xsl:value-of>
 </identifier>
 </xsl:for-each>
 </xsl:template>
 <xsl:template name="relatedIdentifierLocal">
 <xsl:for-each select="marc:subfield[@code='w']">
 <identifier type="local">
 <xsl:value-of select="."></xsl:value-of>
 </identifier>
 </xsl:for-each>
 </xsl:template>
 <xsl:template name="relatedIdentifier">
 <xsl:for-each select="marc:subfield[@code='o']">
 <identifier>
 <xsl:value-of select="."></xsl:value-of>
 </identifier>
 </xsl:for-each>
 </xsl:template>
 <xsl:template name="relatedItem76X-78X">
 <xsl:call-template name="displayLabel"></xsl:call-template>
 <xsl:call-template name="relatedTitle76X-78X"></xsl:call-template>
 <xsl:call-template name="relatedName"></xsl:call-template>
 <xsl:call-template name="relatedOriginInfo"></xsl:call-template>
 <xsl:call-template name="relatedLanguage"></xsl:call-template>
 <xsl:call-template name="relatedExtent"></xsl:call-template>
 <xsl:call-template name="relatedNote"></xsl:call-template>
 <xsl:call-template name="relatedSubject"></xsl:call-template>
 <xsl:call-template name="relatedIdentifier"></xsl:call-template>
 <xsl:call-template name="relatedIdentifierISSN"></xsl:call-template>
 <xsl:call-template name="relatedIdentifierLocal"></xsl:call-template>
 <xsl:call-template name="relatedPart"></xsl:call-template>
 </xsl:template>
 <xsl:template name="subjectGeographicZ">
 <geographic>
 <xsl:call-template name="chopPunctuation">
 <xsl:with-param name="chopString" select="."></xsl:with-param>
 </xsl:call-template>
 </geographic>
 </xsl:template>
 <xsl:template name="subjectTemporalY">
 <temporal>
 <xsl:call-template name="chopPunctuation">
 <xsl:with-param name="chopString" select="."></xsl:with-param>
 </xsl:call-template>
 </temporal>
 </xsl:template>
 <xsl:template name="subjectTopic">
 <topic>
 <xsl:call-template name="chopPunctuation">
 <xsl:with-param name="chopString" select="."></xsl:with-param>
 </xsl:call-template>
 </topic>
 </xsl:template> 
 <!-- 3.2 change tmee 6xx $v genre -->
 <xsl:template name="subjectGenre">
 <genre>
 <xsl:call-template name="chopPunctuation">
 <xsl:with-param name="chopString" select="."></xsl:with-param>
 </xsl:call-template>
 </genre>
 </xsl:template>
 
 <xsl:template name="nameABCDN">
 <xsl:for-each select="marc:subfield[@code='a']">
 <namePart>
 <xsl:call-template name="chopPunctuation">
 <xsl:with-param name="chopString" select="."></xsl:with-param>
 </xsl:call-template>
 </namePart>
 </xsl:for-each>
 <xsl:for-each select="marc:subfield[@code='b']">
 <namePart>
 <xsl:value-of select="."></xsl:value-of>
 </namePart>
 </xsl:for-each>
 <xsl:if test="marc:subfield[@code='c'] or marc:subfield[@code='d'] or marc:subfield[@code='n']">
 <namePart>
 <xsl:call-template name="subfieldSelect">
 <xsl:with-param name="codes">cdn</xsl:with-param>
 </xsl:call-template>
 </namePart>
 </xsl:if>
 </xsl:template>
 <xsl:template name="nameABCDQ">
 <namePart>
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
 </namePart>
 <xsl:call-template name="termsOfAddress"></xsl:call-template>
 <xsl:call-template name="nameDate"></xsl:call-template>
 </xsl:template>
 <xsl:template name="nameACDEQ">
 <namePart>
 <xsl:call-template name="subfieldSelect">
 <xsl:with-param name="codes">acdeq</xsl:with-param>
 </xsl:call-template>
 </namePart>
 </xsl:template>
 <xsl:template name="constituentOrRelatedType">
 <xsl:if test="@ind2=2">
 <xsl:attribute name="type">constituyente</xsl:attribute>
 </xsl:if>
 </xsl:template>
 <xsl:template name="relatedTitle">
 <xsl:for-each select="marc:subfield[@code='t']">
 <titleInfo>
 <title>
 <xsl:call-template name="chopPunctuation">
 <xsl:with-param name="chopString">
 <xsl:value-of select="."></xsl:value-of>
 </xsl:with-param>
 </xsl:call-template>
 </title>
 </titleInfo>
 </xsl:for-each>
 </xsl:template>
 <xsl:template name="relatedTitle76X-78X">
 <xsl:for-each select="marc:subfield[@code='t']">
 <titleInfo>
 <title>
 <xsl:call-template name="chopPunctuation">
 <xsl:with-param name="chopString">
 <xsl:value-of select="."></xsl:value-of>
 </xsl:with-param>
 </xsl:call-template>
 </title>
 <xsl:if test="marc:datafield[@tag!=773]and marc:subfield[@code='g']">
 <xsl:call-template name="relatedPartNumName"></xsl:call-template>
 </xsl:if>
 </titleInfo>
 </xsl:for-each>
 <xsl:for-each select="marc:subfield[@code='p']">
 <titleInfo type="abbreviated">
 <title>
 <xsl:call-template name="chopPunctuation">
 <xsl:with-param name="chopString">
 <xsl:value-of select="."></xsl:value-of>
 </xsl:with-param>
 </xsl:call-template>
 </title>
 <xsl:if test="marc:datafield[@tag!=773]and marc:subfield[@code='g']">
 <xsl:call-template name="relatedPartNumName"></xsl:call-template>
 </xsl:if>
 </titleInfo>
 </xsl:for-each>
 <xsl:for-each select="marc:subfield[@code='s']">
 <titleInfo type="uniform">
 <title>
 <xsl:call-template name="chopPunctuation">
 <xsl:with-param name="chopString">
 <xsl:value-of select="."></xsl:value-of>
 </xsl:with-param>
 </xsl:call-template>
 </title>
 <xsl:if test="marc:datafield[@tag!=773]and marc:subfield[@code='g']">
 <xsl:call-template name="relatedPartNumName"></xsl:call-template>
 </xsl:if>
 </titleInfo>
 </xsl:for-each>
 </xsl:template>
 <xsl:template name="relatedOriginInfo">
 <xsl:if test="marc:subfield[@code='b' or @code='d'] or marc:subfield[@code='f']">
 <originInfo>
 <xsl:if test="@tag=775">
 <xsl:for-each select="marc:subfield[@code='f']">
 <place>
 <placeTerm>
 <xsl:attribute name="type">código</xsl:attribute>
 <xsl:attribute name="authority">marcgac</xsl:attribute>
 <xsl:value-of select="."></xsl:value-of>
 </placeTerm>
 </place>
 </xsl:for-each>
 </xsl:if>
 <xsl:for-each select="marc:subfield[@code='d']">
 <publisher>
 <xsl:value-of select="."></xsl:value-of>
 </publisher>
 </xsl:for-each>
 <xsl:for-each select="marc:subfield[@code='b']">
 <edition>
 <xsl:value-of select="."></xsl:value-of>
 </edition>
 </xsl:for-each>
 </originInfo>
 </xsl:if>
 </xsl:template>
 <xsl:template name="relatedLanguage">
 <xsl:for-each select="marc:subfield[@code='e']">
 <xsl:call-template name="getLanguage">
 <xsl:with-param name="langString">
 <xsl:value-of select="."></xsl:value-of>
 </xsl:with-param>
 </xsl:call-template>
 </xsl:for-each>
 </xsl:template>
 <xsl:template name="nameDate">
 <xsl:for-each select="marc:subfield[@code='d']">
 <namePart type="date">
 <xsl:call-template name="chopPunctuation">
 <xsl:with-param name="chopString" select="."></xsl:with-param>
 </xsl:call-template>
 </namePart>
 </xsl:for-each>
 </xsl:template>
 <xsl:template name="subjectAuthority">
 <xsl:if test="@ind2!=4">
 <xsl:if test="@ind2!=' '">
 <xsl:if test="@ind2!=8">
 <xsl:if test="@ind2!=9">
 <xsl:attribute name="authority">
 <xsl:choose>
 <xsl:when test="@ind2=0">lcsh</xsl:when>
 <xsl:when test="@ind2=1">lcshac</xsl:when>
 <xsl:when test="@ind2=2">mesh</xsl:when>
 <!-- 1/04 fix -->
 <xsl:when test="@ind2=3">nal</xsl:when>
 <xsl:when test="@ind2=5">csh</xsl:when>
 <xsl:when test="@ind2=6">rvm</xsl:when>
 <xsl:when test="@ind2=7">
 <xsl:value-of select="marc:subfield[@code='2']"></xsl:value-of>
 </xsl:when>
 </xsl:choose>
 </xsl:attribute>
 </xsl:if>
 </xsl:if>
 </xsl:if>
 </xsl:if>
 </xsl:template>
 <xsl:template name="subjectAnyOrder">
 <xsl:for-each select="marc:subfield[@code='v' or @code='x' or @code='y' or @code='z']">
 <xsl:choose>
 <xsl:when test="@code='v'">
 <xsl:call-template name="subjectGenre"></xsl:call-template>
 </xsl:when>
 <xsl:when test="@code='x'">
 <xsl:call-template name="subjectTopic"></xsl:call-template>
 </xsl:when>
 <xsl:when test="@code='y'">
 <xsl:call-template name="subjectTemporalY"></xsl:call-template>
 </xsl:when>
 <xsl:when test="@code='z'">
 <xsl:call-template name="subjectGeographicZ"></xsl:call-template>
 </xsl:when>
 </xsl:choose>
 </xsl:for-each>
 </xsl:template>
 <xsl:template name="specialSubfieldSelect">
 <xsl:param name="anyCodes"></xsl:param>
 <xsl:param name="axis"></xsl:param>
 <xsl:param name="beforeCodes"></xsl:param>
 <xsl:param name="afterCodes"></xsl:param>
 <xsl:variable name="str">
 <xsl:for-each select="marc:subfield">
 <xsl:if test="contains($anyCodes, @code)      or (contains($beforeCodes,@code) and following-sibling::marc:subfield[@code=$axis])      or (contains($afterCodes,@code) and preceding-sibling::marc:subfield[@code=$axis])">
 <xsl:value-of select="text()"></xsl:value-of>
 <xsl:text> </xsl:text>
 </xsl:if>
 </xsl:for-each>
 </xsl:variable>
 <xsl:value-of select="substring($str,1,string-length($str)-1)"></xsl:value-of>
 </xsl:template>
 
 <!-- 3.2 change tmee 6xx $v genre -->
 <xsl:template match="marc:datafield[@tag=600]">
 <subject>
 <xsl:call-template name="subjectAuthority"></xsl:call-template>
 <name type="personal">
 <xsl:call-template name="termsOfAddress"></xsl:call-template>
 <namePart>
 <xsl:call-template name="chopPunctuation">
 <xsl:with-param name="chopString">
 <xsl:call-template name="subfieldSelect">
 <xsl:with-param name="codes">aq</xsl:with-param>
 </xsl:call-template>
 </xsl:with-param>
 </xsl:call-template>
 </namePart>
 <xsl:call-template name="nameDate"></xsl:call-template>
 <xsl:call-template name="affiliation"></xsl:call-template>
 <xsl:call-template name="role"></xsl:call-template>
 </name>
 <xsl:call-template name="subjectAnyOrder"></xsl:call-template>
 </subject>
 </xsl:template>
 <xsl:template match="marc:datafield[@tag=610]">
 <subject>
 <xsl:call-template name="subjectAuthority"></xsl:call-template>
 <name type="corporate">
 <xsl:for-each select="marc:subfield[@code='a']">
 <namePart>
 <xsl:value-of select="."></xsl:value-of>
 </namePart>
 </xsl:for-each>
 <xsl:for-each select="marc:subfield[@code='b']">
 <namePart>
 <xsl:value-of select="."></xsl:value-of>
 </namePart>
 </xsl:for-each>
 <xsl:if test="marc:subfield[@code='c' or @code='d' or @code='n' or @code='p']">
 <namePart>
 <xsl:call-template name="subfieldSelect">
 <xsl:with-param name="codes">cdnp</xsl:with-param>
 </xsl:call-template>
 </namePart>
 </xsl:if>
 <xsl:call-template name="role"></xsl:call-template>
 </name>
 <xsl:call-template name="subjectAnyOrder"></xsl:call-template>
 </subject>
 </xsl:template>
 <xsl:template match="marc:datafield[@tag=611]">
 <subject>
 <xsl:call-template name="subjectAuthority"></xsl:call-template>
 <name type="conference">
 <namePart>
 <xsl:call-template name="subfieldSelect">
 <xsl:with-param name="codes">abcdeqnp</xsl:with-param>
 </xsl:call-template>
 </namePart>
 <xsl:for-each select="marc:subfield[@code='4']">
 <role>
 <roleTerm authority="marcrelator" type="code">
 <xsl:value-of select="."></xsl:value-of>
 </roleTerm>
 </role>
 </xsl:for-each>
 </name>
 <xsl:call-template name="subjectAnyOrder"></xsl:call-template>
 </subject>
 </xsl:template>
 <xsl:template match="marc:datafield[@tag=630]">
 <subject>
 <xsl:call-template name="subjectAuthority"></xsl:call-template>
 <titleInfo>
 <title>
 <xsl:call-template name="chopPunctuation"> <xsl:with-param name="chopString"> <xsl:call-template name="subfieldSelect"> <xsl:with-param name="codes">adfhklor</xsl:with-param> </xsl:call-template> </xsl:with-param> </xsl:call-template> <xsl:call-template name="part"></xsl:call-template> </title>
 </titleInfo>
 <xsl:call-template name="subjectAnyOrder"></xsl:call-template>
 </subject>
 </xsl:template>
 <xsl:template match="marc:datafield[@tag=650]">
 <subject>
 <xsl:call-template name="subjectAuthority"></xsl:call-template>
 <topic>
 <xsl:call-template name="chopPunctuation">
 <xsl:with-param name="chopString">
 <xsl:call-template name="subfieldSelect">
 <xsl:with-param name="codes">abcd</xsl:with-param>
 </xsl:call-template>
 </xsl:with-param>
 </xsl:call-template>
 </topic>
 <xsl:call-template name="subjectAnyOrder"></xsl:call-template>
 </subject>
 </xsl:template>
 <xsl:template match="marc:datafield[@tag=651]">
 <subject>
 <xsl:call-template name="subjectAuthority"></xsl:call-template>
 <xsl:for-each select="marc:subfield[@code='a']">
 <geographic>
 <xsl:call-template name="chopPunctuation">
 <xsl:with-param name="chopString" select="."></xsl:with-param>
 </xsl:call-template>
 </geographic>
 </xsl:for-each>
 <xsl:call-template name="subjectAnyOrder"></xsl:call-template>
 </subject>
 </xsl:template>
 <xsl:template match="marc:datafield[@tag=653]">
 <subject>
 <xsl:for-each select="marc:subfield[@code='a']">
 <topic>
 <xsl:value-of select="."></xsl:value-of>
 </topic>
 </xsl:for-each>
 </subject>
 </xsl:template>
 <xsl:template match="marc:datafield[@tag=656]">
 <subject>
 <xsl:if test="marc:subfield[@code=2]">
 <xsl:attribute name="authority">
 <xsl:value-of select="marc:subfield[@code=2]"></xsl:value-of>
 </xsl:attribute>
 </xsl:if>
 <occupation>
 <xsl:call-template name="chopPunctuation">
 <xsl:with-param name="chopString">
 <xsl:value-of select="marc:subfield[@code='a']"></xsl:value-of>
 </xsl:with-param>
 </xsl:call-template>
 </occupation>
 </subject>
 </xsl:template>
 <xsl:template name="termsOfAddress">
 <xsl:if test="marc:subfield[@code='b' or @code='c']">
 <namePart type="termsOfAddress">
 <xsl:call-template name="chopPunctuation">
 <xsl:with-param name="chopString">
 <xsl:call-template name="subfieldSelect">
 <xsl:with-param name="codes">bc</xsl:with-param>
 </xsl:call-template>
 </xsl:with-param>
 </xsl:call-template>
 </namePart>
 </xsl:if>
 </xsl:template>
 <xsl:template name="displayLabel">
 <xsl:if test="marc:subfield[@code='i']">
 <xsl:attribute name="displayLabel">
 <xsl:value-of select="marc:subfield[@code='i']"></xsl:value-of>
 </xsl:attribute>
 </xsl:if>
 <xsl:if test="marc:subfield[@code='3']">
 <xsl:attribute name="displayLabel">
 <xsl:value-of select="marc:subfield[@code='3']"></xsl:value-of>
 </xsl:attribute>
 </xsl:if>
 </xsl:template>
 <xsl:template name="isInvalid">
 <xsl:param name="type"/>
 <xsl:if test="marc:subfield[@code='z'] or marc:subfield[@code='y']">
 <identifier>
 <xsl:attribute name="type">
 <xsl:value-of select="$type"/>
 </xsl:attribute>
 <xsl:attribute name="invalid">
 <xsl:text>Sí</xsl:text>
 </xsl:attribute>
 <xsl:if test="marc:subfield[@code='z']">
 <xsl:value-of select="marc:subfield[@code='z']"/>
 </xsl:if>
 <xsl:if test="marc:subfield[@code='y']">
 <xsl:value-of select="marc:subfield[@code='y']"/>
 </xsl:if>
 </identifier>
 </xsl:if>
 </xsl:template>
 <xsl:template name="subtitle">
 <xsl:if test="marc:subfield[@code='b']">
 <subTitle>
 <xsl:call-template name="chopPunctuation">
 <xsl:with-param name="chopString">
 <xsl:value-of select="marc:subfield[@code='b']"/>
 <!--<xsl:call-template name="subfieldSelect">
 <xsl:with-param name="codes">b</xsl:with-param> 
 </xsl:call-template>-->
 </xsl:with-param>
 </xsl:call-template>
 </subTitle>
 </xsl:if>
 </xsl:template>
 <xsl:template name="script">
 <xsl:param name="scriptCode"></xsl:param>
 <xsl:attribute name="script">
 <xsl:choose>
 <xsl:when test="$scriptCode='(3'">Árabe</xsl:when>
 <xsl:when test="$scriptCode='(B'">Latín</xsl:when>
 <xsl:when test="$scriptCode='$1'">Chino, Japonés, Coreano</xsl:when>
 <xsl:when test="$scriptCode='(N'">Cirílico</xsl:when>
 <xsl:when test="$scriptCode='(2'">Hebreo</xsl:when>
 <xsl:when test="$scriptCode='(S'">Griego</xsl:when>
 </xsl:choose>
 </xsl:attribute>
 </xsl:template>
 <xsl:template name="parsePart">
 <!-- assumes 773$q= 1:2:3<4
 with up to 3 levels and one optional start page
 -->
 <xsl:variable name="level1">
 <xsl:choose>
 <xsl:when test="contains(text(),':')">
 <!-- 1:2 -->
 <xsl:value-of select="substring-before(text(),':')"></xsl:value-of>
 </xsl:when>
 <xsl:when test="not(contains(text(),':'))">
 <!-- 1 or 1<3 -->
 <xsl:if test="contains(text(),'&lt;')">
 <!-- 1<3 -->
 <xsl:value-of select="substring-before(text(),'&lt;')"></xsl:value-of>
 </xsl:if>
 <xsl:if test="not(contains(text(),'&lt;'))">
 <!-- 1 -->
 <xsl:value-of select="text()"></xsl:value-of>
 </xsl:if>
 </xsl:when>
 </xsl:choose>
 </xsl:variable>
 <xsl:variable name="sici2">
 <xsl:choose>
 <xsl:when test="starts-with(substring-after(text(),$level1),':')">
 <xsl:value-of select="substring(substring-after(text(),$level1),2)"></xsl:value-of>
 </xsl:when>
 <xsl:otherwise>
 <xsl:value-of select="substring-after(text(),$level1)"></xsl:value-of>
 </xsl:otherwise>
 </xsl:choose>
 </xsl:variable>
 <xsl:variable name="level2">
 <xsl:choose>
 <xsl:when test="contains($sici2,':')">
 <!-- 2:3<4 -->
 <xsl:value-of select="substring-before($sici2,':')"></xsl:value-of>
 </xsl:when>
 <xsl:when test="contains($sici2,'&lt;')">
 <!-- 1: 2<4 -->
 <xsl:value-of select="substring-before($sici2,'&lt;')"></xsl:value-of>
 </xsl:when>
 <xsl:otherwise>
 <xsl:value-of select="$sici2"></xsl:value-of>
 <!-- 1:2 -->
 </xsl:otherwise>
 </xsl:choose>
 </xsl:variable>
 <xsl:variable name="sici3">
 <xsl:choose>
 <xsl:when test="starts-with(substring-after($sici2,$level2),':')">
 <xsl:value-of select="substring(substring-after($sici2,$level2),2)"></xsl:value-of>
 </xsl:when>
 <xsl:otherwise>
 <xsl:value-of select="substring-after($sici2,$level2)"></xsl:value-of>
 </xsl:otherwise>
 </xsl:choose>
 </xsl:variable>
 <xsl:variable name="level3">
 <xsl:choose>
 <xsl:when test="contains($sici3,'&lt;')">
 <!-- 2<4 -->
 <xsl:value-of select="substring-before($sici3,'&lt;')"></xsl:value-of>
 </xsl:when>
 <xsl:otherwise>
 <xsl:value-of select="$sici3"></xsl:value-of>
 <!-- 3 -->
 </xsl:otherwise>
 </xsl:choose>
 </xsl:variable>
 <xsl:variable name="page">
 <xsl:if test="contains(text(),'&lt;')">
 <xsl:value-of select="substring-after(text(),'&lt;')"></xsl:value-of>
 </xsl:if>
 </xsl:variable>
 <xsl:if test="$level1">
 <detail level="1">
 <number>
 <xsl:value-of select="$level1"></xsl:value-of>
 </number>
 </detail>
 </xsl:if>
 <xsl:if test="$level2">
 <detail level="2">
 <number>
 <xsl:value-of select="$level2"></xsl:value-of>
 </number>
 </detail>
 </xsl:if>
 <xsl:if test="$level3">
 <detail level="3">
 <number>
 <xsl:value-of select="$level3"></xsl:value-of>
 </number>
 </detail>
 </xsl:if>
 <xsl:if test="$page">
 <extent unit="page">
 <start>
 <xsl:value-of select="$page"></xsl:value-of>
 </start>
 </extent>
 </xsl:if>
 </xsl:template>
 <xsl:template name="getLanguage">
 <xsl:param name="langString"></xsl:param>
 <xsl:param name="controlField008-35-37"></xsl:param>
 <xsl:variable name="length" select="string-length($langString)"></xsl:variable>
 <xsl:choose>
 <xsl:when test="$length=0"></xsl:when>
 <xsl:when test="$controlField008-35-37=substring($langString,1,3)">
 <xsl:call-template name="getLanguage">
 <xsl:with-param name="langString" select="substring($langString,4,$length)"></xsl:with-param>
 <xsl:with-param name="controlField008-35-37" select="$controlField008-35-37"></xsl:with-param>
 </xsl:call-template>
 </xsl:when>
 <xsl:otherwise>
 <language>
 <languageTerm authority="iso639-2b" type="code">
 <xsl:value-of select="substring($langString,1,3)"></xsl:value-of>
 </languageTerm>
 </language>
 <xsl:call-template name="getLanguage">
 <xsl:with-param name="langString" select="substring($langString,4,$length)"></xsl:with-param>
 <xsl:with-param name="controlField008-35-37" select="$controlField008-35-37"></xsl:with-param>
 </xsl:call-template>
 </xsl:otherwise>
 </xsl:choose>
 </xsl:template>
 <xsl:template name="isoLanguage">
 <xsl:param name="currentLanguage"></xsl:param>
 <xsl:param name="usedLanguages"></xsl:param>
 <xsl:param name="remainingLanguages"></xsl:param>
 <xsl:choose>
 <xsl:when test="string-length($currentLanguage)=0"></xsl:when>
 <xsl:when test="not(contains($usedLanguages, $currentLanguage))">
 <language>
 <xsl:if test="@code!='a'">
 <xsl:attribute name="objectPart">
 <xsl:choose>
 <xsl:when test="@code='b'">resumen o subtítulo</xsl:when>
 <xsl:when test="@code='d'">texto hablado o cantado</xsl:when>
 <xsl:when test="@code='e'">libreto</xsl:when>
 <xsl:when test="@code='f'">tabal de contenidos</xsl:when>
 <xsl:when test="@code='g'">material adjunto</xsl:when>
 <xsl:when test="@code='h'">traducción</xsl:when>
 </xsl:choose>
 </xsl:attribute>
 </xsl:if>
 <languageTerm authority="iso639-2b" type="code">
 <xsl:value-of select="$currentLanguage"></xsl:value-of>
 </languageTerm>
 </language>
 <xsl:call-template name="isoLanguage">
 <xsl:with-param name="currentLanguage">
 <xsl:value-of select="substring($remainingLanguages,1,3)"></xsl:value-of>
 </xsl:with-param>
 <xsl:with-param name="usedLanguages">
 <xsl:value-of select="concat($usedLanguages,$currentLanguage)"></xsl:value-of>
 </xsl:with-param>
 <xsl:with-param name="remainingLanguages">
 <xsl:value-of select="substring($remainingLanguages,4,string-length($remainingLanguages))"></xsl:value-of>
 </xsl:with-param>
 </xsl:call-template>
 </xsl:when>
 <xsl:otherwise>
 <xsl:call-template name="isoLanguage">
 <xsl:with-param name="currentLanguage">
 <xsl:value-of select="substring($remainingLanguages,1,3)"></xsl:value-of>
 </xsl:with-param>
 <xsl:with-param name="usedLanguages">
 <xsl:value-of select="concat($usedLanguages,$currentLanguage)"></xsl:value-of>
 </xsl:with-param>
 <xsl:with-param name="remainingLanguages">
 <xsl:value-of select="substring($remainingLanguages,4,string-length($remainingLanguages))"></xsl:value-of>
 </xsl:with-param>
 </xsl:call-template>
 </xsl:otherwise>
 </xsl:choose>
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
 <xsl:template name="rfcLanguages">
 <xsl:param name="nodeNum"></xsl:param>
 <xsl:param name="usedLanguages"></xsl:param>
 <xsl:param name="controlField008-35-37"></xsl:param>
 <xsl:variable name="currentLanguage" select="."></xsl:variable>
 <xsl:choose>
 <xsl:when test="not($currentLanguage)"></xsl:when>
 <xsl:when test="$currentLanguage!=$controlField008-35-37 and $currentLanguage!='rfc3066'">
 <xsl:if test="not(contains($usedLanguages,$currentLanguage))">
 <language>
 <xsl:if test="@code!='a'">
 <xsl:attribute name="objectPart">
 <xsl:choose>
 <xsl:when test="@code='b'">resumen o subtítulo</xsl:when>
 <xsl:when test="@code='d'">texto hablado o cantado</xsl:when>
 <xsl:when test="@code='e'">libreto</xsl:when>
 <xsl:when test="@code='f'">tabal de contenidos</xsl:when>
 <xsl:when test="@code='g'">material adjunto</xsl:when>
 <xsl:when test="@code='h'">traducción</xsl:when>
 </xsl:choose>
 </xsl:attribute>
 </xsl:if>
 <languageTerm authority="rfc3066" type="code">
 <xsl:value-of select="$currentLanguage"/>
 </languageTerm>
 </language>
 </xsl:if>
 </xsl:when>
 <xsl:otherwise>
 </xsl:otherwise>
 </xsl:choose>
 </xsl:template>
</xsl:stylesheet>
