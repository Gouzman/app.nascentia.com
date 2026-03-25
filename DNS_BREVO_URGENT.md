# 🔐 CONFIGURATION DNS BREVO - GUIDE URGENT

## ⚠️ PROBLÈME ACTUEL

Vous envoyez des emails depuis `contact@nascentia-tech.com` mais ils **ne sont pas reçus** car les DNS ne sont pas configurés.

**Résultat :** Les emails sont bloqués ou vont directement dans les SPAMS.

---

## 🎯 SOLUTION : Configurer les DNS dans cPanel LWS

### Étape 1 : Connexion à cPanel

1. Allez sur : `https://www.nascentia-tech.com/cpanel`
2. Connectez-vous avec vos identifiants LWS
3. Cherchez "**Zone Editor**" ou "**Éditeur de zone DNS**"

---

### Étape 2 : Ajouter les 4 enregistrements DNS

Voici EXACTEMENT ce que Brevo vous a fourni :

#### 1️⃣ **TXT - Vérification domaine**

```
Type:  TXT
Nom:   nascentia-tech.com (ou @ ou vide)
Valeur: v=spf1 include:spf.brevo.com ~all
TTL:   3600 (ou défaut)
```

#### 2️⃣ **CNAME - DKIM 1**

```
Type:  CNAME
Nom:   nascentia1._domainkey.nascentia-tech.com
Cible: nascentia1._domainkey.brevo.net
TTL:   3600
```

#### 3️⃣ **CNAME - DKIM 2**

```
Type:  CNAME
Nom:   nascentia2._domainkey.nascentia-tech.com
Cible: nascentia2._domainkey.brevo.net
TTL:   3600
```

#### 4️⃣ **TXT - DMARC**

```
Type:  TXT
Nom:   _dmarc.nascentia-tech.com
Valeur: v=DMARC1; p=none
TTL:   3600
```

---

### Étape 3 : Vérification dans cPanel

#### Interface cPanel typique :

1. **Zone Editor** ou **Éditeur de zone DNS**
2. Sélectionner le domaine : `nascentia-tech.com`
3. Cliquer sur "**+ Add Record**" ou "**Ajouter un enregistrement**"
4. Pour chaque enregistrement :
   - Choisir le **Type** (TXT ou CNAME)
   - Entrer le **Nom** (exactement comme ci-dessus)
   - Entrer la **Valeur/Cible**
   - Sauvegarder

---

### Étape 4 : Attendre la propagation

⏱️ **Temps de propagation :** 15 minutes à 48 heures (généralement 1-2 heures)

**Vérifier la propagation :**
```
https://mxtoolbox.com/SuperTool.aspx
```

Tester :
- SPF : `nascentia-tech.com`
- DKIM : `nascentia1._domainkey.nascentia-tech.com`
- DMARC : `_dmarc.nascentia-tech.com`

---

### Étape 5 : Vérifier dans Brevo

1. Aller sur https://app.brevo.com/
2. **Settings** → **Senders & IP**
3. Vérifier que `contact@nascentia-tech.com` a le statut : ✅ **Verified**
4. Les DNS doivent être validés (cochés en vert)

---

## 🧪 TEST APRÈS CONFIGURATION

### 1. Attendez 1-2 heures

### 2. Testez l'envoi d'email

```powershell
# Relancer le site
.\run-dev.ps1
```

### 3. Remplir le formulaire de contact sur le site

- Utilisez votre email personnel
- Vérifiez la réception dans :
  - ✅ Boîte de réception
  - ⚠️ Dossier spam (si DNS pas encore propagés)

### 4. Vérifier les logs

```
[BREVO] ✅ Email envoyé avec succès!
[BREVO] Message ID: <...>
```

Si vous voyez ça, c'est bon côté technique ! Le problème est uniquement DNS.

---

## ❌ ERREURS FRÉQUENTES

### Erreur 1 : Nom du CNAME mal saisi

❌ **Incorrect :**
```
nascentia1._domainkey
```

✅ **Correct :**
```
nascentia1._domainkey.nascentia-tech.com
```

### Erreur 2 : Valeur SPF mal copiée

❌ **Incorrect :**
```
include:spf.brevo.com
```

✅ **Correct :**
```
v=spf1 include:spf.brevo.com ~all
```

### Erreur 3 : Oublier le point à la fin

Certains systèmes DNS exigent un point final :

```
nascentia1._domainkey.brevo.net.  ← Noter le point
```

---

## 🎯 APRÈS CONFIGURATION

### Avantages immédiats :

✅ Les emails arrivent dans la boîte de réception (pas spam)
✅ Meilleure délivrabilité (99% au lieu de 20%)
✅ Réputation domaine préservée
✅ Confiance des clients augmentée

---

## 🆘 EN CAS DE PROBLÈME

### Support LWS :
- Email : assistance@lws.fr
- Téléphone : 01 77 62 30 03
- Chat : https://www.lws.fr/support.php

**Demander :** "Bonjour, je souhaite configurer les enregistrements DNS SPF/DKIM/DMARC pour Brevo sur mon domaine nascentia-tech.com"

### Support Brevo :
- https://help.brevo.com/
- Chat en bas à droite du dashboard

---

## 📊 VÉRIFICATION FINALE

Une fois les DNS configurés et propagés, testez avec ces outils :

1. **MXToolbox** : https://mxtoolbox.com/SuperTool.aspx
   - SPF : `nascentia-tech.com`
   - DKIM : `nascentia1._domainkey.nascentia-tech.com`
   - DMARC : `_dmarc.nascentia-tech.com`

2. **Mail-tester** : https://www.mail-tester.com/
   - Envoyez un email test
   - Score doit être > 8/10

3. **Brevo Dashboard** :
   - Status sender : ✅ Verified
   - Authentication : ✅ All records configured

---

## ⚡ PROCHAINES ÉTAPES

```
☐ 1. Se connecter à cPanel LWS
☐ 2. Aller dans Zone Editor
☐ 3. Ajouter les 4 enregistrements DNS (copier-coller exact)
☐ 4. Sauvegarder
☐ 5. Attendre 1-2 heures
☐ 6. Vérifier sur mxtoolbox.com
☐ 7. Vérifier dans Brevo Dashboard (✅ Verified)
☐ 8. Tester l'envoi d'email depuis le site
☐ 9. Vérifier réception dans votre boîte email
```

---

## 🎉 RÉSULTAT ATTENDU

**AVANT (sans DNS) :**
- ❌ Emails bloqués ou spam
- ❌ Délivrabilité ~20%
- ❌ Réputation domaine endommagée

**APRÈS (avec DNS) :**
- ✅ Emails arrivent en boîte de réception
- ✅ Délivrabilité ~99%
- ✅ Réputation domaine protégée
- ✅ Expérience utilisateur professionnelle

---

**🔥 PRIORITÉ ABSOLUE : Configurez les DNS AUJOURD'HUI pour que les emails fonctionnent !**
