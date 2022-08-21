<xsl:stylesheet xmlns:xsl="http://www.w3.org/1999/XSL/Transform"
                xmlns:fo="http://www.w3.org/1999/XSL/Format"
                xmlns:xhtml="http://www.w3.org/1999/xhtml"
                version="1.0">

  <xsl:output indent="yes"/>

  <xsl:template match="/">
    <!-- media-usage="bounded-in-one-dimension" -->
    <fo:root media-usage="bounded-in-one-dimension">
      <fo:layout-master-set>
        <!-- every attribute set to auto -->
        <fo:simple-page-master master-name="pm" page-width="auto"> 
          <fo:region-body/>
        </fo:simple-page-master>
      </fo:layout-master-set>
      <fo:page-sequence master-reference="pm">
        <fo:flow flow-name="xsl-region-body">
          <xsl:apply-templates/>
        </fo:flow>
      </fo:page-sequence>
    </fo:root>
  </xsl:template>

  <xsl:template match="xhtml:div | 
                       xhtml:frame | 
                       xhtml:frameset | xhtml:noframes | xhtml:iframe">
    <fo:block><xsl:apply-templates/></fo:block>
  </xsl:template>


  <xsl:template match="xhtml:li">
    <fo:list-item>
      <fo:list-item-label end-indent="label-end()">
        <fo:block text-align="end">
          <xsl:choose>
            <xsl:when test="parent::xhtml:ol"><xsl:number/></xsl:when>
            <xsl:when test="parent::xhtml:ul">
	      <xsl:variable name="depth" select="count(ancestor::xhtml:ul)" />
	      <xsl:choose>
		<xsl:when test="$depth=1">&#x25CF;</xsl:when>
		<xsl:when test="$depth=2">o</xsl:when>
		<xsl:when test="$depth=2">-</xsl:when>
		<xsl:otherwise>x</xsl:otherwise>
	      </xsl:choose>
            </xsl:when>
          </xsl:choose>
        </fo:block>
      </fo:list-item-label>
         
      <fo:list-item-body start-indent="body-start()">
        <fo:block><xsl:apply-templates/></fo:block>
      </fo:list-item-body>
    </fo:list-item>
  </xsl:template>


  <xsl:template match="xhtml:head | xhtml:script"/>

  <xsl:template match="xhtml:table">
    <fo:table-and-caption>
      <xsl:apply-templates select="xhtml:caption"/>
      <fo:table>
        <xsl:apply-templates select="xhtml:colgroup"/>
        <xsl:apply-templates select="xhtml:thead"/>
        <xsl:apply-templates select="xhtml:tfoot"/>
        <xsl:apply-templates select="xhtml:tbody"/>

        <xsl:if test="xhtml:tr">
          <fo:table-body>
            <xsl:apply-templates select="xhtml:tr"/>
          </fo:table-body>
        </xsl:if>
      </fo:table>
    </fo:table-and-caption>
  </xsl:template>

  <xsl:template match="xhtml:tr">
    <fo:table-row><xsl:apply-templates/></fo:table-row>
  </xsl:template>

  <xsl:template match="xhtml:thead">
    <fo:table-header><xsl:apply-templates/></fo:table-header>
  </xsl:template>

  <xsl:template match="xhtml:tbody">
    <fo:table-body><xsl:apply-templates/></fo:table-body>
  </xsl:template>

  <xsl:template match="xhtml:tfoot">
    <fo:table-footer><xsl:apply-templates/></fo:table-footer>
  </xsl:template>

  <xsl:template match="xhtml:colgroup">
    <fo:table-column column-width= "{@width}px" 
                     column-number="{count(preceding::col)}">
     <!-- the html:colgroup/@span  corresponds to -->
     <!-- xsl:column-group/@number-columns-repeated -->
     <!-- but should be ignored if the colgroup has children --> 
     <xsl:attribute name="number-columns-repeated">
       <xsl:choose>
         <xsl:when test="not(col)"><xsl:value-of select="@span"/></xsl:when>
         <xsl:otherwise><xsl:value-of select="count(col)"/></xsl:otherwise>
       </xsl:choose>
     </xsl:attribute>
   </fo:table-column>
   <xsl:apply-templates/>
  </xsl:template>

  <xsl:template match="xhtml:col">
    <fo:table-column column-width="{@width}px"
                     number-columns-repeated="{@span}"
                     column-number="{count(preceding::col)}"/>
  </xsl:template>


  <xsl:template match="xhtml:td">
    <fo:table-cell><fo:block><xsl:apply-templates/></fo:block></fo:table-cell>
  </xsl:template>

  <xsl:template match="xhtml:th">
    <fo:table-cell font-weight="bolder" text-align="center">
      <fo:block>
        <xsl:apply-templates/>
      </fo:block>
    </fo:table-cell>
  </xsl:template>

  <xsl:template match="xhtml:caption">
    <fo:table-caption text-align="center">
      <fo:block><xsl:apply-templates/></fo:block>
    </fo:table-caption>
  </xsl:template>

  <xsl:template match="xhtml:body">
    <fo:block padding="8px" line-height="1.12em">
      <xsl:apply-templates/>
    </fo:block>
  </xsl:template>

  <xsl:template match="xhtml:h1">
    <fo:block font-size="200%" margin=".67em 0em" font-family="sans-serif" font-weight="bolder">
      <xsl:apply-templates/>
    </fo:block>
  </xsl:template>

  <xsl:template match="xhtml:h2">
    <fo:block font-size="150%" margin=".83em 0em" font-family="sans-serif" font-weight="bolder">
      <xsl:apply-templates/>
    </fo:block>
  </xsl:template>

  <xsl:template match="xhtml:h3">
    <fo:block font-size="117%" margin="1em 0em" font-family="sans-serif" font-weight="bolder">
      <xsl:apply-templates/>
    </fo:block>
  </xsl:template>

  <xsl:template match="xhtml:h4">
    <fo:block margin="1.33em 0em" font-family="sans-serif" font-weight="bolder">
      <xsl:apply-templates/>
    </fo:block>
  </xsl:template>

  <xsl:template match="xhtml:h5">
    <fo:block font-size="83%" line-height="1.17em" margin="1.67em 0em" font-family="sans-serif" font-weight="bolder">
      <xsl:apply-templates/>
    </fo:block>
  </xsl:template>

  <xsl:template match="xhtml:h6">
    <fo:block font-size="67%" margin="2.33em 0em" font-family="sans-serif" font-weight="bolder">
      <xsl:apply-templates/>
    </fo:block>
  </xsl:template>

  <xsl:template match="xhtml:p">
    <fo:block margin="1.33em 0em">
      <xsl:apply-templates/>
    </fo:block>
  </xsl:template>

  <xsl:template match="xhtml:blockquote">
    <fo:block margin="1.33em 0em" margin-left="40px" margin-right="40px">
      <xsl:apply-templates/>
    </fo:block>
  </xsl:template>

  <xsl:template match="xhtml:fieldset">
    <fo:block margin="1.33em 0em">
      <xsl:apply-templates/>
    </fo:block>
  </xsl:template>

  <xsl:template match="xhtml:form">
    <fo:block margin="1.33em 0em">
      <xsl:apply-templates/>
    </fo:block>
  </xsl:template>

  <xsl:template match="xhtml:ul | xhtml:dir | xhtml:menu | xhtml:ol">
    <fo:list-block margin="1.33em 0em">
      <xsl:apply-templates/>
    </fo:list-block>
  </xsl:template>

  <xsl:template match="xhtml:ul//xhtml:ul | 
                       xhtml:ul//xhtml:ol | 
                       xhtml:ol//xhtml:ol |
                       xhtml:ol//xhtml:ul">
    <fo:list-block margin-top="0em" margin-bottom="0em">
      <xsl:apply-templates/>
    </fo:list-block>
  </xsl:template>

  <xsl:template match="xhtml:dl">
    <fo:block margin="1.33em 0em">
      <xsl:apply-templates/>
    </fo:block>
  </xsl:template>

  <xsl:template match="xhtml:dir">
    <fo:block margin-right="0" margin-left="40px">
      <xsl:apply-templates/>
    </fo:block>
  </xsl:template>

  <xsl:template match="xhtml:menu">
    <fo:block margin-right="0" margin-left="40px">
      <xsl:apply-templates/>
    </fo:block>
  </xsl:template>

  <xsl:template match="xhtml:b | xhtml:strong">
    <fo:inline font-weight="bolder">
      <xsl:apply-templates/>
    </fo:inline>
  </xsl:template>

  <xsl:template match="xhtml:i | xhtml:cite | xhtml:em | xhtml:var">
    <fo:inline font-style="italic">
      <xsl:apply-templates/>
    </fo:inline>
  </xsl:template>

  <xsl:template match="xhtml:tt | xhtml:code | xhtml:kbd | xhtml:samp">
    <fo:inline font-family="monospace">
      <xsl:apply-templates/>
    </fo:inline>
  </xsl:template>

  <xsl:template match="xhtml:pre">
    <fo:block font-family="monospace" linefeed-treatment="preserve" white-space-collapse="false">
      <xsl:apply-templates/>
    </fo:block>
  </xsl:template>

  <xsl:template match="xhtml:big">
    <fo:inline font-size="larger">
      <xsl:apply-templates/>
    </fo:inline>
  </xsl:template>

  <xsl:template match="xhtml:small">
    <fo:inline font-size="smaller">
      <xsl:apply-templates/>
    </fo:inline>
  </xsl:template>

  <xsl:template match="xhtml:sub">
    <fo:inline font-size="smaller" vertical-align="sub">
      <xsl:apply-templates/>
    </fo:inline>
  </xsl:template>

  <xsl:template match="xhtml:sup">
    <fo:inline font-size="smaller" vertical-align="super">
      <xsl:apply-templates/>
    </fo:inline>
  </xsl:template>

  <xsl:template match="xhtml:s | xhtml:strike | xhtml:del">
    <fo:inline text-decoration="line-through">
      <xsl:apply-templates/>
    </fo:inline>
  </xsl:template>

  <xsl:template match="xhtml:hr">
    <!-- this is the correct definition -->
    <fo:block border="1px inset"/>
  </xsl:template>

  <xsl:template match="xhtml:dd">
    <fo:block margin-left="40px">
      <xsl:apply-templates/>
    </fo:block>
  </xsl:template>

  <xsl:template match="xhtml:dt">
    <fo:block><xsl:apply-templates/></fo:block>
  </xsl:template>

  <xsl:template match="xhtml:img">
    <fo:external-graphic src="url('{@src}')">
      <xsl:if test="@width">
        <xsl:attribute name="content-width">
          <xsl:value-of select="@width"/><xsl:text>px</xsl:text>
        </xsl:attribute>
      </xsl:if>

      <xsl:if test="@height">
        <xsl:attribute name="content-height">
          <xsl:value-of select="@height"/><xsl:text>px</xsl:text>
        </xsl:attribute>
      </xsl:if>
    </fo:external-graphic>
  </xsl:template>

  <xsl:template match="xhtml:a">
    <xsl:choose>
      <xsl:when test="@href">
        <fo:basic-link color="blue" text-decoration="underline">
          <xsl:choose>
            <xsl:when test="starts-with(@href,'#')">
              <xsl:attribute name="internal-destination">
                <xsl:value-of select="substring-after(@href,'#')"/>
              </xsl:attribute>
            </xsl:when>
            <xsl:otherwise>
              <xsl:attribute name="external-destination">
		    <xsl:text>url('</xsl:text>
                <xsl:value-of select="@href"/>
                <xsl:text>')</xsl:text>
              </xsl:attribute>
            </xsl:otherwise>
          </xsl:choose>
          <xsl:apply-templates/>
        </fo:basic-link>
      </xsl:when>
      <xsl:otherwise>
        <fo:wrapper>
          <xsl:copy-of select="@id"/>
          <xsl:apply-templates/>
        </fo:wrapper>
      </xsl:otherwise>
    </xsl:choose>
  </xsl:template>

  <xsl:template match="xhtml:address">
    <fo:block font-style="italic">
      <xsl:apply-templates/>
    </fo:block>
  </xsl:template>

  <xsl:template match="xhtml:dir | xhtml:menu ">
    <fo:block margin-left="40px">
      <xsl:apply-templates/>
    </fo:block>
  </xsl:template>

  <xsl:template match="xhtml:u | xhtml:ins">
    <fo:inline text-decoration="underline">
      <xsl:apply-templates/>
    </fo:inline>
  </xsl:template>

  <xsl:template match="xhtml:center">
    <fo:block text-align="center">
      <xsl:apply-templates/>
    </fo:block>
  </xsl:template>

  <xsl:template match="xhtml:br">
    <fo:inline linefeed-treatment="preserve"><xsl:text>&#xA;</xsl:text></fo:inline>
  </xsl:template>

  <xsl:template match="xhtml:abbr | xhtml:acronym">
    <fo:inline font-variant="small-caps" letter-spacing="0.1em"> 
      <xsl:apply-templates/>
    </fo:inline>
  </xsl:template>

  <xsl:template match="xhtml:bdo">
    <fo:bidi-override direction="{@dir}">
      <xsl:apply-templates/>
    </fo:bidi-override>
  </xsl:template>

</xsl:stylesheet>
