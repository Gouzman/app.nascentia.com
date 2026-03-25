# ✅ CHECKLIST DÉPLOIEMENT CPANEL - NASCENTIA

**Date du déploiement :** _______________
**Version :** _______________
**Déployé par :** _______________

---

## 🔧 PRÉPARATION LOCALE

```
☐ 1. Code testé et fonctionnel en local
☐ 2. Toutes les modifications commit dans Git
☐ 3. Variable .env correctement configurées
```

---

## 📦 BUILD DE PRODUCTION

```
☐ 4. Lancer: .\build-prod.ps1
☐ 5. Build réussi sans erreurs
☐ 6. Vérifier build\web\version.json contient:
     - build_hash: _______________
     - build_date: _______________
☐ 7. Vérifier présence de build\web\.htaccess
☐ 8. Vérifier présence de build\web\version-check.js
```

---

## 🧪 TEST LOCAL (OPTIONNEL)

```
☐ 9. cd build\web
☐ 10. python -m http.server 8080
☐ 11. Ouvrir http://localhost:8080
☐ 12. Vérifier:
      ☐ Chargement rapide (2-5s)
      ☐ Images s'affichent
      ☐ Scroll fluide
      ☐ Formulaires fonctionnent
      ☐ Pas d'erreurs console (F12)
```

---

## 📤 DÉPLOIEMENT CPANEL

### Connexion

```
☐ 13. Ouvrir: https://_______________/cpanel
☐ 14. Se connecter avec identifiants
☐ 15. Aller dans "Gestionnaire de fichiers"
☐ 16. Naviguer vers public_html/ (ou dossier du site)
```

### Configuration d'affichage

```
☐ 17. Activer "Afficher les fichiers cachés"
      (Icône ⚙️ en haut à droite)
```

### Sauvegarde (IMPORTANT)

```
☐ 18. Télécharger sauvegarde des fichiers actuels
      (Sélectionner tout → Compresser → Télécharger le ZIP)
☐ 19. Nom de la sauvegarde: backup-_______________
☐ 20. Sauvegarde enregistrée localement
```

### Nettoyage

```
☐ 21. Sélectionner TOUS les fichiers dans public_html/
☐ 22. ATTENTION: Ne PAS supprimer .htaccess initial si critique
☐ 23. Cliquer "Supprimer"
☐ 24. Confirmer la suppression
```

### Téléchargement

**Option A : ZIP (Recommandée)**

```
☐ 25. Lancer localement: .\prepare-cpanel.ps1
☐ 26. ZIP créé: nascentia-web-_______________.zip
☐ 27. Dans cPanel, cliquer "Télécharger"
☐ 28. Sélectionner le ZIP
☐ 29. Attendre 100% du téléchargement
☐ 30. Clic droit sur le ZIP → "Extraire"
☐ 31. Vérifier l'extraction réussie
☐ 32. Supprimer le ZIP
```

**Option B : Fichiers individuels**

```
☐ 25. Dans cPanel, cliquer "Télécharger"
☐ 26. Sélectionner TOUT le contenu de build\web\
      (Ctrl+A dans l'explorateur Windows)
☐ 27. Attendre la fin du téléchargement de tous les fichiers
☐ 28. Vérifier le nombre de fichiers téléchargés
```

### Vérification des fichiers critiques

```
☐ 33. Vérifier présence de .htaccess
      (Si invisible, réactiver "Afficher fichiers cachés")
☐ 34. Vérifier présence de version-check.js
☐ 35. Vérifier présence de version.json
☐ 36. Vérifier présence de index.html
☐ 37. Vérifier les dossiers:
      ☐ assets/
      ☐ canvaskit/
      ☐ icons/
```

---

## ✅ VÉRIFICATION POST-DÉPLOIEMENT

### Test basique

```
☐ 38. Ouvrir en navigation privée:
      https://_______________
☐ 39. Le site se charge (2-5 secondes max)
☐ 40. Les images CDN s'affichent
☐ 41. Le scroll fonctionne
☐ 42. Pas d'erreurs visibles
```

### Test du version.json

```
☐ 43. Ouvrir: https://_______________/version.json
☐ 44. Vérifier le contenu:
      {
        "app_name": "nascentia",
        "version": "1.0.0",
        "build_number": "1",
        "package_name": "nascentia",
        "build_hash": "_______________",
        "build_date": "_______________"
      }
☐ 45. Le build_hash correspond au build local
```

