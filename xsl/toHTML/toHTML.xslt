<?xml version="1.0" encoding="ISO-8859-1"?>
<xsl:stylesheet version="1.0" xmlns:xsl="http://www.w3.org/1999/XSL/Transform">
	<xsl:output method="html" encoding="UTF-8" indent="yes"/>
	<xsl:template match="/">
		<html>
			<head>
				<title>Edition en date du <xsl:value-of select="/factures/@dateeditionXML"/></title>
				<style type="text/css">
					.facture{
						height:287cm;
						width:20cm;
						page-break-before:always;
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
					<li>
						<a href="#F">factures N° XXXX du XXXX-XX-XX</a>
					</li>
				</ul>
				<hr/>
				<div class="facture" id="F">
					<div class="emeteur adresse">emeteur</div>
					<div class="client adresse">client</div>
					<div class="numerofacture">Facture N° XX<br/><i>en date du :XXXX-XX-XX</i></div>
					<table border="1" cellpadding="0" cellspacing="0">
						<thead>
							<tr>
								<th>REF</th>
								<th>Designation</th>
								<th>euro/unit</th>
								<th>quantité</th>
								<th>sous-total</th>
							</tr>
						</thead>
						<tbody>
							<tr>
								<td>REF</td>
								<td>Designation</td>
								<td>euro/unit</td>
								<td>quantité</td>
								<td>sous-total</td>
							</tr>
							<tr>
								<td class="right" colspan="4"> Total HT :</td>
								<td>XX.XX Euro</td>
							</tr>
							<tr>
								<td class="right" colspan="4"> Total TVA :</td>
								<td>XX.XX Euro</td>
							</tr>
							<tr>
								<td class="right" colspan="4"> Total TTC :</td>
								<td>XX.XX Euro</td>
							</tr>
						</tbody>
					</table>
				</div>
			</body>
		</html>
	</xsl:template>
</xsl:stylesheet>