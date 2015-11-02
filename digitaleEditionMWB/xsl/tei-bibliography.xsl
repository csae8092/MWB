<?xml version="1.0" encoding="UTF-8"?>
<!-- ANK 2013-06-11: Änderung der Überschrift -->
<!-- PA 2013-01-07: Angleich an tei-register-places/persons.xml
<xsl:include ersetzt durch xsl:import  href="http://diglib.hab.de/rules/styles/param.xsl"/; sowie .../tei-phraselevel.xsl"
-->

<xsl:stylesheet 
    xmlns="http://www.w3.org/1999/xhtml"
    xmlns:tei="http://www.tei-c.org/ns/1.0"
    xmlns:mets="http://www.loc.gov/METS/"
    xmlns:xlink="http://www.w3.org/1999/xlink"
    xmlns:xsl="http://www.w3.org/1999/XSL/Transform"
    xmlns:exist="http://exist.sourceforge.net/NS/exist"
    exclude-result-prefixes="tei exist" 
    version="1.0">
    
    <xsl:import href="http://diglib.hab.de/rules/styles/param.xsl"/>
    <xsl:import href="http://diglib.hab.de/rules/styles/tei-phraselevel.xsl"/>
    <xsl:output encoding="UTF-8" indent="yes" method="html" doctype-public="'-//W3C//DTD HTML 4.01//EN' 'http://www.w3.org/TR/html4/strict.dtd'"/>
    
    <xsl:strip-space elements="*"/> 
       
    
    <xsl:param name="ref"/>
    <xsl:param name="footerXML"/>
    <xsl:param name="footerXSL"/>


        <xsl:template match="/">
            <html>
                <head>
                    <meta http-equiv="Content-Type" content="text/html; charset=utf-8" />
                    <title>Bibliographie</title>
                    <!-- <link rel="stylesheet" type="text/css" href="rubens.css" />-->
                    <link rel="stylesheet" type="text/css" href="http://diglib.hab.de/navigator2.css"/>
                    <script src="http://diglib.hab.de/navigator.js" type="text/javascript"><noscript>please activate javascript to enable wdb functions</noscript></script>
                </head>
                <body>
                    <!--  Dokumentkopf -->
                    <div id="doc_header">
                        <div style="margin-bottom:0.2em;padding:0;letter-spacing:0.3em;">Bibliographie</div>
                        <hr style="margin:0;padding:0;height:1px;"/>
                        <!-- herauskommentiert PA, 2013-07-01
                        <xsl:choose>  
                            <xsl:when test="document($metsfile)//mets:rightsMD[@ID=document($metsfile)//mets:div[@TYPE='transcripton']/@ADMID]/mets:mdRef/@xlink:href">
                                <a>
                                    <xsl:attribute name="href">
                                        <xsl:value-of select="document($metsfile)//mets:rightsMD[@ID=document($metsfile)//mets:div[@TYPE='transcripton']/@ADMID]/mets:mdRef/@xlink:href"/>
                                    </xsl:attribute>
                                  
                                </a>
                            </xsl:when>
                            <xsl:otherwise>
                                <xsl:value-of select="document($metsfile)//mets:rightsMD[@ID=document($metsfile)//mets:div[@TYPE='transcripton']/@ADMID]/mets:mdWrap/mets:xmlData"/>
                            </xsl:otherwise>
                        </xsl:choose>
                        -->
                    </div>
                  
                    <xsl:choose>
                        <xsl:when test="$ref =''"><xsl:apply-templates select="//tei:div[@type='bibliography']/tei:listBibl"/></xsl:when>
                        <xsl:otherwise>
                            <xsl:apply-templates mode="single" select="//tei:bibl[@xml:id=$ref]"/>
                        </xsl:otherwise>
                    </xsl:choose>
                    <br/>
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
    
    <xsl:template match="tei:listBibl">
        <ul style="list-style:none; margin-left:0; padding:0;">
            <xsl:apply-templates/>

        </ul>
    </xsl:template>
    
    <xsl:template match="tei:bibl">
        <li style="margin-top:0.5em;margin-left:1em;text-indent:-1em;">
            <a>
                <xsl:attribute name="name">
                    <xsl:value-of select="@xml:id"/>
                </xsl:attribute>
                <xsl:text> </xsl:text>
            </a>   
            <xsl:apply-templates/>
           
        </li>
    </xsl:template>
    
    <xsl:template match="tei:bibl" mode="single">
        <div style="position:relative;left:5%;">
            <xsl:apply-templates/>
        </div>
    </xsl:template>
    
    <xsl:template match="tei:head">
        <h2>
            <xsl:apply-templates/>
        </h2>
    </xsl:template>
    
    <!-- ANK: Ergänzung externe Links -->
    <!--<xsl:template match="tei:ref[@target]">
        <span title="Referenz">
            <xsl:text> [</xsl:text>
            <a>
                <xsl:attribute name="href">
                    <xsl:value-of select="@target"/>
                </xsl:attribute>
                <xsl:attribute name="target">_blank</xsl:attribute>
                <xsl:text>↗</xsl:text>
            </a>
            <xsl:text>]</xsl:text>
        </span>
    </xsl:template>-->
    <!-- ANK: Ende Ergänzung -->
    
    <xsl:template match="tei:ptr">
        <!--<xsl:value-of select="translate($bibl_ref,'abcdefghijklmnopqrstuvwxyz','ABCDEFGHIJKLMNOPQRSTUVWXYZ')"/>-->
        <xsl:choose>
            <xsl:when test="@cRef">
                <!-- Liste moeglicher cRefs in param.xsl -->
                <xsl:call-template name="referencesPTR">
                    <xsl:with-param name="refType">
                        <xsl:value-of select="@type"/>
                    </xsl:with-param>
                    <xsl:with-param name="refValue">
                        <xsl:value-of select="@cRef"/>
                    </xsl:with-param>
                </xsl:call-template>
            </xsl:when>
            <xsl:otherwise/>
        </xsl:choose>
    </xsl:template>
    
    <xsl:template match="tei:ref">
       <xsl:text>[</xsl:text> 
        <a>
            <xsl:attribute name="href">
                <xsl:value-of select="@target"/>
            </xsl:attribute>
            <xsl:attribute name="target">_blank</xsl:attribute>
            <xsl:apply-templates/>
        </a>
        <xsl:text>]</xsl:text>
    </xsl:template>
    
    <!-- Autor in Kapitälchen, PA 2013-07-01 -->
    <xsl:template match="tei:author">
        <span style="font-variant:small-caps; font-size:large">
            <xsl:apply-templates/>,
        </span>
    </xsl:template>
    
    <xsl:template match="tei:title">
        <i>
            <xsl:apply-templates/>,
        </i>
    </xsl:template>
    <!--
    <xsl:template match="tei:pubPlace">
        <xsl:apply-templates/>
    </xsl:template>
     -->
    <xsl:template match="tei:date">
        <xsl:apply-templates/>.
    </xsl:template>
   
</xsl:stylesheet>
