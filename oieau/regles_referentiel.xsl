<!--2011-04-28 ajout du controle de Luhn pour la verification de la validité des codes SIRET ajout de la verification des codes gelés--><!--2013-08-26 suppression des règles E4.2 et ajout des règles d'avertissement A3.10--><!--2025-09-17 ajout des règles liés aux référentiels des commémoratifs-->
<axsl:stylesheet xmlns:xx="http://xml.sandre.eaufrance.fr/scenario/labo_dest/1.1" xmlns:xsl="http://www.w3.org/1999/XSL/Transform" xmlns:sa_ref="http://xml.sandre.eaufrance.fr/scenario/referentiel/2" xmlns:sch="http://www.ascc.net/xml/schematron" xmlns:axsl="http://www.w3.org/1999/XSL/Transform" version="1.0">
    <axsl:output method="text" omit-xml-declaration="no" standalone="yes" indent="yes"/>
    <!--<axsl:variable name="chemin">http://195.220.97.105:8080/exist/xmldb/db/sandre/Referentiels/old_referentiel.xml</axsl:variable>-->
    <axsl:variable name="cheminPAR">http://xml.sandre.eaufrance.fr/exist/sandre/Referentiels/PAR.xml</axsl:variable>
    <axsl:variable name="cheminMET">http://xml.sandre.eaufrance.fr/exist/sandre/Referentiels/MET.xml</axsl:variable>
    <axsl:variable name="cheminSUP">http://xml.sandre.eaufrance.fr/exist/sandre/Referentiels/SUP.xml</axsl:variable>
    <axsl:variable name="cheminFAN">http://xml.sandre.eaufrance.fr/exist/sandre/Referentiels/FAN.xml</axsl:variable>
    <axsl:variable name="cheminURF">http://xml.sandre.eaufrance.fr/exist/sandre/Referentiels/URF.xml</axsl:variable>
    <axsl:variable name="cheminNSA">http://xml.sandre.eaufrance.fr/exist/sandre/Referentiels/NSA.xml</axsl:variable>
    <axsl:variable name="cheminCMM">http://xml.sandre.eaufrance.fr/exist/sandre/Referentiels/CMM.xml</axsl:variable>
    <axsl:variable name="cheminDC">http://xml.sandre.eaufrance.fr/exist/sandre/Referentiels/DC.xml</axsl:variable>
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
    <axsl:template match="*[local-name()='CdParametre']" priority="4000" mode="M1">
        <axsl:choose>
            <axsl:when test="document($cheminPAR)//sa_ref:Referentiel/sa_ref:Parametre/sa_ref:CdParametre/text()=./text()">
                <axsl:if test="document($cheminPAR)//sa_ref:Referentiel/sa_ref:Parametre[./sa_ref:CdParametre/text()=current()/text()]/sa_ref:StParametre/text()='Gelé'">
                    A3.10/AVERTISSEMENT: Le code '<axsl:value-of select="text()"/>' est gelé au regard de la liste de référence des paramètres#
                </axsl:if>
            </axsl:when>
            <axsl:otherwise>E3.1/Le code '<axsl:value-of select="text()"/>' est inconnu au regard de la liste de référence des paramètres#</axsl:otherwise>
        </axsl:choose>
        <axsl:apply-templates mode="M1"/>
    </axsl:template>
    <axsl:template match="*[local-name()='CdMethode']" priority="3999" mode="M1">
        <axsl:choose>
            <axsl:when test="document($cheminMET)//sa_ref:Referentiel/sa_ref:Methode/sa_ref:CdMethode/text()=./text()">
                <axsl:if test="document($cheminMET)//sa_ref:Referentiel/sa_ref:Methode[./sa_ref:CdMethode/text()=current()/text()]/sa_ref:StMethode/text()='Gelé'">
                A3.10/AVERTISSEMENT: Le code '<axsl:value-of select="text()"/>' est gelé au regard de la liste de référence des méthodes#
            </axsl:if>
            </axsl:when>
            <axsl:otherwise>E3.1/Le code '<axsl:value-of select="text()"/>' est inconnu au regard de la liste de référence des méthodes#</axsl:otherwise>
        </axsl:choose>
        <axsl:apply-templates mode="M1"/>
    </axsl:template>
    <axsl:template match="*[name()='CdSupport']" priority="3998" mode="M1">
        <axsl:choose>
            <axsl:when test="document($cheminSUP)//sa_ref:Referentiel/sa_ref:Support/sa_ref:CdSupport/text()=./text()">
                <axsl:if test="document($cheminSUP)//sa_ref:Referentiel/sa_ref:Support[./sa_ref:CdSupport/text()=current()/text()]/sa_ref:StSupport/text()='Gelé'">
                    A3.10/AVERTISSEMENT: Le code '<axsl:value-of select="text()"/>' est gelé au regard de la liste de référence des supports#
                </axsl:if>
            </axsl:when>
            <axsl:otherwise>E3.1/Le code '<axsl:value-of select="text()"/>' est inconnu au regard de la liste de référence des supports#</axsl:otherwise>
        </axsl:choose>
        <axsl:apply-templates mode="M1"/>
    </axsl:template>
    <axsl:template match="*[local-name()='CdUniteReference']" priority="3997" mode="M1">
        <axsl:choose>
            <axsl:when test="document($cheminURF)//sa_ref:Referentiel/sa_ref:UniteReference/sa_ref:CdUniteReference/text()=./text()">
                <axsl:if test="document($cheminURF)//sa_ref:Referentiel/sa_ref:UniteReference[./sa_ref:CdUniteReference/text()=current()/text()]/sa_ref:StUniteReference/text()='Gelé'">
                    A3.10/AVERTISSEMENT: Le code '<axsl:value-of select="text()"/>' est gelé au regard de la liste de référence des unités de mesure#
                </axsl:if>
            </axsl:when>
            <axsl:otherwise>E3.1/Le code '<axsl:value-of select="text()"/>' est inconnu au regard de la liste de référence des unités de mesure#</axsl:otherwise>
        </axsl:choose>
        <axsl:apply-templates mode="M1"/>
    </axsl:template>
    <!--<axsl:template match="//com_labo:CdFractionAnalysee" priority="3996" mode="M1">-->
    <axsl:template match="*[local-name()='CdFractionAnalysee']" priority="3996" mode="M1">
        <axsl:choose>
            <axsl:when test="document($cheminFAN)//sa_ref:Referentiel/sa_ref:FractionAnalysee/sa_ref:CdFractionAnalysee/text()=./text()">
                <axsl:if test="document($cheminFAN)//sa_ref:Referentiel/sa_ref:FractionAnalysee[./sa_ref:CdFractionAnalysee/text()=current()/text()]/sa_ref:StFractionAnalysee/text()='Gelé'">
                    A3.10/AVERTISSEMENT: Le code '<axsl:value-of select="text()"/>' est gelé au regard de la liste de référence des fractions analysées#
                </axsl:if>
            </axsl:when>
            <axsl:otherwise>E3.1/Le code '<axsl:value-of select="text()"/>' est inconnu au regard de la liste de référence des fractions analysées#</axsl:otherwise>
        </axsl:choose>
        <axsl:apply-templates mode="M1"/>
    </axsl:template>
    <axsl:template match="*[local-name()='CdIntervenant'][./@schemeAgencyID='SIRET']" priority="4000" mode="M1">
        <axsl:call-template name="controle-luhn">
            <axsl:with-param name="numero" select="text()"/>
            <axsl:with-param name="somme" select="0"/>
            <axsl:with-param name="indice" select="1"/>
        </axsl:call-template>
        <axsl:apply-templates mode="M1"/>
    </axsl:template>
    <axsl:template name="controle-luhn">
        <axsl:param name="numero" select="normalize-space(.)"/>
        <axsl:param name="somme" select="0"/>
        <axsl:param name="indice" select="1"/>
        <axsl:choose>
            <axsl:when test="string-length($numero)=0">
                <!-- Nous arrivons ici après le dernier chiffre -->
                <axsl:choose>
                    <axsl:when test="$somme mod 10 = 0"/>
                    <axsl:otherwise>
                    E3.3/Le code SIRET '<axsl:value-of select="text()"/>' est erroné au regard du contrôle de la formule de Luhn, la somme <axsl:value-of select="$somme"/> n'est pas un multiple de 10#
                  </axsl:otherwise>
                </axsl:choose>
            </axsl:when>
            <axsl:when test="$indice mod 2 = 0">
                <!-- Cas des chiffres d'indice pair -->
                <axsl:call-template name="controle-luhn">
                    <axsl:with-param name="numero" select="substring($numero, 2)"/>
                    <axsl:with-param name="somme" select="$somme + substring($numero, 1, 1)"/>
                    <axsl:with-param name="indice" select="$indice + 1"/>
                </axsl:call-template>
            </axsl:when>
            <axsl:otherwise>
                <!-- Cas des chiffres d'indice impair -->
                <axsl:variable name="double" select="concat(substring($numero, 1, 1) * 2, '0') "/>
                <axsl:call-template name="controle-luhn">
                    <axsl:with-param name="numero" select="substring($numero, 2)"/>
                    <axsl:with-param name="somme" select="$somme + substring($double, 1, 1) + substring($double, 2, 1)"/>
                    <axsl:with-param name="indice" select="$indice + 1"/>
                </axsl:call-template>
            </axsl:otherwise>
              </axsl:choose>
        <axsl:apply-templates mode="M1"/>
    </axsl:template>