### Test des headers HTTP

```
☐ 46. Ouvrir DevTools (F12)
☐ 47. Onglet "Network"
☐ 48. Recharger la page (Ctrl+R)
☐ 49. Cliquer sur "index.html"
☐ 50. Onglet "Headers"
☐ 51. Vérifier Response Headers:
      ☐ Cache-Control: no-cache, no-store, must-revalidate
      ☐ Content-Encoding: gzip (compression active)
```

### Test du version checker

```
☐ 52. Ouvrir Console (F12)
☐ 53. Rechercher dans les logs:
      ☐ "✅ Version actuelle: {version:..."
      ☐ "✅ Version checker initialisé..."
☐ 54. Pas d'erreurs JavaScript
```

### Test des formulaires

```
☐ 55. Tester le formulaire de contact
☐ 56. Email envoyé avec succès via Brevo
☐ 57. Vérifier réception sur contact@nascentia-tech.com
```

---

## 📱 TEST MOBILE

```
☐ 58. Chrome DevTools → Device Mode (Ctrl+Shift+M)
☐ 59. Tester sur iPhone SE (375x667)
☐ 60. Tester sur iPad (768x1024)
☐ 61. Vérifier l'affichage responsive
☐ 62. Tester le menu burger (mobile)
☐ 63. Tester le scroll sur mobile
```

---

## 🎉 TEST DE MISE À JOUR AUTOMATIQUE

### Simulation de mise à jour

```
☐ 64. Laisser le site ouvert pendant 5 minutes
☐ 65. Modifier un petit texte dans le code
☐ 66. Rebuild: .\build-prod.ps1
☐ 67. Redéployer sur cPanel
☐ 68. Sur le site ouvert, attendre max 5 minutes
☐ 69. Une notification devrait apparaître:
      "🚀 Nouvelle version disponible !"
☐ 70. Cliquer sur "Mettre à jour maintenant"
☐ 71. La page se recharge avec la nouvelle version
```

---

## 📊 MONITORING (24-48H APRÈS)

```
☐ 72. Vérifier Google Analytics:
      ☐ Taux de rebond < 40%
      ☐ Temps de chargement < 5s
      ☐ Pages par session > 3
☐ 73. Vérifier les journaux d'erreur cPanel
☐ 74. Vérifier les retours utilisateurs
☐ 75. Pas de plaintes sur la mise en cache
```

---

## 🔧 EN CAS DE PROBLÈME

### Rollback d'urgence

```
☐ 76. Télécharger la sauvegarde depuis le PC
☐ 77. Dans cPanel, supprimer les nouveaux fichiers
☐ 78. Extraire la sauvegarde backup-_______________
☐ 79. Tester que l'ancienne version fonctionne
☐ 80. Analyser les logs d'erreur
```

### Contact support hébergeur

```
☐ 81. Vérifier que mod_rewrite est activé
☐ 82. Vérifier que mod_headers est activé
☐ 83. Vérifier les permissions (755 dossiers, 644 fichiers)
☐ 84. Vérifier les quotas (espace disque, bande passante)
```

---

## 📝 NOTES DU DÉPLOIEMENT

```
Problèmes rencontrés:
_________________________________________________________________
_________________________________________________________________
_________________________________________________________________

Solutions appliquées:
_________________________________________________________________
_________________________________________________________________
_________________________________________________________________

Temps total du déploiement: ________ minutes

Observations:
_________________________________________________________________
_________________________________________________________________
_________________________________________________________________
```

---

## 🎓 PROCHAINE FOIS

**Améliorations identifiées :**

```
☐ _________________________________________________________________
☐ _________________________________________________________________
☐ _________________________________________________________________
```

---

## ✅ VALIDATION FINALE

```
☐ Le site est accessible publiquement
☐ Le site se charge rapidement (< 5s)
☐ Toutes les fonctionnalités marchent
☐ Le système de cache fonctionne
☐ La notification de mise à jour s'affiche
☐ Aucune erreur dans les logs
☐ Équipe/client informé du déploiement
```

---

**🎉 DÉPLOIEMENT TERMINÉ AVEC SUCCÈS !**

**Signature :** _______________
**Date/Heure :** _______________
