<!--
  Anzeige fuer mets.xml im Navigator (c) HAB; staecker 2012-05-20
-->
<!--
 2013-03-30  Umstellung von TYPE='submenu' auf Funktion http://diglib.hab.de/behavior#folding  in behavior-Sec 
-->
<xsl:stylesheet xmlns:xsl="http://www.w3.org/1999/XSL/Transform" xmlns:mets="http://www.loc.gov/METS/" xmlns:mods="http://www.loc.gov/mods/v3" xmlns:pica="info:srw/schema/5/picaXML-v1.0" xmlns:rmd="http://diglib.hab.de/rights" xmlns:tei="http://www.tei-c.org/ns/1.0" xmlns:wdb="http://diglib.hab.de/wdb/" xmlns:xlink="http://www.w3.org/1999/xlink" xmlns:html="http://www.w3.org/1999/xhtml" exclude-result-prefixes="html mets mods pica rmd tei" version="1.0">
<xsl:import href="http://diglib.hab.de/rules/styles/param.xsl"/>
<xsl:import href="http://diglib.hab.de/rules/styles/bibliography.xsl"/>
<xsl:import href="http://diglib.hab.de/rules/styles/url-encode.xsl"/>
<xsl:output method="html" encoding="UTF-8" indent="yes" doctype-public="-//W3C//DTD HTML 4.0 Transitional//EN"/>
<xsl:strip-space elements="*"/>
<xsl:param name="lang"/>
<xsl:param name="footerXML"/>
<xsl:param name="footerXSL"/>
<xsl:variable name="codeNo">
<xsl:value-of select="mets:mets/@OBJID"/>
</xsl:variable>
<!--
 Legenden (Lokalisation; ggf.  in Zukunft auslagern in param.xsl) 
