/// Contenu légal RGPD pour NASCENTIA
///
/// ⚠️ IMPORTANT: Adapter ces contenus avec VOS informations réelles
class LegalContent {
  static Map<String, String> getContent(String type) {
    switch (type) {
      case 'mentions':
        return _mentionsLegales;
      case 'privacy':
        return _politiqueConfidentialite;
      case 'terms':
        return _cgu;
      default:
        return _mentionsLegales;
    }
  }

  // ========================================
  // MENTIONS LÉGALES
  // ========================================
  static final Map<String, String> _mentionsLegales = {
    'title': 'Mentions Légales',
    'lastUpdate': 'Dernière mise à jour : 25 mars 2026',
    'body': '''
<h2>1. Éditeur du site</h2>
<p>Le site nascentia-tech.com est édité par :</p>
<p><strong>[NOM DE LA SOCIÉTÉ OU NOM/PRÉNOM SI PERSONNE PHYSIQUE]</strong><br>
[Forme juridique si société : SARL, SAS, etc.]<br>
Capital social : [MONTANT] (si société)<br>
SIRET : [NUMÉRO SIRET]<br>
RCS : [VILLE] [NUMÉRO RCS] (si société)<br>
<br>
Siège social :<br>
[ADRESSE COMPLÈTE]<br>
[CODE POSTAL] [VILLE]<br>
[PAYS]<br>
<br>
Contact :<br>
Email : nascentia.info@gmail.com<br>
Téléphone : [NUMÉRO DE TÉLÉPHONE]</p>

<h2>2. Directeur de publication</h2>
<p>Le directeur de la publication du site est : <strong>[NOM PRÉNOM]</strong></p>

<h2>3. Hébergeur</h2>
<p>Le site est hébergé par :</p>
<p><strong>LWS (Ligne Web Services)</strong><br>
SAS au capital de 150 000 €<br>
SIRET : 851 993 683 00015<br>
RCS : Amiens B 851 993 683<br>
<br>
Adresse :<br>
10 rue de la Perle<br>
75003 Paris<br>
France<br>
<br>
Contact :<br>
Site web : https://www.lws.fr<br>
Téléphone : +33 3 66 72 10 70</p>

<h2>4. Propriété intellectuelle</h2>
<p>L'ensemble des éléments du site nascentia-tech.com (textes, images, logos, vidéos, code source, charte graphique, etc.) sont la propriété exclusive de [NOM SOCIÉTÉ/PERSONNE] ou de ses partenaires, sauf mention contraire.</p>
<p>Toute reproduction, représentation, modification, publication, adaptation totale ou partielle des éléments du site, quel que soit le moyen ou le procédé utilisé, est interdite sans autorisation écrite préalable de [NOM SOCIÉTÉ/PERSONNE].</p>

<h2>5. Données personnelles</h2>
<p>Les informations collectées via les formulaires du site font l'objet d'un traitement informatique destiné à :</p>
<ul>
<li>Répondre aux demandes de contact</li>
<li>Gérer l'inscription à la newsletter</li>
<li>Améliorer nos services</li>
</ul>
<p>Conformément au Règlement Général sur la Protection des Données (RGPD) et à la loi "Informatique et Libertés", vous disposez d'un droit d'accès, de rectification, de suppression et d'opposition aux données vous concernant.</p>
<p>Pour exercer ces droits, contactez-nous à : nascentia.info@gmail.com</p>
<p>Pour plus de détails, consultez notre <a href="/politique-confidentialite">Politique de confidentialité</a>.</p>

<h2>6. Cookies</h2>
<p>Le site nascentia-tech.com utilise uniquement des cookies techniques nécessaires au bon fonctionnement de l'application (Service Worker pour PWA). Aucun cookie publicitaire ou de tracking tiers n'est utilisé.</p>

<h2>7. Liens hypertextes</h2>
<p>Le site peut contenir des liens vers des sites externes. [NOM SOCIÉTÉ/PERSONNE] décline toute responsabilité quant au contenu de ces sites tiers.</p>

<h2>8. Responsabilité</h2>
<p>Les informations présentes sur le site sont fournies à titre indicatif. [NOM SOCIÉTÉ/PERSONNE] s'efforce d'assurer l'exactitude et la mise à jour des informations, mais ne peut garantir l'exactitude, la précision ou l'exhaustivité des informations mises à disposition.</p>

<h2>9. Droit applicable</h2>
<p>Le présent site et les mentions légales sont régis par le droit français. Tout litige relatif à l'utilisation du site sera soumis à la compétence exclusive des tribunaux français.</p>
''',
  };

