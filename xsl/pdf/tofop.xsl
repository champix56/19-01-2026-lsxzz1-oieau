<?xml version="1.0" encoding="UTF-8"?>
<xsl:stylesheet version="1.0" xmlns:xsl="http://www.w3.org/1999/XSL/Transform" xmlns:fo="http://www.w3.org/1999/XSL/Format">
	<xsl:output method="xml" version="1.0" indent="yes" encoding="utf-8"/>
	<xsl:attribute-set name="adresse">
		<xsl:attribute name="border">0.3mm solid black</xsl:attribute>
		<xsl:attribute name="font-style">italic</xsl:attribute>
		<xsl:attribute name="margin-bottom">1cm</xsl:attribute>
	</xsl:attribute-set>
	<xsl:attribute-set name="client">
		<xsl:attribute name="margin-left">14cm</xsl:attribute>
	</xsl:attribute-set>
	<xsl:template match="/">
		<fo:root>
			<fo:layout-master-set>
				<fo:simple-page-master master-name="A4">
					<fo:region-body/>
				</fo:simple-page-master>
			</fo:layout-master-set>
			<fo:page-sequence master-reference="A4">
				<fo:flow flow-name="xsl-region-body">
					<fo:block>
						<xsl:apply-templates select="//facture"/>
					</fo:block>
				</fo:flow>
			</fo:page-sequence>
		</fo:root>
	</xsl:template>
	<xsl:template match="facture">
		<fo:block break-after="page">
			<fo:block xsl:use-attribute-sets="adresse">destinataire</fo:block>
			<fo:block xsl:use-attribute-sets="adresse client">client</fo:block>
			<fo:block text-align="center" font-weight="900" font-size="17pt">Facture N° <xsl:value-of select="@numfacture"/></fo:block>
			<fo:table>
				<fo:table-header>
					<fo:table-row>
						<xsl:for-each select=".//ligne[1]/*">
							<fo:table-cell>
								<fo:block>
									<xsl:value-of select="name()"/>
								</fo:block>
							</fo:table-cell>
						</xsl:for-each>
					</fo:table-row>
				</fo:table-header>
				<fo:table-body>
					<xsl:for-each select=".//ligne">
						<fo:table-row>
							<xsl:for-each select="*">
								<fo:table-cell>
									<fo:block>
										<xsl:value-of select="."/>
									</fo:block>
								</fo:table-cell>
							</xsl:for-each>
						</fo:table-row>
					</xsl:for-each>
				</fo:table-body>
			</fo:table>
		</fo:block>
	</xsl:template>
</xsl:stylesheet>