-->
<xsl:variable name="content_en">
<xsl:text>Contents</xsl:text>
</xsl:variable>
<xsl:variable name="content_de">
<xsl:text>Inhalt</xsl:text>
</xsl:variable>
<xsl:variable name="pv_en">
<xsl:text>Parallel Views</xsl:text>
</xsl:variable>
<xsl:variable name="pv_de">
<xsl:text>Parallele Anzeige</xsl:text>
</xsl:variable>
<xsl:template match="/">
<html>
<head>
<title>
<xsl:apply-templates select="/mets:mets/mets:dmdSec[@ID='dmd_local']/mets:mdWrap/mets:xmlData/wdb:title"/>
</title>
<link rel="stylesheet" type="text/css" href="http://diglib.hab.de/navigator2.css"/>
<script src="http://diglib.hab.de/navigator.js" type="text/javascript">
<noscript>please activate javascript to enable wdb functions</noscript>
</script>
</head>
<body>
<div class="toc_content">
<xsl:choose>
<xsl:when test="/mets:mets/mets:dmdSec[@ID='dmd_local']">
<div id="toc_title">
<div>
<xsl:choose>
<xsl:when test="/mets:mets/mets:dmdSec[@ID='dmd_local']/mets:mdWrap/mets:xmlData/mods:mods">
<xsl:apply-templates select="//mets:mets/mets:dmdSec[@ID='dmd_local']/mets:mdWrap/mets:xmlData/mods:mods"/>
</xsl:when>
<!--  TEI lokal  -->
<xsl:when test="/mets:mets/mets:dmdSec[@ID='dmd_local']/mets:mdWrap/mets:xmlData/tei:*">
<xsl:apply-templates select="/mets:mets/mets:dmdSec[@ID='dmd_local']/mets:mdWrap/mets:xmlData/tei:*"/>
</xsl:when>
<!--  wdb Titelinformationen - deprecated  -->
<xsl:when test="/mets:mets/mets:dmdSec[@ID='dmd_local']/mets:mdWrap/mets:xmlData/wdb:title">
<xsl:value-of select="/mets:mets/mets:dmdSec[@ID='dmd_local']/mets:mdWrap/mets:xmlData/wdb:title"/>
<xsl:if test="/mets:mets/mets:dmdSec[@ID='dmd_local']/mets:mdWrap/mets:xmlData/wdb:ppn">
<xsl:text>[</xsl:text>
<a>
<xsl:attribute name="href">
<xsl:value-of select="$opac"/>
<xsl:value-of select="/mets:mets/mets:dmdSec[@ID='dmd_local']/mets:mdWrap/mets:xmlData/wdb:ppn"/>
</xsl:attribute>
<xsl:attribute name="target">_blank</xsl:attribute>
<xsl:text>↗opac</xsl:text>
</a>
<xsl:text>]</xsl:text>
</xsl:if>
</xsl:when>
<xsl:otherwise>
<xsl:text>No title found - please contact</xsl:text>
<a href="mailto:auskunft@hab.de">the library</a>
</xsl:otherwise>
</xsl:choose>
</div>
<div style="font-size:smaller;margin:0.5em 0 0.5em 0;">
<xsl:choose>
<xsl:when test="/mets:mets/mets:dmdSec[@ID='dmd_local']/mets:mdWrap/mets:xmlData/mods:mods/mods:identifier[@type='purl']">
<xsl:value-of select="/mets:mets/mets:dmdSec[@ID='dmd_local']/mets:mdWrap/mets:xmlData/mods:mods/mods:identifier[@type='purl']"/>
</xsl:when>
<!--  wdb deprecated   -->
<xsl:when test="/mets:mets/mets:dmdSec[@ID='dmd_local']/mets:mdWrap/mets:xmlData/wdb:purl">
<xsl:value-of select="/mets:mets/mets:dmdSec[@ID='dmd_local']/mets:mdWrap/mets:xmlData/wdb:purl"/>
</xsl:when>
</xsl:choose>
</div>
</div>
</xsl:when>
<xsl:when test="/mets:mets/mets:dmdSec[@ID='dmd_opac']">
<div id="toc_title">
<xsl:apply-templates select="document(/mets:mets/mets:dmdSec[@ID='dmd_opac']/mets:mdRef/@xlink:href)/mods:mods"/>
<xsl:apply-templates select="document(/mets:mets/mets:dmdSec[@ID='dmd_opac']/mets:mdRef/@xlink:href)/pica:record"/>
<div style="font-size:smaller;margin:0.5em 0 0.5em 0;">
<xsl:value-of select="document(/mets:mets/mets:dmdSec[@ID='dmd_opac']/mets:mdRef/@xlink:href)/mods:mods/mods:location/mods:url[@usage='primary display']"/>
</div>
</div>
</xsl:when>
<xsl:otherwise/>
</xsl:choose>
</div>
<xsl:choose>
<xsl:when test="document(concat($server, '/', /mets:mets/@OBJID, '/ToC.html'))">
<xsl:copy-of select="document(concat($server, '/', /mets:mets/@OBJID, '/ToC.html'))"/>
</xsl:when>
<xsl:otherwise>
<div class="toc_content">
<h2>
<xsl:choose>
<xsl:when test="$lang='de'">
<xsl:value-of select="$content_de"/>
</xsl:when>
<xsl:otherwise>
<xsl:value-of select="$content_en"/>
</xsl:otherwise>
</xsl:choose>
</h2>
<div style="border: 1px solid gray;padding-right:5px;">
<ul>
<xsl:apply-templates select="/mets:mets/mets:structMap/mets:div/mets:div[@ID != 'parallel_views']"/>
</ul>
</div>
</div>
<xsl:if test="/mets:mets/mets:structMap/mets:div/mets:div[@ID = 'parallel_views' ]">
<div class="toc_content">
<h2>
<xsl:choose>
<xsl:when test="$lang='de'">
<xsl:value-of select="$pv_de"/>
</xsl:when>
<xsl:otherwise>
<xsl:value-of select="$pv_en"/>
</xsl:otherwise>
</xsl:choose>
</h2>
<div style="border: 1px solid gray">
<ul>
<xsl:apply-templates select="/mets:mets/mets:structMap/mets:div/mets:div[@ID = 'parallel_views']"/>
</ul>
</div>
</div>
</xsl:if>
</xsl:otherwise>
</xsl:choose>
<xsl:call-template name="footer">
<xsl:with-param name="footerXML">
<xsl:value-of select="$footerXML"/>
</xsl:with-param>
<xsl:with-param name="footerXSL">
<xsl:value-of select="$footerXSL"/>
</xsl:with-param>
</xsl:call-template>
</body>
</html>
</xsl:template>
<!--
  #################### Bibliographische Eintraege ##########################################################################   
