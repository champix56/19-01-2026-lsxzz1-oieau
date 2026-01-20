<?xml version="1.0" encoding="UTF-8"?>
<xsl:stylesheet version="1.0" xmlns:xsl="http://www.w3.org/1999/XSL/Transform">
	<xsl:output method="xml" version="1.0" encoding="UTF-8" indent="yes"/>
	<xsl:variable name="chemin" select="'clients.xml'"/>
	<xsl:template match="/">
		<compta>
			<xsl:apply-templates select="//facture"/>
		</compta>
	</xsl:template>
	<xsl:decimal-format name="euro" decimal-separator="," grouping-separator=" " NaN="NC"/>
	<xsl:template match="facture">
		<facture>
			<xsl:apply-templates select="@*"/>
			<xsl:variable name="idc" select="@idclient"/>
			<xsl:variable name="docClient" select="document($chemin)/clients/client[@id=$idc]"/>
			<!--<xsl:variable name="docClient" select="document($chemin)/clients/client[@id=current()/@idclient]"/>-->
			<xsl:apply-templates select="$docClient"/>
			<xsl:variable name="ht" select="format-number(sum(.//stotligne),'0.00')"/>
			<xsl:variable name="tva" select="format-number($ht*0.20,'0.00')"/>
			<xsl:variable name="t" select="format-number('56846845,099','# ##0,00€','euro')"/>
			<totalht>
				<xsl:value-of select="$ht"/>
			</totalht>
			<tva>
				<xsl:value-of select="$tva"/>
			</tva>
			<ttc>
				<xsl:value-of select="$ht+$tva"/>
			</ttc>
			<value>
				<xsl:value-of select="$t"/>
			</value>
		</facture>
	</xsl:template>
	<xsl:template match="client">
		<client>
			<xsl:apply-templates select="@*"/>
			<xsl:apply-templates select="*"/>
		</client>
	</xsl:template>
	<xsl:template match="*">
		<xsl:element name="{name()}">
			<xsl:apply-templates select="@*"/>
			<xsl:apply-templates select="*|text()"/>
		</xsl:element>
	</xsl:template>
	<xsl:template match="@*">
		<xsl:attribute name="{name()}">
			<xsl:value-of select="."/>
		</xsl:attribute>
	</xsl:template>
	<xsl:template match="facture/@type">
		<xsl:attribute name="{name()}">
			<xsl:value-of select="translate(.,'FD','fd')"/>
		</xsl:attribute>
	</xsl:template>
	<xsl:template match="client/@id|client/adr2[string-length()=0]" priority="100"/>
	
</xsl:stylesheet>