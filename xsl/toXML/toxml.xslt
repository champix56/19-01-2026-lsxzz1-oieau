<?xml version="1.0" encoding="UTF-8"?>
<xsl:stylesheet version="1.0" xmlns:xsl="http://www.w3.org/1999/XSL/Transform">
	<xsl:output method="xml" version="1.0" encoding="UTF-8" indent="yes" omit-xml-declaration="no"/>
	<xsl:template match="/">
		<facturation>
			<factures>
				<xsl:apply-templates select="//facture"/>
			</factures>
		</facturation>
	</xsl:template>
	<xsl:template match="@numfacture">N° <xsl:value-of select="."/></xsl:template>
	<xsl:template match="facture[@type='devis'or@type='Devis']" priority="100000">
		<devis>un devis <xsl:apply-templates select="@numfacture"/></devis>
	</xsl:template>
	<xsl:template match="/factures/facture">
		<facture>une facture <xsl:apply-templates select="@numfacture"/></facture>
	</xsl:template>
</xsl:stylesheet>