-->
<!--  PICA +  -->
<xsl:template match="pica:record">
<xsl:apply-templates select="pica:datafield[@tag='021A']"/>
<xsl:apply-templates select="pica:datafield[@tag='033A']"/>
<xsl:text>,</xsl:text>
<xsl:apply-templates select="pica:datafield[@tag='011@']"/>
<xsl:apply-templates select="pica:datafield[@tag='003@']"/>
</xsl:template>
<xsl:template match="pica:datafield">
<xsl:apply-templates select="pica:subfield"/>
</xsl:template>
<xsl:template match="pica:subfield[@code ='a']">
<xsl:value-of select="."/>
</xsl:template>
<xsl:template match="pica:subfield[@code ='d']">
<xsl:text>.</xsl:text>
<xsl:value-of select="."/>
</xsl:template>
<xsl:template match="pica:subfield[@code ='h']">
<xsl:text>:</xsl:text>
<xsl:value-of select="."/>
</xsl:template>
<xsl:template match="pica:subfield[@code ='p']">
<xsl:text>.</xsl:text>
<xsl:value-of select="."/>
</xsl:template>
<xsl:template match="pica:subfield[@code ='n']">
<xsl:text>:</xsl:text>
<xsl:value-of select="."/>
</xsl:template>
<xsl:template match="pica:subfield[@code ='0']">
<xsl:text>[</xsl:text>
<a>
<xsl:attribute name="href">
<xsl:value-of select="$opac"/>
<xsl:value-of select="."/>
</xsl:attribute>
<xsl:attribute name="target">_blank</xsl:attribute>
<xsl:text>↗opac</xsl:text>
</a>
<xsl:text>]</xsl:text>
</xsl:template>
<!--  MODS  -->
<xsl:template match="mods:mods">
<!--  zentarler Verteiler  -->
<xsl:choose>
<xsl:when test="mods:name/@usage='primary'">
<xsl:apply-templates select="mods:name" mode="opac"/>
</xsl:when>
<xsl:otherwise>
<xsl:apply-templates select="mods:name" mode="local"/>
</xsl:otherwise>
</xsl:choose>
<xsl:apply-templates select="mods:titleInfo[not(@type='alternative')]"/>
<xsl:apply-templates select="mods:originInfo"/>
<xsl:apply-templates select="mods:relatedItem"/>
<xsl:apply-templates select="mods:recordInfo"/>
<xsl:apply-templates select="mods:note[@type='original location']"/>
<xsl:apply-templates select="mods:note[@type='local']"/>
</xsl:template>
<xsl:template match="mods:name" mode="local">
<xsl:if test="position() > 1">
<xsl:text>;</xsl:text>
</xsl:if>
<xsl:choose>
<xsl:when test="mods:namePart[@type='family']">
<xsl:value-of select="mods:namePart[@type='family']"/>
<xsl:text>,</xsl:text>
<xsl:value-of select="mods:namePart[@type='given']"/>
</xsl:when>
<xsl:otherwise>
<xsl:value-of select="mods:namePart[1]"/>
<xsl:text></xsl:text>
<xsl:value-of select="mods:namePart[2]"/>
</xsl:otherwise>
</xsl:choose>
<xsl:if test="position() = last()">
<xsl:text>:</xsl:text>
</xsl:if>
</xsl:template>
<xsl:template match="mods:name" mode="opac">
<xsl:if test="@usage='primary'">
<xsl:if test="position() > 1">
<xsl:text>;</xsl:text>
</xsl:if>
<xsl:choose>
<xsl:when test="mods:namePart[@type='family']">
<xsl:value-of select="mods:namePart[@type='family']"/>
<xsl:text>,</xsl:text>
<xsl:value-of select="mods:namePart[@type='given']"/>
</xsl:when>
<xsl:otherwise>
<xsl:value-of select="mods:namePart[1]"/>
<xsl:text></xsl:text>
<xsl:value-of select="mods:namePart[2]"/>
</xsl:otherwise>
</xsl:choose>
<xsl:if test="position() = last()">
<xsl:text>:</xsl:text>
</xsl:if>
</xsl:if>
</xsl:template>
<xsl:template match="mods:titleInfo">
<i>
<xsl:apply-templates/>
</i>
<xsl:if test="not(ancestor::mods:relatedItem)">
<xsl:text>.</xsl:text>
</xsl:if>
</xsl:template>
<xsl:template match="mods:title">
<xsl:apply-templates/>
</xsl:template>
<xsl:template match="mods:subTitle">
<xsl:text>:</xsl:text>
<xsl:apply-templates/>
</xsl:template>
<xsl:template match="mods:nonSort">
<xsl:apply-templates/>
</xsl:template>
<xsl:template match="mods:originInfo">
<xsl:value-of select="mods:place/mods:placeTerm[@type = 'text'][1]"/>
<xsl:text></xsl:text>
<xsl:value-of select="mods:dateIssued"/>
<xsl:text>.</xsl:text>
</xsl:template>
<!--  Serie  -->
<xsl:template match="mods:relatedItem[@type='series']">
<xsl:text>(</xsl:text>
<xsl:apply-templates/>
<xsl:text>)</xsl:text>
</xsl:template>
<xsl:template match="mods:part">
<xsl:apply-templates/>
</xsl:template>
<xsl:template match="mods:detail">
<xsl:apply-templates/>
</xsl:template>
<xsl:template match="mods:number">
<xsl:text>,</xsl:text>
<xsl:apply-templates/>
</xsl:template>
<xsl:template match="mods:recordInfo">
<xsl:apply-templates select="mods:recordIdentifier"/>
</xsl:template>
<xsl:template match="mods:recordIdentifier">
<xsl:text>[</xsl:text>
<a>
<xsl:attribute name="href">
<xsl:value-of select="$opac"/>
<xsl:value-of select="."/>
</xsl:attribute>
<xsl:attribute name="title">
<xsl:value-of select="@source"/>
</xsl:attribute>
<xsl:attribute name="target">_blank</xsl:attribute>
<xsl:text>↗opac</xsl:text>
</a>
<xsl:text>]</xsl:text>
</xsl:template>
<xsl:template match="mods:note">
<div style="font-style:italic;font-size:0.9em;margin:0.5em 0 0.5em 0;">
<xsl:apply-templates/>
</div>
</xsl:template>
<xsl:template match="tei:title">
<xsl:apply-templates/>
<xsl:text>.</xsl:text>
</xsl:template>
<xsl:template match="tei:respStmt">
<xsl:apply-templates/>
<xsl:text>.</xsl:text>
</xsl:template>
<xsl:template match="tei:publicationStmt">
<xsl:apply-templates select="tei:date | tei:publisher | tei:pubPlace"/>
</xsl:template>
<xsl:template match="tei:publisher">
<xsl:apply-templates/>
<xsl:text>,</xsl:text>
</xsl:template>
<xsl:template match="tei:date">
<xsl:apply-templates/>
<xsl:text>.</xsl:text>
</xsl:template>
<xsl:template match="tei:pubPlace">
<xsl:choose>
<xsl:when test="tei:ptr[@type='purl']">
<div style="font-size:smaller;margin:0.5em 0 0.5em 0;">
<xsl:attribute name="href">
<xsl:value-of select="tei:ptr[@type='purl']/@cRef"/>
</xsl:attribute>
<xsl:value-of select="tei:ptr[@type='purl']/@cRef"/>
</div>
</xsl:when>
</xsl:choose>
</xsl:template>
<!--
  ##### Content Abschnitte #########################################################################################
