# 🔍 Guide : Trouver ou Créer l'enregistrement SPF dans cPanel

## Option 1 : Chercher l'enregistrement TXT existant

### Dans Zone Editor (cPanel → Domaines → Zone Editor)

1. **Sélectionner le domaine** : `nascentia-tech.com`
2. Cliquer sur **"Gérer"** ou **"Manage"**
3. Chercher dans la liste des enregistrements :

**Types à chercher :**
- Type = **TXT**
- Nom = **nascentia-tech.com** OU **@** OU **(vide)**
- Valeur contient : `v=spf1`

### Comment identifier le SPF ?

L'enregistrement ressemble à :
```
Type : TXT
Nom  : nascentia-tech.com (ou @)
Valeur : v=spf1 ip4:91.234.194.126 include:premiumsmtp...
```

**Si vous le trouvez** → Passer à "Modifier l'enregistrement" ci-dessous

---

## Option 2 : Si AUCUN enregistrement SPF trouvé

### Créer un NOUVEAU record TXT

Dans **Zone Editor → Gérer** :

1. Cliquer **"Ajouter un enregistrement"** ou **"Add Record"**
2. Sélectionner **Type : TXT**
3. Remplir :

```
Nom (Name)    : @
              (ou laisser vide)
              (ou nascentia-tech.com)

TTL           : 3600

Valeur (TXT)  : v=spf1 include:spf.brevo.com ip4:91.234.194.126 +a +mx ~all
```

4. **Enregistrer/Sauvegarder**

---

## Option 3 : Modifier un enregistrement existant

Si vous avez trouvé un TXT avec `v=spf1` :

1. Cliquer sur **"Modifier"** ou **"Edit"** (icône crayon)
2. Remplacer la **Valeur** par :

```
v=spf1 include:spf.brevo.com ip4:91.234.194.126 +a +mx ~all
```

3. **Enregistrer**

---

## 🔍 Autre emplacement possible

### Si Zone Editor ne montre rien

Essayez dans **cPanel → Email → SPF Records** (si disponible) :

1. Chercher dans le menu Email
2. Section "Deliverability" → "Email Deliverability"
3. Ou "Advanced DNS Zone Editor"

### Alternative : Fichier .htaccess ou configuration DNS externe

Si votre DNS est géré **hors de cPanel** (ex: Cloudflare, externe) :
- Aller sur votre gestionnaire DNS externe
- Créer l'enregistrement TXT là-bas

---

## ✅ Après création/modification

### Vérifier immédiatement dans cPanel

Retourner dans **Zone Editor → Gérer** et confirmer que vous voyez :

```
Type  : TXT
Nom   : nascentia-tech.com (ou @)
Valeur: v=spf1 include:spf.brevo.com ip4:91.234.194.126 +a +mx ~all
```

### Tester la propagation (après 15-30 min)

```
https://mxtoolbox.com/spf.aspx
Entrer : nascentia-tech.com
```

Doit afficher : ✅ Tous les tests verts (sans "null value")

---

## 🆘 Si toujours introuvable

**Faites une capture d'écran de :**
1. cPanel → Zone Editor → Liste complète des enregistrements
2. Montrez tous les records **Type TXT** visibles

Je pourrai identifier exactement où se trouve le SPF ou confirmer qu'il faut le créer.

---

## 📋 Valeur SPF finale à utiliser

```
v=spf1 include:spf.brevo.com ip4:91.234.194.126 +a +mx ~all
```

**Ne pas oublier :**
- Pas d'espace au début/fin
- Copier-coller exactement cette ligne
- Supprimer tout `include:premiumsmtp` si présent
