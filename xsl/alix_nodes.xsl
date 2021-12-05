<?xml version="1.0" encoding="UTF-8"?>
<xsl:transform version="1.0"
  xmlns:xsl="http://www.w3.org/1999/XSL/Transform"
  xmlns:tei="http://www.tei-c.org/ns/1.0"
  exclude-result-prefixes="tei"
  >
  <xsl:output omit-xml-declaration="yes" encoding="UTF-8" method="text" indent="yes"/>
  <!-- Une clé sur tous les noms de personnes accrochés pat leur clé @key.
    On trouve toujours plus vite ses choses quand on les range. -->
  <xsl:key name="pers" match="tei:persName" use="@key"/>
  <xsl:variable name="lf" select="'&#10;'"/>
  <xsl:variable name="tab" select="'&#9;'"/>
  <xsl:template match="/">
    <xsl:text>Id</xsl:text>
    <xsl:value-of select="$tab"/>
    <xsl:text>Label</xsl:text>
    <xsl:value-of select="$tab"/>
    <xsl:text>Weight</xsl:text>
    <xsl:value-of select="$lf"/>
    <!-- Un hack XSLT1 connnu comme l’algorithme de Muenchian, assez malin et formateur, no comment, si tu comprends, tu apprends -->
    <xsl:for-each select=".//tei:persName[generate-id() = generate-id(key('pers', @key)[1])]">
      <!-- Trier en ordre de fréquence descendante -->
      <xsl:sort select="count(key('pers', @key))" data-type="number" order="descending"/>
      <xsl:value-of select="@key"/>
      <xsl:value-of select="$tab"/>
      <xsl:value-of select="@key"/>
      <xsl:value-of select="$tab"/>
      <xsl:value-of select="count(key('pers', @key))"/>
      <xsl:value-of select="$lf"/>
    </xsl:for-each>
  </xsl:template>
</xsl:transform>