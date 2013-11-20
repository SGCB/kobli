
<!-- $Id: MARC21slim2DC.xsl,v 1.1 2003/01/06 08:20:27 adam Exp $ -->
<!DOCTYPE stylesheet [<!ENTITY nbsp "&#160;" >]>
<xsl:stylesheet version="1.0"
  xmlns:marc="http://www.loc.gov/MARC21/slim"
  xmlns:items="http://www.koha-community.org/items"
  xmlns:xsl="http://www.w3.org/1999/XSL/Transform"
  exclude-result-prefixes="marc items">
 <xsl:import href="MARC21slimUtils.xsl"/>
 <xsl:output method = "html" indent="yes" omit-xml-declaration = "yes" encoding="UTF-8"/>

 <xsl:template match="/">
 <xsl:apply-templates/>
 </xsl:template>

 <xsl:template match="marc:record">

 <!-- Option: Display Alternate Graphic Representation (MARC 880) -->
 <xsl:variable name="display880" select="boolean(marc:datafield[@tag=880])"/>

 <xsl:variable name="UseControlNumber" select="marc:sysprefs/marc:syspref[@name='UseControlNumber']"/>
 <xsl:variable name="DisplayOPACiconsXSLT" select="marc:sysprefs/marc:syspref[@name='DisplayOPACiconsXSLT']"/>
 <xsl:variable name="OPACURLOpenInNewWindow" select="marc:sysprefs/marc:syspref[@name='OPACURLOpenInNewWindow']"/>
 <xsl:variable name="URLLinkText" select="marc:sysprefs/marc:syspref[@name='URLLinkText']"/>
 
 <xsl:variable name="SubjectModifier"><xsl:if test="marc:sysprefs/marc:syspref[@name='TraceCompleteSubfields']='1'">,complete-subfield</xsl:if></xsl:variable>
 <xsl:variable name="UseAuthoritiesForTracings" select="marc:sysprefs/marc:syspref[@name='UseAuthoritiesForTracings']"/>
 <xsl:variable name="TraceSubjectSubdivisions" select="marc:sysprefs/marc:syspref[@name='TraceSubjectSubdivisions']"/>
 <xsl:variable name="Show856uAsImage" select="marc:sysprefs/marc:syspref[@name='OPACDisplay856uAsImage']"/>
 <xsl:variable name="OPACTrackClicks" select="marc:sysprefs/marc:syspref[@name='TrackClicks']"/>
 <xsl:variable name="biblionumber" select="marc:datafield[@tag=999]/marc:subfield[@code='c']"/>
 <xsl:variable name="BiblioItemtypeImage" select="marc:sysprefs/marc:syspref[@name='BiblioItemtypeImage']"/>
 <xsl:variable name="TracingQuotesLeft">
 <xsl:choose>
 <xsl:when test="marc:sysprefs/marc:syspref[@name='UseICU']='1'">{</xsl:when>
 <xsl:otherwise>"</xsl:otherwise>
 </xsl:choose>
 </xsl:variable>
 <xsl:variable name="TracingQuotesRight">
 <xsl:choose>
 <xsl:when test="marc:sysprefs/marc:syspref[@name='UseICU']='1'">}</xsl:when>
 <xsl:otherwise>"</xsl:otherwise>
 </xsl:choose>
 </xsl:variable>
 <xsl:variable name="leader" select="marc:leader"/>
 <xsl:variable name="leader6" select="substring($leader,7,1)"/>
 <xsl:variable name="leader7" select="substring($leader,8,1)"/>
 <xsl:variable name="leader19" select="substring($leader,20,1)"/>
 <xsl:variable name="controlField008" select="marc:controlfield[@tag=008]"/>
 <xsl:variable name="materialTypeCode">
 <xsl:choose>
 <xsl:when test="$leader19='a'">ST</xsl:when>
 <xsl:when test="$leader6='a'">
 <xsl:choose>
 <xsl:when test="$leader7='c' or $leader7='d' or $leader7='m'">BK</xsl:when>
 <xsl:when test="$leader7='i' or $leader7='s'">SE</xsl:when>
 <xsl:when test="$leader7='a' or $leader7='b'">AR</xsl:when>
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
 <xsl:variable name="materialTypeLabel">
 <xsl:choose>
 <xsl:when test="$leader19='a'">Conjunto</xsl:when>
 <xsl:when test="$leader6='a'">
 <xsl:choose>
 <xsl:when test="$leader7='c' or $leader7='d' or $leader7='m'">Libro</xsl:when>
 <xsl:when test="$leader7='i' or $leader7='s'">
 <xsl:choose>
 <xsl:when test="substring($controlField008,22,1)!='m'">Recursos continuos</xsl:when>
 <xsl:otherwise>Series</xsl:otherwise>
 </xsl:choose>
 </xsl:when>
 <xsl:when test="$leader7='a' or $leader7='b'">Artículo</xsl:when>
 </xsl:choose>
 </xsl:when>
 <xsl:when test="$leader6='t'">Libro</xsl:when>
 <xsl:when test="$leader6='o'">Kit</xsl:when>
 <xsl:when test="$leader6='p'">Materiales variados</xsl:when>
 <xsl:when test="$leader6='m'">Archivo de ordenador</xsl:when>
 <xsl:when test="$leader6='e' or $leader6='f'">Mapa</xsl:when>
 <xsl:when test="$leader6='g' or $leader6='k' or $leader6='r'">Material visual</xsl:when>
 <xsl:when test="$leader6='j'">Música</xsl:when>
 <xsl:when test="$leader6='i'">Sonido</xsl:when>
 <xsl:when test="$leader6='c' or $leader6='d'">Puntuación</xsl:when>
 </xsl:choose>
 </xsl:variable>

 <!-- Schema.org type -->
 <xsl:variable name="schemaOrgType">
 <xsl:choose>
 <xsl:when test="$materialTypeLabel='Book'">Libro</xsl:when>
 <xsl:when test="$materialTypeLabel='Map'">Mapa</xsl:when>
 <xsl:when test="$materialTypeLabel='Music'">Álbum de música</xsl:when>
 <xsl:otherwise>Trabajo creativo</xsl:otherwise>
 </xsl:choose>
 </xsl:variable>

 <!-- Wrapper div for our schema.org object -->
 <xsl:element name="div">
 <xsl:attribute name="class">registro</xsl:attribute>
 <xsl:attribute name="vocab">http://schema.org/</xsl:attribute>
 <xsl:attribute name="typeof"><xsl:value-of select='$schemaOrgType' /> Producto</xsl:attribute>
 <xsl:attribute name="resource">#registros</xsl:attribute>

 <!-- Title Statement -->
 <!-- Alternate Graphic Representation (MARC 880) -->
 <xsl:if test="$display880">
 <h1 class="title" property="alternativeHeadline">
 <xsl:call-template name="m880Select">
 <xsl:with-param name="basetags">245</xsl:with-param>
 <xsl:with-param name="codes">abhfgknps</xsl:with-param>
 </xsl:call-template>
 </h1>
 </xsl:if>

 <xsl:if test="marc:datafield[@tag=245]">
 <h1 class="title" property="name">
 <xsl:for-each select="marc:datafield[@tag=245]">
 <xsl:call-template name="subfieldSelect">
 <xsl:with-param name="codes">a</xsl:with-param>
 </xsl:call-template>
 <xsl:if test="marc:subfield[@code='h']">
 <xsl:text> [</xsl:text>
 <xsl:call-template name="subfieldSelect">
 <xsl:with-param name="codes">h</xsl:with-param>
 </xsl:call-template>
 <xsl:text>]</xsl:text>
 </xsl:if>
 <xsl:if test="marc:subfield[@code='b']">
 <xsl:text> </xsl:text>
 <xsl:call-template name="subfieldSelect">
 <xsl:with-param name="codes">b</xsl:with-param>
 </xsl:call-template>
 </xsl:if>
 <xsl:text> </xsl:text>
 <xsl:call-template name="subfieldSelect">
 <xsl:with-param name="codes">fgknps</xsl:with-param>
 </xsl:call-template>
 </xsl:for-each>
 </h1>
 </xsl:if>

 <!-- Author Statement: Alternate Graphic Representation (MARC 880) -->
 <xsl:if test="$display880">
 <h5 class="author">
 <xsl:call-template name="m880Select">
 <xsl:with-param name="basetags">100,110,111,700,710,711</xsl:with-param>
 <xsl:with-param name="codes">abc</xsl:with-param>
 <xsl:with-param name="index">au</xsl:with-param>
 <!-- do not use label 'by ' here, it would be repeated for every occurence of 100,110,111,700,710,711 -->
 </xsl:call-template>
 </h5>
 </xsl:if>
 <xsl:choose>
 <xsl:when test="marc:datafield[@tag=100] or marc:datafield[@tag=110] or marc:datafield[@tag=111] or marc:datafield[@tag=700] or marc:datafield[@tag=710] or marc:datafield[@tag=711]">
 <h5 class="author" property="author">por <xsl:call-template name="showAuthor">
 <xsl:with-param name="authorfield" select="marc:datafield[@tag=100 or @tag=110 or @tag=111 or @tag=700 or @tag=710 or @tag=711]"/>
 <xsl:with-param name="UseAuthoritiesForTracings" select="$UseAuthoritiesForTracings"/>
 </xsl:call-template>
 </h5>
 </xsl:when>
 </xsl:choose>

 <xsl:if test="$DisplayOPACiconsXSLT!='0'">
 <xsl:if test="$BiblioItemtypeImage='Control'">
 <xsl:if test="$materialTypeCode!=''">
 <span class="results_summary type"><span class="label">Tipo: </span>
 <xsl:element name="img"><xsl:attribute name="src">/opac-tmpl/lib/famfamfam/<xsl:value-of select="$materialTypeCode"/>.png</xsl:attribute><xsl:attribute name="alt">materialTypeLabel</xsl:attribute><xsl:attribute name="class">materialtype</xsl:attribute></xsl:element>
 <xsl:value-of select="$materialTypeLabel"/>
 </span>
 </xsl:if>
 </xsl:if>
 </xsl:if>

 <!-- 024 -->
 <xsl:if test="$display880">
 <span class="results_summary">
 <xsl:call-template name="m880Select">
 <xsl:with-param name="basetags">024</xsl:with-param>
 <xsl:with-param name="codes">abhfgknps</xsl:with-param>
 </xsl:call-template>
 </span>
 </xsl:if>
 <xsl:if test="marc:datafield[@tag=024]">
 <span class="results_summary">
 <xsl:for-each select="marc:datafield[@tag=024]">
 <span class="label">
 <xsl:if test="marc:subfield[@code='2']">
 <xsl:text> </xsl:text>
 <xsl:call-template name="subfieldSelect">
 <xsl:with-param name="codes">2</xsl:with-param>
 </xsl:call-template>
 <xsl:text>:</xsl:text>
 </xsl:if>
 </span>
 <xsl:if test="marc:subfield[@code='a']">
 <xsl:text> </xsl:text>
 <xsl:call-template name="subfieldSelect">
 <xsl:with-param name="codes">a</xsl:with-param>
 </xsl:call-template>
 </xsl:if>
 <xsl:text> </xsl:text>
 <xsl:call-template name="subfieldSelect">
 <xsl:with-param name="codes">fgknps</xsl:with-param>
 </xsl:call-template>
 </xsl:for-each>
 </span>
 </xsl:if>

 <!-- 590 -->
 <xsl:if test="$display880">
 <span class="results_summary">
 <xsl:call-template name="m880Select">
 <xsl:with-param name="basetags">590</xsl:with-param>
 <xsl:with-param name="codes">abhfgknps</xsl:with-param>
 </xsl:call-template>
 </span>
 </xsl:if>
 <xsl:if test="marc:datafield[@tag=590]">
 <span class="results_summary"><span class="label">Fecha:</span>
 <xsl:for-each select="marc:datafield[@tag=590]">
 <xsl:if test="marc:subfield[@code='a']">
 <xsl:text> </xsl:text>
 <xsl:call-template name="subfieldSelect">
 <xsl:with-param name="codes">a</xsl:with-param>
 </xsl:call-template>
 </xsl:if>
 <xsl:text> </xsl:text>
 <xsl:call-template name="subfieldSelect">
 <xsl:with-param name="codes">fgknps</xsl:with-param>
 </xsl:call-template>
 </xsl:for-each>
 </span>
 </xsl:if>
 
 <!--Series: Alternate Graphic Representation (MARC 880) -->
 <xsl:if test="$display880">
 <xsl:call-template name="m880Select">
 <xsl:with-param name="basetags">440,490</xsl:with-param>
 <xsl:with-param name="codes">av</xsl:with-param>
 <xsl:with-param name="class">results_summary series</xsl:with-param>
 <xsl:with-param name="label">Series: </xsl:with-param>
 <xsl:with-param name="index">se</xsl:with-param>
 </xsl:call-template>
 </xsl:if>

 <!-- Series -->
 <xsl:if test="marc:datafield[@tag=440 or @tag=490]">
 <span class="results_summary series"><span class="label">Series: </span>
 <!-- 440 -->
 <xsl:for-each select="marc:datafield[@tag=440]">
 <a><xsl:attribute name="href">/cgi-bin/koha/opac-search.pl?q=se,phr:"<xsl:value-of select="marc:subfield[@code='a']"/>"</xsl:attribute>
 <xsl:call-template name="chopPunctuation">
 <xsl:with-param name="chopString">
 <xsl:call-template name="subfieldSelect">
 <xsl:with-param name="codes">av</xsl:with-param>
 </xsl:call-template>
 </xsl:with-param>
 </xsl:call-template>
 </a>
 <xsl:call-template name="part"/>
 <xsl:choose><xsl:when test="position()=last()"><xsl:text>. </xsl:text></xsl:when><xsl:otherwise><xsl:text> ; </xsl:text></xsl:otherwise></xsl:choose>
 </xsl:for-each>

 <!-- 490 Series not traced, Ind1 = 0 -->
 <xsl:for-each select="marc:datafield[@tag=490][@ind1!=1]">
 <a><xsl:attribute name="href">/cgi-bin/koha/opac-search.pl?q=se,phr:"<xsl:value-of select="marc:subfield[@code='a']"/>"</xsl:attribute>
 <xsl:call-template name="chopPunctuation">
 <xsl:with-param name="chopString">
 <xsl:call-template name="subfieldSelect">
 <xsl:with-param name="codes">av</xsl:with-param>
 </xsl:call-template>
 </xsl:with-param>
 </xsl:call-template>
 </a>
 <xsl:call-template name="part"/>
 <xsl:choose><xsl:when test="position()=last()"><xsl:text>.</xsl:text></xsl:when><xsl:otherwise><xsl:text>; </xsl:text></xsl:otherwise></xsl:choose>
 </xsl:for-each>
 <!-- 490 Series traced, Ind1 = 1 -->
 <xsl:if test="marc:datafield[@tag=490][@ind1=1]">
 <xsl:for-each select="marc:datafield[@tag=800 or @tag=810 or @tag=811 or @tag=830]">
 <xsl:choose>
 <xsl:when test="$UseControlNumber = '1' and marc:subfield[@code='w']">
 <a href="/cgi-bin/koha/opac-search.pl?q=rcn:{marc:subfield[@code='w']}">
 <xsl:call-template name="chopPunctuation">
 <xsl:with-param name="chopString">
 <xsl:call-template name="subfieldSelect">
 <xsl:with-param name="codes">a_t</xsl:with-param>
 </xsl:call-template>
 </xsl:with-param>
 </xsl:call-template>
 </a>
 </xsl:when>
 <xsl:otherwise>
 <a><xsl:attribute name="href">/cgi-bin/koha/opac-search.pl?q=se,phr:"<xsl:value-of select="marc:subfield[@code='a']"/>"</xsl:attribute>
 <xsl:call-template name="chopPunctuation">
 <xsl:with-param name="chopString">
 <xsl:call-template name="subfieldSelect">
 <xsl:with-param name="codes">a_t</xsl:with-param>
 </xsl:call-template>
 </xsl:with-param>
 </xsl:call-template>
 </a>
 <xsl:call-template name="part"/>
 </xsl:otherwise>
 </xsl:choose>
 <xsl:text>: </xsl:text>
 <xsl:value-of  select="marc:subfield[@code='v']" />
 <xsl:choose><xsl:when test="position()=last()"><xsl:text></xsl:text></xsl:when><xsl:otherwise><xsl:text>; </xsl:text></xsl:otherwise></xsl:choose>
 </xsl:for-each>
 </xsl:if>
 </span>
 </xsl:if>
 
 <!-- Analytics -->
 <xsl:if test="($leader7='s' or $leader7='m') and marc:datafield[@tag=973]">
 <span class="results_summary analytics"><span class="label">Analíticas: </span>
 <a>
 <xsl:choose>
 <xsl:when test="$UseControlNumber = '1' and marc:controlfield[@tag=001]">
 <xsl:attribute name="href">/cgi-bin/koha/opac-search.pl?q=rcn:<xsl:value-of select="marc:controlfield[@tag=001]"/>+and+(bib-level:a+or+bib-level:b)</xsl:attribute>
 </xsl:when>
 <xsl:otherwise>
 <xsl:attribute name="href">/cgi-bin/koha/opac-search.pl?q=Host-item:<xsl:value-of select="translate(marc:datafield[@tag=245]/marc:subfield[@code='a'], '/', '')"/></xsl:attribute>
 </xsl:otherwise>
 </xsl:choose>
 <xsl:text>Mostrar analíticas</xsl:text>
 </a>
 </span>
 </xsl:if>

 <!-- Volumes of sets and traced series -->
 <xsl:if test="$materialTypeCode='ST' or substring($controlField008,22,1)='m'">
 <span class="results_summary volumes"><span class="label">Volúmenes: </span>
 <a>
 <xsl:choose>
 <xsl:when test="$UseControlNumber = '1' and marc:controlfield[@tag=001]">
 <xsl:attribute name="href">/cgi-bin/koha/opac-search.pl?q=rcn:<xsl:value-of select="marc:controlfield[@tag=001]"/>+not+(bib-level:a+or+bib-level:b)</xsl:attribute>
 </xsl:when>
 <xsl:otherwise>
 <xsl:attribute name="href">/cgi-bin/koha/opac-search.pl?q=ti,phr:<xsl:value-of select="translate(marc:datafield[@tag=245]/marc:subfield[@code='a'], '/', '')"/></xsl:attribute>
 </xsl:otherwise>
 </xsl:choose>
 <xsl:text>Mostrar volúmenes</xsl:text>
 </a>
 </span>
 </xsl:if>

 <!-- Set -->
 <xsl:if test="$leader19='c'">
 <span class="results_summary set"><span class="label">Conjunto: </span>
 <xsl:for-each select="marc:datafield[@tag=773]">
 <a>
 <xsl:choose>
 <xsl:when test="$UseControlNumber = '1' and marc:subfield[@code='w']">
 <xsl:attribute name="href">/cgi-bin/koha/opac-search.pl?q=Control-number:<xsl:call-template name="extractControlNumber"><xsl:with-param name="subfieldW" select="marc:subfield[@code='w']"/></xsl:call-template></xsl:attribute>
 </xsl:when>
 <xsl:otherwise>
 <xsl:attribute name="href">/cgi-bin/koha/opac-search.pl?q=ti,phr:<xsl:value-of select="translate(//marc:datafield[@tag=245]/marc:subfield[@code='a'], '.', '')"/></xsl:attribute>
 </xsl:otherwise>
 </xsl:choose>
 <xsl:value-of select="translate(//marc:datafield[@tag=245]/marc:subfield[@code='a'], '.', '')" />
 </a>
 <xsl:choose>
 <xsl:when test="position()=last()"></xsl:when>
 <xsl:otherwise><xsl:text>; </xsl:text></xsl:otherwise>
 </xsl:choose>
 </xsl:for-each>
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
 <span property="publisher" typeof="Organization">
 <xsl:if test="marc:subfield[@code='a']">
 <span property="location">
 <xsl:call-template name="subfieldSelect">
 <xsl:with-param name="codes">a</xsl:with-param>
 </xsl:call-template>
 </span>
 </xsl:if>
 <xsl:text> </xsl:text>
 <xsl:if test="marc:subfield[@code='b']">
 <span property="name"><a href="/cgi-bin/koha/opac-search.pl?q=pb:{marc:subfield[@code='b']}">
 <xsl:call-template name="subfieldSelect">
 <xsl:with-param name="codes">b</xsl:with-param>
 </xsl:call-template>
 </a></span>
 </xsl:if>
 </span>
 <xsl:text> </xsl:text>
 <xsl:if test="marc:subfield[@code='c' or @code='g']">
 <span property="datePublished">
 <xsl:call-template name="chopPunctuation">
 <xsl:with-param name="chopString">
 <xsl:call-template name="subfieldSelect">
 <xsl:with-param name="codes">cg</xsl:with-param>
 </xsl:call-template>
 </xsl:with-param>
 </xsl:call-template>
 </span>
 </xsl:if>
 <xsl:choose><xsl:when test="position()=last()"><xsl:text></xsl:text></xsl:when><xsl:otherwise><xsl:text>; </xsl:text></xsl:otherwise></xsl:choose>
 </xsl:for-each>
 </span>
 </xsl:if>

 <!-- Edition Statement: Alternate Graphic Representation (MARC 880) -->
 <xsl:if test="$display880">
 <xsl:call-template name="m880Select">
 <xsl:with-param name="basetags">250</xsl:with-param>
 <xsl:with-param name="codes">ab</xsl:with-param>
 <xsl:with-param name="class">results_summary edition</xsl:with-param>
 <xsl:with-param name="label">Edición: </xsl:with-param>
 </xsl:call-template>
 </xsl:if>

 <xsl:if test="marc:datafield[@tag=250]">
 <span class="results_summary edition"><span class="label">Edición: </span>
 <xsl:for-each select="marc:datafield[@tag=250]">
 <span property="bookEdition">
 <xsl:call-template name="chopPunctuation">
 <xsl:with-param name="chopString">
 <xsl:call-template name="subfieldSelect">
 <xsl:with-param name="codes">ab</xsl:with-param>
 </xsl:call-template>
 </xsl:with-param>
 </xsl:call-template>
 </span>
 <xsl:choose><xsl:when test="position()=last()"><xsl:text>.</xsl:text></xsl:when><xsl:otherwise><xsl:text>; </xsl:text></xsl:otherwise></xsl:choose>
 </xsl:for-each>
 </span>
 </xsl:if>

 <!-- Description: Alternate Graphic Representation (MARC 880) -->
 <xsl:if test="$display880">
 <xsl:call-template name="m880Select">
 <xsl:with-param name="basetags">300</xsl:with-param>
 <xsl:with-param name="codes">abceg</xsl:with-param>
 <xsl:with-param name="class">results_summary edition</xsl:with-param>
 <xsl:with-param name="label">Descripción: </xsl:with-param>
 </xsl:call-template>
 </xsl:if>

 <xsl:if test="marc:datafield[@tag=300]">
 <span class="results_summary description"><span class="label">Descripción: </span>
 <xsl:for-each select="marc:datafield[@tag=300]">
 <span property="description">
 <xsl:call-template name="chopPunctuation">
 <xsl:with-param name="chopString">
 <xsl:call-template name="subfieldSelect">
 <xsl:with-param name="codes">abceg</xsl:with-param>
 </xsl:call-template>
 </xsl:with-param>
 </xsl:call-template>
 </span>
 <xsl:choose><xsl:when test="position()=last()"><xsl:text>.</xsl:text></xsl:when><xsl:otherwise><xsl:text>; </xsl:text></xsl:otherwise></xsl:choose>
 </xsl:for-each>
 </span>
 </xsl:if>

 <xsl:if test="marc:datafield[@tag=020]">
 <span class="results_summary isbn"><span class="label">ISBN: </span>
 <xsl:for-each select="marc:datafield[@tag=020]">
 <span property="isbn">
 <xsl:variable name="isbn" select="marc:subfield[@code='a']"/>
 <xsl:value-of select="marc:subfield[@code='a']"/>
 <xsl:choose><xsl:when test="position()=last()"><xsl:text>.</xsl:text></xsl:when><xsl:otherwise><xsl:text>; </xsl:text></xsl:otherwise></xsl:choose>
 </span>
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

 <xsl:if test="marc:datafield[@tag=013]">
 <span class="results_summary patent_info">
 <span class="label">Información personal</span>
 <xsl:for-each select="marc:datafield[@tag=013]">
 <xsl:call-template name="subfieldSelect">
 <xsl:with-param name="codes">acdef</xsl:with-param>
 <xsl:with-param name="delimeter">, </xsl:with-param>
 </xsl:call-template>
 <xsl:choose><xsl:when test="position()=last()"><xsl:text></xsl:text></xsl:when><xsl:otherwise><xsl:text>; </xsl:text></xsl:otherwise></xsl:choose>
 </xsl:for-each>
 </span>
 </xsl:if>

 <xsl:if test="marc:datafield[@tag=088]">
 <span class="results_summary report_number">
 <span class="label">Informe número:</span>
 <xsl:for-each select="marc:datafield[@tag=088]">
 <xsl:call-template name="subfieldSelect">
 <xsl:with-param name="codes">a</xsl:with-param>
 </xsl:call-template>
 <xsl:choose><xsl:when test="position()=last()"><xsl:text></xsl:text></xsl:when><xsl:otherwise><xsl:text>; </xsl:text></xsl:otherwise></xsl:choose>
 </xsl:for-each>
 </span>
 </xsl:if>

 <!-- Other Title Statement: Alternate Graphic Representation (MARC 880) -->
 <xsl:if test="$display880">
 <xsl:call-template name="m880Select">
 <xsl:with-param name="basetags">246</xsl:with-param>
 <xsl:with-param name="codes">abhfgnp</xsl:with-param>
 <xsl:with-param name="class">results_summary other_title</xsl:with-param>
 <xsl:with-param name="label">Otro título: </xsl:with-param>
 </xsl:call-template>
 </xsl:if>

 <xsl:if test="marc:datafield[@tag=246]">
 <span class="results_summary other_title"><span class="label">Otro título: </span>
 <xsl:for-each select="marc:datafield[@tag=246]">
 <span property="alternativeHeadline"> 
 <xsl:call-template name="chopPunctuation">
 <xsl:with-param name="chopString">
 <xsl:call-template name="subfieldSelect">
 <xsl:with-param name="codes">iabhfgnp</xsl:with-param>
 </xsl:call-template>
 </xsl:with-param>
 </xsl:call-template>
 </span>
 <xsl:choose><xsl:when test="position()=last()"><xsl:text>.</xsl:text></xsl:when><xsl:otherwise><xsl:text>; </xsl:text></xsl:otherwise></xsl:choose>
 </xsl:for-each>
 </span>
 </xsl:if>


 <xsl:if test="marc:datafield[@tag=242]">
 <span class="results_summary translated_title"><span class="label">Título traducido:</span>
 <xsl:for-each select="marc:datafield[@tag=242]">
 <span property="alternativeHeadline"> 
 <xsl:call-template name="chopPunctuation">
 <xsl:with-param name="chopString">
 <xsl:call-template name="subfieldSelect">
 <xsl:with-param name="codes">abchnp</xsl:with-param>
 </xsl:call-template>
 </xsl:with-param>
 </xsl:call-template>
 </span>
 <xsl:choose><xsl:when test="position()=last()"><xsl:text>.</xsl:text></xsl:when><xsl:otherwise><xsl:text>; </xsl:text></xsl:otherwise></xsl:choose>
 </xsl:for-each>
 </span>
 </xsl:if>

 <!-- Uniform Title Statement: Alternate Graphic Representation (MARC 880) -->
 <xsl:if test="$display880">
 <span property="alternativeHeadline"> 
 <xsl:call-template name="m880Select">
 <xsl:with-param name="basetags">130,240</xsl:with-param>
 <xsl:with-param name="codes">adfklmor</xsl:with-param>
 <xsl:with-param name="class">results_summary uniform_title</xsl:with-param>
 <xsl:with-param name="label">Títulos uniformes: </xsl:with-param>
 </xsl:call-template>
 </span>
 </xsl:if>

 <xsl:if test="marc:datafield[@tag=130]|marc:datafield[@tag=240]|marc:datafield[@tag=730][@ind2!=2]">
 <span class="results_summary uniform_titles"><span class="label">Títulos uniformes: </span>
 <xsl:for-each select="marc:datafield[@tag=130]|marc:datafield[@tag=240]|marc:datafield[@tag=730][@ind2!=2]">
 <span property="alternativeHeadline"> 
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
 </span>
 <xsl:choose><xsl:when test="position()=last()"><xsl:text>.</xsl:text></xsl:when><xsl:otherwise><xsl:text>; </xsl:text></xsl:otherwise></xsl:choose>
 </xsl:for-each>
 </span>
 </xsl:if>

 <xsl:if test="marc:datafield[substring(@tag, 1, 1) = '6']">
 <span class="results_summary subjects"><span class="label">Tema(s): </span>
 <xsl:for-each select="marc:datafield[substring(@tag, 1, 1) = '6']">
 <span property="keywords">
 <a>
 <xsl:choose>
 <xsl:when test="marc:subfield[@code=9] and $UseAuthoritiesForTracings='1'">
 <xsl:attribute name="href">/cgi-bin/koha/opac-search.pl?q=an:<xsl:value-of select="marc:subfield[@code=9]"/></xsl:attribute>
 </xsl:when>
 <xsl:when test="$TraceSubjectSubdivisions='1'">
 <xsl:attribute name="href">/cgi-bin/koha/opac-search.pl?q=<xsl:call-template name="subfieldSelect">
 <xsl:with-param name="codes">abcdfgklmnopqrstvxyz</xsl:with-param>
 <xsl:with-param name="delimeter"> Y</xsl:with-param>
 <xsl:with-param name="prefix">(su<xsl:value-of select="$SubjectModifier"/>:<xsl:value-of select="$TracingQuotesLeft"/></xsl:with-param>
 <xsl:with-param name="suffix"><xsl:value-of select="$TracingQuotesRight"/>) </xsl:with-param>
 </xsl:call-template>
 </xsl:attribute>
 </xsl:when>
 <xsl:otherwise>
 <xsl:attribute name="href">/cgi-bin/koha/opac-search.pl?q=su<xsl:value-of select="$SubjectModifier"/>:<xsl:value-of select="$TracingQuotesLeft"/><xsl:value-of select="marc:subfield[@code='a']"/><xsl:value-of select="$TracingQuotesRight"/></xsl:attribute>
 </xsl:otherwise>
 </xsl:choose>
 <xsl:call-template name="chopPunctuation">
 <xsl:with-param name="chopString">
 <xsl:call-template name="subfieldSelect">
 <xsl:with-param name="codes">abcdfgklmnopqrstvxyz</xsl:with-param>
 <xsl:with-param name="subdivCodes">vxyz</xsl:with-param>
 <xsl:with-param name="subdivDelimiter">-- </xsl:with-param>
 </xsl:call-template>
 </xsl:with-param>
 </xsl:call-template>
 </a>
 </span>
 <xsl:if test="marc:subfield[@code=9]">
 <a class='authlink'>
 <xsl:attribute name="href">/cgi-bin/koha/opac-authoritiesdetail.pl?authid=<xsl:value-of select="marc:subfield[@code=9]"/></xsl:attribute>
 <img style="vertical-align:middle" height="15" width="15" src="/opac-tmpl/prog/images/filefind.png"/>
 </a>
 </xsl:if>
 <xsl:choose>
 <xsl:when test="position()=last()"></xsl:when>
 <xsl:otherwise> | </xsl:otherwise>
 </xsl:choose>

 </xsl:for-each>
 </span>
 </xsl:if>

