<axsl:stylesheet xmlns:xx="http://xml.sandre.eaufrance.fr/scenario/labo_dest/1.1" xmlns:xsl="http://www.w3.org/1999/XSL/Transform" xmlns:xy="http://xml.sandre.eaufrance.fr/referentielsisesandre" xmlns:sa_ref="http://xml.sandre.eaufrance.fr/scenario/referentiel/2" xmlns:fn="http://www.w3.org/2006/xpath-functions" xmlns:sch="http://www.ascc.net/xml/schematron" xmlns:axsl="http://www.w3.org/1999/XSL/Transform" version="1.0">
    <axsl:output method="text" omit-xml-declaration="no" standalone="yes" indent="yes"/>
		<axsl:variable name="DateMAJ.1">2010-11-16</axsl:variable>
		<axsl:variable name="Statut.1">Gelé</axsl:variable>
		<!--affichage du code du prelevement errone pour le test E4.17-->
		<axsl:variable name="DateMAJ.2">2011-09-26 </axsl:variable>
		<axsl:variable name="Statut.2">Gelé</axsl:variable>
		<!--2011-09-26 changement des adresses de fichier de référentiel suite changement serveur -->
		<axsl:variable name="DateMAJ.3">2011-10-06</axsl:variable>
		<axsl:variable name="Statut.3">Gelé</axsl:variable>
		<!--2011-10-06 correction de détection de l'erreur E4.41-->
		<axsl:variable name="DateMAJ.4">2013-04-08</axsl:variable>
		<axsl:variable name="Statut.4">Gelé</axsl:variable>
		<!-- 2013-04-08 désactivation des règles E4.12, E4.13. E4.14, E4.17-->
		<axsl:variable name="DateMAJ.5">2013-04-09</axsl:variable>
		<axsl:variable name="Statut.5">Gelé</axsl:variable>
		<!--2013-04-09 Ajout de la règle E4.40 -->
		<axsl:variable name="DateMAJ.6">2025-09-04</axsl:variable>
		<axsl:variable name="Statut.6">Validé</axsl:variable>
		<!--2025-09-04 Mise à jour de la règle E4.31 contrôle unité uniquement si RqAna = 4 et RsAna a pour valeur 1 ou 2-->
		
	<!--<axsl:variable name="chemin">http://195.220.97.105:8080/exist/xmldb/db/sandre/Referentiels/old_referentiel.xml</axsl:variable>-->
    <axsl:variable name="DateMAJ">2025-09-04</axsl:variable>
    <axsl:variable name="cheminPAR">https://api.sandre.eaufrance.fr/referentiels/v1/PAR.xml</axsl:variable>
    <axsl:variable name="cheminSUP">https://api.sandre.eaufrance.fr/referentiels/v1/SUP.xml</axsl:variable>
    <axsl:variable name="cheminFAN">https://api.sandre.eaufrance.fr/referentiels/v1/FAN.xml</axsl:variable>
    <axsl:variable name="cheminReferentielSISESANDRE">http://xml.sandre.eaufrance.fr/exist/sandre/Referentiels/REFENTIELSISESANDRE11052009.xml</axsl:variable>
    <axsl:variable name="DateMAJReferentielSISESANDRE">document('http://xml.sandre.eaufrance.fr/exist/sandre/Referentiels/REFENTIELSISESANDRE11052009.xml')//xy:DateMAJReferentielSISESANDRE/text()</axsl:variable>
    <axsl:variable name="testFanSup">
        <axsl:for-each select="document($cheminFAN)//sa_ref:Referentiel/sa_ref:FractionAnalysee">
            <axsl:text>'</axsl:text>
            <axsl:value-of select="current()/sa_ref:CdFractionAnalysee/text()"/>
            <axsl:text>-</axsl:text>
            <axsl:value-of select="current()/sa_ref:Support/sa_ref:CdSupport/text()"/>
            <axsl:text>'</axsl:text>
            <axsl:if test="position() != last()">
                <axsl:text>, </axsl:text>
            </axsl:if>
        </axsl:for-each>
    </axsl:variable>
    
    <axsl:template match="*|@*" mode="schematron-get-full-path">
        <axsl:apply-templates select="parent::*" mode="schematron-get-full-path"/>
        <axsl:text>/</axsl:text>
        <axsl:if test="count(. | ../@*) = count(../@*)">@</axsl:if>
        <axsl:value-of select="name()"/>
        <axsl:text>[</axsl:text>
        <axsl:value-of select="1+count(preceding-sibling::*[name()=name(current())])"/>
        <axsl:text>]</axsl:text>
    </axsl:template>
    <axsl:template match="/">
        <axsl:apply-templates select="/" mode="M1"/>
    </axsl:template>
    <axsl:template match="//xx:LABO_DEST/xx:Demande//*[name()='CdIntervenant']" priority="4000" mode="M1">
        <axsl:choose>
            <axsl:when test="//xx:LABO_DEST/xx:Intervenant/xx:CdIntervenant/text()=current()"/>
            <axsl:otherwise>E4.2/Tous les intervenants mis en jeu au sein d'un fichier DOIVENT être déclarés en amont du fichier. L'intervenant dont le code est '<axsl:value-of select="text()"/>' n'est pas déclaré.#</axsl:otherwise>
        </axsl:choose>
        <axsl:apply-templates mode="M1"/>
    </axsl:template>
    <axsl:template match="//xx:LABO_DEST/xx:StationPrelevement" priority="4000" mode="M1">
        <axsl:choose>
            <axsl:when test="(not(./xx:CoordXStationPrelevement) and not(./xx:CoordYStationPrelevement) and not(./xx:ProjectStationPrelevement))or ((./xx:CoordXStationPrelevement) and (./xx:CoordYStationPrelevement) and (./xx:ProjectStationPrelevement)) "/>
            <axsl:otherwise>E4.7/Toute coordonnée géographique mentionnée pour une station de prélevement 
DOIT être accompagnée du type de projection géographique. Les coordonnées géographiques de la station '<axsl:value-of select="./xx:CdStationPrelevement/text()"/>' (<axsl:value-of select="./xx:LbStationPrelevement/text()"/>) sont incomplètes.#</axsl:otherwise>
        </axsl:choose>
        <axsl:choose>
            <axsl:when test="(not(./xx:AltitudeStationPrelevement) and not(./xx:ProjectAltiStationPrelevement)) or ((./xx:AltitudeStationPrelevement) and (./xx:ProjectAltiStationPrelevement)) "/>
            <axsl:otherwise>E4.8/Toute coordonnée altimetrique mentionnée pour une station  de prélèvement 
DOIT être accompagnée du type de projection altimétrique. Les coordonnées altimétriques de la station '<axsl:value-of select="./xx:CdStationPrelevement/text()"/>' (<axsl:value-of select="./xx:LbStationPrelevement/text()"/>) sont incomplètes.#</axsl:otherwise>
        </axsl:choose>
        <axsl:apply-templates mode="M1"/>
    </axsl:template>
    <axsl:template match="//xx:LABO_DEST/xx:StationPrelevement/xx:LocalPrelevement" priority="4000" mode="M1">
        <axsl:choose>
            <axsl:when test="(not(./xx:CoordXLocalPrelevement) and not(./xx:CoordYLocalPrelevement) and not(./xx:ProjLocalPrelevement))or ((./xx:CoordXLocalPrelevement) and (./xx:CoordYLocalPrelevement) and (./xx:ProjLocalPrelevement)) "/>
            <axsl:otherwise>E4.7/Toute coordonnée géographique mentionnée pour une localisation de prélevement 
DOIT être accompagnée du type de projection géographique. Les coordonnées géographiques de la localisation '<axsl:value-of select="./xx:CdLocalPrelevement/text()"/>' (<axsl:value-of select="./xx:LbLocalPrelevement/text()"/>) sont incomplètes.#</axsl:otherwise>
        </axsl:choose>
        <axsl:choose>
            <axsl:when test="(not(./xx:ProjAltiLocalPrelevement) and not(./xx:AltMinLocalPrelevement) and not(./xx:AltMaxLocalPrelevement)) or ((./xx:ProjAltiLocalPrelevement) and (./xx:AltMinLocalPrelevement) and (./xx:AltMaxLocalPrelevement)) "/>
            <axsl:otherwise>E4.8/Toute coordonnée altimétrique mentionnée pour une localisation  de prélevement 
