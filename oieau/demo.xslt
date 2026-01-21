<?xml version="1.0" encoding="UTF-8"?>
<xsl:stylesheet version="1.0" xmlns:xsl="http://www.w3.org/1999/XSL/Transform">
	<xsl:output method="text" encoding="UTF-8" indent="yes"/>
	<xsl:template match="/">
		<!--<xsl:apply-templates select="LABO_DEST/Demande"/>-->
		<!--<xsl:apply-templates select="LABO_DEST/Demande/TypeDemande"/>
		<xsl:apply-templates select="LABO_DEST/Demande/contextCodification"/>-->
		<xsl:apply-templates select="LABO_DEST/Demande"/>
	</xsl:template>
	<xsl:template match="Demande">
		<!--commanditaire, prestataire-->
		<xsl:apply-templates select="TypeDemande"/>
		<xsl:apply-templates select="ContexteCodification"/>
	</xsl:template>
	<xsl:template match="TypeDemande">
		<xsl:choose>
			<xsl:when test=".&lt;=3 or .>=1">
				<xsl:message>OK pour <xsl:value-of select="name()"/></xsl:message>
			</xsl:when>
			<xsl:otherwise>E4.**/Au sein d'une demande de prélèvements,le type de prelevemesnt doit etre entre 1 et 3.#</xsl:otherwise>
		</xsl:choose>
	</xsl:template>
	<xsl:template match="*"/>
	<xsl:template match="ContexteCodification[. = 1]">
		<!--valeur adinissible mais controle plus profond-->
		<xsl:choose>
			<xsl:when test="../TypeDemande &lt; 3">E5.X.**/Au sein d'une demande de prélèvements,le Context de Codification = 1, le demande doit posseder un typeDemande &lt; 2 ;valeur de ContexteCodification=<xsl:value-of select="."/>, valeur TypeDemande=<xsl:value-of select="../TypeDemande"/>#
			</xsl:when>
		</xsl:choose>
	</xsl:template>
	<xsl:template match="ContexteCodification[. = 2]">
		<!--valeur adinissible mais controle plus profond-->
	</xsl:template>
	<xsl:template match="ContexteCodification[. &lt; 1 or . &gt; 2]">E5.1.**/Au sein d'une demande de prélèvements,le Context de Codification doit etre entre 1 et 2.;valeur du noeud <xsl:value-of select="."/>#</xsl:template>
</xsl:stylesheet>