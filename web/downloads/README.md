# Downloads - NASCENTIA APK

> ⚠️ **Ce dossier est obsolète.** L'APK n'est plus servi depuis ce dossier local.

## Hébergement actuel de l'APK

L'APK est hébergé sur **Supabase Storage** et l'URL publique est générée dynamiquement par `lib/services/supabase_config.dart` :

```
{SUPABASE_URL}/storage/v1/object/public/uploads/nascentia.apk
```

## Comment mettre à jour l'APK

1. Connecte-toi à ton projet Supabase → **Storage** → bucket `uploads`
2. Remplace le fichier `nascentia.apk` par la nouvelle version

## Fichiers concernés

- `lib/services/supabase_config.dart` — URL publique Supabase Storage
- `lib/pages/download_page.dart` — bouton de téléchargement principal
- `lib/sections/app_section.dart` — bouton CTA dans la section App