DOIT être accompagnée du type de projection altimétrique. Les coordonnées altimétriques de la localisation '<axsl:value-of select="./xx:CdLocalPrelevement/text()"/>' (<axsl:value-of select="./xx:LbLocalPrelevement/text()"/>) sont incomplètes.#</axsl:otherwise>
        </axsl:choose>
        <axsl:apply-templates mode="M1"/>
    </axsl:template>
    <axsl:template match="//xx:LABO_DEST/xx:Demande/xx:DateDebutApplicationDemande" priority="4000" mode="M1">
        <axsl:variable name="AnneeDebut">
            <axsl:value-of select="substring(text(),1,4)"/>
        </axsl:variable>
        <axsl:variable name="MoisDebut">
            <axsl:value-of select="substring(text(),6,2)"/>
        </axsl:variable>
        <axsl:variable name="JourDebut">
            <axsl:value-of select="substring(text(),9,2)"/>
        </axsl:variable>
        <xsl:if test="//xx:LABO_DEST/xx:Demande/xx:DateFinApplicationDemande">
            <axsl:variable name="AnneeFin">
                <axsl:value-of select="substring(//xx:LABO_DEST/xx:Demande/xx:DateFinApplicationDemande,1,4)"/>
            </axsl:variable>
            <axsl:variable name="MoisFin">
                <axsl:value-of select="substring(//xx:LABO_DEST/xx:Demande/xx:DateFinApplicationDemande,6,2)"/>
            </axsl:variable>
            <axsl:variable name="JourFin">
                <axsl:value-of select="substring(//xx:LABO_DEST/xx:Demande/xx:DateFinApplicationDemande,9,2)"/>
            </axsl:variable>
            <axsl:choose>
                <axsl:when test="($AnneeFin&gt;$AnneeDebut) or (($AnneeFin&gt;=$AnneeDebut) and ($MoisFin&gt;$MoisDebut)) or (($AnneeFin&gt;=$AnneeDebut) and ($MoisFin&gt;=$MoisDebut) and ($JourFin&gt;$JourDebut))"/>
                <axsl:otherwise>E4.11/La date de début d'application de la demande DOIT être inferieure ou égale à la demande de fin d'application <axsl:value-of select="$AnneeDebut"/>
                    <axsl:value-of select="$MoisDebut"/>
                    <axsl:value-of select="$JourDebut"/>.#</axsl:otherwise>
            </axsl:choose>
        </xsl:if>
        <axsl:apply-templates mode="M1"/>
    </axsl:template>
    <!--<axsl:template match="//xx:LABO_DEST/xx:Demande/xx:TypeDemande[text()='3']" priority="4000" mode="M1">
        <axsl:choose>
            <axsl:when test="(//xx:LABO_DEST/xx:Demande/xx:Prestataire/xx:CdIntervenant[text()=//xx:LABO_DEST/xx:Demande/xx:Prelevement/xx:Preleveur/xx:CdIntervenant]) and (//xx:LABO_DEST/xx:Demande/xx:Prestataire/xx:CdIntervenant[text()=//xx:LABO_DEST/xx:Demande/xx:Prelevement/xx:Echantillon/xx:Laboratoire/xx:CdIntervenant])"/>
            <axsl:otherwise>E4.12/Au sein d'une demande mixte, le prestataire DOIT au moins être mentionné en tant que préleveur d'un prélevement 
et laboratoire d'un échantillon.#</axsl:otherwise>
        </axsl:choose>
        <axsl:apply-templates mode="M1"/>
    </axsl:template>
    <axsl:template match="//xx:LABO_DEST/xx:Demande/xx:TypeDemande[text()='1']" priority="4000" mode="M1">
        <axsl:choose>
            <axsl:when test="//xx:LABO_DEST/xx:Demande/xx:Prestataire/xx:CdIntervenant[text()=//xx:LABO_DEST/xx:Demande/xx:Prelevement/xx:Preleveur/xx:CdIntervenant]"/>
            <axsl:otherwise>E4.13/Au sein d'une demande de prélèvements, le prestataire DOIT au moins être mentionné en tant que préleveur d'un prélevement.#</axsl:otherwise>
        </axsl:choose>
        <axsl:apply-templates mode="M1"/>
    </axsl:template>
    <axsl:template match="//xx:LABO_DEST/xx:Demande/xx:TypeDemande[text()='2']" priority="4000" mode="M1">
        <axsl:choose>
            <axsl:when test="//xx:LABO_DEST/xx:Demande/xx:Prestataire/xx:CdIntervenant[text()=//xx:LABO_DEST/xx:Demande/xx:Prelevement/xx:Echantillon/xx:Laboratoire/xx:CdIntervenant]"/>
            <axsl:otherwise>E4.14/Au sein d'une demande d'analyses, le prestataire DOIT au moins être mentionné en tant que laboratoire d'un échantillon.#</axsl:otherwise>
        </axsl:choose>
        <axsl:apply-templates mode="M1"/>
    </axsl:template>-->
    <axsl:template match="//xx:LABO_DEST/xx:Demande/xx:Prelevement/xx:MesureEnvironnementale/xx:Parametre/xx:CdParametre" priority="4000" mode="M1">
        <!--<axsl:choose>
            <axsl:when test="./text()=document($cheminPAR)//sa_ref:Referentiel/sa_ref:Parametre[./sa_ref:ParametreEnvironnemental]/sa_ref:CdParametre"/>
            <axsl:otherwise>E4.15/Tout paramètre faisant l'objet d'une mesure environnementale DOIT etre référencé par le SANDRE comme étant un parametre de nature environnementale.
Le parametre '<axsl:value-of select="./text()"/>' n'est pas de nature environnementale.#</axsl:otherwise>
        </axsl:choose>-->
        <axsl:apply-templates mode="M1"/>
    </axsl:template>
    <axsl:template match="//xx:LABO_DEST/xx:Demande/xx:Prelevement/xx:CdPrelevement" priority="4000" mode="M1">
        <axsl:choose>
            <axsl:when test="./@schemeAgencyID=//xx:LABO_DEST/xx:Intervenant/xx:CdIntervenant/text()"/>
            <axsl:otherwise>E4.16/L'intervenant dont le code est '<axsl:value-of select="./@schemeAgencyID"/>', ayant codifié le prelevement <axsl:value-of select="text()"/> DOIT etre declare en amont du fichier d'echange.#</axsl:otherwise>
        </axsl:choose>
        <axsl:apply-templates mode="M1"/>
    </axsl:template>
    <!--<axsl:template match="//xx:LABO_DEST/xx:Demande/xx:Prelevement[./xx:StationPrelevement/xx:CdStationPrelevement/@schemeAgencyID='2']/xx:Echantillon/xx:Analyse" priority="4000" mode="M1">
        <axsl:variable name="combinaison">
            <axsl:value-of select="concat(./xx:Parametre/xx:CdParametre/text(),'-',./xx:FractionAnalysee/xx:CdFractionAnalysee/text(),'-',./xx:Methode/xx:CdMethode/text(),'-',./xx:UniteReference/xx:CdUniteReference/text())"/>
        </axsl:variable>
        <axsl:choose>
            <axsl:when test="document($cheminReferentielSISESANDRE)//xy:Combinaison/text()=$combinaison"/>
            <axsl:otherwise>E3.2/Votre fichier a trait au domaine de l'alimentation en eau potable. Pour information, la combinaison suivante de codes Sandre  '<axsl:value-of select="$combinaison"/>' (Paramètre-Fraction-Méthode-Unité) n'est pas reconnue au regard du tableau de correspondance existant entre les paramètres Sandre et ceux de SISE-EAUX, la date de dernière mise à jour de ce tableau étant le '<axsl:value-of select="document($cheminReferentielSISESANDRE)//xy:DateMAJReferentielSISESANDRE/text()"/>'.#</axsl:otherwise>
        </axsl:choose>
        <axsl:apply-templates mode="M1"/>
    </axsl:template>-->
    <!--<axsl:template match="//xx:LABO_DEST/xx:Demande/xx:Prelevement/xx:Echantillon[./xx:Laboratoire/xx:CdIntervenant/text()!=preceding-sibling::xx:Preleveur/xx:CdIntervenant/text()]" priority="4000" mode="M1">
        <axsl:choose>
            <axsl:when test="count(./xx:Analyse/xx:InsituAna[./text()='1'])='0'"/>
            <axsl:otherwise>E4.17/Lorsqu'un prélèvement donne lieu a des mesures in situ et des analyses a réaliser en laboratoire, si le préleveur est différent du laboratoire, alors les mesures in situ DOIVENT etre 
