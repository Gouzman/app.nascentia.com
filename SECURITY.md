# 🔐 Guide de Sécurité - Configuration Supabase

## ⚠️ ACTION IMMÉDIATE REQUISE

Les clés Supabase dans ce projet ont été exposées en clair dans le code. Vous DEVEZ régénérer les clés immédiatement.

## Étapes de Sécurisation

### 1. Régénérer les Clés Supabase

1. Connectez-vous à [Supabase Console](https://app.supabase.com)
2. Sélectionnez votre projet `ukqbpzpqlaejgddzsqml`
3. Allez dans **Settings** → **API**
4. Cliquez sur **Reset anon key** (ou générer une nouvelle clé)
5. Copiez la nouvelle clé

### 2. Configurer les Variables d'Environnement

Le fichier `.env` contient actuellement les anciennes clés (pour référence). Mettez-le à jour :

```bash
# .env (déjà dans .gitignore)
SUPABASE_URL=https://ukqbpzpqlaejgddzsqml.supabase.co
SUPABASE_ANON_KEY=VOTRE_NOUVELLE_CLE_ICI
```

### 3. Lancer l'Application

**Développement avec Chrome :**
```powershell
flutter run -d chrome --dart-define=SUPABASE_URL=https://ukqbpzpqlaejgddzsqml.supabase.co --dart-define=SUPABASE_ANON_KEY=votre_nouvelle_cle
```

**Build Production Web :**
```powershell
flutter build web --dart-define=SUPABASE_URL=https://ukqbpzpqlaejgddzsqml.supabase.co --dart-define=SUPABASE_ANON_KEY=votre_nouvelle_cle
```

### 4. Créer un Script PowerShell (Optionnel)

Pour simplifier, créez `run-dev.ps1` :

```powershell
# run-dev.ps1
$env:SUPABASE_URL = "https://ukqbpzpqlaejgddzsqml.supabase.co"
$env:SUPABASE_ANON_KEY = "votre_nouvelle_cle"

flutter run -d chrome `
  --dart-define=SUPABASE_URL=$env:SUPABASE_URL `
  --dart-define=SUPABASE_ANON_KEY=$env:SUPABASE_ANON_KEY
```

Utilisation : `.\run-dev.ps1`

## Vérification de Sécurité Supabase

Connectez-vous à Supabase Console et vérifiez :

- ✅ **RLS (Row Level Security)** activé sur toutes les tables
- ✅ **Policies** configurées pour limiter `anon` à lecture seule
- ✅ **API Rate Limiting** activé
- ✅ **CORS** configuré pour votre domaine uniquement

## Important

- ❌ **NE JAMAIS** commit `.env` dans Git
- ✅ Utiliser `.env.example` comme template
- ✅ Documenter les variables requises dans le README
- ✅ Utiliser des clés différentes pour dev/staging/production

## Alternative : flutter_dotenv

Si vous préférez utiliser un package pour gérer `.env` :

```yaml
# pubspec.yaml
dependencies:
  flutter_dotenv: ^5.1.0
```

```dart
// main.dart
import 'package:flutter_dotenv/flutter_dotenv.dart';

Future<void> main() async {
  await dotenv.load(fileName: ".env");
  // ...
}
```

Mais la méthode `--dart-define` est recommandée car elle ne nécessite pas de dépendance supplémentaire.
