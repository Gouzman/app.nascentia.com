# Configuration Google Search Console - NASCENTIA

## Code de vérification TXT

```
google-site-verification=gsWYJAnRrHIYxmSgypAZW9azYZ5yVLMgCr
```

---

## Guide selon votre hébergeur

### 🟠 Si vous êtes chez **OVH**

1. Connectez-vous sur https://www.ovh.com/manager/
2. Allez dans **Web Cloud** → **Noms de domaine**
3. Cliquez sur **nascentia-tech.com**
4. Onglet **Zone DNS**
5. Cliquez sur **Ajouter une entrée**
6. Choisissez **TXT**
7. Laissez le sous-domaine vide (ou mettez juste `@`)
8. Dans **Valeur**, collez : `google-site-verification=gsWYJAnRrHIYxmSgypAZW9azYZ5yVLMgCr`
9. Cliquez sur **Suivant** puis **Valider**
10. Attendez 5-15 minutes puis retournez dans Google Search Console et cliquez sur **VALIDER**

---

### 🔵 Si vous êtes chez **cPanel** (hébergement mutualisé)

1. Connectez-vous à votre **cPanel**
2. Cherchez la section **Domaines** → **Zone Editor** (ou **Éditeur de zone**)
3. Trouvez **nascentia-tech.com** et cliquez sur **Gérer**
4. Cliquez sur **+ Ajouter un enregistrement**
5. **Type** : TXT
6. **Nom** : `@` (ou laissez vide, ou mettez `nascentia-tech.com`)
7. **Valeur TTL** : 14400 (ou laissez par défaut)
8. **Enregistrement TXT** : `google-site-verification=gsWYJAnRrHIYxmSgypAZW9azYZ5yVLMgCr`
9. Cliquez sur **Ajouter un enregistrement**
10. Attendez 5-15 minutes puis cliquez sur **VALIDER** dans Google Search Console

---

### 🟢 Si vous êtes chez **Cloudflare**

1. Connectez-vous sur https://dash.cloudflare.com/
2. Sélectionnez le domaine **nascentia-tech.com**
3. Allez dans l'onglet **DNS** → **Records**
4. Cliquez sur **Add record**
5. **Type** : TXT
6. **Name** : `@` (ou laissez vide)
7. **Content** : `google-site-verification=gsWYJAnRrHIYxmSgypAZW9azYZ5yVLMgCr`
8. **TTL** : Auto
9. **Proxy status** : DNS only (nuage gris)
10. Cliquez sur **Save**
11. Attendez 2-5 minutes puis cliquez sur **VALIDER** dans Google Search Console

---

### 🟡 Si vous êtes chez **Namecheap**

1. Connectez-vous sur https://www.namecheap.com/
2. Allez dans **Domain List** → Cliquez sur **Manage** à côté de nascentia-tech.com
3. Onglet **Advanced DNS**
4. Section **Host Records**, cliquez sur **Add New Record**
5. **Type** : TXT Record
6. **Host** : `@`
7. **Value** : `google-site-verification=gsWYJAnRrHIYxmSgypAZW9azYZ5yVLMgCr`
8. **TTL** : Automatic
9. Cliquez sur **Save All Changes** (en bas de page)
10. Attendez 5-15 minutes puis cliquez sur **VALIDER** dans Google Search Console

---

### 🔴 Si vous êtes chez **GoDaddy**

1. Connectez-vous sur https://dcc.godaddy.com/
2. Allez dans **Mes produits** → **Domaines**
3. Cliquez sur **nascentia-tech.com** puis sur **DNS**
4. Descendez jusqu'à la section **Enregistrements**
5. Cliquez sur **Ajouter**
6. **Type** : TXT
7. **Nom** : `@`
8. **Valeur** : `google-site-verification=gsWYJAnRrHIYxmSgypAZW9azYZ5yVLMgCr`
9. **TTL** : 1 heure
10. Cliquez sur **Enregistrer**
11. Attendez 5-15 minutes puis cliquez sur **VALIDER** dans Google Search Console

---

## ✅ Après validation

Une fois la propriété validée, vous pourrez :

1. **Demander l'indexation** de vos nouvelles pages
2. **Voir les performances** de recherche (clics, impressions, CTR)
3. **Soumettre votre sitemap** : https://nascentia-tech.com/sitemap.xml
4. **Suivre les erreurs** d'exploration
5. **Demander une ré-indexation urgente** pour mettre à jour le logo et la description

---

## 🔍 Vérifier la propagation DNS

Après avoir ajouté l'enregistrement TXT, vous pouvez vérifier qu'il est bien propagé :

```powershell
nslookup -type=TXT nascentia-tech.com
```

Vous devriez voir votre code de vérification Google dans les résultats.

---

## ⚠️ Important

- La propagation DNS peut prendre de **5 minutes à 24 heures** selon les hébergeurs
- Si Google dit "échec de validation", attendez 30 minutes et réessayez
- Le code de vérification TXT doit rester dans votre DNS **indéfiniment** pour que Google continue à vous reconnaître comme propriétaire