regroupées dans un échantillon distinct, dont le laboratoire destinataire correspond au préleveur. Le code du prélèvement erroné est '<axsl:value-of select="preceding-sibling::xx:CdPrelevement/text()"/>'.#</axsl:otherwise>
        </axsl:choose>
        <axsl:apply-templates mode="M1"/>
    </axsl:template>-->
    <axsl:key name="Echantillons" match="//xx:LABO_DEST/xx:Demande/xx:Prelevement" use="xx:Echantillon/xx:Laboratoire/xx:CdIntervenant/text()"/>
    <axsl:key name="Prelevements" match="//xx:LABO_DEST/xx:Demande/xx:Prelevement" use="xx:CdPrelevement/text()"/>
        <!--<axsl:template match="//xx:LABO_DEST/xx:Demande/xx:Prelevement/xx:RealisePrel='0']" priority="4000" mode="M1">
        <axsl:choose>
            <axsl:when test="(./xx:RealisePrel='0') and count(./xx:Echantillon/xx:Analyse[./xx:RqAna!=0])=0"/>
            E4.40/Un prélèvement non réalisé ne DOIT pas comporter de résultats d'analyses en laboratoire.#
        </axsl:choose>
        <axsl:apply-templates mode="M1"/>
    </axsl:template>-->
    <axsl:template match="//xx:LABO_DEST/xx:Demande/xx:Prelevement" priority="4000" mode="M1">
        <axsl:variable name="Support" select="./xx:Support/xx:CdSupport/text()"/>
        <xsl:variable name="DatePrel" select="number(translate(./xx:DatePrel, '-', ''))"/>
        <axsl:for-each select="./xx:Echantillon/xx:Analyse"> 
            <axsl:variable name="valueTestFanSup">
                <axsl:text>'</axsl:text>
                <axsl:value-of select="current()/xx:FractionAnalysee/xx:CdFractionAnalysee/text()"/>
                <axsl:text>-</axsl:text>
                <axsl:value-of select="$Support"/>
                <axsl:text>'</axsl:text>
            </axsl:variable>
            <xsl:choose>
                <xsl:when test="contains($testFanSup, $valueTestFanSup)"/>
                <axsl:otherwise>E4.150/La fraction analysée '<axsl:value-of select="./xx:FractionAnalysee/xx:CdFractionAnalysee"/>' (<axsl:value-of select="document($cheminFAN)/sa_ref:REFERENTIELS/sa_ref:Referentiel/sa_ref:FractionAnalysee[./sa_ref:CdFractionAnalysee/text() = current()/xx:FractionAnalysee/xx:CdFractionAnalysee/text()]/sa_ref:LbFractionAnalysee"/>) associée à une analyse est incohérente par rapport au support prélevé
                    '<axsl:value-of select="$Support"/>' (<axsl:value-of select="document($cheminSUP)/sa_ref:REFERENTIELS/sa_ref:Referentiel/sa_ref:Support[./sa_ref:CdSupport/text() = $Support]/sa_ref:LbSupport"/>) .Erreur sur une analyse portant sur le '.# </axsl:otherwise>
            </xsl:choose>
            <xsl:variable name="DateAna" select="number(translate(./xx:DateAna/text(), '-', ''))"/>
            <xsl:choose>
                <xsl:when test="not(./xx:DateAna) or ($DateAna &gt;= $DatePrel)"/>
                <axsl:otherwise>E4.112/Toute date d’analyse faisant suite à un prélèvement donné
                    DOIT être supérieure ou égale à la date de ce même prélèvement. L'analyse
                    réalisée le '<axsl:value-of select="./xx:DateAna"/>' ayant porté sur le
                    paramètre '<axsl:value-of select="./xx:Parametre/xx:CdParametre"/>' a été
                    réalisée à une date antérieure au prélèvement du '<axsl:value-of select="ancestor::xx:Prelevement/xx:DatePrel"/>''.#</axsl:otherwise>
            </xsl:choose>
            
            
        </axsl:for-each>
        <axsl:choose>
            <axsl:when test="(./xx:RealisePrel='0') and count(./xx:Echantillon/xx:Analyse[(./xx:RqAna/text()!=0) and (./xx:InsituAna=2)])!=0">
            E4.40/Un prélèvement non réalisé ne DOIT pas comporter de résultats d'analyses en laboratoire. Le prélèvement erroné est '<axsl:value-of select="./xx:CdPrelevement"/>' .#
            </axsl:when>
        </axsl:choose>
        <axsl:choose>
            <axsl:when test="count(./xx:Echantillon[./xx:Laboratoire/xx:CdIntervenant/text()=preceding-sibling::xx:Echantillon/xx:Laboratoire/xx:CdIntervenant]/xx:Laboratoire/xx:CdIntervenant/text())=0"/>
            <axsl:otherwise>E4.19/Pour un prélèvement donné, il ne DOIT pas y avoir plus d'un échantillon adressé au meme laboratoire. Le prélevement erroné est celui réalisé sur la station '
			<axsl:value-of select="./xx:StationPrelevement/xx:CdStationPrelevement"/>' en date du '<axsl:value-of select="./xx:DatePrel"/>', et portant sur le support '<axsl:value-of select="./xx:Support/xx:CdSupport"/>' (<axsl:value-of select="document($cheminSUP)//sa_ref:Referentiel/sa_ref:Support[./sa_ref:CdSupport/text()=current()/xx:Support/xx:CdSupport]/sa_ref:LbSupport"/>).#</axsl:otherwise>
        </axsl:choose>
        <axsl:apply-templates mode="M1"/>
    </axsl:template>
    <axsl:template match="//xx:LABO_DEST/xx:Demande/xx:Prelevement/xx:Echantillon/xx:Analyse[./xx:RqAna/text()='4']" priority="4000" mode="M1">
        <axsl:choose>
 <axsl:when test="((document($cheminPAR)//sa_ref:Referentiel/sa_ref:Parametre[./sa_ref:CdParametre/text()=current()/xx:Parametre/xx:CdParametre/text()]/sa_ref:ParametreMicrobiologique) or (document($cheminPAR)//sa_ref:Referentiel/sa_ref:Parametre[./sa_ref:CdParametre/text()=current()/xx:Parametre/xx:CdParametre/text()]/sa_ref:ParametreChimique)) and ((
  current()/xx:RsAna/text()='0'
  or
  ((current()/xx:RsAna/text()='1' or current()/xx:RsAna/text()='2')
     and current()/xx:UniteReference/xx:CdUniteReference='X')
)
)"/>
            <axsl:otherwise>E4.31/Erreur au niveau du résultat du paramètre '<axsl:value-of select="./xx:Parametre/xx:CdParametre"/>' ('<axsl:value-of select="document($cheminPAR)//sa_ref:Referentiel/sa_ref:Parametre[./sa_ref:CdParametre/text()=current()/xx:Parametre/xx:CdParametre/text()]/sa_ref:NomParametre"/>'). Le code remarque 4 est utilisé dans les cas suivants :
    En présence d'éléments, sans qu’il soit requis de les quantifier, le résultat prend la valeur 1.
    En absence d'éléments, le résultat prend la valeur 2. Pour ces deux valeurs le code de l'unité de mesure associé au résultat du paramètre DOIT prendre pour valeur 'X' (sans objet).
    Lorsque les conditions de mesure ou les limitations de la méthode ne permettent ni de confirmer la présence ni d’affirmer l’absence, le résultat prend la valeur 0 (Non quantifié ou non détecté). C’est par exemple le cas lorsqu’un résultat correspond à la somme d’analytes, chacun étant individuellement soit indétectable, soit inquantifiable.
