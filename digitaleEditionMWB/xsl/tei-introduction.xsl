<?xml version="1.0" encoding="UTF-8"?>
<!-- ANK: 2013-02-03; adaptiert PA -->
<xsl:stylesheet 
    xmlns="http://www.w3.org/1999/xhtml"
    xmlns:tei="http://www.tei-c.org/ns/1.0"
    xmlns:mets="http://www.loc.gov/METS/"
    xmlns:xlink="http://www.w3.org/1999/xlink"
    xmlns:xsl="http://www.w3.org/1999/XSL/Transform"
    xmlns:exist="http://exist.sourceforge.net/NS/exist"
    exclude-result-prefixes="#default tei" 
    version="1.0">
  
    <!-- Einbindung der Standard-Templates und Variablen -->
    <xsl:import href="http://diglib.hab.de/rules/styles/param.xsl"/>
    <xsl:import href="http://diglib.hab.de/rules/styles/tei-phraselevel.xsl"/>
    

    <xsl:output encoding="UTF-8" indent="yes" method="html" doctype-public="'-//W3C//DTD HTML 4.01//EN' 'http://www.w3.org/TR/html4/strict.dtd'"/>
    
   
    <xsl:param name="dir"/>
    <xsl:param name="distype"/>
    <xsl:param name="pvID"/>
    <xsl:param name="lokal"/>
    <!--<xsl:variable name="pvID">pv_transcript-facs1602</xsl:variable>-->
    <xsl:param name="footerXML"/>
    <xsl:param name="footerXSL"/>

  
    <!--  <xsl:variable name="metsfile"><xsl:value-of select="concat('/',$dir,'/mets.xml')"/></xsl:variable> -->

    <xsl:variable name="metsfile"><xsl:value-of select="'http://diglib.hab.de/edoc/ed000223/mets.xml'"/></xsl:variable> 
    

    <xsl:template match="/">
        <html>
            <head>
                <meta http-equiv="Content-Type" content="text/html; charset=utf-8" />
                <title><xsl:value-of select="/tei:TEI/tei:teiHeader/tei:fileDesc/tei:titleStmt/tei:title"/></title>
                <link rel="stylesheet" type="text/css" href="http://diglib.hab.de/navigator2.css"/>
                <script src="http://diglib.hab.de/navigator.js" type="text/javascript"><noscript>please activate javascript to enable wdb functions</noscript></script>
            </head>
            
            <body>
                <!--  Dokumentkopf -->
                <div id="doc_header">
                <div style="margin-bottom:0.2em;padding:0;letter-spacing:0.3em;">Einleitung</div>
                <hr style="margin:0;padding:0;height:1px;"/>
                  <!--  Herauskommentiert PA 
                    <div class="menue_page" style="font-size:smaller;text-align:right;"><xsl:text>[</xsl:text>
                        <a>
                            <xsl:attribute name="href">
                                        <xsl:value-of select="$content"/><xsl:text>?dir=edoc/ed000145&amp;distype=optional&amp;xml=</xsl:text><xsl:value-of select="substring-after($footerXML,'http://diglib.hab.de/edoc/ed000145/')"/><xsl:text>&amp;xsl=</xsl:text><xsl:value-of select="$footerXSL"/><xsl:text>&amp;lokal=orig</xsl:text>
                                    </xsl:attribute>
                                    <xsl:text>Originale Schreibweise</xsl:text>
                             
                        </a>
                        <xsl:text>]</xsl:text>
                    </div>
                    --> 
                    <xsl:choose>  
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
                    </div>
                <!-- Titel -->
                <!--<div id="caption">
                    <div>
                        <xsl:value-of select="/tei:TEI/tei:teiHeader/tei:fileDesc/tei:titleStmt/tei:title"/>
                    </div>
                    <div>
                        <xsl:value-of select="/tei:TEI/tei:teiHeader/tei:fileDesc/tei:titleStmt/tei:author/tei:name/tei:forename"/><xsl:text> </xsl:text><xsl:value-of select="/tei:TEI/tei:teiHeader/tei:fileDesc/tei:titleStmt/tei:author/tei:name/tei:surname"/>
                    </div>
                    </div>-->
                <!-- Inhaltsuebersicht -->
                
                <a href="javascript:switchlayer('headings');">
                    <div style="margin: 1em 0 1em 0;">[Inhaltsverzeichnis]</div>
                </a> 
                
                <div id="headings" style="display:none;">
                    <ul>
                        <xsl:for-each select="/tei:TEI/tei:text/tei:body//tei:div/tei:head">
                            <li>
                                <xsl:number level="multiple" count="tei:div" format="1.1. "/>
                                <a>
                                    <xsl:attribute name="href"><xsl:text>#hd</xsl:text><xsl:number level="any"/></xsl:attribute>
                                    <xsl:apply-templates>
                                        <xsl:with-param name="caption">true</xsl:with-param>
                                    </xsl:apply-templates>
                                </a>
                                <xsl:apply-templates select="../tei:argument/tei:p">
                                    <xsl:with-param name="caption">true</xsl:with-param>
                                </xsl:apply-templates>
                            </li>
                        </xsl:for-each>
                    </ul>
                </div>
                
                
                <!--  hier nicht -->
                <div class="content" style="text-align:justify;">
                    <!-- Haupttext -->
                    <xsl:apply-templates select="tei:TEI/tei:text"/>
                    <!-- Fussnotenbereich  -->
                    <a name="footnotes"><hr style="height:1px;margin:1em 0 1em; 0"/></a>
                    <xsl:choose>
                        <xsl:when test="tei:TEI/tei:text/tei:body/tei:div[@type='footnotes']">
                            <!--  Wenn es einen Fussnotenbereich gibt -->
                            <xsl:apply-templates select="tei:TEI/tei:text/tei:body/tei:div[@type='footnotes']"/>
                        </xsl:when>
                        <xsl:otherwise>
                            <!--  andernfalls notes auswerten -->
                            <xsl:for-each select="tei:TEI/tei:text/tei:body//tei:note[@type='crit_app']">
                                <div class="footnotes">
                                    <xsl:element name="a">
                                        <xsl:attribute name="name">
                                            <xsl:text>fn</xsl:text>
                                            <xsl:number level="any" format="i" count="tei:note[@type='crit_app']"/>
                                        </xsl:attribute>
                                        <a>
                                            <xsl:attribute name="href">
                                                <xsl:text>#fna</xsl:text><xsl:number level="any" format="i" count="tei:note[@type='crit_app']"/>
                                            </xsl:attribute>
                                            <span style="font-size:9pt;vertical-align:super;color:green;"><xsl:number level="any" format="i" count="tei:note[@type='crit_app']"/></span>
                                        </a>
                                        <xsl:apply-templates/>
                                    </xsl:element>
                                </div>
                            </xsl:for-each>
                            <xsl:for-each select="tei:TEI/tei:text/tei:body//tei:note[@type='source']">
                                <div class="footnotes">
                                    <xsl:element name="a">
                                        <xsl:attribute name="name">
                                            <xsl:text>fn</xsl:text>
                                            <xsl:number level="any" count="tei:note[@type ='source']"/>
                                        </xsl:attribute>
                                        <a>
                                            <xsl:attribute name="href">
                                                <xsl:text>#fna</xsl:text><xsl:number level="any" count="tei:note[@type ='source']"/>
                                            </xsl:attribute>
                                            <span style="font-size:7pt;vertical-align:super;color:blue;"><xsl:number level="any" count="tei:note[@type ='source']"/></span>
                                        </a>
                                        <xsl:apply-templates/>
                                      </xsl:element>
                                </div>
                            </xsl:for-each>
                            <xsl:for-each select="tei:TEI/tei:text/tei:body//tei:note[@type='annotation']">
                                <div class="footnotes">
                                    <xsl:element name="a">
                                        <xsl:attribute name="name">
                                            <xsl:text>fn</xsl:text>
                                            <xsl:number level="any" format="1" count="tei:note[@type ='annotation']"/>
                                        </xsl:attribute>
                                        <a>
                                            <xsl:attribute name="href">
                                                <xsl:text>#fna</xsl:text><xsl:number level="any" format="1" count="tei:note[@type ='annotation']"/>
                                            </xsl:attribute>
                                            <span style="font-size:9pt;vertical-align:super;color:red;"><xsl:number level="any" format="1" count="tei:note[@type ='annotation']"/></span>
                                        </a>
                                        <xsl:apply-templates/>
                                    </xsl:element>
                                </div>
                            </xsl:for-each>
                          </xsl:otherwise>
                    </xsl:choose>
                    <!-- Bibliographie -->
                    <!--<a name="bibliography"><hr style="height:1px;margin:1em 0 1em; 0"/></a>-->
                    <!--<xsl:apply-templates select="tei:TEI/tei:text/tei:back/tei:div[@type='bibliography']"/>-->
                    
                    <!-- Bibliographie -->
                    <div id="kritApp" style="font-size:smaller;line-height:1em;">
                    <a name="kritischerAppart"><hr style="height:1px;margin:1em 0 1em; 0"/></a>
                    <xsl:for-each select="//tei:lem">
                        <a>
                            <xsl:attribute name="name">
                                <xsl:text>kA</xsl:text><xsl:number level="any"/>
                            </xsl:attribute><xsl:text> </xsl:text>
                        </a>
                        <a>
                        <xsl:attribute name="href">
                            <xsl:text>#kAz</xsl:text><xsl:number level="any"/>
                        </xsl:attribute>
                            [<xsl:number level="any"/>]
                        </a>
                        <xsl:value-of select="../tei:rdg"/><xsl:text> </xsl:text><i><xsl:value-of select="substring-after(../tei:rdg/@wit,'#')"/></i>
                        <br/>
                      </xsl:for-each>
                    </div>
                    
                    
                    <!-- footer -->
                    <xsl:call-template name="footer">
                        <xsl:with-param name="footerXML">
                            <xsl:value-of select="$footerXML"/>
                        </xsl:with-param>
                        <xsl:with-param name="footerXSL">
                            <xsl:value-of select="$footerXSL"/>
                        </xsl:with-param>
                    </xsl:call-template>
                </div> <!-- Ende main -->
            </body>
        </html>
    </xsl:template>
    
   
    <!--header-->
    <!-- editor, contributer etc. -->
    <xsl:template match="tei:respStmt">
        <xsl:if test="position() != 1">
            <xsl:text>,</xsl:text>
        </xsl:if>
        <xsl:text> </xsl:text>
        <xsl:value-of select="tei:resp"/>
        <xsl:text> </xsl:text>
        <xsl:value-of select="tei:name"/>
    </xsl:template>

    <!-- Front -->
    <xsl:template match="tei:front">
        <!--<xsl:apply-templates select="tei:titlePage"/>-->
        <xsl:apply-templates/>
    </xsl:template>

    <xsl:template match="tei:titlePage">
        <p class="content">
            <xsl:apply-templates/>
        </p>
    </xsl:template>

    <xsl:template match="tei:docTitle">
        <xsl:apply-templates/>
    </xsl:template>

    <xsl:template match="tei:byline">
        <p class="content">
            <xsl:apply-templates/>
        </p>
    </xsl:template>

    <xsl:template match="tei:imprimatur">
        <p class="content">
            <xsl:apply-templates/>
        </p>
    </xsl:template>

    <xsl:template match="tei:docDate">
        <p class="content">
            <xsl:apply-templates/>
        </p>
    </xsl:template>

    <xsl:template match="tei:docAuthor">
        <xsl:apply-templates/>
    </xsl:template>

    <xsl:template match="tei:epigraph">
        <p class="legende">
            <xsl:apply-templates/>
        </p>
    </xsl:template>

    <xsl:template match="tei:titlePart">
        <p class="content">
            <xsl:apply-templates/>
        </p>
    </xsl:template>


    <!--body-->
    <!-- main distribution-->
    <xsl:template match="tei:div[not(@type='footnotes')]">
        <a>
            <xsl:attribute name="name">
                <xsl:text>div</xsl:text>
                <xsl:number level="any"/>
            </xsl:attribute>
            <xsl:text> </xsl:text>
        </a>
        <!-- Anker als Sprungziel fuer xml:id -->
        <xsl:if test="@xml:id">
            <a>
                <xsl:attribute name="name">
                    <xsl:value-of select="@xml:id"/>
                </xsl:attribute>
                <xsl:text> </xsl:text>
            </a>
        </xsl:if>
        <div>
            <xsl:if test="@type = 'abstract'"><xsl:attribute name="style">font-size:smaller;</xsl:attribute></xsl:if>
            <xsl:apply-templates/>
        </div>
    </xsl:template>
    