  // ========================================
  // POLITIQUE DE CONFIDENTIALITÉ (RGPD)
  // ========================================
  static final Map<String, String> _politiqueConfidentialite = {
    'title': 'Politique de Confidentialité',
    'lastUpdate': 'Dernière mise à jour : 25 mars 2026',
    'body': '''
<h2>1. Introduction</h2>
<p>La protection de vos données personnelles est une priorité pour NASCENTIA ("nous", "notre").</p>
<p>Cette politique de confidentialité vous informe sur la manière dont nous collectons, utilisons, stockons et protégeons vos données personnelles conformément au Règlement Général sur la Protection des Données (RGPD - UE 2016/679) et à la loi "Informatique et Libertés".</p>

<h2>2. Responsable du traitement</h2>
<p><strong>Identité :</strong> [NOM SOCIÉTÉ OU NOM/PRÉNOM]<br>
<strong>Adresse :</strong> [ADRESSE COMPLÈTE]<br>
<strong>Email :</strong> nascentia.info@gmail.com<br>
<strong>Téléphone :</strong> [NUMÉRO]</p>

<h2>3. Données collectées</h2>
<p>Nous collectons les données personnelles suivantes :</p>

<h2>3.1 Via le formulaire de contact</h2>
<ul>
<li>Nom et prénom</li>
<li>Adresse email</li>
<li>Numéro de téléphone (optionnel)</li>
<li>Message</li>
<li>Date et heure de la demande</li>
<li>Adresse IP (pour sécurité)</li>
</ul>

<h2>3.2 Via l'inscription newsletter</h2>
<ul>
<li>Adresse email</li>
<li>Date d'inscription</li>
</ul>

<h2>3.3 Données techniques automatiques</h2>
<ul>
<li>Adresse IP</li>
<li>Type de navigateur</li>
<li>Système d'exploitation</li>
<li>Pages visitées</li>
<li>Durée de visite</li>
</ul>

<h2>4. Finalités du traitement</h2>
<p>Vos données sont collectées pour les finalités suivantes :</p>
<ul>
<li><strong>Formulaire de contact :</strong> Répondre à vos demandes d'information</li>
<li><strong>Newsletter :</strong> Vous envoyer nos actualités, offres et informations sur l'application NASCENTIA</li>
<li><strong>Données techniques :</strong> Améliorer l'expérience utilisateur, assurer la sécurité du site et réaliser des statistiques d'audience</li>
</ul>

<h2>5. Base légale</h2>
<p>Le traitement de vos données repose sur :</p>
<ul>
<li><strong>Consentement</strong> (formulaire contact, newsletter) : Vous consentez explicitement à la collecte de vos données lors de la soumission</li>
<li><strong>Intérêt légitime</strong> : Traitement des données techniques pour améliorer le service et assurer la sécurité</li>
</ul>

<h2>6. Destinataires des données</h2>
<p>Vos données personnelles sont accessibles uniquement par :</p>
<ul>
<li><strong>Notre équipe :</strong> Personnel autorisé de NASCENTIA</li>
<li><strong>Prestataires techniques :</strong>
  <ul>
    <li><strong>Brevo (ex-Sendinblue)</strong> : Service d'email transactionnel et newsletter (hébergement UE, certifié RGPD)</li>
    <li><strong>Supabase</strong> : Base de données et CDN (hébergement UE, certifié GDPR)</li>
    <li><strong>LWS</strong> : Hébergement web (France)</li>
  </ul>
</li>
</ul>
<p>Nous ne vendons ni ne louons vos données à des tiers.</p>

<h2>7. Transferts hors UE</h2>
<p>Vos données sont hébergées et traitées exclusivement dans l'Union Européenne. Aucun transfert hors UE n'est effectué.</p>

<h2>8. Durée de conservation</h2>
<ul>
<li><strong>Formulaire de contact :</strong> 3 ans après le dernier échange</li>
<li><strong>Newsletter :</strong> Jusqu'à désinscription ou 3 ans d'inactivité</li>
<li><strong>Logs techniques :</strong> 12 mois maximum</li>
</ul>

<h2>9. Vos droits (RGPD)</h2>
<p>Conformément au RGPD, vous disposez des droits suivants :</p>
<ul>
<li><strong>Droit d'accès :</strong> Obtenir une copie de vos données</li>
<li><strong>Droit de rectification :</strong> Corriger vos données inexactes</li>
<li><strong>Droit à l'effacement :</strong> Supprimer vos données ("droit à l'oubli")</li>
<li><strong>Droit d'opposition :</strong> Vous opposer au traitement de vos données</li>
<li><strong>Droit à la limitation :</strong> Limiter l'utilisation de vos données</li>
<li><strong>Droit à la portabilité :</strong> Recevoir vos données dans un format structuré</li>
<li><strong>Droit de retirer votre consentement</strong> à tout moment</li>
</ul>

<h2>10. Exercer vos droits</h2>
<p>Pour exercer vos droits, contactez-nous par email à :</p>
<p><strong>nascentia.info@gmail.com</strong></p>
<p>Objet : "Exercice de mes droits RGPD"</p>
<p>Nous nous engageons à répondre sous 30 jours maximum.</p>

<h2>11. Réclamation CNIL</h2>
<p>Si vous estimez que vos droits ne sont pas respectés, vous pouvez introduire une réclamation auprès de la CNIL :</p>
<p><strong>Commission Nationale de l'Informatique et des Libertés (CNIL)</strong><br>
3 Place de Fontenoy<br>
TSA 80715<br>
75334 Paris Cedex 07<br>
France<br>
Site web : https://www.cnil.fr</p>

<h2>12. Sécurité</h2>
<p>Nous mettons en œuvre des mesures techniques et organisationnelles appropriées pour protéger vos données contre :</p>
<ul>
<li>L'accès non autorisé</li>
<li>La perte ou destruction accidentelle</li>
<li>L'utilisation illicite ou non autorisée</li>
</ul>
<p>Mesures de sécurité : HTTPS, chiffrement en transit (TLS), accès restreint, sauvegardes régulières.</p>

<h2>13. Cookies</h2>
<p>Le site nascentia-tech.com utilise uniquement des cookies techniques nécessaires au fonctionnement de l'application PWA (Service Worker). Ces cookies ne nécessitent pas de consentement RGPD car strictement nécessaires.</p>
<p>Nous n'utilisons pas de cookies publicitaires, de tracking tiers ou d'analytics pour le moment.</p>

<h2>14. Modifications</h2>
<p>Nous nous réservons le droit de modifier cette politique de confidentialité à tout moment. Les modifications prennent effet dès leur publication sur cette page. Nous vous invitons à la consulter régulièrement.</p>

<h2>15. Contact</h2>
<p>Pour toute question concernant cette politique de confidentialité, contactez-nous :</p>
<p><strong>Email :</strong> nascentia.info@gmail.com<br>
<strong>Adresse :</strong> [ADRESSE COMPLÈTE]</p>
''',
  };

