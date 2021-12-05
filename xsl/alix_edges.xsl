<?xml version="1.0" encoding="UTF-8"?>
<xsl:transform version="1.0"
  xmlns:xsl="http://www.w3.org/1999/XSL/Transform"
  xmlns:tei="http://www.tei-c.org/ns/1.0"
  exclude-result-prefixes="tei"
  xmlns:exslt="http://exslt.org/common"
  extension-element-prefixes="exslt"
  >
  <xsl:output omit-xml-declaration="yes" encoding="UTF-8" method="text" indent="yes"/>
  <!-- une clé sur tous noms de personnes accrochés par les chapitres -->
  <xsl:key name="pers" match="tei:persName" use="
    concat(
      generate-id(ancestor::tei:*[@type = 'chapter'][1]),
      @key
    )
   "/>
  <xsl:variable name="lf" select="'&#10;'"/>
  <xsl:variable name="tab" select="'&#9;'"/>
  <xsl:template match="/">
    <xsl:text>Source</xsl:text>
    <xsl:value-of select="$tab"/>
    <xsl:text>Target</xsl:text>
    <xsl:value-of select="$lf"/>
    <!-- Boucler sur tous les chapitres pour en sortir les relations -->
    <xsl:for-each select=".//tei:*[@type = 'chapter']">
      <xsl:variable name="names">
        <xsl:variable name="chapid" select="generate-id()"/>
        <xsl:for-each select=".//tei:persName[generate-id() = generate-id(key('pers', concat($chapid, @key))[1])]">
          <xsl:copy-of select="."/>
        </xsl:for-each>
      </xsl:variable>
      <xsl:for-each select="exslt:node-set($names)/*">
        <xsl:variable name="source" select="@key"/>
        <xsl:for-each select="following-sibling::tei:persName">
          <xsl:value-of select="$source"/>
          <xsl:value-of select="$tab"/>
          <xsl:value-of select="@key"/>
          <xsl:value-of select="$lf"/>
        </xsl:for-each>
      </xsl:for-each>
    </xsl:for-each>
  </xsl:template>    
</xsl:transform>