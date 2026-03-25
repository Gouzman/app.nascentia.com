# 📝 Prompt pour Générer le Contenu Légal NASCENTIA

Copiez-collez ce prompt dans ChatGPT, Claude ou tout autre LLM pour générer vos textes légaux personnalisés.

---

## 🤖 PROMPT À COPIER

```
Je développe un site web pour l'application mobile NASCENTIA et j'ai besoin de générer le contenu légal complet conforme RGPD.

## CONTEXTE DU PROJET

**Nom du site :** nascentia-tech.com  
**Type :** Landing page Flutter Web pour application mobile Android  
**Activité :** Application de planification familiale scientifique en Côte d'Ivoire  
**Langue :** Français  
**Juridiction :** Côte d'Ivoire + conformité RGPD (UE)

## INFORMATIONS SOCIÉTÉ

**À PERSONNALISER AVEC VOS VRAIES INFOS :**

- **Nom commercial :** NASCENTIA  
- **Raison sociale :** [Votre nom/entreprise]  
- **Forme juridique :** [Personne physique / SARL / SAS / SASU / etc.]  
- **Capital social :** [Si société, sinon supprimer]  
- **SIRET :** [Votre numéro SIRET]  
- **RCS :** [Si société : ville + numéro]  
- **Adresse siège social :** [Votre adresse complète]  
- **Ville/Pays :** [Ville, Côte d'Ivoire]  
- **Email contact :** contact@nascentia-tech.com  
- **Téléphone :** [Votre numéro]  
- **Directeur de publication :** [Nom Prénom]

## HÉBERGEMENT

- **Hébergeur :** LWS (Ligne Web Services)  
- **Forme juridique :** SAS au capital de 150 000 €  
- **SIRET :** 851 993 683 00015  
- **RCS :** Amiens B 851 993 683  
- **Adresse :** 10 rue de la Perle, 75003 Paris, France  
- **Site :** https://www.lws.fr  
- **Téléphone :** +33 3 66 72 10 70

## DONNÉES COLLECTÉES

### Formulaire de contact
- Nom et prénom
- Email
- Téléphone (optionnel)
- Message
- Date/heure
- IP (sécurité)

### Newsletter
- Email
- Date d'inscription

### Données techniques
- IP
- Type navigateur
- Système d'exploitation
- Pages visitées
- Durée de visite

## SOUS-TRAITANTS / SERVICES TIERS

1. **Brevo (ex-Sendinblue)** — Email transactionnel + newsletter
   - Hébergement : Union Européenne
   - Conforme RGPD
   - Site : https://www.brevo.com

2. **Supabase** — Base de données + CDN images
   - Hébergement : Union Européenne
   - Conforme GDPR
   - Site : https://supabase.com

3. **LWS** — Hébergement web
   - Localisation : France
   - Conforme RGPD

**Aucun transfert hors UE.**

## DURÉES DE CONSERVATION

- Formulaire contact : 3 ans après dernier échange
- Newsletter : Jusqu'à désinscription ou 3 ans d'inactivité
- Logs techniques : 12 mois maximum

## COOKIES

**Cookies techniques uniquement** (Service Worker PWA) — pas de consentement requis.  
Aucun cookie publicitaire, tracking ou analytics pour le moment.

---

## 📋 DEMANDE

**Génère 3 documents légaux complets, professionnels et conformes :**

### 1. MENTIONS LÉGALES
Inclure :
- Identification éditeur (avec infos société ci-dessus)
- Directeur de publication
- Hébergeur (LWS détails complets)
- Propriété intellectuelle
- Données personnelles (renvoi vers politique confidentialité)
- Cookies (techniques uniquement)
- Liens hypertextes
- Responsabilité
- Droit applicable (français)

### 2. POLITIQUE DE CONFIDENTIALITÉ (RGPD)
Inclure :
- Introduction RGPD
- Responsable traitement (avec coordonnées)
- Données collectées (détails ci-dessus)
- Finalités du traitement
- Base légale (consentement)
- Destinataires (sous-traitants listés)
- Transferts hors UE (AUCUN)
- Durées de conservation
- Droits RGPD (accès, rectification, suppression, opposition, portabilité, limitation)
- Exercer ses droits (contact email)
- Réclamation CNIL (coordonnées complètes)
- Sécurité des données
- Cookies (techniques uniquement)
- Modifications de la politique

### 3. CONDITIONS GÉNÉRALES D'UTILISATION (CGU)
Inclure :
- Objet
- Accès au site
- Description du service (landing page + téléchargement APK)
- Utilisation du site
- Propriété intellectuelle
- Données personnelles (renvoi)
- Responsabilité
- Liens externes
- Téléchargement APK Android (responsabilité utilisateur)
- Newsletter (consentement, désinscription)
- Formulaire de contact
- Cookies
- Modifications des CGU
- Droit applicable et juridiction

---

## FORMAT DE SORTIE

Pour **chaque document**, fournis :

1. Le titre complet
2. La date de dernière mise à jour (25 mars 2026)
3. Le contenu structuré en sections `<h2>` avec paragraphes `<p>` et listes `<ul><li>`
4. Ton professionnel mais accessible
5. Conformité stricte RGPD + législation française + Côte d'Ivoire

**Structure HTML simple attendue :**
```html
<h2>Titre de section</h2>
<p>Paragraphe explicatif...</p>
<ul>
<li>Élément de liste</li>
<li>Élément de liste</li>
</ul>
```

**Format final :** Dart String avec échappement correct des caractères pour copier-coller directement dans mon fichier `legal_content.dart`.

---

Génère maintenant les 3 documents légaux complets et prêts à l'emploi !
```