  // ========================================
  // CONDITIONS GÉNÉRALES D'UTILISATION (CGU)
  // ========================================
  static final Map<String, String> _cgu = {
    'title': 'Conditions Générales d\'Utilisation',
    'lastUpdate': 'Dernière mise à jour : 25 mars 2026',
    'body': '''
<h2>1. Objet</h2>
<p>Les présentes Conditions Générales d'Utilisation (CGU) régissent l'accès et l'utilisation du site nascentia-tech.com (ci-après "le Site") édité par [NOM SOCIÉTÉ/PERSONNE] (ci-après "nous", "notre").</p>
<p>En accédant au Site, vous acceptez sans réserve les présentes CGU.</p>

<h2>2. Accès au Site</h2>
<p>Le Site est accessible gratuitement à tout utilisateur disposant d'un accès à Internet. Les coûts de connexion restent à votre charge.</p>
<p>Nous nous réservons le droit de suspendre, modifier ou interrompre l'accès au Site à tout moment, sans préavis, pour des raisons de maintenance, de sécurité ou pour tout autre motif.</p>

<h2>3. Description du service</h2>
<p>Le Site présente l'application mobile NASCENTIA et permet de :</p>
<ul>
<li>Découvrir les fonctionnalités de l'application</li>
<li>Télécharger l'application Android (APK)</li>
<li>Contacter notre équipe via un formulaire</li>
<li>S'inscrire à notre newsletter</li>
</ul>

<h2>4. Utilisation du Site</h2>
<p>En utilisant le Site, vous vous engagez à :</p>
<ul>
<li>Ne pas utiliser le Site à des fins illégales ou non autorisées</li>
<li>Ne pas perturber le fonctionnement du Site (attaques, virus, scripts malveillants, etc.)</li>
<li>Ne pas extraire ou copier le contenu du Site sans autorisation écrite</li>
<li>Respecter les droits de propriété intellectuelle</li>
</ul>

<h2>5. Propriété intellectuelle</h2>
<p>L'ensemble des contenus présents sur le Site (textes, images, logos, vidéos, code source, design, etc.) sont la propriété exclusive de [NOM SOCIÉTÉ/PERSONNE] ou de ses partenaires, sauf mention contraire.</p>
<p>Toute reproduction, représentation, modification, publication, adaptation, même partielle, est strictement interdite sans autorisation écrite préalable.</p>

<h2>6. Données personnelles</h2>
<p>Les données personnelles collectées via le Site sont traitées conformément à notre <a href="/politique-confidentialite">Politique de confidentialité</a> et au RGPD.</p>
<p>Vous disposez d'un droit d'accès, de rectification, de suppression et d'opposition à vos données personnelles.</p>

<h2>7. Responsabilité</h2>
<p>Nous mettons tout en œuvre pour assurer :</p>
<ul>
<li>L'exactitude et la mise à jour des informations</li>
<li>La disponibilité et l'accessibilité du Site</li>
<li>La sécurité des données</li>
</ul>
<p>Toutefois, nous ne pouvons garantir :</p>
<ul>
<li>L'absence totale d'erreurs ou d'omissions</li>
<li>Un fonctionnement sans interruption (maintenance, panne, etc.)</li>
<li>La protection absolue contre les cyberattaques</li>
</ul>

<h2>8. Liens externes</h2>
<p>Le Site peut contenir des liens vers des sites tiers. Nous déclinons toute responsabilité quant au contenu, à la disponibilité et aux pratiques de confidentialité de ces sites externes.</p>

<h2>9. Téléchargement de l'application</h2>
<p>Le téléchargement de l'application NASCENTIA (fichier APK Android) se fait sous votre propre responsabilité. Nous vous recommandons :</p>
<ul>
<li>De vérifier les autorisations demandées avant installation</li>
<li>D'utiliser un antivirus à jour</li>
<li>De télécharger uniquement depuis notre site officiel</li>
</ul>
<p>Nous déclinons toute responsabilité en cas de dommages causés par l'installation de l'application obtenue depuis une source non officielle.</p>

<h2>10. Newsletter</h2>
<p>En vous inscrivant à notre newsletter, vous consentez à recevoir des emails contenant :</p>
<ul>
<li>Actualités sur l'application NASCENTIA</li>
<li>Offres et promotions</li>
<li>Conseils et astuces</li>
</ul>
<p>Vous pouvez vous désinscrire à tout moment en cliquant sur le lien de désinscription présent dans chaque email ou en nous contactant à : nascentia.info@gmail.com</p>

<h2>11. Formulaire de contact</h2>
<p>Les informations transmises via le formulaire de contact sont uniquement destinées à notre équipe pour répondre à vos demandes. Elles ne seront jamais partagées avec des tiers.</p>

<h2>12. Cookies</h2>
<p>Le Site utilise uniquement des cookies techniques nécessaires au fonctionnement de l'application PWA (Service Worker). Ces cookies ne collectent aucune donnée personnelle.</p>

<h2>13. Modifications des CGU</h2>
<p>Nous nous réservons le droit de modifier les présentes CGU à tout moment. Les modifications prennent effet dès leur publication sur cette page. Nous vous invitons à consulter régulièrement cette page.</p>

<h2>14. Droit applicable et juridiction</h2>
<p>Les présentes CGU sont régies par le droit français. En cas de litige, et à défaut d'accord amiable, les tribunaux français seront seuls compétents.</p>

<h2>15. Contact</h2>
<p>Pour toute question concernant les présentes CGU, contactez-nous :</p>
<p><strong>Email :</strong> nascentia.info@gmail.com<br>
<strong>Adresse :</strong> [ADRESSE COMPLÈTE]<br>
<strong>Téléphone :</strong> [NUMÉRO]</p>
''',
  };
}