-->
<xsl:template match="mets:div">
<xsl:variable name="number">
<xsl:number level="multiple"/>
</xsl:variable>
<xsl:choose>
<!--   Parallelsichten Schleife  -->
<xsl:when test="@TYPE ='parallel_views'">
<xsl:apply-templates/>
</xsl:when>
<!--
  Menuefunktionen : verbergen, sichbar, aufklappen ############################################     
-->
<!--  Struktur verbergen : @TYPE = 'hide' deprecated  -->
<xsl:when test="@TYPE = 'hide'"/>
<!--   Aufgeklappt: @TYPE = 'menu'; deprecated  -->
<xsl:when test="@TYPE = 'menu' or //mets:behavior[@ID='function_folding'][@STRUCTID=current()/@ID]/mets:mechanism[@xlink:actuate='onLoad']">
<!--
 zeigt Hierarchiebenen aufgeklappt, kein Auf- und Zuklappen moeglich 
-->
<li>
<xsl:value-of select="@LABEL"/>
<ul>
<xsl:apply-templates/>
</ul>
</li>
</xsl:when>
<!--    @TYPE = 'submenu' is deprecated   -->
<xsl:when test="@TYPE = 'submenu' or //mets:behavior[@ID='function_folding'][@STRUCTID=current()/@ID]/mets:mechanism[@xlink:actuate='onRequest']">
<li>
<a href="javascript:switchlayer('bd{$number}');">
<xsl:value-of select="@LABEL"/>
</a>
<ul>
<xsl:attribute name="ID">
<xsl:text>bd</xsl:text>
<xsl:value-of select="$number"/>
</xsl:attribute>
<xsl:attribute name="style">display:none;</xsl:attribute>
<xsl:apply-templates/>
</ul>
</li>
</xsl:when>
<!--
  Menuefunktionen Ende #####################################################  