---

## 📌 INSTRUCTIONS D'UTILISATION

### 1. **Copier le prompt ci-dessus**
Sélectionner tout le texte entre les ``` (le prompt)

### 2. **Personnaliser VOS informations**
Remplacer dans le prompt :
- `[Votre nom/entreprise]`
- `[Votre numéro SIRET]`
- `[Votre adresse complète]`
- `[Votre numéro de téléphone]`
- Etc.

### 3. **Coller dans un LLM**
Options recommandées :
- **ChatGPT** (GPT-4) : https://chat.openai.com
- **Claude** (Sonnet/Opus) : https://claude.ai
- **Mistral** : https://chat.mistral.ai

### 4. **Récupérer la réponse**
Le LLM va générer 3 textes légaux complets

### 5. **Copier dans legal_content.dart**
Remplacer les strings dans :
- `_mentionsLegales['body']`
- `_politiqueConfidentialite['body']`
- `_cgu['body']`

### 6. **Vérifier**
```powershell
flutter analyze
flutter run -d chrome
```

Naviguer vers :
- http://localhost:xxxxx/mentions-legales
- http://localhost:xxxxx/politique-confidentialite
- http://localhost:xxxxx/cgu

---

## ⚖️ CONSEIL JURIDIQUE

**Important :** Ce prompt génère une base solide conforme RGPD, MAIS :

1. **Vérifier avec un avocat** si :
   - Activité réglementée (santé, finance, etc.)
   - Traitement de données sensibles
   - Commerce vers l'UE depuis Côte d'Ivoire

2. **Adapter selon votre structure** :
   - Personne physique vs société
   - Micro-entreprise vs SARL/SAS
   - Activité commerciale vs associative

3. **Mettre à jour régulièrement** :
   - À chaque changement de service
   - Nouveaux cookies/analytics
   - Évolution législation

---

## 🎯 EXEMPLE DE RÉSULTAT ATTENDU

Le LLM devrait retourner quelque chose comme :

```dart
'body': '''
<h2>1. Éditeur du site</h2>
<p>Le site nascentia-tech.com est édité par :</p>
<p><strong>NASCENTIA SARL</strong><br>
Société à Responsabilité Limitée au capital de 1 000 000 FCFA<br>
SIRET : [votre SIRET]<br>
RCS : Abidjan [numéro]<br>
<br>
Siège social :<br>
Cocody, [Adresse complète]<br>
Abidjan, Côte d'Ivoire<br>
...
```

Vous copiez-collez directement dans `legal_content.dart` !

---

## ✅ CHECKLIST FINALE

Après génération et intégration :

- [ ] Toutes les `[...]` remplacées par vraies infos
- [ ] Numéros SIRET/RCS vérifiés
- [ ] Adresse complète et correcte
- [ ] Email et téléphone à jour
- [ ] Nom directeur publication correct
- [ ] Test de chaque page légale
- [ ] Liens footer fonctionnels
- [ ] Aucune erreur `flutter analyze`
- [ ] Design cohérent avec le site

**Durée estimée totale : 30 minutes** (personnalisation + copie + test)

---

Bonne génération ! 🚀
