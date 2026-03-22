import 'dart:convert';
import 'package:http/http.dart' as http;
import 'package:flutter/foundation.dart';

/// Service d'envoi d'emails via Brevo (anciennement Sendinblue)
/// Documentation API: https://developers.brevo.com/reference/sendtransacemail
class BrevoService {
  // Clé API Brevo (à configurer via --dart-define)
  static const String _apiKey = String.fromEnvironment(
    'BREVO_API_KEY',
    defaultValue: '', // Ne JAMAIS mettre une vraie clé ici!
  );

  static const String _apiUrl = 'https://api.brevo.com/v3/smtp/email';

  /// Adresse email de l'expéditeur (doit être vérifiée dans Brevo)
  static const String senderEmail = String.fromEnvironment(
    'BREVO_SENDER_EMAIL',
    defaultValue: 'contact@nascentia-tech.com',
  );

  static const String senderName = 'NASCENTIA';

  /// Adresse email de réception (votre email professionnel)
  static const String receiverEmail = String.fromEnvironment(
    'BREVO_RECEIVER_EMAIL',
    defaultValue: 'nascentia.info@gmail.com',
  );

  /// Envoie un email de contact depuis le formulaire du site web
  ///
  /// **Paramètres:**
  /// - [name] : Nom complet de l'expéditeur
  /// - [email] : Email de l'expéditeur (pour répondre)
  /// - [subject] : Sujet du message
  /// - [message] : Contenu du message
  ///
  /// **Retour:**
  /// - `true` si l'email a été envoyé avec succès
  /// - `false` en cas d'erreur
  static Future<bool> sendContactEmail({
    required String name,
    required String email,
    required String subject,
    required String message,
  }) async {
    // Vérification de la clé API
    if (_apiKey.isEmpty) {
      debugPrint('[BREVO] ❌ Erreur: BREVO_API_KEY non configurée');
      debugPrint('[BREVO] ℹ️ Utilisez: flutter run --dart-define=BREVO_API_KEY=votre_cle');
      return false;
    }

    try {
      // Construction du corps de l'email HTML
      final String htmlContent = _buildContactEmailTemplate(
        name: name,
        email: email,
        subject: subject,
        message: message,
      );

      // Préparation de la requête API Brevo
      final Map<String, dynamic> emailData = {
        'sender': {
          'name': senderName,
          'email': senderEmail,
        },
        'to': [
          {
            'email': receiverEmail,
            'name': 'Équipe NASCENTIA',
          }
        ],
        'replyTo': {
          'email': email,
          'name': name,
        },
        'subject': '📧 Nouveau message depuis NASCENTIA-TECH.com - $subject',
        'htmlContent': htmlContent,
        'textContent': '''
Nouveau message depuis le site web NASCENTIA

Nom: $name
Email: $email
Sujet: $subject

Message:
$message

---
Envoyé depuis nascentia-tech.com
        ''',
      };

      // Envoi de la requête
      final response = await http.post(
        Uri.parse(_apiUrl),
        headers: {
          'accept': 'application/json',
          'api-key': _apiKey,
          'content-type': 'application/json',
        },
        body: jsonEncode(emailData),
      );

      if (response.statusCode == 201) {
        final responseData = jsonDecode(response.body);
        debugPrint('[BREVO] ✅ Email envoyé avec succès!');
        debugPrint('[BREVO] Message ID: ${responseData['messageId']}');
        return true;
      } else {
        debugPrint('[BREVO] ❌ Erreur ${response.statusCode}: ${response.body}');
        return false;
      }
    } catch (e, stackTrace) {
      debugPrint('[BREVO] ❌ Exception lors de l\'envoi: $e');
      debugPrint('[BREVO] StackTrace: $stackTrace');
      return false;
    }
  }

