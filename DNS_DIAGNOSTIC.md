# Diagnostic DNS - Email non reçu

**Date:** 25 mars 2026
**Problème:** Emails envoyés depuis le formulaire mais non reçus

## Points à vérifier immédiatement

### 1. Délai de propagation DNS
- ⏱️ **Combien de temps depuis la modification DNS SPF ?**
- La propagation DNS prend **15-30 minutes** (parfois jusqu'à 48h)
- Si modifié il y a moins d'1 heure → **C'EST NORMAL**

### 2. Vérifier la propagation SPF

**Test en ligne:** https://mxtoolbox.com/spf.aspx

Recherchez: `nascentia-tech.com`

✅ **Valeur attendue:**
```
v=spf1 include:spf.brevo.com include:premiumsmtp.dnshostservices.com ip4:91.234.194.126 +a +mx ~all
```

❌ **Si vous voyez encore l'ancienne valeur:**
- DNS pas encore propagé
- Attendre encore 15-30 minutes
- Retester

### 3. Vérifier les logs Brevo dans le terminal

Quand vous testez le formulaire, vous devriez voir:

✅ **Si l'email est envoyé:**
```
[BREVO] ✅ Email envoyé avec succès!
[BREVO] Message ID: <...>
```

❌ **Si erreur:**
```
[BREVO] ❌ Erreur 403: Forbidden
[BREVO] ❌ Erreur 401: Unauthorized
```

### 4. Vérifier le dossier SPAM

⚠️ **IMPORTANT:** Pendant la période de propagation DNS, **les emails peuvent aller en SPAM**

**Où chercher:**
1. Gmail → Dossier "Spam" ou "Courrier indésirable"
2. Outlook → Dossier "Courrier indésirable"
3. Autre client email → Vérifier le filtre anti-spam

**Recherche par expéditeur:**
- `contact@nascentia-tech.com`
- Sujet contenant "NASCENTIA"

### 5. Test DNS complet

**Commandes à exécuter:**

```powershell
# Test SPF
nslookup -type=TXT nascentia-tech.com

# Test DKIM 1
nslookup -type=CNAME brevo1._domainkey.nascentia-tech.com

# Test DKIM 2
nslookup -type=CNAME brevo2._domainkey.nascentia-tech.com

# Test DMARC
nslookup -type=TXT _dmarc.nascentia-tech.com
```

## Actions à faire MAINTENANT

### ✅ Action 1: Tester MXToolbox
1. Allez sur https://mxtoolbox.com/spf.aspx
2. Entrez: `nascentia-tech.com`
3. Cliquez "SPF Record Lookup"
4. **Faites une capture d'écran du résultat**

### ✅ Action 2: Vérifier les logs
1. Ouvrez le terminal PowerShell où `.\run-dev.ps1` tourne
2. Testez le formulaire de contact
3. **Copiez les logs qui apparaissent** (lignes [BREVO])

### ✅ Action 3: Chercher dans SPAM
1. Ouvrez votre boîte email (celle utilisée pour tester)
2. Vérifiez le dossier **SPAM/Courrier indésirable**
3. Cherchez "NASCENTIA" ou "contact@nascentia-tech.com"

### ✅ Action 4: Tester avec votre email
Quel email utilisez-vous pour tester ?
- `elie.gouzou@gmail.com` → Vérifier Gmail spam
- Autre → Préciser lequel

## Diagnostic rapide selon les résultats

| Symptôme | Cause probable | Solution |
|----------|---------------|----------|
| Logs [BREVO] ✅ Email envoyé + Message ID | DNS pas propagé OU spam | Attendre propagation + vérifier spam |
| Logs [BREVO] ❌ Erreur 403 | Sender email non vérifié | Vérifier Brevo Dashboard |
| Logs [BREVO] ❌ Erreur 401 | API Key incorrecte | Vérifier .env |
| Aucun log [BREVO] | Formulaire ne se soumet pas | Vérifier erreurs JavaScript |
| Email en spam | DNS SPF incomplet | Attendre propagation complète |

## Prochaines étapes selon votre situation

**Si DNS PAS ENCORE PROPAGÉ (MXToolbox montre ancienne valeur):**
- ⏱️ **Attendre** 30 minutes de plus
- ☕ Prendre un café
- 🔄 Retester après

**Si DNS PROPAGÉ (MXToolbox montre include:spf.brevo.com):**
- 📧 Tester envoi email via formulaire
- 📥 Vérifier réception dans les 2-5 minutes
- ⚠️ Si toujours rien → vérifier spam

**Si email en SPAM:**
- ✅ Marquer comme "Non spam"
- ✅ Ajouter contact@nascentia-tech.com aux contacts
- 🔄 Retester → devrait arriver en boîte normale

**Si aucun log [BREVO] n'apparaît:**
- 🔍 Vérifier console navigateur (F12)
- 🔍 Chercher erreurs JavaScript
- 📞 Me montrer captures d'écran

## Informations à me fournir

Pour diagnostiquer précisément, envoyez-moi:

1. **Capture d'écran MXToolbox SPF** (https://mxtoolbox.com/spf.aspx)
2. **Logs terminal PowerShell** (après test formulaire)
3. **Heure de la modification DNS** ("il y a combien de temps ?")
4. **Email utilisé pour tester** (Gmail ? Outlook ? Autre ?)
5. **Résultat recherche spam** (trouvé quelque chose ?)

---

**Note importante:** Si vous avez modifié le DNS **il y a moins d'1 heure**, c'est NORMAL que les emails n'arrivent pas encore. La propagation DNS prend du temps. Patience! ⏳