<!--    Ueberschriften-->
    <xsl:template match="tei:head">
        <xsl:if test="@xml:id[starts-with(.,'org') or starts-with(.,'ue')]">
        <a>
            <xsl:attribute name="name"><xsl:value-of select="@xml:id"/></xsl:attribute>
            <xsl:text> </xsl:text>
        </a>
        </xsl:if>
        <a>
            <xsl:attribute name="name"><xsl:text>hd</xsl:text><xsl:number level="any"/></xsl:attribute>
            <xsl:text> </xsl:text>
        </a>
        <h2 style="background-color:#EEE;padding:0.3em;margin-top:1em;position:relative;width:100%;">
            <div style="position:relative;width:90%;"><xsl:apply-templates/></div>
            <div style="position:absolute;right:1.5em;top:0.2em;font-weight:900;"><a href="#">↑</a></div>
        </h2>
    </xsl:template>

    <!-- dictonary entries -->
    <xsl:template match="tei:orth">
        <br/>
        <span class="lemma">
            <a>
                <xsl:attribute name="name">
                    <xsl:text>orth</xsl:text>
                    <xsl:number level="any"/>
                </xsl:attribute>
            </a>
            <xsl:apply-templates/>
        </span>
    </xsl:template>

    <!-- pysical pages     -->
    <xsl:template match="tei:pb">
        <a>
            <xsl:attribute name="name">
                <!-- Geändert von PA, 26.Juni 2013   
                <xsl:value-of select="substring(@facs,2)"/> 
            -->
                <xsl:value-of select="@xml:id"/>
            </xsl:attribute>
            <xsl:text> </xsl:text>
        </a> 
        <div style="margin-top:2em;">
            <xsl:text> || </xsl:text>
            <xsl:text> [</xsl:text>
            <xsl:element name="a">
                <xsl:attribute name="href">
                    
                    <!-- convert identifier z.B. drucke_qun-59-9-1_00006 -->
                    <!-- select type of resource e.g. drucke -->
                    <xsl:text>http://diglib.hab.de/</xsl:text>
                    <xsl:value-of select="substring-before(substring(@facs,2),'_')"/>
                    <xsl:text>/</xsl:text>
                    <!-- select shelf mark e.g.qun-59-9-1 -->
                    <xsl:value-of
                        select="substring-before(substring-after(substring(@facs,2),'_'),'_')"/>
                    <!-- select Image-No , e.g. 00006  -->
                    <xsl:text>/start.htm?distype=imgs&amp;image=</xsl:text>
                    <xsl:value-of
                        select="substring-after(substring-after(substring(@facs,2),'_'),'_')"
                    />
                </xsl:attribute>
                <xsl:if test="$pvID = 'pv_transcript-facs'">
                    <xsl:attribute name="target">display2</xsl:attribute>
                </xsl:if>       
                <xsl:value-of select="@n"/>
                </xsl:element>
            <xsl:text>] </xsl:text>
            
            
        </div>
    </xsl:template>
    
    <!-- choice -->
    
    <xsl:template match="tei:choice">
    <xsl:choose>
        <xsl:when test="$lokal = 'orig'">
            <xsl:apply-templates select="tei:orig"/>
            <xsl:apply-templates select="tei:abbr"/>
        </xsl:when>
        <xsl:otherwise>
            <xsl:apply-templates select="tei:reg"/>
            <xsl:apply-templates select="tei:expan"/>
        </xsl:otherwise>
    </xsl:choose>
    </xsl:template>
    
    <xsl:template match="tei:orig">
        <xsl:apply-templates/>
    </xsl:template>
    
    <xsl:template match="tei:reg">
        <xsl:apply-templates/>
    </xsl:template>
 
    <xsl:template match="tei:abbr">
        <xsl:apply-templates/>
    </xsl:template>
 
    <xsl:template match="tei:expan">
        <i><xsl:apply-templates/></i>
    </xsl:template>
    
    