.#</axsl:otherwise>
        </axsl:choose>
        <axsl:apply-templates mode="M1"/>
    </axsl:template>
    <axsl:template match="//xx:LABO_DEST/xx:Demande/xx:Prelevement/xx:Echantillon/xx:Analyse[./xx:RqAna/text()=0]" priority="4000" mode="M1">
        <axsl:choose>
            <axsl:when test="string-length(./xx:RsAna/text())=0"/>
            <axsl:otherwise>E4.32/Erreur au niveau de l'analyse portant sur le paramètre '<axsl:value-of select="./xx:Parametre/xx:CdParametre"/>'. Celle-ci n'a pas été réalisée (code remarque associé égal à 0), et le résultat d'analyse est pourtant différent d'une valeur nulle.#</axsl:otherwise>
        </axsl:choose>
        <axsl:apply-templates mode="M1"/>
    </axsl:template>
    <axsl:template match="//xx:LABO_DEST/xx:Demande/xx:Prelevement/xx:Echantillon/xx:Analyse[./xx:RqAna/text()=0]" priority="4000" mode="M1">
        <axsl:choose>
            <axsl:when test="string-length(./xx:RsAna/text())=0"/>
            <axsl:otherwise>E4.32/Erreur au niveau de l'analyse portant sur le paramètre '<axsl:value-of select="./xx:Parametre/xx:CdParametre"/>'. Celle-ci n'a pas été réalisée (code remarque associé égal à 0), et le résultat d'analyse est pourtant différent d'une valeur nulle.#</axsl:otherwise>
        </axsl:choose>
        <axsl:apply-templates mode="M1"/>
    </axsl:template>
    <axsl:template match="//xx:LABO_DEST/xx:Demande/xx:Prelevement/xx:Echantillon/xx:Analyse[./xx:RqAna/text()=5]" priority="3" mode="M1">
        <axsl:choose>
            <axsl:when test="string-length(./xx:RsAna/text())=0"/>
            <axsl:otherwise>E4.33/Erreur au niveau de l'analyse portant sur le paramètre '<axsl:value-of select="./xx:Parametre/xx:CdParametre"/>'. Le résultat est incomptable (code remarque associé égal à 5), et celui-ci ('<axsl:value-of select="./xx:RsAna"/>') est pourtant différent d'une valeur nulle.#</axsl:otherwise>
        </axsl:choose>
        <axsl:apply-templates mode="M1"/>
    </axsl:template>
    <axsl:template match="//xx:LABO_DEST/xx:Demande/xx:Prelevement/xx:Echantillon/xx:Analyse[./xx:RqAna/text()=10]" priority="4001" mode="M1">
        <axsl:choose>
            <axsl:when test="(./xx:LQAna and ./xx:RsAna/text()=./xx:LQAna/text()) or not(./xx:LQAna)"/>
            <axsl:otherwise>A4.23/Avertissement au niveau de l'analyse portant sur le paramètre '<axsl:value-of select="./xx:Parametre/xx:CdParametre"/>'. Le résultat d'analyse DOIT être égal à la limite de quantification lorsque le code remarque est égal à 10. Or, le résultat est égal à <axsl:value-of select="./xx:RsAna/text()"/> et la limite de quantification est égale à <axsl:value-of select="./xx:LQAna/text()"/>.#
            </axsl:otherwise>
        </axsl:choose>
        <axsl:apply-templates mode="M1"/>
    </axsl:template>
    <axsl:template match="//xx:LABO_DEST/xx:Demande/xx:Prelevement/xx:Echantillon/xx:Analyse[./xx:RqAna/text()=6]" priority="4000" mode="M1">
        <axsl:choose>
            <axsl:when test="string-length(./xx:RsAna/text())=0"/>
            <axsl:otherwise>E4.35/Erreur au niveau de l'analyse portant sur le paramètre '<axsl:value-of select="./xx:Parametre/xx:CdParametre"/>'. Les taxons ne sont pas individualisables (code remarque associé égal à 6), et le résultat d'analyse ('<axsl:value-of select="./xx:RsAna"/>') est pourtant différent d'une valeur nulle. Il est recommandé d'utiliser le code remarque 8 (dénombrement &gt;résultat).#</axsl:otherwise>
        </axsl:choose>
        <axsl:choose>
            <axsl:when test="document($cheminPAR)//sa_ref:Referentiel/sa_ref:Parametre[./sa_ref:CdParametre/text()=current()/xx:Parametre/xx:CdParametre/text()][./sa_ref:ParametreMicrobiologique]"/>
            <axsl:otherwise>E4.36/Erreur au niveau du résultat du paramètre '<axsl:value-of select="./xx:Parametre/xx:CdParametre"/>' ('<axsl:value-of select="document($cheminPAR)//sa_ref:Referentiel/sa_ref:Parametre[./sa_ref:CdParametre/text()=current()/xx:Parametre/xx:CdParametre/text()]/sa_ref:NomParametre"/>'). Le code remarque 6 (taxons non individualisables) est réservé aux résultats de paramètre hydrobiologique.
 .#</axsl:otherwise>
        </axsl:choose>
        <axsl:apply-templates mode="M1"/>
    </axsl:template>
    <axsl:template match="//xx:LABO_DEST/xx:Demande/xx:Prelevement/xx:Echantillon/xx:Analyse[(./xx:RqAna/text()='8') or (./xx:RqAna/text()='9')]" priority="1" mode="M1">
        <axsl:choose>
            <axsl:when test="document($cheminPAR)//sa_ref:Referentiel/sa_ref:Parametre[./sa_ref:CdParametre/text()=current()/xx:Parametre/xx:CdParametre/text()][(./sa_ref:ParametreMicrobiologique) or (./sa_ref:ParametreHydrobiologique)]"/>
            <axsl:otherwise>E4.37/Erreur au niveau du résultat du paramètre '<axsl:value-of select="./xx:Parametre/xx:CdParametre"/>' ('<axsl:value-of select="document($cheminPAR)//sa_ref:Referentiel/sa_ref:Parametre[./sa_ref:CdParametre/text()=current()/xx:Parametre/xx:CdParametre/text()]/sa_ref:NomParametre"/>'). Les codes remarque 8 (Dénombrement&gt;valeur) et 9 (Dénombrement&lt;valeur) sont réservés au résultat de paramètre microbiologique ou hydrobiologique.
 .#</axsl:otherwise>
        </axsl:choose>
        <axsl:apply-templates mode="M1"/>
    </axsl:template>
    <axsl:template match="//xx:LABO_DEST/xx:Demande/xx:Prelevement/xx:Echantillon/xx:Analyse[(./xx:RqAna/text()='2') or (./xx:RqAna/text()='3') or (./xx:RqAna/text()='7') or (./xx:RqAna/text()='10')]" priority="4000" mode="M1">
        <axsl:choose>
            <axsl:when test="document($cheminPAR)//sa_ref:Referentiel/sa_ref:Parametre[./sa_ref:CdParametre/text()=current()/xx:Parametre/xx:CdParametre/text()][(./sa_ref:ParametreChimique) or (./sa_ref:ParametrePhysique) ]"/>
            <axsl:otherwise>E4.38/Erreur au niveau du résultat du paramètre '<axsl:value-of select="./xx:Parametre/xx:CdParametre"/>' ('<axsl:value-of select="document($cheminPAR)//sa_ref:Referentiel/sa_ref:Parametre[./sa_ref:CdParametre/text()=current()/xx:Parametre/xx:CdParametre/text()]/sa_ref:NomParametre"/>'). Les codes remarque '2' (&lt;seuil de détection), '3' (&lt;seuil de saturation), '7' (traces, LD&lt;resultat&lt;LQ) et '10' (&lt; seuil de quantification) sont réservés aux résultats de paramètre chimique.
 #</axsl:otherwise>
        </axsl:choose>
        <axsl:apply-templates mode="M1"/>
    </axsl:template>
    <axsl:template match="//xx:LABO_DEST/xx:Demande/xx:Prelevement/xx:Echantillon/xx:Analyse" priority="2" mode="M1">
        <axsl:choose>
            <axsl:when test="not(document($cheminPAR)//sa_ref:Referentiel/sa_ref:Parametre[./sa_ref:CdParametre/text()=current()/xx:Parametre/xx:CdParametre/text()]/sa_ref:ValeursPossiblesParametre) or not(document($cheminPAR)//sa_ref:Referentiel/sa_ref:Parametre[./sa_ref:CdParametre/text()=current()/xx:Parametre/xx:CdParametre/text()])  or (document($cheminPAR)//sa_ref:Referentiel/sa_ref:Parametre[not(./sa_ref:ParametreMicrobiologique) and (./sa_ref:CdParametre/text()=current()/xx:Parametre/xx:CdParametre/text())]/sa_ref:ValeursPossiblesParametre/sa_ref:CdValeursPossiblesParametre/text()=current()/xx:RsAna/text()) or (document($cheminPAR)//sa_ref:Referentiel/sa_ref:Parametre[(./sa_ref:ParametreMicrobiologique) and (./sa_ref:CdParametre/text()=current()/xx:Parametre/xx:CdParametre/text())])"/>
            <axsl:otherwise>E4.39/Erreur au niveau du résultat d'analyse portant sur le paramètre '<axsl:value-of select="./xx:Parametre/xx:CdParametre"/>' ('<axsl:value-of select="document($cheminPAR)//sa_ref:Referentiel/sa_ref:Parametre[./sa_ref:CdParametre/text()=current()/xx:Parametre/xx:CdParametre/text()]/sa_ref:NomParametre"/>'). La valeur du résultat '<axsl:value-of select="./xx:RsAna"/>' est inconnue. Les codes de valeurs possibles pour le résultat d'une analyse portant sur le paramètre '<axsl:value-of select="./xx:Parametre/xx:CdParametre"/>' sont <axsl:for-each select="document($cheminPAR)//sa_ref:Referentiel/sa_ref:Parametre[./sa_ref:CdParametre/text()=current()/xx:Parametre/xx:CdParametre/text()]/sa_ref:ValeursPossiblesParametre">'<axsl:value-of select="./sa_ref:CdValeursPossiblesParametre/text()"/>' ('<axsl:value-of select="./sa_ref:LbValeursPossiblesParametre/text()"/>');</axsl:for-each>
