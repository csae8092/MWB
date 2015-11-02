<xsl:stylesheet xmlns="http://www.w3.org/1999/xhtml" xmlns:xsl="http://www.w3.org/1999/XSL/Transform" xmlns:tei="http://www.tei-c.org/ns/1.0" version="2.0">
    <xsl:output method="html" encoding="UTF-8"/>
    <!-- (c) HAB, Torsten Schaßan, 2014-06-19 -->
    <xsl:template match="/">
        <html>
            <head>
                <title>XML statistics for "<xsl:value-of select="/tei:TEI/descendant::tei:titleStmt/tei:title"/> (<xsl:value-of select="/tei:TEI/@xml:id"/>)</title>
                <meta name="viewport" content="initial-scale=1.0, user-scalable=no"/>
                <style type="text/css">
                    &lt;!--
                    table {empty-cells:show;border-collapse:collapse;}
                    td {border:1px solid #000;vertical-align:top;}
                    --&gt;
                    #map-canvas {
                    height: 75%;
                    width: 75;
                    margin: 10px;
                    padding: 10px
                    }
                </style>
                <script type="text/javascript" src="http://www.digital-archiv.at/versuche/js_maps.js"></script>
                <script type="text/javascript">
                    var map;
                    function initialize() {
                    var mapOptions = {
                    zoom: 8,
                    center: new google.maps.LatLng(-34.397, 150.644)
                    };
                    map = new google.maps.Map(document.getElementById('map-canvas'),
                    mapOptions);
                    }
                    
                    google.maps.event.addDomListener(window, 'load', initialize);

                </script>
            </head>
            <body>
                <div id="map-canvas"/>
                <h4>XML statistics for <br/>
                    <xsl:value-of select="/tei:TEI/descendant::tei:titleStmt/tei:title"/>
                    <br/>
                    (<xsl:value-of select="/tei:TEI/@xml:id"/>)</h4>
                <table>
                    <thead>
                        <tr>
                            <td>Element</td>
                            <td>Anzahl</td>
                            <td>Attribute / Werte</td>
<!--                            <td>Pfade</td>-->
                        </tr>
                    </thead>
                    <tbody>
                        <!-- gehe zu jedem Element, das <text> als Vorfahr hat und gruppiere die gefundenen Treffer nach dem Namen des Elements -->
                        <xsl:for-each-group select="//*[ancestor::tei:text]" group-by="name()">
                            <xsl:sort select="current-grouping-key()"/>
                            <tr>
                                <td>
                                    <xsl:value-of select="current-grouping-key()"/>
                                </td>
                                <td>
                                    <xsl:value-of select="count(//*[name() = current-grouping-key()][ancestor::tei:text])"/>
                                </td>
                                <td>
                                    <!-- wenn das derzeit verarbeitete Element Attribute hat, sollen alle Attribute nach Namen gruppiert werden -->
                                    <xsl:if test="@*">
                                        <table style="width:100%">
                                            <xsl:for-each-group select="//*[name() = current-grouping-key()][ancestor::tei:text]/@*" group-by="name()">
                                                <tr>
                                                    <td style="width:30%">
                                                        <xsl:value-of select="current-grouping-key()"/>; 
                                                    </td>
                                                    <td style="width:70%">
                                                        <xsl:for-each-group select="current-group()" group-by=".">
                                                            <xsl:sort select="current-grouping-key()"/>
                                                            <!-- Zähler der unterschiedlichen Atritbute eingefügt, Andorfer, 02-07-2014 -->
                                                            <xsl:value-of select="count(current-group())"/>
                                                            <text>: </text>
                                                            <xsl:value-of select="current-grouping-key()"/>
                                                            <xsl:if test="not(position()=last())">
                                                                <br/>
                                                            </xsl:if>
                                                        </xsl:for-each-group>
                                                    </td>
                                                    <td style="width:20%">
                                                        <xsl:value-of select="count(distinct-values(current-group()))"/>
                                                    </td>
                                                </tr>
                                            </xsl:for-each-group>
                                        </table>
                                    </xsl:if>
                                </td>
                                <!--<td>
                                    <!-\- gehe zu jedem Element, dessen Name dem derzeit verarbeiteten Gruppierungsschlüssel entspricht -\->
                                    <xsl:for-each select="//*[name() = current-grouping-key()][ancestor::tei:text]">
                                        <xsl:variable name="path">
                                            <xsl:for-each select="ancestor::*">
                                                <xsl:if test="parent::*">
                                                    <xsl:text> > </xsl:text>
                                                </xsl:if>
                                                <xsl:value-of select="name()"/>
                                            </xsl:for-each>
                                        </xsl:variable>
                                        <xsl:value-of select="$path"/>
                                        <br/>
                                    </xsl:for-each>
                                </td>-->
                            </tr>
                        </xsl:for-each-group>
                    </tbody>
                </table>
            </body>
        </html>
    </xsl:template>
</xsl:stylesheet>