<!--    Links -->
    <xsl:template match="tei:ref">
        <xsl:param name="bibliography">
            <xsl:choose>
                <xsl:when test="@type='bibliography'">
                    <xsl:text>tei-bibliography.xsl</xsl:text>
                </xsl:when>
            </xsl:choose>
        </xsl:param>
        <xsl:param name="caption"/>
        <xsl:choose>
            <xsl:when test="@type='crit_app' and $caption != 'true'">
                <xsl:element name="a">
                    <xsl:attribute name="name">
                        <xsl:text>fna</xsl:text>
                        <xsl:value-of select="."/>
                    </xsl:attribute>
                    <a>
                        <xsl:attribute name="href">
                            <xsl:value-of select="@target"/>
                        </xsl:attribute>
                        <span style="font-size:9pt;vertical-align:super;color:green;"><xsl:value-of select="."/></span>
                    </a>
                </xsl:element>
            </xsl:when>
            
            <xsl:when test="@type='source' and $caption != 'true'">
                <xsl:element name="a">
                    <xsl:attribute name="name">
                        <xsl:text>fna</xsl:text>
                        <xsl:value-of select="."/>
                    </xsl:attribute>
                    <a>
                        <xsl:attribute name="href">
                            <xsl:value-of select="@target"/>
                        </xsl:attribute>
                        <span style="font-size:7pt;vertical-align:super;color:blue;"><xsl:value-of select="."/></span>
                    </a>
                </xsl:element>
            </xsl:when>
            <xsl:when test="@type='annotation' and $caption != 'true'">
                <xsl:element name="a">
                    <xsl:attribute name="name">
                        <xsl:text>fna</xsl:text>
                        <xsl:value-of select="."/>
                    </xsl:attribute>
                    <a>
                        <xsl:attribute name="href">
                            <xsl:value-of select="@target"/>
                        </xsl:attribute>
                        <span style="font-size:9pt;vertical-align:super;color:red;"><xsl:value-of select="."/></span>
                    </a>
                </xsl:element>
            </xsl:when>
            <!-- Google Books -->
            <xsl:when test="@type='google_books'">
                <a>
                    <xsl:attribute name="href">
                        <xsl:text>javascript:show_annotation_html('</xsl:text><xsl:value-of select="$dir"/><xsl:text>','</xsl:text><xsl:value-of select="@target"/><xsl:text>',500,600)</xsl:text>
                    </xsl:attribute>
                    <xsl:apply-templates/>
                </a> 
            </xsl:when>
            <xsl:when test="@type='bibliography'">
                <a>
                    <xsl:if test="starts-with(@target,'#')">
                        <xsl:attribute name="title">
                            <xsl:value-of select="normalize-space(id(substring(@target,2)))"/>
                        </xsl:attribute>
                    </xsl:if>  
                    <xsl:attribute name="href"> <xsl:value-of select="@target"/></xsl:attribute>
                    <xsl:apply-templates/>
                </a>
            </xsl:when>
            <xsl:when test="@target">
                <a>
                    <xsl:attribute name="href">
                        <xsl:value-of select="@target"/>
                    </xsl:attribute>
                     <xsl:attribute name="target">_blank</xsl:attribute>
                     <xsl:apply-templates/>
                </a>
            </xsl:when>
        </xsl:choose>
        <xsl:choose>
            <xsl:when test="@type='metsID_index'">
                <a>
                    <xsl:attribute name="href">
                        <xsl:value-of select="$content"/><xsl:text>?dir=edoc/ed000223&amp;xml=tei-transcript-mwb7.xml&amp;xsl=tei-transcript.xsl</xsl:text><xsl:value-of select="@cRef"/>
                    </xsl:attribute>
                    <xsl:attribute name="target">_blank</xsl:attribute>
                    <xsl:apply-templates/>
                </a>
            </xsl:when>
        </xsl:choose>
        <xsl:choose>
            <xsl:when test="substring-after(substring(@cRef,2),'pb_')&lt;='0138'">
                <a>
                    <xsl:attribute name="href">
                        <xsl:value-of select="$content"/><xsl:text>?dir=edoc/ed000223&amp;xml=tei-transcript-mwb1.xml&amp;xsl=tei-transcript.xsl</xsl:text><xsl:value-of select="@cRef"/>
                    </xsl:attribute>
                    <xsl:attribute name="target">_blank</xsl:attribute>
                    <xsl:apply-templates/>
                </a>
            </xsl:when>
            <xsl:when test="substring-after(substring(@cRef,2),'pb_') &lt;='0233'">
                <a><xsl:attribute name="href">
                    <xsl:value-of select="$content"/><xsl:text>?dir=edoc/ed000223&amp;xml=tei-transcript-mwb2.xml&amp;xsl=tei-transcript.xsl</xsl:text><xsl:value-of select="@cRef"/>
                </xsl:attribute>
                    <xsl:attribute name="target">_blank</xsl:attribute>
                    <xsl:apply-templates/>
                </a>
            </xsl:when>
            <xsl:when test="substring-after(substring(@cRef,2),'pb_') &lt;='0651'">
                <a><xsl:attribute name="href">
                    <xsl:value-of select="$content"/><xsl:text>?dir=edoc/ed000223&amp;xml=tei-transcript-mwb3.xml&amp;xsl=tei-transcript.xsl</xsl:text><xsl:value-of select="@cRef"/>
                </xsl:attribute>
                    <xsl:attribute name="target">_blank</xsl:attribute>
                    <xsl:apply-templates/>
                </a>
            </xsl:when>
            <xsl:when test="substring-after(substring(@cRef,2),'pb_') &lt;='0692'">
                <a><xsl:attribute name="href">
                    <xsl:value-of select="$content"/><xsl:text>?dir=edoc/ed000223&amp;xml=tei-transcript-mwb4.xml&amp;xsl=tei-transcript.xsl</xsl:text><xsl:value-of select="@cRef"/>
                </xsl:attribute>
                    <xsl:attribute name="target">_blank</xsl:attribute>
                    <xsl:apply-templates/>
                </a>
            </xsl:when>
            <xsl:when test="substring-after(substring(@cRef,2),'pb_') &lt;='0906'">
                <a><xsl:attribute name="href">
                    <xsl:value-of select="$content"/><xsl:text>?dir=edoc/ed000223&amp;xml=tei-transcript-mwb5.xml&amp;xsl=tei-transcript.xsl</xsl:text><xsl:value-of select="@cRef"/>
                </xsl:attribute>
                    <xsl:attribute name="target">_blank</xsl:attribute>
                    <xsl:apply-templates/>
                </a>
            </xsl:when>
            <xsl:when test="substring-after(substring(@cRef,2),'pb_') &lt;='1004'">
                <a><xsl:attribute name="href">
                    <xsl:value-of select="$content"/><xsl:text>?dir=edoc/ed000223&amp;xml=tei-transcript-mwb6.xml&amp;xsl=tei-transcript.xsl</xsl:text><xsl:value-of select="@cRef"/>
                </xsl:attribute>
                    <xsl:attribute name="target">_blank</xsl:attribute>
                    <xsl:apply-templates/>
                </a>
            </xsl:when>
            <xsl:when test="substring-after(substring(@cRef,2),'pb_') &lt;='2000'">
                <a><xsl:attribute name="href">
                    <xsl:value-of select="$content"/><xsl:text>?dir=edoc/ed000223&amp;xml=tei-transcript-mwb7.xml&amp;xsl=tei-transcript.xsl</xsl:text><xsl:value-of select="@cRef"/>
                </xsl:attribute>
                    <xsl:attribute name="target">_blank</xsl:attribute>
                    <xsl:apply-templates/>
                </a>
            </xsl:when>
            <xsl:when test="starts-with(@cRef,'#MWB_pb_i')">
                <a><xsl:attribute name="href">
                    <xsl:value-of select="$content"/><xsl:text>?dir=edoc/ed000223&amp;xml=tei-transcript-mwb1.xml&amp;xsl=tei-transcript.xsl</xsl:text><xsl:value-of select="@cRef"/>
                </xsl:attribute>
                    <xsl:attribute name="target">_blank</xsl:attribute>
                    <xsl:apply-templates/>
                </a>
            </xsl:when>
          </xsl:choose>
      
        
     </xsl:template>
    

        
    
 
    <xsl:template match="tei:ptr">
        
        <xsl:variable name="ptrSTD">
            <xsl:call-template name="referencesPTR">
            <xsl:with-param name="refType">
                <xsl:value-of select="@type"/>
            </xsl:with-param>
            <xsl:with-param name="refValue">
                <xsl:value-of select="@cRef"/>
            </xsl:with-param>
            </xsl:call-template>
        </xsl:variable>
        
        <xsl:choose>
            <!-- Zunaechst  PTR Standard abarbeiten -->
            <xsl:when test="$ptrSTD != 'NULL'">
                <xsl:call-template name="referencesPTR">
                    <xsl:with-param name="refType">
                        <xsl:value-of select="@type"/>
                    </xsl:with-param>
                    <xsl:with-param name="refValue">
                        <xsl:value-of select="@cRef"/>
                    </xsl:with-param>
                </xsl:call-template>
            </xsl:when>
            <xsl:when test="@type='google_books'">
                [<a>
                    <xsl:attribute name="href">
                        <xsl:text>javascript:show_annotation_html('</xsl:text><xsl:value-of select="$dir"/><xsl:text>','</xsl:text><xsl:value-of select="@target"/><xsl:text>',400,600)</xsl:text>
                    </xsl:attribute>
                    <xsl:text>Google Books</xsl:text></a>]
            </xsl:when>
            <xsl:when test="starts-with(@target,'http://')">
                [<a>
                    <xsl:attribute name="href"><xsl:value-of select="@target"/></xsl:attribute>
                    <xsl:attribute name="target">_blank</xsl:attribute>
                    <xsl:text>Link</xsl:text>
                </a>]
            </xsl:when>
                <xsl:when test="@type='GettyThesaurus' ">
                [<a href="{normalize-space(concat($GettyThesaurus,(substring-after(@target, '#TGN_'))))}" target='_blank'>TGN</a>]
                </xsl:when>
            <xsl:when test="starts-with(@target,'#')">
                <span title="Referenz">
                    <xsl:text>[</xsl:text>
                    <a>
                        <xsl:attribute name="href">
                            <xsl:value-of select="@target"/>
                        </xsl:attribute>
                        <xsl:text>↗</xsl:text>
                    </a>
                    <xsl:text>]</xsl:text>
                </span>
            </xsl:when>
        </xsl:choose>
        <xsl:apply-templates/>
    </xsl:template>
 
    <!-- Listen -->
    
    <xsl:template match="tei:list">
        <!-- ANK: Einrücken und Aufzählungszeichen deaktiviert -->
        <!-- PA: Einrücken und Blocksatz aktiviert -->
        <ul style="
            list-style-type:square ; 
            padding:0;
            text-align:justify;
            margin-left:1em;
            ">
            <xsl:apply-templates/>
        </ul>  
    </xsl:template>
    
    <xsl:template match="tei:item">
        <li><xsl:apply-templates/></li>
     </xsl:template>
    
    <xsl:template match="tei:listBibl">
        <div style="line-height:1em;">
            <xsl:apply-templates/>
        </div>  
      </xsl:template>
    
    
    <xsl:template match="tei:bibl[parent::tei:listBibl and @n]">
            <xsl:element name="a">
                <xsl:attribute name="name">
                    <xsl:value-of select="@xml:id"/>
                </xsl:attribute>
                <xsl:text> </xsl:text>
            </xsl:element>
            <br/>
        <xsl:text>[</xsl:text><a>
            <xsl:attribute name="href">
                <xsl:text>javascript:show_annotation('</xsl:text><xsl:value-of select="$dir"/><xsl:text>','tei-bibliography.xml','tei-bibliography.xsl','</xsl:text><xsl:value-of select="@xml:id"/><xsl:text>',400,600)</xsl:text>
             </xsl:attribute>
            <xsl:text>B</xsl:text><xsl:value-of select="@n"/>
        </a>
        <xsl:text>] </xsl:text>
                    <xsl:apply-templates/>
       </xsl:template>
    
    <!-- footnotes, annotations -->

    <xsl:template match="tei:note">
        <xsl:param name="caption"/>
        <!--  zwei Typen: entweder Fussnoten am Text- oder Seitenende in einem besonderen Abschnitt oder in den Text integriert -->
        <xsl:choose>
            <xsl:when test="parent::tei:div[@type='footnotes' ]">
                <!--   Fussnoten am Text- oder Seitenende -->
                <div class="footnotes">
                <xsl:element name="a">
                    <xsl:attribute name="name">
                        <xsl:text>fn</xsl:text>
                         <xsl:value-of select="@n"/>
                    </xsl:attribute>
                    <a>
                        <xsl:attribute name="href">
                            <xsl:text>#fna</xsl:text><xsl:value-of select="@n"/>
                        </xsl:attribute>
                        <span style="font-size:9pt;vertical-align:super;color:blue;margin-right:0.3em;">
                            <xsl:value-of select="@n"/>
                        </span>
                    </a>
                </xsl:element>
                    <xsl:apply-templates/>
                </div>
            </xsl:when>
            <xsl:when test="$caption ='true'">
                <!-- keine Anzeige -->
            </xsl:when>
            <xsl:when test="@type='footnoteX'">
                <!--  noch in Bearbeitung, nicht anzeigen -->
             </xsl:when>   
            <xsl:when test="@type='crit_app'">
                <!--  in Text integriert, nur Verweis , Fussnotenabschnitt mit foreach generiert -->
                <xsl:element name="a"> 
                    <xsl:attribute name="name">
                        <xsl:text>fna</xsl:text>
                        <xsl:number level="any" format="i" count="tei:note[@type='crit_app']"/>
                    </xsl:attribute>
                    <a>
                        <xsl:attribute name="href">
                            <xsl:text>#fn</xsl:text><xsl:number level="any" format="i" count="tei:note[@type='crit_app']"/>
                        </xsl:attribute>
                        <xsl:attribute name="title">
                            <xsl:value-of select="normalize-space(.)"/>
                        </xsl:attribute>
                        <span style="font-size:9pt;vertical-align:super;color:green;"><xsl:value-of select="$caption"/><xsl:number level="any" format="i" count="tei:note[@type='crit_app']"/></span>
                    </a>
                </xsl:element>
            </xsl:when>
            <xsl:when test="@type='source'">
                <!--  in Text integriert, nur Verweis , Fussnotenabschnitt mit foreach generiert -->
                <xsl:element name="a"> 
                    <xsl:attribute name="name">
                        <xsl:text>fna</xsl:text>
                        <xsl:number level="any" count="tei:note[@type ='source']"/>
                    </xsl:attribute>
                    <a>
                        <xsl:attribute name="href">
                            <xsl:text>#fn</xsl:text><xsl:number level="any" count="tei:note[@type ='source']"/>
                        </xsl:attribute>
                        <xsl:attribute name="title">
                            <xsl:value-of select="normalize-space(.)"/>
                        </xsl:attribute>
                        <span style="font-size:7pt;vertical-align:super;color:blue;"><xsl:value-of select="$caption"/><xsl:number level="any" count="tei:note[@type ='source']"/></span>
                    </a>
                </xsl:element>
              </xsl:when>
            <xsl:when test="@type='annotation'">
                <!--  in Text integriert, nur Verweis , Fussnotenabschnitt mit foreach generiert -->
                <xsl:element name="a"> 
                    <xsl:attribute name="name">
                        <xsl:text>fna</xsl:text>
                        <xsl:number level="any" format="1" count="tei:note[@type ='annotation']"/>
                    </xsl:attribute>
                    <a>
                        <xsl:attribute name="href">
                            <xsl:text>#fn</xsl:text><xsl:number level="any" format="1" count="tei:note[@type ='annotation']"/>
                        </xsl:attribute>
                        <xsl:attribute name="title">
                            <xsl:value-of select="normalize-space(.)"/>
                        </xsl:attribute>
                        <span style="font-size:9pt;vertical-align:super;color:red;"><xsl:value-of select="$caption"/><xsl:number level="any" format="1" count="tei:note[@type ='annotation']"/></span>
                    </a>
                </xsl:element>
            </xsl:when>
            <xsl:otherwise>
                <xsl:text>(</xsl:text><xsl:apply-templates/><xsl:text>)</xsl:text>
            </xsl:otherwise>
        </xsl:choose>
        <xsl:text> </xsl:text>
       
    </xsl:template>
    
    <!-- closer -->
    <xsl:template match="tei:closer">
        <xsl:apply-templates/>
    </xsl:template>
    <!-- Namen -->
    <xsl:template match="tei:name">
        <xsl:apply-templates/>
    </xsl:template>
    <!-- Datum -->
    <xsl:template match="tei:dateline">
        <xsl:apply-templates/>
    </xsl:template>
    
    <!-- tei:date @calendar roll-over <abbr title=""> PA 2013-02-03-->
    <xsl:template match="tei:date">
        <xsl:choose>
        <xsl:when test="@calendar='ad'" >
        <abbr>
            <xsl:attribute name="title">
                <xsl:value-of select="@when"/>
            </xsl:attribute>
            <xsl:apply-templates/>
        </abbr>
        </xsl:when>
            <xsl:otherwise>
                <xsl:apply-templates/>
            </xsl:otherwise>
        </xsl:choose>
    </xsl:template>
    
    <!-- Grafiken -->
    <xsl:template match="tei:graphic">
        <img src="{@url}" alt="Abbildung" class="illustration"/>
    </xsl:template>
    
    <!-- index  erst mal auslassen-->
    <xsl:template match="tei:index">
        
    </xsl:template>
    
    <!--  Anker fuer Spruenge im Text -->
    <xsl:template match="tei:anchor">
        <a>
            <xsl:attribute name="name">
                <xsl:value-of select="@xml:id"/>
            </xsl:attribute>
            <xsl:text> </xsl:text>
        </a>
    </xsl:template>
    <!-- lokal ################################################################################################  -->
    
    
   
    <!-- entitaeten -->
    
    <!-- PA geändert am 5.Juni 2013 ANK: aus tei-transcript.xsl übernommen -->
    <xsl:template match="tei:rs">
        <xsl:choose>
            <xsl:when test="@type='person' or @type='author'">
                <a>
                    <xsl:attribute name="href">
                        <xsl:text>javascript:show_annotation('</xsl:text>edoc/ed000223/<xsl:text>','tei-personenverzeichnis.xml','show-person.xsl','</xsl:text><xsl:value-of select="substring(@ref,2)"/><xsl:text>',300,500)</xsl:text>
                    </xsl:attribute>
                    <xsl:apply-templates/>
                </a>
            </xsl:when>
            <xsl:when test="@type='place'">
                <a>
                    <xsl:attribute name="href">
                        <xsl:text>javascript:show_annotation('</xsl:text>edoc/ed000223/<xsl:text>','tei-ortsverzeichnis.xml','show-place.xsl','</xsl:text><xsl:value-of select="substring(@ref,2)"/><xsl:text>',300,500)</xsl:text>
                    </xsl:attribute>
                    <xsl:apply-templates/>    
                </a>
            </xsl:when>
            <xsl:when test="@type='bibliography'">
                <a>
                    <xsl:attribute name="href">
                        <xsl:text>javascript:show_annotation('</xsl:text>edoc/ed000223/<xsl:text>','tei-bibliography.xml','tei-bibliography.xsl','</xsl:text><xsl:value-of select="substring(@ref,2)"/><xsl:text>',300,500)</xsl:text>
                    </xsl:attribute>
                    <xsl:apply-templates/>    
                </a>
            </xsl:when>
        </xsl:choose>
    </xsl:template>
    
    
    <!-- ANK: ENDE Ã„nderungen  -->
    <!--  Textkritik -->
    
    <xsl:template match="tei:app">
       <xsl:apply-templates select="tei:lem"/>
    </xsl:template>
  
    <xsl:template match="tei:lem">
        <a>
            <xsl:attribute name="name">
                <xsl:text>kAz</xsl:text><xsl:number level="any"/>
            </xsl:attribute>
            <xsl:text> </xsl:text>
        </a>
            <xsl:apply-templates/>
        <a>
            <xsl:attribute name="href">
                <xsl:text>#kA</xsl:text><xsl:number level="any"/>
            </xsl:attribute>
            <xsl:attribute name="title">
                <xsl:value-of select="../tei:rdg"/><xsl:text> (</xsl:text><xsl:value-of select="substring-after(../tei:rdg/@wit,'#')"/><xsl:text>)</xsl:text>
            </xsl:attribute>
            [<xsl:number level="any"/>]
        </a>
    </xsl:template>
    
    
    <xsl:template match="tei:l">
        <xsl:if test="@xml:id[starts-with(.,'org') or starts-with(.,'ue')]">
            <a>
                <xsl:attribute name="name"><xsl:value-of select="@xml:id"/></xsl:attribute>
                <xsl:text> </xsl:text>
            </a>
        </xsl:if>
        <br/>
        <xsl:apply-templates/>
    </xsl:template>
    <!--
        <xsl:template match="tei:quote">
            <xsl:choose>
                <xsl:when test="@rend ='blockquote'">
                    <p style="position:relative; left:3em;right:3em;"><xsl:apply-templates/></p>
                </xsl:when>
                <xsl:otherwise>
                        <span style="font-style:italic;"><xsl:apply-templates/></span>
                  </xsl:otherwise>
            </xsl:choose>
                 
        </xsl:template>
     -->  
    <!--
    <xsl:template match="tei:q">
        <xsl:choose>
            <xsl:when test="tei:q/@type='Abraham_Judas2_1689'">
                Hallo
            </xsl:when>
            <xsl:otherwise>
                <span stlye="color:#cd9db5"><xsl:apply-templates/></span>  
            </xsl:otherwise>
        </xsl:choose>
        </xsl:template>
        -->
  <!--      <span style="color:#cd9db5"> <xsl:apply-templates/></span> -->
            
   
    <xsl:template match="tei:q">
        <xsl:choose>
            <xsl:when test="@who='1'">
                <span style="background-color:#F5F5DC"><xsl:apply-templates></xsl:apply-templates></span>
            </xsl:when>
            <xsl:when test="@who='2'">
                <span style="background-color:#F66134"><xsl:apply-templates></xsl:apply-templates></span>
            </xsl:when>
            <xsl:when test="@who='3'">
                <span style="background-color:#A89C7F"><xsl:apply-templates></xsl:apply-templates></span>
            </xsl:when>
            <xsl:when test="@who='4a'">
                <span style="background-color:#FF0"><xsl:apply-templates></xsl:apply-templates></span>
            </xsl:when>
            <xsl:when test="@who='4b'">
                <span style="background-color:#FC0"><xsl:apply-templates></xsl:apply-templates></span>
            </xsl:when>
            <xsl:when test="@who='4c'">
                <span style="background-color:#F90"><xsl:apply-templates></xsl:apply-templates></span>
            </xsl:when>
            <xsl:when test="@who='4d'">
                <span style="background-color:#F60"><xsl:apply-templates></xsl:apply-templates></span>
            </xsl:when>
            <xsl:when test="@who='4c'">
                <span style="background-color:#F30"><xsl:apply-templates></xsl:apply-templates></span>
            </xsl:when>
            <xsl:when test="@who='5'">
                <span style="background-color:#FCF"><xsl:apply-templates></xsl:apply-templates></span>
            </xsl:when>
            <xsl:when test="@who='6'">
                <span style="background-color:#CCF"><xsl:apply-templates></xsl:apply-templates></span>
            </xsl:when>
            <xsl:when test="@who='7'">
                <span style="background-color:#9CF"><xsl:apply-templates></xsl:apply-templates></span>
            </xsl:when>
            <xsl:when test="@who='8'">
                <span style="background-color:#6CF"><xsl:apply-templates></xsl:apply-templates></span>
            </xsl:when>
            <xsl:when test="@who='9'">
                <span style="background-color:#09F"><xsl:apply-templates></xsl:apply-templates></span>
            </xsl:when>
            <xsl:when test="@who='10'">
                <span style="background-color:#FF9"><xsl:apply-templates></xsl:apply-templates></span>
            </xsl:when>
            <xsl:when test="@who='11'">
                <span style="background-color:#FFE4C4"><xsl:apply-templates></xsl:apply-templates></span>
            </xsl:when>
            <xsl:when test="@who='15'">
                <span style="font-size:1em; background-color:#7F4861"><xsl:apply-templates></xsl:apply-templates></span>
            </xsl:when>
            <xsl:otherwise>
                <xsl:apply-templates/>
            </xsl:otherwise>
            
        </xsl:choose>       
    </xsl:template>
   
      
        <xsl:template match="tei:hi | tei:emph">
           <xsl:if test="@xml:id[starts-with(.,'org') or starts-with(.,'ue')]">
               <a>
                   <xsl:attribute name="name"><xsl:value-of select="@xml:id"/></xsl:attribute>
                   <xsl:text> </xsl:text>
               </a>
           </xsl:if>
           <xsl:choose>
               <xsl:when test="@rend ='italics'">
                   <span style="font-style:italic;"><xsl:apply-templates/></span>
               </xsl:when>
               <xsl:when test="@rend ='bold'">
                   <span style="font-weight:bold;"><xsl:apply-templates/></span>
               </xsl:when>
               <xsl:when test="@rend ='underline'">
                   <u><xsl:apply-templates/></u>
               </xsl:when>
               <xsl:when test="@rend ='smallCaps'">
                   <span style="font-variant:small-caps;"><xsl:apply-templates/></span>
               </xsl:when>
                   <xsl:when test="@rend ='initial'">
                       <big><xsl:apply-templates/></big>
               </xsl:when>
               <xsl:otherwise>
                   <xsl:apply-templates/>
               </xsl:otherwise>
           </xsl:choose>
       </xsl:template>
    
    
    <!-- ANK: Beginn Ergänzungen -->
    
    <!-- Buchtitel kursiv -->
    <xsl:template match="tei:bibl/tei:title">
        <i><xsl:apply-templates/></i>
    </xsl:template>
    
    <!-- Spaltenumbruch anzeigen -->
   
    <xsl:template match="tei:cb">
        <div>
            <xsl:if test="@n='2'"><xsl:attribute name="style">margin-top:2em;</xsl:attribute></xsl:if>
            <xsl:text>|| </xsl:text>
            <xsl:text> [Spalte </xsl:text><xsl:value-of select="@n"/><xsl:text>] </xsl:text>
        </div>
    </xsl:template>
    
    <!-- Korrekturen unterstreichen -->
    <xsl:template match="tei:corr">
        <span class="textcrit_corr" style="text-decoration:underline">
            <xsl:apply-templates/>
        </span>
    </xsl:template>
  
    <xsl:template match="tei:lb">
      <br/><xsl:text/>
    </xsl:template>
  
    <!-- salute wurde vorher nicht umgesetzt -->
    <xsl:template match="tei:salute">
        <xsl:apply-templates/>
    </xsl:template>
    
    <!-- ANK: Darstellung von Grafiken mit Hilfe von Tabellen -->
    <xsl:template match="tei:figure/tei:p/tei:table">
        <table>
            <xsl:attribute name="width">90%</xsl:attribute>
            <xsl:attribute name="align">center</xsl:attribute>
            <xsl:attribute name="style">table-layout:fixed; line-height:0.8em; font-size:0.8em</xsl:attribute>
            <xsl:apply-templates/>   
        </table>
    </xsl:template>
    
    <xsl:template match="tei:cell">
        <td>
            <xsl:choose>
                <xsl:when test="@rend='left'">
                    <xsl:attribute name="style">border:none; text-align:left; vertical-align:center</xsl:attribute> 
                </xsl:when>
                <xsl:otherwise>
                    <xsl:attribute name="style">border:none; text-align:center; vertical-align:center</xsl:attribute> 
                </xsl:otherwise>
            </xsl:choose>
            <xsl:apply-templates/>
        </td>
    </xsl:template>
    <!-- Ende Ergänzung-->
    
    
    <!-- Titel soll fett erscheinen -->
    <xsl:template match="tei:title">
        <b><xsl:apply-templates/></b>
    </xsl:template>
    
   <!-- Ende ANK -->
    
       <!-- spezifica -->
    <!-- Bibliographie hier ausschalten -->
       <xsl:template match="tei:back"/>
       
</xsl:stylesheet>