  /// Construit le template HTML professionnel pour l'email de contact
  static String _buildContactEmailTemplate({
    required String name,
    required String email,
    required String subject,
    required String message,
  }) {
    return '''
<!DOCTYPE html>
<html lang="fr">
<head>
  <meta charset="UTF-8">
  <meta name="viewport" content="width=device-width, initial-scale=1.0">
  <title>Nouveau message - NASCENTIA</title>
  <style>
    body {
      margin: 0;
      padding: 0;
      font-family: -apple-system, BlinkMacSystemFont, 'Segoe UI', Roboto, 'Helvetica Neue', Arial, sans-serif;
      background-color: #f5f5f5;
    }
    .container {
      max-width: 600px;
      margin: 40px auto;
      background-color: #ffffff;
      border-radius: 16px;
      overflow: hidden;
      box-shadow: 0 4px 20px rgba(0,0,0,0.1);
    }
    .header {
      background: linear-gradient(135deg, #E95263 0%, #582674 100%);
      padding: 40px 30px;
      text-align: center;
      color: #ffffff;
    }
    .header h1 {
      margin: 0 0 10px;
      font-size: 28px;
      font-weight: 700;
      letter-spacing: -0.5px;
    }
    .header p {
      margin: 0;
      font-size: 16px;
      opacity: 0.9;
    }
    .content {
      padding: 40px 30px;
    }
    .info-row {
      margin-bottom: 24px;
      padding-bottom: 24px;
      border-bottom: 1px solid #e5e5e5;
    }
    .info-row:last-child {
      border-bottom: none;
    }
    .label {
      display: block;
      font-size: 13px;
      font-weight: 600;
      text-transform: uppercase;
      letter-spacing: 0.5px;
      color: #666;
      margin-bottom: 8px;
    }
    .value {
      font-size: 16px;
      color: #1a1a1a;
      line-height: 1.6;
      word-wrap: break-word;
    }
    .message-box {
      background-color: #f8f8f8;
      border-left: 4px solid #E95263;
      padding: 20px;
      border-radius: 8px;
      margin-top: 10px;
    }
    .footer {
      background-color: #f8f8f8;
      padding: 30px;
      text-align: center;
      border-top: 1px solid #e5e5e5;
    }
    .footer p {
      margin: 6px 0;
      font-size: 14px;
      color: #666;
    }
    .footer a {
      color: #E95263;
      text-decoration: none;
      font-weight: 600;
    }
    .badge {
      display: inline-block;
      background: linear-gradient(135deg, #E95263 0%, #582674 100%);
      color: white;
      padding: 6px 14px;
      border-radius: 20px;
      font-size: 12px;
      font-weight: 600;
      letter-spacing: 0.5px;
      margin-bottom: 16px;
    }
  </style>
</head>
<body>
  <div class="container">
    <!-- Header -->
    <div class="header">
      <h1>✉️ NASCENTIA</h1>
      <p>Nouveau message depuis le site web</p>
    </div>

    <!-- Content -->
    <div class="content">
      <div class="badge">📧 FORMULAIRE DE CONTACT</div>

      <!-- Nom -->
      <div class="info-row">
        <span class="label">👤 Nom complet</span>
        <div class="value">${_escapeHtml(name)}</div>
      </div>

      <!-- Email -->
      <div class="info-row">
        <span class="label">📧 Adresse email</span>
        <div class="value">
          <a href="mailto:${_escapeHtml(email)}" style="color: #E95263; text-decoration: none;">
            ${_escapeHtml(email)}
          </a>
        </div>
      </div>

      <!-- Sujet -->
      <div class="info-row">
        <span class="label">📋 Sujet</span>
        <div class="value">${_escapeHtml(subject)}</div>
      </div>

      <!-- Message -->
      <div class="info-row">
        <span class="label">💬 Message</span>
        <div class="message-box">
          <div class="value">${_escapeHtml(message).replaceAll('\n', '<br>')}</div>
        </div>
      </div>
    </div>

    <!-- Footer -->
    <div class="footer">
      <p style="font-weight: 600; color: #333; margin-bottom: 12px;">
        🔔 Action requise: Répondre à ce message
      </p>
      <p>Cliquez sur "Répondre" pour contacter directement ${_escapeHtml(name)}</p>
      <p style="margin-top: 20px; font-size: 13px; color: #999;">
        Envoyé automatiquement depuis
        <a href="https://nascentia-tech.com">nascentia-tech.com</a>
        via Brevo
      </p>
      <p style="font-size: 12px; color: #999;">
        ${DateTime.now().toLocal().toString().split('.')[0]}
      </p>
    </div>
  </div>
</body>
</html>
    ''';
  }

  /// Échappe les caractères HTML pour éviter les injections XSS
  static String _escapeHtml(String text) {
    return text
        .replaceAll('&', '&amp;')
        .replaceAll('<', '&lt;')
        .replaceAll('>', '&gt;')
        .replaceAll('"', '&quot;')
        .replaceAll("'", '&#x27;');
  }