.#</axsl:otherwise>
        </axsl:choose>
        <axsl:apply-templates mode="M1"/>
    </axsl:template>
    <axsl:template match="//xx:LABO_DEST/xx:Demande/xx:ContexteCodification[./text()='1']" priority="4000" mode="M1">
        <axsl:choose>
            <axsl:when test="count(//xx:LABO_DEST/xx:Demande/xx:Prelevement[./xx:CdPrelevement/text()=preceding-sibling::xx:Prelevement/xx:CdPrelevement/text()])=0"/>
			<!--<axsl:when test="count(key('Prelevements',./xx:CdPrelevement))='1'"/>-->
            <axsl:otherwise>E4.29/Plusieurs prélèvements ont le même code '<axsl:value-of select="//xx:LABO_DEST/xx:Demande/xx:Prelevement[./xx:CdPrelevement/text()=preceding-sibling::xx:Prelevement/xx:CdPrelevement/text()]/xx:CdPrelevement/text()"/>'. Le code d'un prélèvement DOIT être unique.#</axsl:otherwise>
        </axsl:choose>
        <axsl:choose>
            <axsl:when test="string-length(//xx:LABO_DEST/xx:Demande/xx:CdDemandeCommanditaire/text())&gt;0"/>
            <axsl:otherwise>E4.40/Erreur au niveau du code de la demande qui est absent. Dans le contexte d'échange relatif à un envoi de résultats avec demande de prestations reçue au préalable, la demande en elle-même et chaque prélèvement doivent avoir un identifiant, correspondant à ceux mentionnés dans la demande.#</axsl:otherwise>
        </axsl:choose>
        <axsl:choose>
            <axsl:when test="count(./xx:Prelevement[not(./xx:CdPrelevement) or not(./xx:NumeroOrdrePrelevement) or string-length(./xx:NumeroOrdrePrelevement/text())=0])=0"/>
            <axsl:otherwise>E4.41/ Erreur au niveau d'un identifiant de prélèvement qui est absent ou incomplet. Dans le contexte d'échange relatif à un envoi de résultats avec demande de prestations reçue au préalable, la demande en elle-même et chaque prélèvement doivent avoir un identifiant, correspondant à ceux mentionnés dans la demande. L'identifiant du prélèvement est composé de deux informations: un code et un numéro d'ordre.#</axsl:otherwise>
        </axsl:choose>
        <axsl:apply-templates mode="M1"/>
    </axsl:template>
    <axsl:template match="//xx:LABO_DEST/xx:Demande/xx:ContexteCodification[text()='2']" priority="4000" mode="M1">
        <axsl:choose>
            <axsl:when test="not(//xx:CdDemandeCommanditaire)"/>
            <axsl:otherwise>E4.42/Erreur au niveau du code de la demande qui est anormalement présent. Dans le contexte d'échange relatif à un envoi de résultats sans demande de prestations reçue au préalable, la demande en elle-même et chaque prélèvement ne doivent avoir d'identifiants.#</axsl:otherwise>
        </axsl:choose>
        <axsl:choose>
            <axsl:when test="not(//xx:CdPrelevement) or not(//xx:NumeroOrdrePrelevement)"/>
            <axsl:otherwise>E4.43/Erreur au niveau d'un identifiant de prélèvement  '<axsl:value-of select="text()"/>' qui est anormalement présent. Dans le contexte d'échange relatif à un envoi de résultats sans demande de prestations reçue au préalable, la demande en elle-même et chaque prélèvement ne doivent pas avoir d'identifiants.#</axsl:otherwise>
        </axsl:choose>
        <axsl:apply-templates mode="M1"/>
    </axsl:template>
    
    <!-- start règles RSDE -->
    <axsl:template match="//xx:LABO_DEST/xx:Demande/xx:Prelevement/xx:Echantillon/xx:Analyse" priority="2" mode="M1">
        <axsl:variable name="Finalite" select="../../xx:FinalitePrel/text()"/>
        <axsl:variable name="Par" select="./xx:Parametre/xx:CdParametre/text()"/>
        <axsl:variable name="Met" select="./xx:Methode/xx:CdMethode/text()"/>
        <axsl:variable name="DatePrel" select="../../xx:DatePrel/text()"/>
        <axsl:variable name="Localisation" select="../../xx:StationPrelevement/xx:CdStationPrelevement/text()"/>
        <axsl:variable name="FractionAnalysee" select="./xx:FractionAnalysee/xx:CdFractionAnalysee/text()"/>
        <axsl:variable name="DateAna" select="./xx:DateAna/text()"/>
        
        <!--49-->
        <axsl:choose>
            <axsl:when test="not(exists($Finalite)) or $Finalite != '11' or ./xx:Parametre/xx:CdParametre/text() = '1552' or ($Finalite = '11' and ./xx:Parametre/xx:CdParametre != '1552' and ./xx:InsituAna != '1')"/>
            <axsl:otherwise>A4.49/ Les analyses ayant pour finalité '11' (RSDE) DOIVENT être effectuée en laboratoire. Erreur détectée sur le paramètre '<axsl:value-of select="./xx:Parametre/xx:CdParametre"/>' au niveau du point de localisation '<axsl:value-of select="$Localisation"/>' lors du prélèvement en date du '<axsl:value-of select="$DatePrel"/>'.#
            </axsl:otherwise>
        </axsl:choose>
        
        <!--<axsl:choose>
            <axsl:when test="./xx:StatutRsAnalyse='A' and ./xx:QualRsAnalyse='4'"/>
            <axsl:otherwise>A4.50/ Le statut des analyses ayant pour finalité '11' (RSDE) DOIT être égal à 'A' et la qualification à '4'. Erreur détectée sur le paramètre '<axsl:value-of select="./xx:Parametre/xx:CdParametre"/>' au niveau du point de localisation '<axsl:value-of select="ancestor::xx:PointMesure/xx:LocGlobalePointMesure"/>' lors du prélèvement en date du '<axsl:value-of select="ancestor::xx:PointMesure/xx:Prlvt/xx:DatePrlvt"/>'.#
         </axsl:otherwise>
        </axsl:choose>-->
        
        <!--72-->
        <axsl:variable name="testPar">
            <xsl:for-each select="ancestor::xx:Prelevement/xx:Echantillon/xx:Analyse/xx:Parametre/xx:CdParametre">
                <xsl:text>'</xsl:text>
                <xsl:value-of select="./text()"/>
                <xsl:if test="position() != last()">
                    <xsl:text>, </xsl:text>
                </xsl:if>
            </xsl:for-each>
        </axsl:variable>
        <xsl:choose>
            <xsl:when test="not(exists($Finalite)) or $Finalite != '11' or ($Finalite = '11' and contains($testPar, '1552'))"/>
            <xsl:otherwise>A4.72/ Pour les prélèvements sur lesquels des analyses ayant pour
                finalité '11' (RSDE) sont réalisées, le débit moyen journalier DOIT être mesuré.
                Erreur détectée au niveau du point de localisation '<axsl:value-of select="$Localisation"/>' lors du
                prélèvement en date du '<axsl:value-of select="$DatePrel"/>'.#</xsl:otherwise>
        </xsl:choose>
        
        <!--74-->
        <xsl:choose>
            <axsl:when test="not(exists($Finalite)) or $Finalite != '11' or ($Finalite = '11' and $Par != '1305' and $Par != '1313' and $Par != '1314' and $Par != '6396' and $Par != '1841') or ($Finalite = '11' and (concat($Par, '-', $Met) = '1305-610' or concat($Par, '-', $Met) = '1305-317' or concat($Par, '-', $Met) = '1313-316' or concat($Par, '-', $Met) = '1313-315' or concat($Par, '-', $Met) = '1314-381' or concat($Par, '-', $Met) = '1314-368' or concat($Par, '-', $Met) = '6396-368' or concat($Par, '-', $Met) = '1841-274'))"/>
            <axsl:otherwise>A4.74/ Pour les analyses ayant pour finalité 11 (RSDE) et portant sur
                les paramètres 1305 1313 1314 6396 1841, les méthodes d'analyses DOIVENT
                correspondre à des méthodes spécifiées dans l'arrêté et correspondant aux couples
                possibles suivants:1305-610, 1305-317, 1313-316, 1313-315, 1314-381, 1314-368, 6396-368,
                1841-274. Erreur détectée sur la méthode d'analyse du paramètre '<xsl:value-of select="./xx:Parametre/xx:CdParametre"/>' au niveau du point de localisation
                '<axsl:value-of select="$Localisation"/>'
                lors du prélèvement en date du '<axsl:value-of select="$DatePrel"/>'.# </axsl:otherwise>
        </xsl:choose>
        
        <!--75-->
        <xsl:choose>
            <axsl:when test="not(exists($Finalite)) or $Finalite != '11' or ($Finalite = '11' and ./xx:Parametre/xx:CdParametre != '1305' and ./xx:Parametre/xx:CdParametre != '1313' and ./xx:Parametre/xx:CdParametre != '1314' and ./xx:Parametre/xx:CdParametre != '6396' and ./xx:Parametre/xx:CdParametre != '1841') or (./xx:AgreAna = '1' and $Finalite = '11' and (./xx:Parametre/xx:CdParametre = '1305' or ./xx:Parametre/xx:CdParametre = '1313' or ./xx:Parametre/xx:CdParametre = '1314' or ./xx:Parametre/xx:CdParametre = '6396' or ./xx:Parametre/xx:CdParametre = '1841'))"/>
            <axsl:otherwise>A4.75/ Les analyses ayant pour finalité '11' (RSDE) et portant sur les
                paramètres 1305, 1313, 1314, 6396, 1841 DOIVENT être réalisées sous agrément. Avertissement
                détecté au niveau du point de localisation '<axsl:value-of select="$Localisation"/>' lors du
                    prélèvement en date du '<axsl:value-of select="$DatePrel"/>',
                l'analyse portant sur le paramètre '<xsl:value-of select="./xx:Parametre/xx:CdParametre"/>'.# </axsl:otherwise>
        </xsl:choose>
        
        <!--76-->
        <xsl:choose>
            <axsl:when test="not(exists($Finalite)) or $Finalite != '11' or ($Finalite = '11' and $Par != '1305' and $Par != '1313' and $Par != '1314' and $Par != '6396' and $Par != '1841') or ($Finalite = '11' and (concat($Par, '-', $Met) = '1305-610' or concat($Par, '-', $Met) = '1305-317' or concat($Par, '-', $Met) = '1313-316' or concat($Par, '-', $Met) = '1313-315' or concat($Par, '-', $Met) = '1314-381' or concat($Par, '-', $Met) = '1314-368' or concat($Par, '-', $Met) = '6396-368' or concat($Par, '-', $Met) = '1841-274'))"/>
            <axsl:otherwise>A4.76/ Pour les analyses ayant pour finalité 11 (RSDE) et portant sur
                les paramètres 1305 1313 1314 6396 1841, les méthodes d'analyses DOIVENT
                correspondre à des méthodes spécifiées dans l'arrêté et correspondant aux couples
                possibles suivants:1305-610, 1305-317, 1313-316, 1313-315, 1314-381, 1314-368, 6396-368,
                1841-274. Erreur détectée sur la méthode d'analyse du paramètre '<xsl:value-of select="./xx:Parametre/xx:CdParametre"/>' au niveau du point de localisation
                '<axsl:value-of select="$Localisation"/>'
                lors du prélèvement en date du '<axsl:value-of select="$DatePrel"/>'.# </axsl:otherwise>
        </xsl:choose>
        
        <!--77-->
        <xsl:choose>
            <axsl:when test="not(exists($Finalite)) or $Finalite != '11' or ($Finalite = '11' and ./xx:Parametre/xx:CdParametre != '1955') or ($Finalite = '11' and (./xx:Parametre/xx:CdParametre = '1955' and (./xx:Methode/xx:CdMethode = '1066' or ./xx:Methode/xx:CdMethode = '1479')))"/>
            <axsl:otherwise>A4.77/ Les analyses ayant pour finalité '11' (RSDE) et portant sur le
                paramètre 1955 DOIVENT être réalisées selon la méthode d'analyse dont le code
                sandre est '1066' ou '1479'. Erreur détectée au niveau du point de localisation '<axsl:value-of select="$Localisation"/>' lors du
                prélèvement en date du '<axsl:value-of select="$DatePrel"/>',
                l'analyse portant sur le paramètre '<xsl:value-of select="./xx:Parametre/xx:CdParametre"/>'.# </axsl:otherwise>
        </xsl:choose>
        
        <!--78-->
        <xsl:choose>
            <axsl:when test="not(exists($Finalite)) or $Finalite != '11' or ($Finalite = '11' and ./xx:IncertAna/text() &lt; 100)"/>
            <axsl:otherwise>A4.78/Pour les analyses ayant pour finalité 11 (RSDE), l'incertitude
                DOIT être exprimée en pourcentage. Les références de l'analyse, dont l'incertitude
                est incorrecte sont: code du prélèvement '<xsl:value-of select="../../LocalPrelevement/CdLocalPrelevement/text()"/>' fournit par '<xsl:value-of select="../../LocalPrelevement/CdLocalPrelevement/@schemeAgencyID"/>'; Date
                du prélèvement: '<xsl:value-of select="$DatePrel"/>' ;
                code Sandre du paramètre '<xsl:value-of select="./xx:Parametre/xx:CdParametre"/>'.#</axsl:otherwise>
        </xsl:choose>
        
        <!--79-->
        <xsl:choose>
            <axsl:when test="not(exists($Finalite)) or $Finalite != '11' or ($Finalite = '11' and ./xx:Parametre/xx:CdParametre != '1369' and ./xx:Parametre/xx:CdParametre != '1388' and ./xx:Parametre/xx:CdParametre != '1389' and ./xx:Parametre/xx:CdParametre != '1379' and ./xx:Parametre/xx:CdParametre != '1392' and ./xx:Parametre/xx:CdParametre != '1386' and ./xx:Parametre/xx:CdParametre != '1382' and ./xx:Parametre/xx:CdParametre != '1373' and ./xx:Parametre/xx:CdParametre != '1383' and ./xx:Parametre/xx:CdParametre != '1368' and ./xx:Parametre/xx:CdParametre != '2555') or ($Finalite = '11' and (concat($Par, '-', $Met) = '1369-715' or concat($Par, '-', $Met) = '1388-715' or concat($Par, '-', $Met) = '1389-715' or concat($Par, '-', $Met) = '1379-715' or concat($Par, '-', $Met) = '1392-715' or concat($Par, '-', $Met) = '1386-715' or concat($Par, '-', $Met) = '1382-715' or concat($Par, '-', $Met) = '1373-715' or concat($Par, '-', $Met) = '1383-715' or concat($Par, '-', $Met) = '1368-715' or concat($Par, '-', $Met) = '2555-715'))"/>
            <axsl:otherwise>A4.79/ Pour les analyses ayant pour finalité 11 (RSDE), la méthode
                d'analyse dont le code Sandre est 715 DOIT être utilisée pour l’analyse des métaux
                suivants : Cadmium, Plomb, Nickel, Arsenic, Zinc, Cuivre, Chrome, Cobalt, Titane, Argent et Thallium.
                Erreur détectée au niveau du point de localisation '<xsl:value-of select="$Localisation"/>' lors du
                prélèvement en date du '<xsl:value-of select="$DatePrel"/>',
                l'analyse portant sur le paramètre '<xsl:value-of select="./xx:Parametre/xx:CdParametre"/>'.# </axsl:otherwise>
        </xsl:choose>
        
        <!--47 a-->
        <xsl:choose>
            <axsl:when test="not(exists($Finalite)) or $Finalite != '11' or ($Finalite = '11' and ./xx:DateAna != '')"/>
            <axsl:otherwise>E4.47/ Les analyses ayant pour finalité '11' (RSDE) DOIVENT être
                accompagnées d'une date d'analyse. Erreur détectée sur le paramètre '<xsl:value-of select="./xx:Parametre/xx:CdParametre"/>' au niveau du point de localisation
                '<xsl:value-of select="$Localisation"/>'
                lors du prélèvement en date du '<xsl:value-of select="$DatePrel"/>'.# </axsl:otherwise>
        </xsl:choose>
        
        <!--47 b-->
        <xsl:choose>
            <axsl:when test="not(exists($Finalite)) or $Finalite != '11' or ($Finalite = '11' and ./xx:DateAna and ./xx:Parametre/xx:CdParametre != '1552' or ./xx:Parametre/xx:CdParametre = '1552' or ./xx:InSituAna = '1')"/>
            <axsl:otherwise>E4.47/ La date d'une analyse ayant pour finalité '11' (RSDE) DOIT être
                renseignée. Erreur détectée sur le paramètre '<xsl:value-of select="./xx:Parametre/xx:CdParametre"/>' au niveau du point de localisation
                '<xsl:value-of select="$Localisation"/>'
                lors du prélèvement en date du '<xsl:value-of select="$DatePrel"/>'.# </axsl:otherwise>
        </xsl:choose>
      
        <!--48-->
        <xsl:choose>
            <axsl:when test="not(exists($Finalite)) or $Finalite != '11' or ($Finalite = '11' and (./xx:RqAna = '1' or ./xx:RqAna = '0' or ./xx:RqAna = '10'))"/>
            <axsl:otherwise>E4.48/ Le code remarque des analyses ayant pour finalité '11' (RSDE)
                DOIT être égal à '0', '1' ou '10'. Erreur détectée sur le paramètre '<xsl:value-of select="./xx:Parametre/xx:CdParametre"/>' au niveau du point de localisation
                '<xsl:value-of select="$Localisation"/>'
                lors du prélèvement en date du '<xsl:value-of select="$DatePrel"/>'.# </axsl:otherwise>
        </xsl:choose>
        
        <!--51-->
        <xsl:choose>
            <axsl:when test="not(exists($Finalite)) or $Finalite != '11' or ($Finalite = '11' and ./xx:Methode)"/>
            <axsl:otherwise>E4.51/ La méthode d'analyse pour une analyse ayant pour finalité '11'
                (RSDE) DOIT être renseignée. Erreur détectée sur le paramètre '<xsl:value-of select="./xx:Parametre/xx:CdParametre"/>' au niveau du point de localisation
                '<xsl:value-of select="$Localisation"/>'
                lors du prélèvement en date du '<xsl:value-of select="$DatePrel"/>'.# </axsl:otherwise>
        </xsl:choose>
        
        <!--52-->
        <xsl:choose>
            <axsl:when test="not(exists($Finalite)) or $Finalite != '11' or ($Finalite = '11' and ./xx:Laboratoire/xx:CdIntervenant)"/>
            <axsl:otherwise>E4.52/ Le code SIRET du laboratoire ayant effectué les analyses ayant
                pour finalité '11' (RSDE) DOIVENT être renseignés. Erreur détectée sur le paramètre
                '<xsl:value-of select="./xx:Parametre/xx:CdParametre"/>' au niveau du point de
                localisation '<xsl:value-of select="$Localisation"/>' lors du
                prélèvement en date du '<xsl:value-of select="$DatePrel"/>'.#
            </axsl:otherwise>
        </xsl:choose>
        
        <!--53-->
        <xsl:choose>
            <axsl:when test="not(exists($Finalite)) or $Finalite != '11' or ($Finalite = '11' and (./xx:LQAna != '0' and ./xx:LQAna != '' and ./xx:Parametre/xx:CdParametre != '1552' or ./xx:Parametre/xx:CdParametre = '1552' or ./xx:InSituAna = '1'))"/>
            <axsl:otherwise>E4.53/ La limite de quantification pour les analyses ayant pour finalité
                '11' (RSDE) DOIT être renseignée et supèrieure à 0. Erreur détectée sur le paramètre '<xsl:value-of select="./xx:Parametre/xx:CdParametre"/>' au niveau du point de localisation
                '<xsl:value-of select="$Localisation"/>'
                lors du prélèvement en date du '<xsl:value-of select="$DatePrel"/>'.# </axsl:otherwise>
        </xsl:choose>
        
        
        <!--54-->
        <xsl:choose>
            <axsl:when test="not(exists($Finalite)) or $Finalite != '11' or ($Finalite = '11' and (./xx:AccreAna != '' and ./xx:AccreAna != '0' and ./xx:Parametre/xx:CdParametre != '1552' or ./xx:Parametre/xx:CdParametre = '1552' or ./xx:InSituAna = '1'))"/>
            <axsl:otherwise>E4.54/ L'accréditation des analyses ayant pour finalité '11' (RSDE) DOIT
                être renseignée et prendre pour valeur '1' (accrédité) ou '2' (non accrédité) .
                Erreur détectée sur le paramètre '<xsl:value-of select="./xx:Parametre/xx:CdParametre"/>' au niveau du point de localisation
                '<xsl:value-of select="$Localisation"/>'
                lors du prélèvement en date du '<xsl:value-of select="$DatePrel"/>'.# </axsl:otherwise>
        </xsl:choose>
        
        <!--55-->
        <xsl:choose>
            <axsl:when test="not(exists($Finalite)) or $Finalite != '11' or ($Finalite = '11' and ancestor::xx:Prelevement/xx:Preleveur)"/>
            <axsl:otherwise>E4.55/ Le code SIRET et le nom de l'organisme préleveur, pour les
                analyses ayant pour finalité '11' (RSDE) DOIVENT être renseignés. Erreur détectée au
                niveau du point de localisation '<xsl:value-of select="$Localisation"/>' lors du
                prélèvement en date du '<xsl:value-of select="$DatePrel"/>'.#
            </axsl:otherwise>
        </xsl:choose>
        
        <!--56-->
        <xsl:choose>
            <axsl:when test="not(exists($Finalite)) or $Finalite != '11' or ($Finalite = '11' and (ancestor::xx:Prelevement/xx:HeurePrel and ./xx:Parametre/xx:CdParametre != '1552' or ./xx:Parametre/xx:CdParametre = '1552' or ./xx:InSituAna = '1'))"/>
            <axsl:otherwise>E4.56/ L'heure du prélèvement, pour les analyses ayant pour finalité
                '11' (RSDE) DOIT être renseigné. Erreur détectée au niveau du point de localisation
                '<xsl:value-of select="$Localisation"/>'
                lors du prélèvement en date du '<xsl:value-of select="$DatePrel"/>'.# </axsl:otherwise>
        </xsl:choose>
        
        <!--57-->
        <!--<xsl:choose>
            <axsl:when test="not(exists($Finalite)) or $Finalite != '11' or ($Finalite = '11' and ancestor::xx:Prelevement/xx:DureePrel) and (ancestor::xx:Prelevement/xx:DureePrel != '00:00:00')"/>
            <axsl:otherwise>E4.57/ La durée du prélèvement, pour les analyses ayant pour finalité
                '11' (RSDE) DOIT être renseignée et être différente de '00:00:00'. Erreur détectée
                au niveau du point de localisation '<xsl:value-of select="$Localisation"/>' lors du
                prélèvement en date du '<xsl:value-of select="$DatePrel"/>'.#
            </axsl:otherwise>
        </xsl:choose>-->
        
        <!--58-->
        <xsl:choose>
            <axsl:when test="not(exists($Finalite)) or $Finalite != '11' or ($Finalite = '11' and ancestor::xx:Prelevement/xx:ConformitePrel)"/>
            <axsl:otherwise>E4.58/ La conformité du prélèvement, pour les analyses ayant pour
                finalité '11' (RSDE) DOIT être renseigné. Erreur détectée au niveau du point de
                localisation '<xsl:value-of select="$Localisation"/>' lors du
                prélèvement en date du '<xsl:value-of select="$DatePrel"/>'.#
            </axsl:otherwise>
        </xsl:choose>
        
        <!--59-->
        <xsl:choose>
            <axsl:when test="not(exists($Finalite)) or $Finalite != '11' or  ($Finalite = '11' and (ancestor::xx:Prelevement/xx:AccredPrel and (ancestor::xx:Prelevement/xx:AccredPrel = '1' or ancestor::xx:Prelevement/xx:AccredPrel = '2') and ./xx:Parametre/xx:CdParametre != '1552' or ./xx:Parametre/xx:CdParametre = '1552' or ./xx:InSituAna = '1'))"/>
            <axsl:otherwise>E4.59/ L'accréditation du prélèvement, pour les analyses ayant pour
                finalité '11' (RSDE) DOIT être renseignée et prendre pour valeur '1' (accrédité) ou
                '2' (non accrédité). Erreur détectée au niveau du point de localisation
                '<xsl:value-of select="$Localisation"/>'
                lors du prélèvement en date du '<xsl:value-of select="$DatePrel"/>'.# </axsl:otherwise>
        </xsl:choose>
        
        <!--61-->
        <xsl:choose>
            <axsl:when test="not(exists($Finalite)) or $Finalite != '11' or ($Finalite = '11' and ancestor::xx:Echantillon/xx:HeureReceptionEchant) or ($Finalite = '11' and ./xx:HeureReceptionEchant/text() = '')"/>
            <axsl:otherwise>E4.61/ L'heure de réception de l'échantillon pour une analyse ayant pour
                finalité '11' (RSDE) DOIT être renseignée. Erreur détectée sur le paramètre
                '<xsl:value-of select="./xx:Parametre/xx:CdParametre"/>' au niveau du point de
                localisation '<xsl:value-of select="$Localisation"/>' lors du
                prélèvement en date du '<xsl:value-of select="$DatePrel"/>'.#
            </axsl:otherwise>
        </xsl:choose>
        
        <!--62-->
        <xsl:choose>
            <axsl:when test="not(exists($Finalite)) or $Finalite != '11' or ($Finalite = '11' and (./xx:AgreAna != '' and ./xx:Parametre/xx:CdParametre != '1552' or ./xx:Parametre/xx:CdParametre = '1552' or ./xx:InSituAna = '1'))"/>
            <axsl:otherwise>E4.62/ L'agrément des analyses ayant pour finalité '11' (RSDE) DOIT être
                renseignée. Erreur détectée sur le paramètre '<xsl:value-of select="./xx:Parametre/xx:CdParametre"/>' au niveau du point de localisation
                '<xsl:value-of select="$Localisation"/>'
                lors du prélèvement en date du '<xsl:value-of select="$DatePrel"/>'.# </axsl:otherwise>
        </xsl:choose>
       
        
        <!--63-->
        <xsl:choose>
            <axsl:when test="not(exists($Finalite)) or $Finalite != '11' or ($Finalite = '11' and (./xx:IncertAna != '' and ./xx:IncertAna &gt;= 1 and ./xx:IncertAna &lt;= 100 and ./xx:Parametre/xx:CdParametre != '1552' or ./xx:Parametre/xx:CdParametre = '1552' or ./xx:InSituAna = '1'))"/>
            <axsl:otherwise>E4.63/ L'incertitude des analyses ayant pour finalité '11' (RSDE) DOIT
                être renseignée et être comprise entre 1 et 100. Erreur détectée sur le paramètre '<xsl:value-of select="./xx:Parametre/xx:CdParametre"/>' au niveau du point de localisation
                '<xsl:value-of select="$Localisation"/>'
                lors du prélèvement en date du '<xsl:value-of select="$DatePrel"/>'.# </axsl:otherwise>
        </xsl:choose>
        
        <!--80-->
        <xsl:choose>
            <axsl:when test="not(exists($Finalite)) or $Finalite != '11' or ($Finalite = '11' and ancestor::xx:Echantillon/xx:DateReceptionEchant) "/>
            
            <axsl:otherwise>E4.80/ La date de réception de l'échantillon pour une analyse ayant pour
                finalité '11' (RSDE) DOIT être renseignée. Erreur détectée sur le paramètre
                '<xsl:value-of select="./xx:Parametre/xx:CdParametre"/>' au niveau du point de
                localisation '<xsl:value-of select="$Localisation"/>' lors du
                prélèvement en date du '<xsl:value-of select="$DatePrel"/>'.#
            </axsl:otherwise>
        </xsl:choose>
        
        <!--82-->
        <axsl:choose>
            <axsl:when test="not(exists($Finalite)) or $Finalite != '11' or ./xx:Parametre/xx:CdParametre/text() != '1552' or ($Finalite = '11' and ./xx:InSituAna/text()='1' and ./xx:Parametre/xx:CdParametre/text() = '1552')"/>
            <axsl:otherwise>A4.82/ Les analyses ayant pour finalité '11' (RSDE) pour les mesures de débit moyen journalier (paramètre 1552) DOIVENT être effectuées en 'in situ'. Erreur détectée sur le paramètre '<axsl:value-of select="./xx:Parametre/xx:CdParametre"/>' au niveau du point de localisation '<axsl:value-of select="$Localisation"/>' lors du prélèvement en date du '<axsl:value-of select="$DatePrel"/>'.#
            </axsl:otherwise>
        </axsl:choose>
        
        <!--84 Doublon analyses -->
        <xsl:choose>
            <axsl:when test="preceding-sibling::xx:Analyse[./xx:Parametre/xx:CdParametre/text() = $Par and ./xx:FractionAnalysee/xx:CdFractionAnalysee/text() = $FractionAnalysee and ./xx:DateAna/text() = $DateAna and ./xx:Methode/xx:CdMethode/text() = $Met]">
                A4.84/Doublon d'analyse sur le prélèvement. Il ne peut y avoir au sein d'un même fichier, pour le même point de prélèvement, date du prélèvement et finalité, deux analyses avec les mêmes caractéristiques suivantes : Code paramètre: <xsl:value-of select="$Par"/>, Date de l'analyse: <xsl:value-of select="./xx:DateAna"/>, Fraction Analysée: <xsl:value-of select="./xx:FractionAnalysee/xx:CdFractionAnalysee"/> et code de la Méthode: <xsl:value-of select="./xx:Methode/xx:CdMethode"/>.#
            </axsl:when>
        </xsl:choose>
        
        <axsl:apply-templates mode="M1"/>
    </axsl:template>
    <!-- fin règles RSDE -->
    
    <axsl:template match="text()" priority="-1" mode="M1"/>
    <axsl:template match="text()" priority="-1"/>
</axsl:stylesheet>