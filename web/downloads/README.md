# Downloads - NASCENTIA APK

Ce dossier contient les fichiers téléchargeables de l'application NASCENTIA.

## Structure

- `nascentia.apk` - Application Android APK (à ajouter ici)

## Instructions

1. **Placer l'APK** : Ajoutez votre fichier APK renommé comme `nascentia.apk` dans ce dossier
2. **Build pour production** : Exécutez `flutter build web` pour générer la version web
3. **Déploiement** : Le fichier sera servi automatiquement sur `https://domaine.com/downloads/nascentia.apk`

## Utilisation dans l'app

Les boutons de téléchargement ("Télécharger Android" et "Télécharger gratuitement") sont configurés pour télécharger le fichier `nascentia.apk` depuis ce dossier.

### Fichiers affectés:
- `lib/sections/app_section.dart` - Bouton de téléchargement dans la section CTA
- `lib/pages/download_page.dart` - Bouton de téléchargement principal dans la page de téléchargement

### URL de téléchargement
```
/downloads/nascentia.apk
```

Cette URL est générée dynamiquement et fonctionnera sur n'importe quel domaine.