  /// Valide une adresse email
  static bool isValidEmail(String email) {
    final emailRegex = RegExp(
      r'^[a-zA-Z0-9._%+-]+@[a-zA-Z0-9.-]+\.[a-zA-Z]{2,}$',
    );
    return emailRegex.hasMatch(email);
  }

  /// Envoie un email de confirmation automatique à l'expéditeur
  /// (optionnel - à activer si souhaité)
  static Future<bool> sendAutoReplyEmail({
    required String recipientEmail,
    required String recipientName,
  }) async {
    if (_apiKey.isEmpty) return false;

    try {
      final Map<String, dynamic> emailData = {
        'sender': {
          'name': senderName,
          'email': senderEmail,
        },
        'to': [
          {
            'email': recipientEmail,
            'name': recipientName,
          }
        ],
        'subject': '✅ Nous avons bien reçu votre message - NASCENTIA',
        'htmlContent': _buildAutoReplyTemplate(recipientName),
      };

      final response = await http.post(
        Uri.parse(_apiUrl),
        headers: {
          'accept': 'application/json',
          'api-key': _apiKey,
          'content-type': 'application/json',
        },
        body: jsonEncode(emailData),
      );

      return response.statusCode == 201;
    } catch (e) {
      debugPrint('[BREVO] ❌ Erreur auto-reply: $e');
      return false;
    }
  }

  /// Ajoute un contact à la liste de newsletter Brevo
  ///
  /// **Paramètres:**
  /// - [email] : Email du contact à ajouter
  ///
  /// **Retour:**
  /// - `true` si le contact a été ajouté avec succès
  /// - `false` en cas d'erreur
  static Future<bool> addToNewsletter({required String email}) async {
    if (_apiKey.isEmpty) {
      debugPrint('[BREVO] ❌ Erreur: BREVO_API_KEY non configurée');
      return false;
    }

    if (!isValidEmail(email)) {
      debugPrint('[BREVO] ❌ Email invalide: $email');
      return false;
    }

    try {
      // API Brevo Contacts: https://developers.brevo.com/reference/createcontact
      const contactsUrl = 'https://api.brevo.com/v3/contacts';

      final Map<String, dynamic> contactData = {
        'email': email,
        'listIds': [3], // ID de votre liste newsletter (à créer dans Brevo)
        'updateEnabled': true, // Met à jour si le contact existe déjà
      };

      final response = await http.post(
        Uri.parse(contactsUrl),
        headers: {
          'accept': 'application/json',
          'api-key': _apiKey,
          'content-type': 'application/json',
        },
        body: jsonEncode(contactData),
      );

      // 201 = créé, 204 = déjà existant
      if (response.statusCode == 201 || response.statusCode == 204) {
        debugPrint('[BREVO] ✅ Contact ajouté à la newsletter: $email');

        // Envoyer un email de bienvenue (optionnel)
        await _sendNewsletterWelcomeEmail(email);

        return true;
      } else {
        debugPrint('[BREVO] ❌ Erreur ${response.statusCode}: ${response.body}');
        return false;
      }
    } catch (e, stackTrace) {
      debugPrint('[BREVO] ❌ Exception newsletter: $e');
      debugPrint('[BREVO] StackTrace: $stackTrace');
      return false;
    }
  }

  /// Envoie un email de bienvenue pour la newsletter
  static Future<void> _sendNewsletterWelcomeEmail(String email) async {
    try {
      final Map<String, dynamic> emailData = {
        'sender': {
          'name': senderName,
          'email': senderEmail,
        },
        'to': [
          {
            'email': email,
          }
        ],
        'subject': '🎉 Bienvenue dans la communauté NASCENTIA!',
        'htmlContent': _buildNewsletterWelcomeTemplate(email),
      };

      await http.post(
        Uri.parse(_apiUrl),
        headers: {
          'accept': 'application/json',
          'api-key': _apiKey,
          'content-type': 'application/json',
        },
        body: jsonEncode(emailData),
      );
    } catch (e) {
      debugPrint('[BREVO] ⚠️ Erreur envoi email bienvenue: $e');
    }
  }