-->
<!--
 Parallelsichten ###################################################################### 
-->
<!-- <xsl:when test="mets:fptr/mets:par"> -->
<xsl:when test="parent::mets:div[@ID='parallel_views'] or mets:fptr/mets:par">
<li>
<a>
<xsl:attribute name="href">
<!--  Link anlegen  -->
<xsl:value-of select="$wdb"/>
<xsl:text>?dir=</xsl:text>
<xsl:value-of select="/mets:mets/@OBJID"/>
<xsl:text>&pvpointer=0&pvID=</xsl:text>
<xsl:value-of select="@ID"/>
<xsl:text>&distype=optional</xsl:text>
<!--  linker Frame  -->
<xsl:choose>
<!--  mets file pointer vorhanden  -->
<xsl:when test="mets:mptr">
<xsl:if test="//mets:behavior[parent::mets:behaviorSec[@ID != 'function_navigator']][@STRUCTID =current()/ancestor-or-self::mets:div/@ID]">
<xsl:text>&mxsl=</xsl:text>
<xsl:value-of select="//mets:behavior[parent::mets:behaviorSec[@ID != 'function_navigator']][@STRUCTID =current()/ancestor-or-self::mets:div/@ID]/mets:mechanism/@xlink:href"/>
</xsl:if>
<xsl:text>&mptr=</xsl:text>
<xsl:value-of select="mets:mptr/@xlink:href"/>
</xsl:when>
<!--  kein XML fuer linken Frame vorhanden -->
<xsl:when test="(//mets:file[@ID = current()/mets:fptr/mets:par/mets:area[1]/@FILEID]/@MIMETYPE != 'application/xml') and (//mets:file[@ID = current()/mets:fptr/mets:par/mets:area[1]/@FILEID]/@MIMETYPE != 'text/xml')">
<xsl:text>&fd1=</xsl:text>
<xsl:value-of select="//mets:file[@ID =current()//mets:fptr/mets:par/mets:area[1]/@FILEID]/mets:FLocat/@xlink:href"/>
</xsl:when>
<!--  XML  fuer linken Frame vorhanden -->
<xsl:when test="(//mets:file[@ID = current()/mets:fptr/mets:par/mets:area[1]/@FILEID]/@MIMETYPE = 'application/xml') or (//mets:file[@ID = current()/mets:fptr/mets:par/mets:area[1]/@FILEID]/@MIMETYPE = 'text/xml')">
<xsl:text>&xmld1=</xsl:text>
<xsl:value-of select="//mets:file[@ID = current()/mets:fptr/mets:par/mets:area[1]/@FILEID]/mets:FLocat/@xlink:href"/>
<xsl:text>&xsld1=</xsl:text>
<!--
  XSL dazu auswaehlen; function-Bereich ausschliessen : mets:behaviorSec[@ID != 'function_navigator'] 
