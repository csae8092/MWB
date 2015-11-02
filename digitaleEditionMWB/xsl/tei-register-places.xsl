<?xml version="1.0" encoding="UTF-8"?>
<!-- Änderungen ANK: 2012-12-20 -->
<!-- Änderungen PA 2013-07-01
   generell 000145 ersetzt durch 000223
    
   
    <xsl:text>javascript:show_annotation_html('</xsl:text><xsl:value-of select="$dir"/><xsl:text>','</xsl:text><xsl:value-of select="$content"/><xsl:text>?dir=edoc/ed000223&amp;xml=ortsverzeichnis.xml&amp;xsl=show_place.xsl&amp;ref=</xsl:text><xsl:value-of select="../@xml:id"/><xsl:text>',300,500)</xsl:text>
    hier: "?dir=edoc/ed000223&amp;xml=personenverzeichnis.xml&amp;xsl=show_person.xsl&amp;ref=" ersetzt durch: "?dir=edoc/ed000223&amp;xml=tei-ortsverzeichnis.xml&amp;xsl=show-person.xsl"
    
    ändern:?? 
     <xsl:variable name="metsfile"><xsl:value-of select="concat('/',$dir,'/mets.xml')"/></xsl:variable>
-->
<xsl:stylesheet 
    xmlns="http://www.w3.org/1999/xhtml"
    xmlns:tei="http://www.tei-c.org/ns/1.0"
    xmlns:mets="http://www.loc.gov/METS/"
    xmlns:xlink="http://www.w3.org/1999/xlink"
    xmlns:xsl="http://www.w3.org/1999/XSL/Transform"
    xmlns:exist="http://exist.sourceforge.net/NS/exist"
    exclude-result-prefixes="tei" 
    version="1.0">
    
    <!-- Einbindung der Standard-Templates und Variablen -->
    <xsl:import href="http://diglib.hab.de/rules/styles/param.xsl"/>
    <xsl:import href="http://diglib.hab.de/rules/styles/tei-phraselevel.xsl"/>
        
    <xsl:output encoding="UTF-8" indent="yes" method="html" doctype-public="'-//W3C//DTD HTML 4.01//EN' 'http://www.w3.org/TR/html4/strict.dtd'"/>
    
    <xsl:strip-space elements="*"/> 
   
    <xsl:param name="dir"/>
    <xsl:param name="distype"/>
    <xsl:param name="pvID"/>
    <xsl:param name="footerXML"/>
    <xsl:param name="footerXSL"/>
    
    <xsl:variable name="metsfile"><xsl:value-of select="concat('/',$dir,'/mets.xml')"/></xsl:variable>
    
    <xsl:template match="/">
        
        <html>
            <head>
                <meta http-equiv="Content-Type" content="text/html; charset=utf-8" />
                <title>Ortsverzeichnis</title>
                <link rel="stylesheet" type="text/css" href="http://diglib.hab.de/navigator2.css"/>
                <script src="http://diglib.hab.de/navigator.js" type="text/javascript"><noscript>please activate javascript to enable wdb functions</noscript></script>
            </head>
            <body>
                <!--  Dokumentkopf -->
                <div id="doc_header">
                    <div style="margin-bottom:0.2em;padding:0;letter-spacing:0.3em;">Ortsverzeichnis</div>
                    <hr style="margin:0;padding:0;height:1px;"/>
            <!--        <xsl:choose>  
                        <xsl:when test="document($metsfile)//mets:rightsMD[@ID=document($metsfile)//mets:div[@TYPE='transcripton']/@ADMID]/mets:mdRef/@xlink:href">
                            <a>
                                <xsl:attribute name="href">
                                    <xsl:value-of select="document($metsfile)//mets:rightsMD[@ID=document($metsfile)//mets:div[@TYPE='transcripton']/@ADMID]/mets:mdRef/@xlink:href"/>
                                </xsl:attribute>
                                copyright
                            </a>
                        </xsl:when>
                        <xsl:otherwise>
                            <xsl:value-of select="document($metsfile)//mets:rightsMD[@ID=document($metsfile)//mets:div[@TYPE='transcripton']/@ADMID]/mets:mdWrap/mets:xmlData"/>
                        </xsl:otherwise>
                    </xsl:choose>
                    -->
                </div>
                
                <div class="content">
                    <xsl:apply-templates select="//tei:div[@type='index_places']/tei:listPlace"/>
                </div>
                <div style="clear:both;margin-top:1em;">
                <xsl:call-template name="footer">
                    <xsl:with-param name="footerXML">
                         <xsl:value-of select="$footerXML"/>
                    </xsl:with-param>
                    <xsl:with-param name="footerXSL">
                        <xsl:value-of select="$footerXSL"/>
                    </xsl:with-param>
                </xsl:call-template>
                </div> 
                </body>
        </html>
    </xsl:template>

<!-- Änderung ANK: Alternativnamen -->
    <xsl:template match="tei:listPlace">
        
        <xsl:variable name="liste">
            <xsl:value-of select="translate(tei:place/tei:placeName,'abcdefghijklmnopqrstuvwxyzABCDEFGHIJKLMNOPQRSTUVWXYZÉ','abcdefghijklmnopqrstuvwxyzABCDEFGHIJKLMNOPQRSTUVWXYZE')"/>
        </xsl:variable>
        
        <div class="content">
            <ul>
                <!--<xsl:apply-templates select="$liste"><xsl:sort lang="de"/></xsl:apply-templates>-->
                <xsl:apply-templates select="tei:place/tei:placeName"><xsl:sort lang="de"/></xsl:apply-templates>
            </ul>
        </div>  
    </xsl:template>
        
    <xsl:template match="tei:placeName">
        <li>
            <a>
                <xsl:attribute name="href">
                    <xsl:text>http://exist.hab.de/rest/db/apps/projekte/lessingsuebersetzungen/search/search-person.xql?dir=edoc/ed000223&amp;qtype=rs&amp;q=</xsl:text><xsl:value-of select="../@xml:ref"/>
                </xsl:attribute><xsl:apply-templates/></a>
            <xsl:text> </xsl:text>
            <a>
                <xsl:attribute name="href">
                    <xsl:text>javascript:show_annotation_html('</xsl:text><xsl:value-of select="$dir"/><xsl:text>','</xsl:text><xsl:value-of select="$content"/><xsl:text>?dir=edoc/ed000223&amp;xml=tei-ortsverzeichnis.xml&amp;xsl=show-place.xsl&amp;ref=</xsl:text><xsl:value-of select="../@xml:id"/><xsl:text>',300,500)</xsl:text>
                </xsl:attribute>
                <img height="16px" src="http://diglib.hab.de/images/info.png" alt="Info" border="0"/>
            </a>   
        </li>
    </xsl:template>
    
  
<!-- Ende Änderung -->    
    
    <!-- ANK: Anzeige der hochgestellten Angaben -->
    <xsl:template match="tei:hi[@rend='super']">
        <span style="vertical-align:super; font-size:0.8em;"><xsl:apply-templates/></span>
    </xsl:template>
    <!-- Ende Ergänzung -->
    
         
<!--    zunächst ausschalten-->
    <xsl:template match="tei:note"/>
    <xsl:template match="tei:ref"/>
    <xsl:template match="tei:ptr"/>
        
    
    
</xsl:stylesheet>
