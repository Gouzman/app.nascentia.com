# 🚨 FIX SPF - Action Immédiate

## Problème détecté
MXToolbox montre : **"A null DNS lookup was found for include (premiumsmtp)"**

Cela empêche la livraison des emails (SPF fail).

## Solution

### 1️⃣ Dans cPanel → Zone Editor → nascentia-tech.com

Trouver l'enregistrement SPF (TXT) et remplacer par **EXACTEMENT** :

```
v=spf1 include:spf.brevo.com ip4:91.234.194.126 +a +mx ~all
```

⚠️ **IMPORTANT** :
- **SUPPRIMER** `include:premiumsmtp.dnshostservices.com` (cause l'erreur null)
- Garder seulement `include:spf.brevo.com` (suffisant pour Brevo)
- Garder `ip4:91.234.194.126` (IP de votre serveur LWS)

### 2️⃣ Pendant la propagation DNS (15-30 min)

**Vérifier les SPAMS** :
- Ouvrir Gmail → Dossier "Spam" / "Courriers indésirables"
- Chercher emails de `nascentia.info@gmail.com`
- Si trouvés → Marquer "Pas un spam" + Ajouter aux contacts

### 3️⃣ Après 15-30 minutes

Retester SPF sur MXToolbox :
https://mxtoolbox.com/spf.aspx

Doit afficher : ✅ **"Number of included lookups is OK"** (sans erreur null)

---

## Tests à faire après correction

1. Envoyer nouveau test formulaire contact
2. S'inscrire avec nouvel email newsletter
3. Vérifier réception dans **inbox** (plus dans spam)

---

## Pourquoi supprimer premiumsmtp ?

- LWS Premium SMTP n'est **PAS nécessaire** avec Brevo
- Brevo utilise ses propres serveurs SMTP
- Cette inclusion cause une erreur DNS (lookup null)
- En la supprimant, SPF sera valide et emails livrés

---

## Configuration finale recommandée

```
SPF (TXT) :  v=spf1 include:spf.brevo.com ip4:91.234.194.126 +a +mx ~all
DKIM 1    :  brevo1._domainkey → b1.nascentia-tech-com.dkim.brevo.com
DKIM 2    :  brevo2._domainkey → b2.nascentia-tech-com.dkim.brevo.com
DMARC     :  _dmarc → v=DMARC1; p=none
```

Cette configuration simple et propre = **100% compatible Brevo**.