-->
<xsl:choose>
<xsl:when test="//mets:behavior[parent::mets:behaviorSec[@ID != 'function_navigator']][@STRUCTID =current()/descendant::mets:area[1]/@ID]">
<xsl:value-of select="//mets:behavior[parent::mets:behaviorSec[@ID != 'function_navigator']][@STRUCTID =current()/descendant::mets:area[1]/@ID]/mets:mechanism/@xlink:href"/>
</xsl:when>
<xsl:when test="//mets:behavior[parent::mets:behaviorSec[@ID != 'function_navigator']][@STRUCTID =current()/ancestor-or-self::mets:div/@ID]">
<xsl:value-of select="//mets:behavior[parent::mets:behaviorSec[@ID != 'function_navigator']][@STRUCTID =current()/ancestor-or-self::mets:div/@ID]/mets:mechanism/@xlink:href"/>
</xsl:when>
</xsl:choose>
</xsl:when>
<xsl:otherwise>
<xsl:text>ERROR: MIMETYPE fehlt in FILE-Attribute</xsl:text>
</xsl:otherwise>
</xsl:choose>
<!-- rechter Frame  -->
<xsl:choose>
<!--  keine Angaben, wenn mets-pointer vorhanden  -->
<xsl:when test="mets:mptr"/>
<!--  kein XML rechter Frame -->
<xsl:when test="(//mets:file[@ID = current()/mets:fptr/mets:par/mets:area[2]/@FILEID]/@MIMETYPE != 'application/xml') and (//mets:file[@ID = current()/mets:fptr/mets:par/mets:area[2]/@FILEID]/@MIMETYPE != 'text/xml')">
<xsl:text>&fd2=</xsl:text>
<xsl:call-template name="url-encode">
<xsl:with-param name="str">
<xsl:value-of select="//mets:file[@ID =current()//mets:fptr/mets:par/mets:area[2]/@FILEID]/mets:FLocat/@xlink:href"/>
</xsl:with-param>
</xsl:call-template>
</xsl:when>
<!--   XML rechter Frame -->
<xsl:when test="(//mets:file[@ID = current()/mets:fptr/mets:par/mets:area[1]/@FILEID]/@MIMETYPE = 'application/xml') or (//mets:file[@ID = current()/mets:fptr/mets:par/mets:area[1]/@FILEID]/@MIMETYPE = 'text/xml')">
<xsl:text>&xmld2=</xsl:text>
<xsl:call-template name="url-encode">
<xsl:with-param name="str">
<xsl:value-of select="//mets:file[@ID = current()/mets:fptr/mets:par/mets:area[2]/@FILEID]/mets:FLocat/@xlink:href"/>
</xsl:with-param>
</xsl:call-template>
<!--
  XSL fuer rechten Frame auswaehlen, function Bereich ausschliessen 
-->
<xsl:text>&xsld2=</xsl:text>
<xsl:choose>
<xsl:when test="//mets:behavior[parent::mets:behaviorSec[@ID != 'function_navigator']][@STRUCTID =current()/descendant::mets:area[2]/@ID]">
<xsl:value-of select="//mets:behavior[parent::mets:behaviorSec[@ID != 'function_navigator']][@STRUCTID =current()/descendant::mets:area[2]/@ID]/mets:mechanism/@xlink:href"/>
</xsl:when>
<xsl:when test="//mets:behavior[parent::mets:behaviorSec[@ID != 'function_navigator']][@STRUCTID =current()/ancestor-or-self::mets:div/@ID]">
<xsl:value-of select="//mets:behavior[parent::mets:behaviorSec[@ID != 'function_navigator']][@STRUCTID =current()/ancestor-or-self::mets:div/@ID]/mets:mechanism/@xlink:href"/>
</xsl:when>
</xsl:choose>
</xsl:when>
<xsl:otherwise>
<xsl:text>
ERROR: MIMETYPE fehlt in FILE-Attribute oder FILE ID nicht gefunden
</xsl:text>
</xsl:otherwise>
</xsl:choose>
<!--
 
                                    $fright=$_GET['fsd2'];
                                    $xmld1=$_GET['xmld1'];
                                    $xmld2=$_GET['xmld2'];
                                    $xsld1=$_GET['xsld1'];
                                    $xsld2=$_GET['xsld2'];
                                
