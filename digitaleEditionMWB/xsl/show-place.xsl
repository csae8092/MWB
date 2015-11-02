<?xml version="1.0" encoding="UTF-8"?>
<!-- Änderungen ANK: 2013-04-29 -->
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
    <!-- Ã„nderung ANK: 2013-04-26 <xsl:strip-space elements="*"/>-->
    
    <xsl:param name="ref"/>
    
    <xsl:template match="/">
        <html>
            <head>
                <meta http-equiv="Content-Type" content="text/html; charset=utf-8" />
                <title>
                    Anmerkung Ort - <xsl:value-of select="//tei:place[@xml:id=$ref]/tei:placeName"/>
                </title>
                <link rel="stylesheet" type="text/css" href="http://diglib.hab.de/navigator.css"/>
                <style type="text/css">
                    td { 
                    vertical-align:top;
                    font-size: 12px;
                    color: #000;
                    text-align: left;
                    }
                </style>  
            </head>
            <body>
                <div class="maintext">
                    <div style="float:left;"><h2 style="margin:0; padding:0;">Anmerkung - Ort</h2></div>
                    <div style="text-align:right">
                        <form style="distype:inline;">
                            <xsl:attribute name="action">
                                <xsl:value-of select="$content"/>
                            </xsl:attribute>
                            <select name="ref" size="1" style="width:150px;font-size:9pt;" onchange="javascript:submit();">
                                <option>- Ortsnamensliste -</option>
                                <!-- ANK: Pfadberichtigung; xsl:sort abgeschaltet, wegen der Sonderzeichen -->
                                <xsl:for-each select="//tei:place/tei:placeName">
                                    <xsl:sort lang="de"/>
                                    <option>
                                        <!-- ANK: Pfad berichtigt -->
                                        <xsl:attribute name="value"><xsl:value-of select="../@xml:id"/></xsl:attribute>
                                        <!-- Ende Ã„nderung -->
                                        <xsl:value-of select="."/>
                                    </option>
                                </xsl:for-each>
                            </select>
                            <input type="hidden" name="dir" value="edoc/ed000223"/>
                            <input type="hidden" name="xml" value="tei-ortsverzeichnis.xml"/>
                            <input type="hidden" name="xsl" value="show-place.xsl"/>
                        </form>
                    </div>
                    <div style="clear:both;">
                        <hr style="margin-top:0em;margin-bottom:1em;height: 1px;"/>
                        <table border="0">
                            <tr>
                                <td>Ortsname:</td>
                                <!-- ANK: Einbindung der Alternativnamen -->
                                <td>
                                    <xsl:for-each select="//tei:place[@xml:id=$ref]/tei:placeName[1]">
                                        <xsl:value-of select="."/> 
                                    </xsl:for-each> 
                                </td>
                            </tr>
                            
                            <xsl:if test="//tei:place[@xml:id=$ref]/tei:placeName[2]">
                                <tr>
                                    <td>Varianten:</td>
                                    <td><xsl:value-of select="//tei:place[@xml:id=$ref]/tei:placeName[2]"/>
                                        <xsl:if test="//tei:place[@xml:id=$ref]/tei:placeName[3]">
                                            <xsl:text>, </xsl:text><xsl:value-of select="//tei:place[@xml:id=$ref]/tei:placeName[3]"/></xsl:if>
                                        <xsl:if test="//tei:place[@xml:id=$ref]/tei:placeName[4]">
                                            <xsl:text>, </xsl:text><xsl:value-of select="//tei:place[@xml:id=$ref]/tei:placeName[4]"/></xsl:if>
                                        <xsl:if test="placeName[5]">
                                            <xsl:text>, </xsl:text><xsl:value-of select="placeName[5]"/></xsl:if>
                                    </td>
                                </tr>
                            </xsl:if>
                            <!-- Ende Ã„nderung ANK -->
                            
                            <xsl:if test="//tei:place[@xml:id=$ref]/tei:placeName/@type='geonames'">
                                <tr>
                                    <td>GeoNames-ID:</td>
                                    <td>
                                        <a>
                                            <xsl:attribute name="target">_blank</xsl:attribute>
                                            <xsl:attribute name="href">http://www.geonames.org/<xsl:value-of select="//tei:place[@xml:id=$ref]/tei:placeName/@key"/></xsl:attribute>
                                            <xsl:value-of select="//tei:place[@xml:id=$ref]/tei:placeName/@key"/>
                                        </a>
                                    </td>
                                </tr>
                            </xsl:if>
                            
                            <xsl:if test="//tei:place[@xml:id=$ref]/tei:placeName/@type='gnd'">
                                <tr>
                                    <td>GND:</td>
                                    <td><a>
                                        <xsl:attribute name="target">_blank</xsl:attribute>
                                        <xsl:attribute name="href">http://d-nb.info/gnd/<xsl:value-of select="//tei:place[@xml:id=$ref]/tei:placeName/@key"/><xsl:text>/about/html</xsl:text></xsl:attribute>
                                        <xsl:value-of select="//tei:place[@xml:id=$ref]/tei:placeName/@key"/>
                                    </a>
                                    </td>
                                </tr>
                            </xsl:if>
                            
                            <xsl:if test="//tei:place[@xml:id=$ref]/tei:placeName/@type='tgn'">
                                <tr>
                                    <td>Getty:</td>
                                    <td><a>
                                        <xsl:attribute name="target">_blank</xsl:attribute>
                                        <xsl:attribute name="href">http://www.getty.edu/vow/TGNServlet?english=Y&amp;find=<xsl:value-of select="//tei:place[@xml:id=$ref]/tei:placeName/@key"/>&amp;place=&amp;page=1&amp;nation=</xsl:attribute><xsl:value-of select="//tei:place[@xml:id=$ref]/tei:placeName/tei:ref/@cRef"/></a></td>
                                </tr>
                            </xsl:if>
                            
                            <xsl:if test="//tei:place[@xml:id=$ref]/tei:placeName/tei:ref/@type='tgn'">
                                <tr>
                                    <td>Getty:</td>
                                    <td><a>
                                        <xsl:attribute name="target">_blank</xsl:attribute>
                                        <xsl:attribute name="href">http://www.getty.edu/vow/TGNServlet?english=Y&amp;find=<xsl:value-of select="//tei:place[@xml:id=$ref]/tei:placeName/tei:ref/@cRef"/>&amp;place=&amp;page=1&amp;nation=</xsl:attribute><xsl:value-of select="//tei:place[@xml:id=$ref]/tei:placeName/tei:ref/@cRef"/></a></td>
                                </tr>
                            </xsl:if>
                            
                            <!-- ANK: Ã„nderung 2013-04-26 -->
                            <xsl:if test="//tei:place[@xml:id=$ref]/tei:placeName/tei:ptr">
                                <tr>
                                    <td>Wikipedia:</td>
                                    <td><xsl:text>[</xsl:text><a>
                                        <xsl:attribute name="target">_blank</xsl:attribute>
                                        <xsl:attribute name="href"><xsl:value-of select="//tei:place[@xml:id=$ref]/tei:placeName/tei:ptr/@target"/></xsl:attribute>â†—</a><xsl:text>]</xsl:text></td>
                                </tr>
                            </xsl:if>
                            <!-- Ende Ã„nderung -->
                            
                            <xsl:if test="//tei:place[@xml:id=$ref]/tei:note">
                                <tr>
                                    <td>Anmerkung:</td>
                                    <td>
                                        <xsl:apply-templates select="//tei:place[@xml:id=$ref]/tei:note"/>
                                    </td>
                                </tr>
                            </xsl:if>
                            
                            <tr>
                                <td><xsl:text> </xsl:text></td>
                                <td >
                                    
                                    <!-- <a target="_blank">
                                        <xsl:attribute name="title">Fundstellen im Text suchen</xsl:attribute>
                                        <xsl:attribute name="href"><xsl:value-of select="$wdb"/><xsl:text>?dir=edoc/ed000223&amp;distype=results-transcript&amp;qurl=rubens/searchref.xql&amp;q=</xsl:text><xsl:value-of select="//tei:place[@xml:id=$ref]/@xml:id"/></xsl:attribute>
                                        <xsl:text>Fundstellen im Text</xsl:text>
                                    </a>-->
                                </td>
                            </tr>
                        </table>     
                    </div>
                </div>
            </body>
        </html>
    </xsl:template>
    <xsl:template match="tei:ptr">
        <a>
            <xsl:attribute name="href">
                <xsl:value-of select="@target"/>
            </xsl:attribute>
            <xsl:attribute name="target">
                <xsl:text>_blank</xsl:text>
            </xsl:attribute>
            <xsl:text>[wikipedia]</xsl:text>
        </a>
    </xsl:template>
    
    <!-- ANK: Anzeige der hochgestellten Angaben -->
    <xsl:template match="tei:hi[@rend='super']">
        <span style="vertical-align:super; font-size:0.8em;"><xsl:apply-templates/></span>
    </xsl:template>
    <!-- Ende ErgÃ¤nzung -->
    
    <xsl:template match="tei:note">
        <xsl:apply-templates/>
    </xsl:template>
    
    <xsl:template match="tei:rs">
        <a>
            <xsl:attribute name="href">
                <xsl:choose>
                    <xsl:when test="@type='place'">
                        <xsl:value-of select="$content"/><xsl:text>?dir=edoc/ed000223&amp;xml=tei-ortsverzeichnis.xml&amp;xsl=show-place.xsl&amp;ref=</xsl:text><xsl:value-of select="substring(@ref,2)"/>
                    </xsl:when>
                    <xsl:when test="@type='person'">
                        <xsl:value-of select="$content"/><xsl:text>?dir=edoc/ed000223&amp;xml=tei-personenverzeichnis.xml&amp;xsl=show-person.xsl&amp;ref=</xsl:text><xsl:value-of select="substring(@ref,2)"/>
                    </xsl:when>
                </xsl:choose>
                <!-- Ende Ã„nderung --> 
            </xsl:attribute>
            <xsl:value-of select="."/>
        </a>
    </xsl:template>
    
    <xsl:template match="tei:ref">
        <xsl:if test="@target"><xsl:text>[</xsl:text></xsl:if>
        <!-- Ã„nderung ANK: 2013-04-26 -->
        <a target="_blank">
            <!-- Ende Ã„nderung -->
            <xsl:choose>
                <xsl:when test="@type">
                    <xsl:attribute name="href">
                        <xsl:call-template name="referencesREF">
                            <xsl:with-param name="refType"><xsl:value-of select="@type"/></xsl:with-param>
                            <xsl:with-param name="cRefValue"><xsl:value-of select="@cRef"/></xsl:with-param>
                            <xsl:with-param name="refXML"/>
                            <xsl:with-param name="refXSL"/>
                            <xsl:with-param name="refID"/>
                        </xsl:call-template>
                    </xsl:attribute>
                </xsl:when>
                <xsl:otherwise>
                    <xsl:attribute name="href"><xsl:value-of select="@target"/></xsl:attribute>
                    <xsl:attribute name="target">_blank</xsl:attribute>
                    <xsl:text>â†—</xsl:text>
                </xsl:otherwise>
            </xsl:choose>
            <xsl:apply-templates/>
        </a>
        <xsl:if test="@target"><xsl:text>]</xsl:text></xsl:if>
    </xsl:template>
    
    <!-- ANK: Beginn ErgÃ¤nzungen -->
    
    <!-- Buchtitel kursiv -->
    <xsl:template match="tei:bibl/tei:title">
        <i><xsl:apply-templates/></i>
    </xsl:template>
    
    <!-- <term>-Element kursiv -->
    <xsl:template match="tei:term">
        <i><xsl:apply-templates/></i>
    </xsl:template>
    
    <!-- ANK: Ende ErgÃ¤nzungen -->
    
</xsl:stylesheet>