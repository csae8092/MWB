<?xml version="1.0" encoding="UTF-8"?>
<!-- Letzte Ã„nderung Norbert Ankenbauer (ANK) 2013-04-29 -->

    <xsl:stylesheet 
        xmlns="http://www.w3.org/1999/xhtml"
        xmlns:tei="http://www.tei-c.org/ns/1.0"
        xmlns:mets="http://www.loc.gov/METS/"
        xmlns:xlink="http://www.w3.org/1999/xlink"
        xmlns:xsl="http://www.w3.org/1999/XSL/Transform"
        exclude-result-prefixes="tei" 
        version="1.0">
       
        <!-- Einbindung der Standard-Templates und Variablen -->
        <xsl:import href="http://diglib.hab.de/rules/styles/param.xsl"/>
        <xsl:import href="http://diglib.hab.de/rules/styles/tei-phraselevel.xsl"/>
        
        <xsl:output encoding="UTF-8" indent="yes" method="html" doctype-public="'-//W3C//DTD HTML 4.01//EN' 'http://www.w3.org/TR/html4/strict.dtd'"/>
        <!-- <xsl:strip-space elements="*"/> --> 
        
        <xsl:param name="ref"/>
        <xsl:param name="footerXML"/>
        <xsl:param name="footerXSL"/>
        
        <xsl:template match="/">
            <html>
                <head>
                    <meta http-equiv="Content-Type" content="text/html; charset=utf-8" /> 
                    <title>
                        Anmerkung Person - <xsl:value-of select="//tei:person[@xml:id=$ref]/tei:persName/tei:forename"/><xsl:text> </xsl:text> <xsl:value-of select="//tei:person[@xml:id=$ref]/tei:persName/tei:surname"/>
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
                        <div style="float:left;"><h2 style="margin:0; padding:0;">Anmerkung - Person</h2></div>
                        <div style="text-align:right">
                            <form style="distype:inline;">
                                <xsl:attribute name="action">
                                    <xsl:value-of select="$content"/>
                                </xsl:attribute>
                                <select name="ref" size="1" style="width:150px;font-size:9pt;" onchange="javascript:submit();">
                                 <option>- Namensliste -</option>
                                    <xsl:for-each select="//tei:persName">
                                     
                                        <xsl:sort select="tei:surname"/>
                                     <xsl:sort select="tei:name"/>
                                     <xsl:sort select="tei:forename"/>
                                 <option>
                                      <xsl:attribute name="value"><xsl:value-of select=" parent::tei:person/@xml:id"/></xsl:attribute>
                                        <xsl:choose>
                                            <xsl:when test="tei:surname">
                                                <xsl:value-of select="tei:surname"/><xsl:text>, </xsl:text>
                                            </xsl:when>
                                            <xsl:when test="tei:name">
                                                <xsl:value-of select="tei:name"/><xsl:text>, </xsl:text>
                                            </xsl:when>
                                            <xsl:otherwise/>
                                        </xsl:choose>
                                        <xsl:value-of select="tei:forename"/>
                                     <xsl:if test="tei:roleName">
                                         <!-- Ã„nderung ANK 2012-06.13: Anpassung an das GND-Format -->
                                         <xsl:text> &lt;</xsl:text>
                                         <xsl:if test="tei:genName">
                                         <xsl:value-of select="tei:genName"/><xsl:text>, </xsl:text>
                                         </xsl:if>
                                         <xsl:value-of select="tei:roleName"/><xsl:text>&gt;</xsl:text>
                                     <!-- Ende Ã„nderung -->
                                     </xsl:if>
                                 </option>
                                 </xsl:for-each>
                                </select>
                                <input type="hidden" name="dir" value="edoc/ed000223"/>
                                <input type="hidden" name="xml" value="tei-personenverzeichnis.xml"/>
                                <input type="hidden" name="xsl" value="show-person.xsl"/>
                              </form>
                        </div>
                        <div style="clear:both;">
                        <hr style="margin-top:0em;margin-bottom:1em;height: 1px;"/>
                        <table>
                            <xsl:if test="//tei:person[@xml:id=$ref]/tei:persName/tei:name">
                                <tr>
                                    <td>Name:</td>
                                    <td>
                                        <xsl:for-each select="//tei:person[@xml:id=$ref]/tei:persName/tei:name">
                                            <xsl:value-of select="."/><xsl:text> </xsl:text>
                                        </xsl:for-each> 
                                    </td>
                                </tr>
                            </xsl:if> 
                            <xsl:if test="//tei:person[@xml:id=$ref]/tei:persName/tei:surname">
                            <tr>
                                <td>Nachname:</td>
                                <td>
                                    <xsl:for-each select="//tei:person[@xml:id=$ref]/tei:persName/tei:surname">
                                        <xsl:value-of select="."/><xsl:text> </xsl:text>
                                    </xsl:for-each> 
                                </td>
                            </tr>
                             </xsl:if>   
                            <xsl:if test="//tei:person[@xml:id=$ref]/tei:persName/tei:forename">
                            <tr>
                                <td>Vorname:</td>
                                <td>
                                    <xsl:value-of select="//tei:person[@xml:id=$ref]/tei:persName/tei:forename"/><xsl:text> </xsl:text><xsl:value-of select="//tei:person[@xml:id=$ref]/tei:persName/tei:nameLink"/>
                                    <!-- ANK Ã„nderung 2012-06-13: Herrscherzahl nach dem Vornamen -->
                                    <xsl:value-of select="//tei:person[@xml:id=$ref]/tei:persName//tei:genName"/>
                                <!-- Ende Ã„nderung Ank -->
                                </td>
                            </tr>
                            </xsl:if>
                            <xsl:if test="//tei:person[@xml:id=$ref]/tei:persName/tei:addName">
                                <tr>
                                    <td>Namenszusatz:</td>
                                    <td>
                                        <xsl:value-of select="//tei:person[@xml:id=$ref]/tei:persName/tei:addName"/><xsl:text> </xsl:text><xsl:value-of select="//tei:person[@xml:id=$ref]/tei:persName/tei:nameLink"/>
                                    </td>
                                </tr>
                            </xsl:if>
                            <xsl:if test="//tei:person[@xml:id=$ref]/tei:persName/tei:roleName">
                            <tr>
                                <td>Amt/Funktion:</td>
                                <td>
                                    <xsl:for-each select="//tei:person[@xml:id=$ref]/tei:persName/tei:roleName">
                                        <xsl:if test="position() > 1">
                                            <xsl:text>, </xsl:text>
                                        </xsl:if>
                                       <xsl:apply-templates/>
                                    </xsl:for-each> 
                                </td>
                            </tr>
                            </xsl:if>
              
              <!-- ANK: GND-Nummer, falls kein gesonderter Link zu Wikipedia als <ptr/> eingefügt ist, wird mit der GND-Nummer ein Link zu Wikipedia erzeugt -->
                                <xsl:if test="//tei:person[@xml:id=$ref]/tei:persName/@key">
                                    <tr>
                                        <td>GND-Nummer:</td>
                                        <td>
                                            <!-- auskommentiert PA, 20131101
                                                <a>
                                                <xsl:attribute name="href">
                                                    <xsl:value-of select="$gnd"/><xsl:value-of select="substring-after(//tei:person[@xml:id=$ref]/tei:persName/@key,'_')"/></xsl:attribute>
                                                <xsl:attribute name="target">_blank</xsl:attribute>
                                                <xsl:value-of select="substring-after(//tei:person[@xml:id=$ref]/tei:persName/@key,'_')"/>
                                            </a>
                                            und  ersetzt mit:  -->
                                            
                                            <a>
                                                <xsl:attribute name="href">
                                                    <xsl:value-of select="$gnd"/><xsl:value-of select="//tei:person[@xml:id=$ref]/tei:persName/@key"/>
                                                </xsl:attribute>
                                                <xsl:attribute name="target">_blank</xsl:attribute>
                                                <xsl:value-of select="//tei:person[@xml:id=$ref]/tei:persName/@key"/>
                                            </a>
                                        </td>
                                    </tr>
                                </xsl:if>
                                <xsl:if test="//tei:person[@xml:id=$ref]/tei:note/tei:ptr/@target">
                                <tr>
                                    <td>Wikipedia:</td>
                                 <td>
                                     <a>
                                         <xsl:attribute name="href">
                                    <xsl:value-of select="//tei:person[@xml:id=$ref]/tei:note/tei:ptr/@target"/>
                                         </xsl:attribute>
                                         <xsl:attribute name="target">_blank</xsl:attribute>
                                         <xsl:text>[link]</xsl:text>
                                     </a>
                                </td>
                                </tr>
                                </xsl:if>
                            <!--   auskommentiert PA, 20131101
                                    <xsl:choose>
                                        <xsl:when test="//tei:person[@xml:id=$ref]/tei:persName/tei:ptr"/>
                                        <xsl:otherwise>
                                            <tr>
                                                <td>Wikipedia:</td>
                                                <td>
                                                    <xsl:text>[</xsl:text>    
                                                    <a target="_blank"><xsl:attribute name="title">Mit GND Nummer in der Wikipedia suchen</xsl:attribute>
                                                        <xsl:attribute name="href"><xsl:value-of select="$gnd2wikipedia"/>
                                                            <xsl:value-of select="substring-after(//tei:person[@xml:id=$ref]/tei:persName/@key,'_')"/>
                                                        </xsl:attribute><xsl:text>â†—</xsl:text>
                                                    </a><xsl:text>]</xsl:text>
                                                </td>
                                            </tr>
                                        </xsl:otherwise>
                                    </xsl:choose>-->
                              
                                                           
                                
                                <!-- Einbindung Wikipedia-Link -->
                                <xsl:if test="//tei:person[@xml:id=$ref]/tei:persName/tei:ptr">
                                    <tr>
                                        <td>Wikipedia:</td>
                                        <td>
                                            <xsl:text>[</xsl:text>
                                            <a target="_blank">
                                                <xsl:attribute name="href"><xsl:value-of select="//tei:person[@xml:id=$ref]/tei:persName/tei:ptr/@target"/></xsl:attribute>
                                                <xsl:text>â†—</xsl:text>
                                            </a><xsl:text>]</xsl:text>
                                        </td>
                                    </tr>
                                </xsl:if>
                               
                            <!-- Einbindung DBdI-Link -->
                            <xsl:if test="//tei:person[@xml:id=$ref]/tei:persName/tei:ref">
                                <tr>
                                    <td>DBdI:</td>
                                    <td>
                                        <xsl:text>[</xsl:text>
                                        <a target="_blank">
                                            <xsl:attribute name="href"><xsl:value-of select="//tei:person[@xml:id=$ref]/tei:persName/tei:ref/@target"/></xsl:attribute>
                                            <xsl:text>â†—</xsl:text>
                                        </a><xsl:text>]</xsl:text>
                                    </td>
                                </tr>
                            </xsl:if>
                               
                        <!-- Geburtsdatum und -ort -->                
                            <xsl:if test="//tei:person[@xml:id=$ref]/tei:birth">
                                 <tr>
                                <td>Geboren:</td>
                                <td>
                                    <xsl:value-of select="//tei:person[@xml:id=$ref]/tei:birth/text()"/>
                                    <xsl:if test="//tei:person[@xml:id=$ref]/tei:birth/tei:placeName">
                                         <xsl:text> (</xsl:text>
                                        <!-- ANK: Verlinkung zum MWBOrtsverzeichnis -->
                                            <a><xsl:attribute name="href">
                                                <xsl:value-of select="$content"/><xsl:text>?dir=edoc/ed000223&amp;xml=tei-ortsverzeichnis.xml&amp;xsl=show-place.xsl&amp;ref=</xsl:text>
                                                <xsl:value-of select="substring(//tei:person[@xml:id=$ref]/tei:birth/tei:placeName/tei:settlement/tei:rs/@ref,2)"/>
                                            </xsl:attribute>
                                                <xsl:value-of select="//tei:person[@xml:id=$ref]/tei:birth/tei:placeName/tei:settlement"/></a>
                                        <xsl:if test="//tei:person[@xml:id=$ref]/tei:birth/tei:placeName/tei:settlement"><xsl:text>, </xsl:text></xsl:if>
                                            <a><xsl:attribute name="href">
                                                <xsl:value-of select="$content"/><xsl:text>?dir=edoc/ed000223&amp;xml=tei-ortsverzeichnis.xml&amp;xsl=show-place.xsl&amp;ref=</xsl:text>
                                                <xsl:value-of select="substring(//tei:person[@xml:id=$ref]/tei:birth/tei:placeName/tei:country/tei:rs/@ref,2)"/>
                                            </xsl:attribute>
                                                <xsl:value-of select="//tei:person[@xml:id=$ref]/tei:birth/tei:placeName/tei:country"/></a>
                                       <!-- Ende Ã„nderung -->
                                            <xsl:text>)</xsl:text>
                                    </xsl:if>
                                </td>
                            </tr>
                        </xsl:if>
                
                            <!-- Sterbedatum und -ort -->       
                            <xsl:if test="//tei:person[@xml:id=$ref]/tei:death">
                                <tr>
                                    <td>Gestorben:</td>
                                    <td>
                                        <xsl:value-of select="//tei:person[@xml:id=$ref]/tei:death/text()"/>
                                        <!-- ANK: Berichtigung 'birth' durch 'death' ersetzt; Verlinkung zum MWBOrtsverzeichnis -->
                                        <xsl:if test="//tei:person[@xml:id=$ref]/tei:death/tei:placeName">
                                            <xsl:text> (</xsl:text>
                                            <a><xsl:attribute name="href">
                                                <xsl:value-of select="$content"/><xsl:text>?dir=edoc/ed000223&amp;xml=tei-ortsverzeichnis.xml&amp;xsl=show-place.xsl&amp;ref=</xsl:text>
                                                <xsl:value-of select="substring(//tei:person[@xml:id=$ref]/tei:death/tei:placeName/tei:settlement/tei:rs/@ref,2)"/>
                                            </xsl:attribute>
                                                <xsl:value-of select="//tei:person[@xml:id=$ref]/tei:death/tei:placeName/tei:settlement"/></a>
                                            <xsl:if test="//tei:person[@xml:id=$ref]/tei:death/tei:placeName/tei:settlement"><xsl:text>, </xsl:text></xsl:if>
                                              <a><xsl:attribute name="href">
                                                <xsl:value-of select="$content"/><xsl:text>?dir=edoc/ed000223&amp;xml=tei-ortsverzeichnis.xml&amp;xsl=show-place.xsl&amp;ref=</xsl:text>
                                                <xsl:value-of select="substring(//tei:person[@xml:id=$ref]/tei:death/tei:placeName/tei:country/tei:rs/@ref,2)"/>
                                            </xsl:attribute>
                                                <xsl:value-of select="//tei:person[@xml:id=$ref]/tei:death/tei:placeName/tei:country"/></a>
                                            <xsl:text>)</xsl:text>
                                        </xsl:if>
                                        <!-- Ende Berichtigung -->
                                    </td>
                                </tr>
                            </xsl:if>
                         
                
                            <!-- Anmerkungen  -->        
                            <xsl:if test="//tei:person[@xml:id=$ref]/tei:note">
                                <tr>
                                    <td>Anmerkung:</td>
                                    <td>
                                        <xsl:apply-templates select="//tei:person[@xml:id=$ref]/tei:note"/>
                                    </td>
                                </tr>
                            </xsl:if>
                            <tr>
                                <td><xsl:text> </xsl:text></td>
                                <td >
                                    
                                   <!-- <a target="_blank">
                                        <xsl:attribute name="title">Fundstellen im Text suchen</xsl:attribute>
                                        <xsl:attribute name="href"><xsl:value-of select="$wdb"/><xsl:text>?dir=edoc/ed000083&amp;distype=results-transcript&amp;qurl=rubens/searchref.xql&amp;q=</xsl:text><xsl:value-of select="//tei:person[@xml:id=$ref]/@xml:id"/></xsl:attribute>
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
                    <!-- ANK: Bezug alternativ auf MWBOrtsverzeichnis oder MWBPersonenverzeichnis; Berichtigung auf ed000223 -->
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
            <a target="_blank">
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
        
       <xsl:template match="tei:term">
            <i><xsl:apply-templates/></i>
        </xsl:template>
        
        <!-- Ende ErgÃ¤nzungen -->
        
</xsl:stylesheet>