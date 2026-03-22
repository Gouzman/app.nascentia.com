import 'package:url_launcher/url_launcher.dart';
import 'package:flutter/foundation.dart';

/// Service centralisé pour gérer tous les liens externes
/// Simplifie l'utilisation de url_launcher et ajoute logging/error handling
class LinkService {
  /// Lance une URL dans le navigateur externe
  static Future<bool> launchLink(String url) async {
    try {
      final uri = Uri.parse(url);
      if (await canLaunchUrl(uri)) {
        return await launchUrl(uri, mode: LaunchMode.externalApplication);
      } else {
        debugPrint('⚠️ Impossible de lancer: $url');
        return false;
      }
    } catch (e) {
      debugPrint('❌ Erreur lors du lancement de $url: $e');
      return false;
    }
  }

  /// Lance un appel téléphonique
  static Future<bool> launchPhone(String phoneNumber) async {
    // Nettoyer le numéro (enlever espaces, tirets)
    final cleanNumber = phoneNumber.replaceAll(RegExp(r'[\s\-\(\)]'), '');
    return await launchLink('tel:$cleanNumber');
  }

  /// Lance un email avec sujet et corps optionnels
  static Future<bool> launchEmail(
    String email, {
    String? subject,
    String? body,
  }) async {
    final uri = Uri(
      scheme: 'mailto',
      path: email,
      queryParameters: {
        if (subject != null) 'subject': subject,
        if (body != null) 'body': body,
      },
    );
    return await launchLink(uri.toString());
  }

  /// Lance WhatsApp avec un numéro
  static Future<bool> launchWhatsApp(String phoneNumber, {String? message}) async {
    // Format international sans + (ex: 2250778683353)
    final cleanNumber = phoneNumber.replaceAll(RegExp(r'[\s\-\(\)\+]'), '');
    final encodedMessage = message != null ? Uri.encodeComponent(message) : '';
    final url = 'https://wa.me/$cleanNumber${message != null ? '?text=$encodedMessage' : ''}';
    return await launchLink(url);
  }

  /// Lance un lien vers les réseaux sociaux
  static Future<bool> launchSocialMedia(String platform, String username) async {
    final urls = {
      'facebook': 'https://facebook.com/$username',
      'instagram': 'https://instagram.com/$username',
      'twitter': 'https://twitter.com/$username',
      'linkedin': 'https://linkedin.com/in/$username',
      'youtube': 'https://youtube.com/@$username',
    };

    final url = urls[platform.toLowerCase()];
    if (url == null) {
      debugPrint('⚠️ Platform non supportée: $platform');
      return false;
    }

    return await launchLink(url);
  }

  /// Télécharge un fichier (APK, PDF, etc.)
  static Future<bool> downloadFile(String url) async {
    try {
      final uri = Uri.parse(url);
      if (await canLaunchUrl(uri)) {
        return await launchUrl(
          uri,
          mode: LaunchMode.externalApplication,
        );
      } else {
        debugPrint('⚠️ Impossible de télécharger: $url');
        return false;
      }
    } catch (e) {
      debugPrint('❌ Erreur lors du téléchargement: $e');
      return false;
    }
  }

  /// Ouvre Google Maps avec coordonnées ou adresse
  static Future<bool> launchMaps({String? address, double? lat, double? lng}) async {
    String url;
    if (lat != null && lng != null) {
      url = 'https://www.google.com/maps/search/?api=1&query=$lat,$lng';
    } else if (address != null) {
      final encodedAddress = Uri.encodeComponent(address);
      url = 'https://www.google.com/maps/search/?api=1&query=$encodedAddress';
    } else {
      debugPrint('⚠️ Coordonnées ou adresse requises');
      return false;
    }
    return await launchLink(url);
  }

  /// Vérifie si une URL est valide avant de la lancer
  static bool isValidUrl(String url) {
    try {
      final uri = Uri.parse(url);
      return uri.hasScheme && uri.host.isNotEmpty;
    } catch (e) {
      return false;
    }
  }
}
