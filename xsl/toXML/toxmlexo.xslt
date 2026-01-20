<?xml version="1.0" encoding="UTF-8"?>
<xsl:stylesheet version="1.0" xmlns:xsl="http://www.w3.org/1999/XSL/Transform">
	<xsl:output method="xml" version="1.0" encoding="UTF-8" indent="yes"/>
	<xsl:template match="/">
		<compta>
			<xsl:apply-templates select="//facture"/>
		</compta>
	</xsl:template>
	<xsl:decimal-format name="euro" decimal-separator="," grouping-separator=" " NaN="NC"/>
	<xsl:template match="facture">
		<facture numfacture="{@numfacture}">
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
</xsl:stylesheet>