  /// Template email de bienvenue newsletter
  static String _buildNewsletterWelcomeTemplate(String email) {
    return '''
<!DOCTYPE html>
<html lang="fr">
<head>
  <meta charset="UTF-8">
  <meta name="viewport" content="width=device-width, initial-scale=1.0">
  <style>
    body { font-family: Arial, sans-serif; line-height: 1.6; color: #333; margin: 0; padding: 0; }
    .container { max-width: 600px; margin: 0 auto; padding: 20px; }
    .header { background: linear-gradient(135deg, #E95263 0%, #582674 100%); color: white; padding: 40px 30px; text-align: center; border-radius: 8px 8px 0 0; }
    .content { background: #f9f9f9; padding: 40px 30px; border-radius: 0 0 8px 8px; }
    .button { display: inline-block; background: linear-gradient(135deg, #E95263 0%, #582674 100%); color: white; padding: 14px 35px; text-decoration: none; border-radius: 25px; margin-top: 20px; font-weight: bold; font-size: 16px; }
  </style>
</head>
<body>
  <div class="container">
    <div class="header">
      <h1 style="margin: 0; font-size: 32px;">🎉 Bienvenue!</h1>
      <p style="margin: 10px 0 0; opacity: 0.9;">Vous faites maintenant partie de la famille NASCENTIA</p>
    </div>
    <div class="content">
      <p style="font-size: 16px; color: #333;">Bonjour,</p>
      <p>Merci de vous être inscrit à notre newsletter! Nous sommes ravis de vous compter parmi nous.</p>
      <p>Vous recevrez désormais:</p>
      <ul style="color: #555; line-height: 1.8;">
        <li>📱 Les dernières nouveautés de l'application NASCENTIA</li>
        <li>💡 Des conseils exclusifs sur le développement de l'enfant</li>
        <li>🎁 Des offres spéciales réservées à nos abonnés</li>
      </ul>
      <p style="margin-top: 30px;">En attendant, découvrez dès maintenant notre application:</p>
      <div style="text-align: center;">
        <a href="https://nascentia-tech.com" class="button">Découvrir NASCENTIA</a>
      </div>
      <p style="margin-top: 40px; color: #666; font-size: 14px;">
        À très bientôt,<br>
        <strong>L'équipe NASCENTIA</strong>
      </p>
      <p style="margin-top: 30px; padding-top: 20px; border-top: 1px solid #ddd; font-size: 12px; color: #999;">
        Vous recevez cet email car vous vous êtes inscrit sur nascentia-tech.com
      </p>
    </div>
  </div>
</body>
</html>
    ''';
  }

  /// Template de réponse automatique
  static String _buildAutoReplyTemplate(String name) {
    return '''
<!DOCTYPE html>
<html lang="fr">
<head>
  <meta charset="UTF-8">
  <meta name="viewport" content="width=device-width, initial-scale=1.0">
  <style>
    body { font-family: Arial, sans-serif; line-height: 1.6; color: #333; }
    .container { max-width: 600px; margin: 0 auto; padding: 20px; }
    .header { background: linear-gradient(135deg, #E95263 0%, #582674 100%); color: white; padding: 30px; text-align: center; border-radius: 8px 8px 0 0; }
    .content { background: #f9f9f9; padding: 30px; border-radius: 0 0 8px 8px; }
    .button { display: inline-block; background: linear-gradient(135deg, #E95263 0%, #582674 100%); color: white; padding: 14px 35px; text-decoration: none; border-radius: 25px; margin-top: 20px; font-weight: bold; font-size: 16px; }
  </style>
</head>
<body>
  <div class="container">
    <div class="header">
      <h1>✅ Message reçu!</h1>
    </div>
    <div class="content">
      <p>Bonjour ${_escapeHtml(name)},</p>
      <p>Merci de nous avoir contactés! Nous avons bien reçu votre message et nous vous répondrons dans les plus brefs délais.</p>
      <p>Notre équipe traite généralement les demandes sous <strong>24-48 heures</strong>.</p>
      <p>En attendant, n'hésitez pas à découvrir notre application NASCENTIA.</p>
      <a href="https://nascentia-tech.com" class="button">Découvrir NASCENTIA</a>
      <p style="margin-top: 30px; color: #666; font-size: 14px;">
        Cordialement,<br>
        <strong>L'équipe NASCENTIA</strong>
      </p>
    </div>
  </div>
</body>
</html>
    ''';
  }
}