-->
</xsl:attribute>
<xsl:attribute name="target">_top</xsl:attribute>
<xsl:value-of select="@LABEL"/>
</a>
</li>
</xsl:when>
<!--   Parellelsichten Ende   -->
<!--
 Darstellung von Dateien ###############################################################
-->
<!--
   Dateien,  die nicht per XML und XSL generiert werden 
-->
<!--
 @TYPE = 'facsimile' or @TYPE = 'URL' als Steuerung deprecated, wird ueber MIMETYPE gesteuert 
-->
<!--
 im zugehoerigen Filesegment muss stets ein absoluter Pfad (URL) stehen; interne Links (localhost, diglib.hab.de) werden im Frame, 
            externe ausserhalb angezeigt 
-->
<xsl:when test="(//mets:file[@ID = current()/mets:fptr/@FILEID]/@MIMETYPE != 'application/xml') and (//mets:file[@ID = current()/mets:fptr/@FILEID]/@MIMETYPE != 'text/xml')">
<li>
<a>
<xsl:attribute name="href">
<xsl:value-of select="//mets:file[@ID=current()/mets:fptr/@FILEID]/mets:FLocat/@xlink:href"/>
</xsl:attribute>
<xsl:choose>
<xsl:when test="//mets:behavior[@STRUCTID=current()/@ID]/mets:mechanism/@xlink:show='new' or //mets:file[@ID=current()/mets:fptr/@FILEID]/mets:FLocat/@xlink:show='new'">
<xsl:attribute name="target">_blank</xsl:attribute>
</xsl:when>
<xsl:when test="//mets:behavior[@STRUCTID=current()/@ID]/mets:mechanism/@xlink:show='replace' or //mets:file[@ID=current()/mets:fptr/@FILEID]/mets:FLocat/@xlink:show='replace'">
<xsl:attribute name="target">_top</xsl:attribute>
</xsl:when>
<xsl:otherwise>
<xsl:attribute name="target">display2</xsl:attribute>
</xsl:otherwise>
</xsl:choose>
<xsl:value-of select="@LABEL"/>
</a>
</li>
</xsl:when>
<!--
 Dateien, die per XML und XSL zusammengesetzt werden (default); wird ueber MIMETYPE gesteuert 
-->
<xsl:when test="(//mets:file[@ID = current()/mets:fptr/@FILEID]/@MIMETYPE = 'application/xml') or (//mets:file[@ID = current()/mets:fptr/@FILEID]/@MIMETYPE = 'text/xml')">
<li>
<a>
<xsl:attribute name="href">
<xsl:value-of select="$content"/>
<xsl:text>?dir=</xsl:text>
<xsl:value-of select="/mets:mets/@OBJID"/>
<xsl:text>&distype=optional</xsl:text>
<!--
 ersetze: 
                                =  || %3D 
                                &  || %26
                                ?  || %3F
                                "   || %22
                            
-->
<xsl:text>&xml=</xsl:text>
<xsl:call-template name="url-encode">
<xsl:with-param name="str">
<xsl:value-of select="//mets:file[@ID=current()/mets:fptr/@FILEID]/mets:FLocat/@xlink:href"/>
</xsl:with-param>
</xsl:call-template>
<xsl:text>&xsl=</xsl:text>
<xsl:value-of select="//mets:behavior[parent::mets:behaviorSec[@ID != 'function_navigator']][@STRUCTID = current()/ancestor-or-self::mets:div/@ID]/mets:mechanism/@xlink:href"/>
</xsl:attribute>
<xsl:attribute name="target">display2</xsl:attribute>
<xsl:value-of select="@LABEL"/>
</a>
</li>
</xsl:when>
<!--
  Fehlerhafte mets.xml; vermutlich fehlender MIME-Type oder falsche Funktionsbezeichnung 
-->
<xsl:otherwise>
<h1>ERROR - mets.xml ist not valid</h1>
</xsl:otherwise>
</xsl:choose>
</xsl:template>
<!--  StructLinks, derzeit keine Verwendung   -->
<xsl:template match="mets:smLink"/>
</xsl:stylesheet>