<?xml version="1.0" encoding="ISO-8859-1"?>
<xsl:stylesheet version="1.0" xmlns:xsl="http://www.w3.org/1999/XSL/Transform">
	<xsl:output method="html" encoding="UTF-8" indent="yes"/>
	<xsl:param name="devise" select="'&#x20ac;'"/>
	<xsl:template match="/">
		<html>
			<head>
				<title>Edition en date du <xsl:value-of select="/factures/@dateeditionXML"/></title>
				<style type="text/css">
					@media print{
						.facture{
							height:287cm;
							width:20cm;
							page-break-before:always;
						}
					}
					.facture{
						
					}
					.adresse{
						width:4cm;
						height:4cm;
						border:1px solid black;
					}
					.client{
						margin-left:15cm;
						margin-bottom:1cm;
					}
					.emeteur{
						margin-bottom:1cm;
					}
					.numerofacture{
						margin-left:10%;
						margin-right:10%;
						
						text-align:center;
						font-weight:900;
						margin-bottom:1cm;
						border:1px solid black;
					}
					table{
						width:80%;
						margin-left:10%;
					}
					.right{
						text-align:right;
						padding-right:3mm;
					}
									
				</style>
			</head>
			<body>
				<h1>Liste des factures en date du <xsl:value-of select="/factures/@dateeditionXML"/></h1>
				<ul>
					<xsl:apply-templates select="//facture" mode="liste"/>
				</ul>
				<hr/>
				<xsl:apply-templates select="//facture"/>
			</body>
		</html>
	</xsl:template>
	<xsl:template match="facture" mode="liste">
		<li>
			<a href="#F{@numfacture}">factures N° <xsl:value-of select="@numfacture"/> du XXXX-XX-XX</a>
		</li>
	</xsl:template>
	<xsl:template match="facture">
		<div class="facture" id="F{@numfacture}">
			<div class="emeteur adresse">emeteur</div>
			<!--
				zone de la div client 
			-->
			<xsl:apply-templates select="@numfacture"/>
			<xsl:apply-templates select="lignes"/>
		</div>
	</xsl:template>
	<xsl:template match="client">
		<div class="client adresse">client</div>
	</xsl:template>
	<xsl:template match="@numfacture">
		<div class="numerofacture">Facture N° XX<br/><i>en date du :XXXX-XX-XX</i></div>
	</xsl:template>
	<xsl:template match="lignes">
		<table border="1" cellpadding="0" cellspacing="0">
			<thead>
				<tr>
					<th>REF</th>
					<th>Designation</th>
					<th><xsl:value-of select="$devise"/>/unit</th>
					<th>quantité</th>
					<th>sous-total</th>
				</tr>
			</thead>
			<tbody>
				<xsl:apply-templates select="ligne"/>
				<xsl:call-template name="totaux"/>
				<tr>
					<th colspan="5" style="text-align:center;font-weight:900;">Totaux de tout le fichier</th>
				</tr>
				<xsl:call-template name="totaux">
					<xsl:with-param name="nodeset" select="/factures"/>
				</xsl:call-template>
			</tbody>
		</table>
	</xsl:template>
	<xsl:template match="ligne">
		<tr>
			<xsl:apply-templates select="*"/>
		</tr>
	</xsl:template>
	<xsl:template match="ligne/*">
		<td>
			<xsl:value-of select="."/>
		</td>
	</xsl:template>
	<xsl:template match="surface" priority="1"/>
	<xsl:template name="totaux">
		<xsl:param name="nodeset" select="."/>
		<xsl:variable name="totalht" select="sum($nodeset//stotligne)"/>
		<tr>
			<td class="right" colspan="4"> Total HT :</td>
			<td><xsl:value-of select="$totalht"/> Euro</td>
		</tr>
		<tr>
			<td class="right" colspan="4"> Total TVA :</td>
			<td>XX.XX Euro</td>
		</tr>
		<tr>
			<td class="right" colspan="4"> Total TTC :</td>
			<td>XX.XX Euro</td>
		</tr>
	</xsl:template>
</xsl:stylesheet>