<!-- Image processing code added here, takes precedence over text links including y3z text -->
 <xsl:if test="marc:datafield[@tag=856]">
 <span class="results_summary online_resources"><span class="label">Recursos en línea:</span>
 <xsl:for-each select="marc:datafield[@tag=856]">
 <xsl:variable name="SubqText"><xsl:value-of select="marc:subfield[@code='q']"/></xsl:variable>
 <a property="url">
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
 <xsl:if test="$OPACURLOpenInNewWindow='1'">
 <xsl:attribute name="target">_blank</xsl:attribute>
 </xsl:if>
 <xsl:choose>
 <xsl:when test="($Show856uAsImage='Details' or $Show856uAsImage='Both') and (substring($SubqText,1,6)='image/' or $SubqText='img' or $SubqText='bmp' or $SubqText='cod' or $SubqText='gif' or $SubqText='ief' or $SubqText='jpe' or $SubqText='jpeg' or $SubqText='jpg' or $SubqText='jfif' or $SubqText='png' or $SubqText='svg' or $SubqText='tif' or $SubqText='tiff' or $SubqText='ras' or $SubqText='cmx' or $SubqText='ico' or $SubqText='pnm' or $SubqText='pbm' or $SubqText='pgm' or $SubqText='ppm' or $SubqText='rgb' or $SubqText='xbm' or $SubqText='xpm' or $SubqText='xwd')">
 <xsl:element name="img"><xsl:attribute name="src"><xsl:value-of select="marc:subfield[@code='u']"/></xsl:attribute><xsl:attribute name="alt"><xsl:value-of select="marc:subfield[@code='y']"/></xsl:attribute><xsl:attribute name="height">100</xsl:attribute></xsl:element><xsl:text></xsl:text>
 </xsl:when> 
 <xsl:when test="marc:subfield[@code='y' or @code='3' or @code='z']">
 <xsl:call-template name="subfieldSelect">
 <xsl:with-param name="codes">y3z</xsl:with-param>
 </xsl:call-template>
 </xsl:when>
 <xsl:when test="$URLLinkText!=''">
 <xsl:value-of select="$URLLinkText"/>
 </xsl:when>
 <xsl:otherwise>
 <xsl:text>Haga clic aquí para acceder en línea</xsl:text>
 </xsl:otherwise>
 </xsl:choose>
 </a>
 <xsl:choose>
 <xsl:when test="position()=last()"><xsl:text> </xsl:text></xsl:when>
 <xsl:otherwise> | </xsl:otherwise>
 </xsl:choose>
 </xsl:for-each>
 </span>
 </xsl:if>

 <!-- 530 -->
 <xsl:if test="marc:datafield[@tag=530]">
 <xsl:for-each select="marc:datafield[@tag=530]">
 <span class="results_summary additionalforms">
 <xsl:call-template name="subfieldSelect">
 <xsl:with-param name="codes">abcd</xsl:with-param>
 </xsl:call-template>
 <xsl:for-each select="marc:subfield[@code='u']">
 <a><xsl:attribute name="href"><xsl:value-of select="text()"/></xsl:attribute>
 <xsl:if test="$OPACURLOpenInNewWindow='1'">
 <xsl:attribute name="target">_blank</xsl:attribute>
 </xsl:if>
 <xsl:value-of select="text()"/>
 </a>
 </xsl:for-each>
 </span>
 </xsl:for-each>
 </xsl:if>

 <!-- 505 -->
 <xsl:if test="marc:datafield[@tag=505]">
 <div class="results_summary contents">
 <xsl:for-each select="marc:datafield[@tag=505]">
 <xsl:if test="position()=1">
 <xsl:choose>
 <xsl:when test="@ind1=1">
 <span class="label">Contenidos incompletos:</span>
 </xsl:when>
 <xsl:when test="@ind1=2">
 <span class="label">Contenidos parciales:</span>
 </xsl:when>
 <xsl:otherwise>
 <span class="label">Contenidos:</span>
 </xsl:otherwise>
 </xsl:choose>
 </xsl:if>
 <div class='contentblock' property='description'>
 <xsl:choose>
 <xsl:when test="@ind2=0">
 <xsl:call-template name="subfieldSelectSpan">
 <xsl:with-param name="codes">tru</xsl:with-param>
 </xsl:call-template>
 </xsl:when>
 <xsl:otherwise>
 <xsl:call-template name="subfieldSelectSpan">
 <xsl:with-param name="codes">atru</xsl:with-param>
 </xsl:call-template>
 </xsl:otherwise>
 </xsl:choose>
 </div>
 </xsl:for-each>
 </div>
 </xsl:if>

 <!-- 583 -->
 <xsl:if test="marc:datafield[@tag=583]">
 <xsl:for-each select="marc:datafield[@tag=583]">
 <xsl:if test="@ind1=1 or @ind1=' '">
 <span class="results_summary actionnote">
 <xsl:choose>
 <xsl:when test="marc:subfield[@code='z']">
 <xsl:value-of select="marc:subfield[@code='z']"/>
 </xsl:when>
 <xsl:otherwise>
 <xsl:call-template name="subfieldSelect">
 <xsl:with-param name="codes">abcdefgijklnou</xsl:with-param>
 </xsl:call-template>
 </xsl:otherwise>
 </xsl:choose>
 </span>
 </xsl:if>
 </xsl:for-each>
 </xsl:if>

 <!-- 586 -->
 <xsl:if test="marc:datafield[@tag=586]">
 <xsl:for-each select="marc:datafield[@tag=586]">
 <span class="results_summary awardsnote">
 <xsl:if test="@ind1=' '">
 <span class="label">Premios: </span>
 </xsl:if>
 <xsl:value-of select="marc:subfield[@code='a']"/>
 </span>
 </xsl:for-each>
 </xsl:if>

 <!-- 773 -->
 <xsl:if test="marc:datafield[@tag=773]">
 <xsl:for-each select="marc:datafield[@tag=773]">
 <xsl:if test="@ind1=0">
 <span class="results_summary in"><span class="label">
 <xsl:choose>
 <xsl:when test="@ind2=' '">
 En: </xsl:when>
 <xsl:when test="@ind2=8">
 <xsl:if test="marc:subfield[@code='i']">
 <xsl:value-of select="marc:subfield[@code='i']"/>
 </xsl:if>
 </xsl:when>
 </xsl:choose>
 </span>
 <xsl:variable name="f773">
 <xsl:call-template name="chopPunctuation"><xsl:with-param name="chopString"><xsl:call-template name="subfieldSelect">
 <xsl:with-param name="codes">a_t</xsl:with-param>
 </xsl:call-template></xsl:with-param></xsl:call-template>
 </xsl:variable>
 <xsl:choose>
 <xsl:when test="$UseControlNumber = '1' and marc:subfield[@code='w']">
 <xsl:if test="marc:subfield[@code='t']">
 <a><xsl:attribute name="href">/cgi-bin/koha/opac-search.pl?q=Control-number:<xsl:call-template name="extractControlNumber"><xsl:with-param name="subfieldW" select="marc:subfield[@code='w']"/></xsl:call-template></xsl:attribute>
 <xsl:value-of select="marc:subfield[@code='t']"/>
 </a>
 <xsl:if test="marc:subfield[@code='d']">
 <span class="label"><xsl:text> - </xsl:text><xsl:value-of select="marc:subfield[@code='d']"/></span>
 </xsl:if>
 <xsl:if test="marc:subfield[@code='g']"><xsl:text> - </xsl:text><xsl:value-of select="marc:subfield[@code='g']"/></xsl:if>
 </xsl:if>
 </xsl:when>
 <xsl:when test="$UseControlNumber = '0'">
 <a><xsl:attribute name="href">/cgi-bin/koha/opac-search.pl?q=ti,phr:<xsl:value-of select="marc:subfield[@code='t']"/></xsl:attribute>
 <xsl:value-of select="marc:subfield[@code='t']"/>
 </a>
 <xsl:if test="marc:subfield[@code='d']">
 <span class="label"><xsl:text> - </xsl:text><xsl:value-of select="marc:subfield[@code='d']"/></span>
 </xsl:if>
 <xsl:if test="marc:subfield[@code='g']"><xsl:text></xsl:text><xsl:value-of select="marc:subfield[@code='g']"/></xsl:if>
 </xsl:when>
 <xsl:otherwise>
 <a><xsl:if test="marc:subfield[@code='t']"><xsl:text></xsl:text><xsl:value-of select="marc:subfield[@code='t']"/></xsl:if></a>
 <xsl:if test="marc:subfield[@code='d']">
 <span class="label"><xsl:text> - </xsl:text><xsl:value-of select="marc:subfield[@code='d']"/></span>
 </xsl:if>
 <xsl:if test="marc:subfield[@code='g']"><xsl:text> - </xsl:text><xsl:value-of select="marc:subfield[@code='g']"/></xsl:if>
 </xsl:otherwise>
 <xsl:when test="marc:subfield[@code='0']">
 <a><xsl:attribute name="href">/cgi-bin/koha/opac-detail.pl?biblionumber=<xsl:value-of select="marc:subfield[@code='0']"/></xsl:attribute>
 <xsl:value-of select="$f773"/>
 </a>
 </xsl:when>
 <xsl:otherwise>
 <a><xsl:attribute name="href">/cgi-bin/koha/opac-search.pl?q=ti,phr:<xsl:value-of select="translate($f773, '()', '')"/></xsl:attribute>
 <xsl:value-of select="$f773"/>
 </a>
 <xsl:if test="marc:subfield[@code='g']"><xsl:text> </xsl:text><xsl:value-of select="marc:subfield[@code='g']"/></xsl:if>
 </xsl:otherwise>
 </xsl:choose>
 </span>

 </xsl:if>
 </xsl:for-each>
 </xsl:if>

 <xsl:for-each select="marc:datafield[@tag=511]">
 <span class="results_summary perf_note">
 <span class="label">
 <xsl:if test="@ind1=1"><xsl:text>Reparto:</xsl:text></xsl:if>
 </span>
 <xsl:call-template name="subfieldSelect">
 <xsl:with-param name="codes">a</xsl:with-param>
 </xsl:call-template>
 </span>
 </xsl:for-each>

 <xsl:if test="marc:datafield[@tag=502]">
 <span class="results_summary diss_note">
 <span class="label">Nota de disertación:</span>
 <xsl:for-each select="marc:datafield[@tag=502]">
 <xsl:call-template name="subfieldSelect">
 <xsl:with-param name="codes">abcdgo</xsl:with-param>
 </xsl:call-template>
 </xsl:for-each>
 <xsl:choose><xsl:when test="position()=last()"><xsl:text></xsl:text></xsl:when><xsl:otherwise><xsl:text> </xsl:text></xsl:otherwise></xsl:choose>
 </span>
 </xsl:if>

 <xsl:for-each select="marc:datafield[@tag=520]">
 <span class="results_summary summary"><span class="label">
 <xsl:choose>
 <xsl:when test="@ind1=0"><xsl:text>Tema: </xsl:text></xsl:when>
 <xsl:when test="@ind1=1"><xsl:text>Comentario:</xsl:text></xsl:when>
 <xsl:when test="@ind1=2"><xsl:text>Ámbito y contenido: </xsl:text></xsl:when>
 <xsl:when test="@ind1=3"><xsl:text>Resumen: </xsl:text></xsl:when>
 <xsl:when test="@ind1=4"><xsl:text>Recomendación de contenido: </xsl:text></xsl:when>
 <xsl:otherwise><xsl:text>Resumen: </xsl:text></xsl:otherwise>
 </xsl:choose>
 </span>
 <xsl:call-template name="subfieldSelect">
 <xsl:with-param name="codes">abcu</xsl:with-param>
 </xsl:call-template>
 </span>
 </xsl:for-each>

 <!-- 866 textual holdings -->
 <xsl:if test="marc:datafield[@tag=866]">
 <span class="results_summary holdings_note"><span class="label">Nota de ejemplaress:</span>
 <xsl:for-each select="marc:datafield[@tag=866]">
 <xsl:call-template name="subfieldSelect">
 <xsl:with-param name="codes">az</xsl:with-param>
 </xsl:call-template>
 <xsl:choose><xsl:when test="position()=last()"><xsl:text></xsl:text></xsl:when><xsl:otherwise><xsl:text>; </xsl:text></xsl:otherwise></xsl:choose>
 </xsl:for-each>
 </span>
 </xsl:if>

 <!-- 775 Other Edition -->
 <xsl:if test="marc:datafield[@tag=775]">
 <span class="results_summary other_editions"><span class="label">Otras ediciones: </span>
 <xsl:for-each select="marc:datafield[@tag=775]">
 <xsl:variable name="f775">
 <xsl:call-template name="chopPunctuation"><xsl:with-param name="chopString"><xsl:call-template name="subfieldSelect">
 <xsl:with-param name="codes">a_t</xsl:with-param>
 </xsl:call-template></xsl:with-param></xsl:call-template>
 </xsl:variable>
 <xsl:if test="marc:subfield[@code='i']">
 <xsl:call-template name="subfieldSelect">
 <xsl:with-param name="codes">i</xsl:with-param>
 </xsl:call-template>
 <xsl:text>: </xsl:text>
 </xsl:if>
 <a>
 <xsl:choose>
 <xsl:when test="$UseControlNumber = '1' and marc:subfield[@code='w']">
 <xsl:attribute name="href">/cgi-bin/koha/opac-search.pl?q=Control-number:<xsl:call-template name="extractControlNumber"><xsl:with-param name="subfieldW" select="marc:subfield[@code='w']"/></xsl:call-template></xsl:attribute>
 </xsl:when>
 <xsl:otherwise>
 <xsl:attribute name="href">/cgi-bin/koha/opac-search.pl?q=ti,phr:<xsl:value-of select="translate($f775, '()', '')"/></xsl:attribute>
 </xsl:otherwise>
 </xsl:choose>
 <xsl:call-template name="subfieldSelect">
 <xsl:with-param name="codes">a_t</xsl:with-param>
 </xsl:call-template>
 </a>
 <xsl:choose>
 <xsl:when test="position()=last()"></xsl:when>
 <xsl:otherwise><xsl:text>; </xsl:text></xsl:otherwise>
 </xsl:choose>
 </xsl:for-each>
 </span>
 </xsl:if>

 <!-- 780 -->
 <xsl:if test="marc:datafield[@tag=780]">
 <xsl:for-each select="marc:datafield[@tag=780]">
 <xsl:if test="@ind1=0">
 <span class="results_summary preceeding_entry">
 <xsl:choose>
 <xsl:when test="@ind2=0">
 <span class="label">Continúa:</span>
 </xsl:when>
 <xsl:when test="@ind2=1">
 <span class="label">Continúa en parte:</span>
 </xsl:when>
 <xsl:when test="@ind2=2">
 <span class="label">Sustituye:</span>
 </xsl:when>
 <xsl:when test="@ind2=3">
 <span class="label">Sustituye en parte:</span>
 </xsl:when>
 <xsl:when test="@ind2=4">
 <span class="label">Formado por la unión: ... y: ...</span>
 </xsl:when>
 <xsl:when test="@ind2=5">
 <span class="label">Absorbido:</span>
 </xsl:when>
 <xsl:when test="@ind2=6">
 <span class="label">Absorbido en parte:</span>
 </xsl:when>
 <xsl:when test="@ind2=7">
 <span class="label">Separado de:</span>
 </xsl:when>
 </xsl:choose>
 <xsl:text> </xsl:text>
 <xsl:variable name="f780">
 <xsl:call-template name="subfieldSelect">
 <xsl:with-param name="codes">a_t</xsl:with-param>
 </xsl:call-template>
 </xsl:variable>
 <xsl:choose>
 <xsl:when test="$UseControlNumber = '1' and marc:subfield[@code='w']">
 <a><xsl:attribute name="href">/cgi-bin/koha/opac-search.pl?q=Control-number:<xsl:call-template name="extractControlNumber"><xsl:with-param name="subfieldW" select="marc:subfield[@code='w']"/></xsl:call-template></xsl:attribute>
 <xsl:value-of select="marc:subfield[@code='t']"/>
 </a>
 </xsl:when>
 <xsl:otherwise>
 <xsl:if test="marc:subfield[@code='t']">
 <xsl:value-of select="marc:subfield[@code='t']"/>
 </xsl:if>
 </xsl:otherwise>
 </xsl:choose>
 </span>

 <xsl:if test="marc:subfield[@code='n']">
 <span class="results_summary"><xsl:value-of select="marc:subfield[@code='n']"/></span>
 </xsl:if>

 </xsl:if>
 </xsl:for-each>
 </xsl:if>

 <!-- 785 -->
 <xsl:if test="marc:datafield[@tag=785]">
 <xsl:for-each select="marc:datafield[@tag=785]">
 <xsl:if test="@ind1=0">
 <span class="results_summary succeeding_entry">
 <xsl:choose>
 <xsl:when test="@ind2=0">
 <span class="label">Continuado por:</span>
 </xsl:when>
 <xsl:when test="@ind2=1">
 <span class="label">Continuado en parte por:</span>
 </xsl:when>
 <xsl:when test="@ind2=2">
 <span class="label">Sustituido por:</span>
 </xsl:when>
 <xsl:when test="@ind2=3">
 <span class="label">Sustituido en parte por:</span>
 </xsl:when>
 <xsl:when test="@ind2=4">
 <span class="label">Absorbido por:</span>
 </xsl:when>
 <xsl:when test="@ind2=5">
 <span class="label">Absorbido en parte por:</span>
 </xsl:when>
 <xsl:when test="@ind2=6">
 <span class="label">Dividir en .. y ...:</span>
 </xsl:when>
 <xsl:when test="@ind2=7">
 <span class="label">Combinado con ... para formar ...</span>
 </xsl:when>
 <xsl:when test="@ind2=8">
 <span class="label">Cambió de nuevo a:</span>
 </xsl:when>
 </xsl:choose>
 <xsl:text> </xsl:text>
 <xsl:variable name="f785">
 <xsl:call-template name="subfieldSelect">
 <xsl:with-param name="codes">a_t</xsl:with-param>
 </xsl:call-template>
 </xsl:variable>

 <xsl:choose>
 <xsl:when test="$UseControlNumber = '1' and marc:subfield[@code='w']">
 <a><xsl:attribute name="href">/cgi-bin/koha/opac-search.pl?q=Control-number:<xsl:call-template name="extractControlNumber"><xsl:with-param name="subfieldW" select="marc:subfield[@code='w']"/></xsl:call-template></xsl:attribute>
 <xsl:value-of select="marc:subfield[@code='t']"/>
 </a>
 </xsl:when>
 <xsl:otherwise>
 <xsl:if test="marc:subfield[@code='t']">
 <xsl:value-of select="marc:subfield[@code='t']"/>
 </xsl:if>
 </xsl:otherwise>
 </xsl:choose>

 </span>

 <xsl:if test="marc:subfield[@code='n']">
 <span class="results_summary"><xsl:value-of select="marc:subfield[@code='n']"/></span>
 </xsl:if>

 </xsl:if>
 </xsl:for-each>
 </xsl:if>
 
 <!-- 787 -->
 <xsl:if test="marc:datafield[@tag=787]">
 <xsl:for-each select="marc:datafield[@tag=787]">
 <xsl:if test="@ind1=0">
 <span class="results_summary in"><span class="label">
 <xsl:choose>
 <xsl:when test="@ind2=' '">
 Item relacionado:</xsl:when>
 <xsl:when test="@ind2=8">
 <xsl:if test="marc:subfield[@code='i']">
 <xsl:value-of select="marc:subfield[@code='i']"/>
 </xsl:if>
 </xsl:when>
 </xsl:choose>
 </span>
 <xsl:variable name="f787">
 <xsl:call-template name="chopPunctuation"><xsl:with-param name="chopString"><xsl:call-template name="subfieldSelect">
 <xsl:with-param name="codes">a_t</xsl:with-param>
 </xsl:call-template></xsl:with-param></xsl:call-template>
 </xsl:variable>
 <xsl:choose>
 <xsl:when test="$UseControlNumber = '1' and marc:subfield[@code='w']">
 <xsl:if test="marc:subfield[@code='t']">
 <a><xsl:attribute name="href">/cgi-bin/koha/opac-search.pl?q=Control-number:<xsl:call-template name="extractControlNumber"><xsl:with-param name="subfieldW" select="marc:subfield[@code='w']"/></xsl:call-template></xsl:attribute>
 <xsl:value-of select="marc:subfield[@code='t']"/>
 </a>
 <xsl:if test="marc:subfield[@code='d']">
 <span class="label"><xsl:text> - </xsl:text><xsl:value-of select="marc:subfield[@code='d']"/></span>
 </xsl:if>
 <xsl:if test="marc:subfield[@code='g']"><xsl:text> - </xsl:text><xsl:value-of select="marc:subfield[@code='g']"/></xsl:if>
 </xsl:if>
 </xsl:when>
 <xsl:when test="$UseControlNumber = '0'">
 <a><xsl:attribute name="href">/cgi-bin/koha/opac-search.pl?q=ti,phr:<xsl:value-of select="marc:subfield[@code='t']"/></xsl:attribute>
 <xsl:value-of select="marc:subfield[@code='t']"/>
 </a>
 <xsl:if test="marc:subfield[@code='d']">
 <span class="label"><xsl:text> - </xsl:text><xsl:value-of select="marc:subfield[@code='d']"/></span>
 </xsl:if>
 <xsl:if test="marc:subfield[@code='g']"><xsl:text></xsl:text><xsl:value-of select="marc:subfield[@code='g']"/></xsl:if>
 </xsl:when>
 <xsl:otherwise>
 <a><xsl:if test="marc:subfield[@code='t']"><xsl:text></xsl:text><xsl:value-of select="marc:subfield[@code='t']"/></xsl:if></a>
 <xsl:if test="marc:subfield[@code='d']">
 <span class="label"><xsl:text> - </xsl:text><xsl:value-of select="marc:subfield[@code='d']"/></span>
 </xsl:if>
 <xsl:if test="marc:subfield[@code='g']"><xsl:text> - </xsl:text><xsl:value-of select="marc:subfield[@code='g']"/></xsl:if>
 </xsl:otherwise>
 <xsl:when test="marc:subfield[@code='0']">
 <a><xsl:attribute name="href">/cgi-bin/koha/opac-detail.pl?biblionumber=<xsl:value-of select="marc:subfield[@code='0']"/></xsl:attribute>
 <xsl:value-of select="$f787"/>
 </a>
 </xsl:when>
 <xsl:otherwise>
 <a><xsl:attribute name="href">/cgi-bin/koha/opac-search.pl?q=ti,phr:<xsl:value-of select="translate($f773, '()', '')"/></xsl:attribute>
 <xsl:value-of select="$f787"/>
 </a>
 <xsl:if test="marc:subfield[@code='g']"><xsl:text> </xsl:text><xsl:value-of select="marc:subfield[@code='g']"/></xsl:if>
 </xsl:otherwise>
 </xsl:choose>
 </span>

 </xsl:if>
 </xsl:for-each>
 </xsl:if>

 </xsl:element>
 </xsl:template>

 <xsl:template name="showAuthor">
 <xsl:param name="authorfield" />
 <xsl:param name="UseAuthoritiesForTracings" />
 <xsl:for-each select="$authorfield">
 <xsl:choose><xsl:when test="position()!=1"><xsl:text>; </xsl:text></xsl:when></xsl:choose>
 <xsl:choose>
 <xsl:when test="not(@tag=111 or @tag=711)" />
 <xsl:when test="marc:subfield[@code='n']">
 <xsl:text> </xsl:text>
 <xsl:call-template name="subfieldSelect">
 <xsl:with-param name="codes">n</xsl:with-param>
 </xsl:call-template>
 <xsl:text> </xsl:text>
 </xsl:when>
 </xsl:choose>
 <a>
 <xsl:choose>
 <xsl:when test="marc:subfield[@code=9] and $UseAuthoritiesForTracings='1'">
 <xsl:attribute name="href">/cgi-bin/koha/opac-search.pl?q=an:<xsl:value-of select="marc:subfield[@code=9]"/>"</xsl:attribute>
 </xsl:when>
 <xsl:otherwise>
 <xsl:attribute name="href">/cgi-bin/koha/opac-search.pl?q=au:<xsl:value-of select="marc:subfield[@code='a']"/>"</xsl:attribute>
 </xsl:otherwise>
 </xsl:choose>
 <xsl:choose>
 <xsl:when test="@tag=100 or @tag=700"><xsl:call-template name="nameABCQ"/></xsl:when>
 <xsl:when test="@tag=110 or @tag=710"><xsl:call-template name="nameABTNDC"/></xsl:when>
 <xsl:when test="@tag=111 or @tag=711"><xsl:call-template name="nameANQDCE"/></xsl:when>
 </xsl:choose>
 <!-- add relator code too between brackets-->
 <xsl:if test="marc:subfield[@code='4' or @code='e']">
 <span class="relatorcode">
 <xsl:text> [</xsl:text>
 <xsl:choose>
 <xsl:when test="marc:subfield[@code=4]"><xsl:value-of select="marc:subfield[@code=4]"/></xsl:when>
 <xsl:otherwise><xsl:value-of select="marc:subfield[@code='e']"/></xsl:otherwise>
 </xsl:choose>
 <xsl:text>]</xsl:text>
 </span>
 </xsl:if>
 </a>
 <xsl:if test="marc:subfield[@code=9]">
 <a class='authlink'>
 <xsl:attribute name="href">/cgi-bin/koha/opac-authoritiesdetail.pl?authid=<xsl:value-of select="marc:subfield[@code=9]"/>"</xsl:attribute>
 <img style="vertical-align:middle" height="15" width="15" src="/opac-tmpl/prog/images/filefind.png"/>
 </a>
 </xsl:if>
 </xsl:for-each>
 <xsl:text>.</xsl:text>
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

 <xsl:template name="nameABTNDC">
 <xsl:for-each select="marc:subfield[@code='a']">
 <xsl:call-template name="chopPunctuation">
 <xsl:with-param name="chopString" select="."/>
 </xsl:call-template>
 </xsl:for-each>
 <xsl:for-each select="marc:subfield[@code='b']">
 <xsl:text>. </xsl:text>
 <xsl:value-of select="."/>
 <xsl:choose>
 <xsl:when test="position() != last()">
 <xsl:text> -- </xsl:text>
 </xsl:when>
 </xsl:choose>
 </xsl:for-each>
 <xsl:if test="marc:subfield[@code='t']">
 <xsl:text>. </xsl:text>
 <xsl:call-template name="subfieldSelect">
 <xsl:with-param name="codes">t</xsl:with-param>
 </xsl:call-template>
 </xsl:if>
 <xsl:if test="marc:subfield[@code='n']">
 <xsl:text>. </xsl:text>
 <xsl:call-template name="subfieldSelect">
 <xsl:with-param name="codes">n</xsl:with-param>
 </xsl:call-template>
 </xsl:if>
 <xsl:if test="marc:subfield[@code='d']">
 <xsl:text>. </xsl:text>
 <xsl:call-template name="subfieldSelect">
 <xsl:with-param name="codes">d</xsl:with-param>
 </xsl:call-template>
 </xsl:if>
 <xsl:if test="marc:subfield[@code='c']">
 <xsl:text>. </xsl:text>
 <xsl:call-template name="subfieldSelect">
 <xsl:with-param name="codes">c</xsl:with-param>
 </xsl:call-template>
 </xsl:if>
 </xsl:template>

 <xsl:template name="nameANQDCE">
 <xsl:if test="marc:subfield[@code='a']">
 <xsl:call-template name="subfieldSelect">
 <xsl:with-param name="codes">a</xsl:with-param>
 </xsl:call-template>
 </xsl:if>
 <xsl:if test="marc:subfield[@code='n']">
 <xsl:text> ( </xsl:text>
 <xsl:call-template name="subfieldSelect">
 <xsl:with-param name="codes">n</xsl:with-param>
 </xsl:call-template>
 </xsl:if>
 <xsl:if test="marc:subfield[@code='q']">
 <xsl:text>. </xsl:text>
 <xsl:call-template name="subfieldSelect">
 <xsl:with-param name="codes">q</xsl:with-param>
 </xsl:call-template>
 </xsl:if>
 <xsl:if test="marc:subfield[@code='d']">
 <xsl:text>. </xsl:text>
 <xsl:call-template name="subfieldSelect">
 <xsl:with-param name="codes">d</xsl:with-param>
 </xsl:call-template>
 </xsl:if>
 <xsl:if test="marc:subfield[@code='c']">
 <xsl:text>. </xsl:text>
 <xsl:call-template name="subfieldSelect">
 <xsl:with-param name="codes">c</xsl:with-param>
 </xsl:call-template>
 </xsl:if>
 <xsl:if test="marc:subfield[@code='e']">
 <xsl:text>. </xsl:text>
 <xsl:call-template name="subfieldSelect">
 <xsl:with-param name="codes">e</xsl:with-param>
 </xsl:call-template>
 </xsl:if>
 <xsl:if test="marc:subfield[@code='n' or @code='q' or @code='d' or @code='c' or @code='e']">
 <xsl:text> ) </xsl:text>
 </xsl:if> 
 </xsl:template>

 <xsl:template name="part">
 <xsl:variable name="partNumber">
 <xsl:call-template name="specialSubfieldSelect">
 <xsl:with-param name="axis">n</xsl:with-param>
 <xsl:with-param name="anyCodes">n</xsl:with-param>
 <xsl:with-param name="afterCodes">fghkdlmor</xsl:with-param>
 </xsl:call-template>
 </xsl:variable>
 <xsl:variable name="partName">
 <xsl:call-template name="specialSubfieldSelect">
 <xsl:with-param name="axis">p</xsl:with-param>
 <xsl:with-param name="anyCodes">p</xsl:with-param>
 <xsl:with-param name="afterCodes">fghkdlmor</xsl:with-param>
 </xsl:call-template>
 </xsl:variable>
 <xsl:if test="string-length(normalize-space($partNumber))">
 <xsl:call-template name="chopPunctuation">
 <xsl:with-param name="chopString" select="$partNumber"/>
 </xsl:call-template>
 </xsl:if>
 <xsl:if test="string-length(normalize-space($partName))">
 <xsl:call-template name="chopPunctuation">
 <xsl:with-param name="chopString" select="$partName"/>
 </xsl:call-template>
 </xsl:if>
 </xsl:template>

 <xsl:template name="specialSubfieldSelect">
 <xsl:param name="anyCodes"/>
 <xsl:param name="axis"/>
 <xsl:param name="beforeCodes"/>
 <xsl:param name="afterCodes"/>
 <xsl:variable name="str">
 <xsl:for-each select="marc:subfield">
 <xsl:if test="contains($anyCodes, @code)      or (contains($beforeCodes,@code) and following-sibling::marc:subfield[@code=$axis])      or (contains($afterCodes,@code) and preceding-sibling::marc:subfield[@code=$axis])">
 <xsl:value-of select="text()"/>
 <xsl:text> </xsl:text>
 </xsl:if>
 </xsl:for-each>
 </xsl:variable>
 <xsl:value-of select="substring($str,1,string-length($str)-1)"/>
 </xsl:template>
</xsl:stylesheet>