<!-- Template sur CdCommemoratif - version XSLT 1.0 -->
<xsl:template match="*[local-name()='CdCommemoratif']" priority="4000" mode="M1">
  <xsl:variable name="thisCdCom" select="normalize-space(.)"/>
  <xsl:variable name="typeComClean" select="
    normalize-space(
      document($cheminCMM)//sa_ref:Commemoratif[sa_ref:CdCommemoratif = $thisCdCom]/sa_ref:TypeCommemoratif
    )
  "/>

  <axsl:variable name="expectedParent">
    <axsl:choose>
      <axsl:when test="$typeComClean='PRL'">Prelevement</axsl:when>
      <axsl:when test="$typeComClean='DEM'">Demande</axsl:when>
      <axsl:when test="$typeComClean='ECH'">Echantillon</axsl:when>
      <axsl:when test="$typeComClean='ANA'">Analyse</axsl:when>
      <axsl:otherwise>UNKNOWN</axsl:otherwise>
    </axsl:choose>
  </axsl:variable>
  <axsl:if test="$expectedParent != 'UNKNOWN' and not(ancestor::*[local-name() = $expectedParent])">
      <axsl:text>E3.4/Commémoratif de type </axsl:text>
      <axsl:value-of select="$typeComClean"/>
      <axsl:text> (CdCommemoratif = '</axsl:text>
      <axsl:value-of select="$thisCdCom"/>
      <axsl:text>') doit se trouver dans </axsl:text>
      <axsl:value-of select="$expectedParent"/>
      <axsl:text>#</axsl:text>
    </axsl:if>
    
    <axsl:if test="$expectedParent != 'UNKNOWN' and ancestor::*[local-name() = $expectedParent] and not(local-name(../..) = $expectedParent)">
      <axsl:text>E3.5/Commémoratif de type </axsl:text>
      <axsl:value-of select="$typeComClean"/>
      <axsl:text> (CdCommemoratif = '</axsl:text>
      <axsl:value-of select="$thisCdCom"/>
      <axsl:text>') doit être directement enfant du parent attendu '</axsl:text>  
      <axsl:value-of select="$expectedParent"/>
      <axsl:text>', pas d'un sous-enfant#</axsl:text>
    </axsl:if>

  <xsl:choose>
    <xsl:when test="document($cheminCMM)//sa_ref:Referentiel/sa_ref:Commemoratif/sa_ref:CdCommemoratif = $thisCdCom">

      <!-- A3.10 : gelé -->
      <xsl:if test="document($cheminCMM)//sa_ref:Referentiel/sa_ref:Commemoratif                       [sa_ref:CdCommemoratif = $thisCdCom]/sa_ref:StCommemoratif = 'Gelé'">
        A3.10/AVERTISSEMENT: Le code '<xsl:value-of select="$thisCdCom"/>' est gelé au regard de la liste de référence des commémoratifs#
      </xsl:if>

      <!-- si DefCommemoratif contient 'N°' -->
      <xsl:if test="contains(document($cheminCMM)//sa_ref:Referentiel/sa_ref:Commemoratif[sa_ref:CdCommemoratif = $thisCdCom]/sa_ref:DefCommemoratif, 'N°')">

        <!-- extraire text brut après 'N°' -->
        <xsl:variable name="numNomRaw" select="normalize-space(substring-after(document($cheminCMM)//sa_ref:Referentiel/sa_ref:Commemoratif[sa_ref:CdCommemoratif = $thisCdCom]/sa_ref:DefCommemoratif, 'N°'))"/>

        <!-- token = premier mot après 'N°' -->
        <xsl:variable name="numNomToken" select="substring-before(concat($numNomRaw,' '),' ')"/>

        <!-- garder uniquement les chiffres -->
        <xsl:variable name="numNom" select="translate($numNomToken, translate($numNomToken, '0123456789',''), '')"/>

        <!-- Valeur à vérifier (dans le fichier testé) -->
        <xsl:variable name="valComRaw" select="normalize-space(../*[local-name()='ValCommemoratif'])"/>
        <xsl:variable name="valCom">
          <xsl:choose>
            <xsl:when test="contains($valComRaw, ':')">
              <xsl:value-of select="normalize-space(substring-after($valComRaw, ':'))"/>
            </xsl:when>
            <xsl:otherwise>
              <xsl:value-of select="$valComRaw"/>
            </xsl:otherwise>
          </xsl:choose>
        </xsl:variable>

        <!-- recherche du référentiel dans NSA -->
        <xsl:variable name="referentielNSA" select="document($cheminNSA)//sa_ref:Referentiel[sa_ref:CdReferentiel = $numNom]"/>
        <xsl:variable name="referentielCount" select="count($referentielNSA)"/>

        <!-- si NSA introuvable => message (seul cas où on émet ce message) -->
        <xsl:if test="$referentielCount = 0">
          <xsl:text>E3.1/Le code '</xsl:text>
          <xsl:value-of select="$numNom"/>
          <xsl:text>' est inconnu au regard de la liste de référence des nomenclatures#</xsl:text>
        </xsl:if>

        <!-- si NSA trouvé, vérifier la valeur dans CdElement -->
        <xsl:if test="$referentielCount &gt; 0">
          <xsl:variable name="nbMatch" select="count($referentielNSA/sa_ref:Element/sa_ref:CdElement[normalize-space(.) = $valCom])"/>


          <!-- si aucun CdElement ne correspond -->
          <xsl:if test="$nbMatch = 0">
            <xsl:text>E3.2/La valeur '</xsl:text>
            <xsl:value-of select="$valCom"/>
            <xsl:text>' n'est pas valide pour la nomenclature N°</xsl:text>
            <xsl:value-of select="$numNom"/>
            <xsl:text>#</xsl:text>
          </xsl:if>
        </xsl:if>
      </xsl:if>
    </xsl:when>
    <xsl:otherwise>
      E3.1/Le code '<xsl:value-of select="$thisCdCom"/>' est inconnu au regard de la liste de référence des commémoratifs#
    </xsl:otherwise>
  </xsl:choose>
<!-- Règle spécifique : CdCommemoratif = 130 ou 126 ou 38 -->
<xsl:if test=". = '130' or . = '126' or . = '38'">
  <xsl:variable name="valComRaw" select="normalize-space(../*[local-name()='ValCommemoratif'])"/>
  <xsl:variable name="valCom">
    <xsl:choose>
      <xsl:when test="contains($valComRaw, ':')">
        <xsl:value-of select="normalize-space(substring-after($valComRaw, ':'))"/>
      </xsl:when>
      <xsl:otherwise>
        <xsl:value-of select="$valComRaw"/>
      </xsl:otherwise>
    </xsl:choose>
  </xsl:variable>

  <!-- Vérification que ValCommemoratif correspond à un CdMethode valide dans MET.xml -->
  <xsl:variable name="methodeNode" 
        select="document($cheminMET)//sa_ref:Referentiel/sa_ref:Methode[normalize-space(sa_ref:CdMethode) = $valCom]"/>
  <xsl:variable name="nbMatchMet" select="count($methodeNode)"/>

  <xsl:if test="$nbMatchMet = 0">
    <xsl:text>E3.1/Le code '</xsl:text>
    <xsl:value-of select="$valCom"/>
    <xsl:text>' est inconnu au regard de la liste de référence des méthodes#</xsl:text>
  </xsl:if>

  <!-- Si la méthode est trouvée mais gelée -->
  <xsl:if test="$nbMatchMet &gt; 0 and $methodeNode/sa_ref:StMethode = 'Gelé'">
    <xsl:text>A3.10/AVERTISSEMENT: Le code '</xsl:text>
    <xsl:value-of select="$valCom"/>
    <xsl:text>' est gelé au regard de la liste de référence des méthodes#</xsl:text>
  </xsl:if>
</xsl:if>
<!-- Règle spécifique : CdCommemoratif = 131 ou 129 ou 128 -->
<xsl:if test=". = '131' or . = '129' or . = '128'">
  <xsl:variable name="valComRaw" select="normalize-space(../*[local-name()='ValCommemoratif'])"/>
  <xsl:variable name="valCom">
    <xsl:choose>
      <xsl:when test="contains($valComRaw, ':')">
        <xsl:value-of select="normalize-space(substring-after($valComRaw, ':'))"/>
      </xsl:when>
      <xsl:otherwise>
        <xsl:value-of select="$valComRaw"/>
      </xsl:otherwise>
    </xsl:choose>
  </xsl:variable>

  <!-- Vérification que ValCommemoratif correspond à un CdParametre valide dans PAR.xml -->
  <xsl:variable name="parametreNode" 
        select="document($cheminPAR)//sa_ref:Referentiel/sa_ref:Parametre[normalize-space(sa_ref:CdParametre) = $valCom]"/>
  <xsl:variable name="nbMatchPar" select="count($parametreNode)"/>

  <xsl:if test="$nbMatchPar = 0">
    <xsl:text>E3.1/Le code '</xsl:text>
    <xsl:value-of select="$valCom"/>
    <xsl:text>' est inconnu au regard de la liste de référence des paramètres#</xsl:text>
  </xsl:if>

  <!-- Si le paramètre est trouvé mais gelé -->
  <xsl:if test="$nbMatchPar &gt; 0 and $parametreNode/sa_ref:StParametre = 'Gelé'">
    <xsl:text>A3.10/AVERTISSEMENT: Le code '</xsl:text>
    <xsl:value-of select="$valCom"/>
    <xsl:text>' est gelé au regard de la liste de référence des paramètres#</xsl:text>
  </xsl:if>
</xsl:if>
<!-- Règle spécifique : CdCommemoratif = 123 -->
<xsl:if test=". = '123'">
  <xsl:variable name="valComRaw" select="normalize-space(../*[local-name()='ValCommemoratif'])"/>
  <xsl:variable name="valCom">
    <xsl:choose>
      <xsl:when test="contains($valComRaw, ':')">
        <xsl:value-of select="normalize-space(substring-after($valComRaw, ':'))"/>
      </xsl:when>
      <xsl:otherwise>
        <xsl:value-of select="$valComRaw"/>
      </xsl:otherwise>
    </xsl:choose>
  </xsl:variable>

  <!-- Vérification que ValCommemoratif correspond à un CodeSandreRdd valide dans DC.xml -->
  <xsl:variable name="DispositifCollecteNode" 
        select="document($cheminDC)//sa_ref:Referentiel/sa_ref:DispositifCollecte[normalize-space(sa_ref:CodeSandreRdd) = $valCom]"/>
  <xsl:variable name="nbMatchDispositifCollecte" select="count($DispositifCollecteNode)"/>

  <xsl:if test="$nbMatchDispositifCollecte = 0">
    <xsl:text>E3.1/Le code '</xsl:text>
    <xsl:value-of select="$valCom"/>
    <xsl:text>' est inconnu au regard de la liste de référence des dispositifs de collecte.#</xsl:text>
  </xsl:if>

  <!-- Si le dispositif de collecte est trouvé mais gelé -->
  <xsl:if test="$nbMatchDispositifCollecte &gt; 0 and $DispositifCollecteNode/sa_ref:StRdd = 'Gelé'">
    <xsl:text>A3.10/AVERTISSEMENT: Le code '</xsl:text>
    <xsl:value-of select="$valCom"/>
    <xsl:text>' est gelé au regard de la liste de référence des dispositifs de collecte#</xsl:text>
  </xsl:if>
</xsl:if>
  <xsl:apply-templates mode="M1"/>
</xsl:template>
  <!-- Bloquer le traitement des textes dans ce mode, si nécessaire -->
    <axsl:template match="text()" priority="-1" mode="M1"/>
    <axsl:template match="text()" priority="-1"/>
</axsl:stylesheet>