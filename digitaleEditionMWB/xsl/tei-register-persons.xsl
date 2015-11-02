<?xml version="1.0" encoding="UTF-8"?>
<!-- Änderungen ANK 2012-11-06 -->
<!-- Änderungen PA 2013-07-01
   generell 000145 ersetzt durch 000223
    
   
    <xsl:text>javascript:show_annotation_html('</xsl:text><xsl:value-of select="$dir"/><xsl:text>','</xsl:text><xsl:value-of select="$content"/><xsl:text>?dir=edoc/ed000223&amp;xml=personenverzeichnis.xml&amp;xsl=show_person.xsl&amp;ref=</xsl:text><xsl:value-of select="../@xml:id"/><xsl:text>',300,500)</xsl:text>
    hier: "?dir=edoc/ed000223&amp;xml=personenverzeichnis.xml&amp;xsl=show_person.xsl&amp;ref=" ersetzt durch: "?dir=edoc/ed000223&amp;xml=tei-personenverzeichnis.xml&amp;xsl=show-person.xsl"
    
    ändern:?? 
     <xsl:variable name="metsfile"><xsl:value-of select="concat('/',$dir,'/mets.xml')"/></xsl:variable>
-->
    
<xsl:stylesheet xmlns="http://www.w3.org/1999/xhtml"
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
                <title>Personenverzeichnis</title>
                <link rel="stylesheet" type="text/css" href="http://diglib.hab.de/navigator2.css"/>
                <script src="http://diglib.hab.de/navigator.js" type="text/javascript"><noscript>please activate javascript to enable wdb functions</noscript></script>
            </head>
            <body>
                <!--  Dokumentkopf -->
                <div id="doc_header">
                    <div style="margin-bottom:0.2em;padding:0;letter-spacing:0.3em;">Personenverzeichnis</div>
                    <hr style="margin:0;padding:0;height:1px;"/>
               <!--    herauskommentiert PA <xsl:choose>  
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
                    <xsl:apply-templates select="//tei:div[@type='index_persons']"/>
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
    
    <xsl:template match="tei:listPerson">
        <div class="content">
            <ol>
                    <xsl:apply-templates select="tei:person">
                        <xsl:sort select="tei:persName/tei:surname"/>
                        <xsl:sort select="tei:persName/tei:forename"/>
                    </xsl:apply-templates>
            </ol>
       </div>  
     </xsl:template>
    
    <xsl:template match="tei:person">
        <li>
            <a>
            <xsl:attribute name="href">
                <xsl:text>http://exist.hab.de/rest/db/apps/projekte/lessingsuebersetzungen/search/search-person.xql?dir=edoc/ed000223&amp;qtype=rs&amp;q=</xsl:text><xsl:value-of select="@xml:id"/>
              </xsl:attribute>
                <xsl:apply-templates/>
            </a>
        </li>
     </xsl:template>
    
    <xsl:template match="tei:persName">
        <xsl:choose>
            <xsl:when test="tei:surname or tei:forename">
                <xsl:apply-templates select="tei:surname"/>
                <xsl:apply-templates select="tei:forename"/>
                <xsl:apply-templates select="tei:nameLink"/>
                <xsl:if test="tei:genName or tei:roleName">
                    <!-- ANK: Änderung der Reihenfolge gemäß GND-Format -->
                    <xsl:text> &lt;</xsl:text>
                    <xsl:apply-templates select="tei:genName"/>
                    <xsl:apply-templates select="tei:roleName"/>
                    <xsl:text>&gt;</xsl:text>
                    <!-- Ende Änderung -->
                </xsl:if>
             </xsl:when>
            <xsl:otherwise>
                <xsl:apply-templates/>
            </xsl:otherwise>
        </xsl:choose>
        
        <xsl:text> </xsl:text>
            <a>
                <xsl:attribute name="href">
                    <xsl:text>javascript:show_annotation_html('</xsl:text><xsl:value-of select="$dir"/><xsl:text>','</xsl:text><xsl:value-of select="$content"/><xsl:text>?dir=edoc/ed000223&amp;xml=tei-personenverzeichnis.xml&amp;xsl=show-person.xsl&amp;ref=</xsl:text><xsl:value-of select="../@xml:id"/><xsl:text>',300,500)</xsl:text>
                 </xsl:attribute>
                <img height="16px" src="{$server}images/info.png" alt="Info" border="0"/>
            </a>   
      </xsl:template>
    
    <xsl:template match="tei:surname">
        <xsl:apply-templates/>
     </xsl:template>
    
    <xsl:template match="tei:nameLink">
        <xsl:text> </xsl:text><xsl:apply-templates/>
    </xsl:template>
    
    <xsl:template match="tei:forename">
        <xsl:if test="../tei:surname"><xsl:text>, </xsl:text></xsl:if>
        <xsl:apply-templates/>
    </xsl:template>
    
    <xsl:template match="tei:roleName">
        <xsl:apply-templates/>
    </xsl:template>
    
    <!-- ANK: Änderung gemäß GND-Format -->
    <xsl:template match="tei:genName">
        <xsl:apply-templates/>
        <xsl:if test="not(contains(.,'.'))"><xsl:text>.</xsl:text></xsl:if>
        <xsl:if test="../tei:roleName"><xsl:text>, </xsl:text></xsl:if>
    </xsl:template>
      <!-- Ende Änderung -->
   
    <xsl:template match="tei:birth"><xsl:text/></xsl:template>
    
    <xsl:template match="tei:death"><xsl:text/></xsl:template>
       


<!--    zunächst ausschalten-->
    <xsl:template match="tei:note"/>
    <xsl:template match="tei:ref"/>
    <xsl:template match="tei:ptr"/>
        
    
    
</xsl:stylesheet>
