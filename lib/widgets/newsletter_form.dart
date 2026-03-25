import 'package:flutter/material.dart';
import '../theme/app_colors.dart';
import '../theme/app_constants.dart';
import '../services/brevo_service.dart';

/// Widget d'inscription à la newsletter dans le footer
class NewsletterForm extends StatefulWidget {
  const NewsletterForm({Key? key}) : super(key: key);

  @override
  State<NewsletterForm> createState() => _NewsletterFormState();
}

class _NewsletterFormState extends State<NewsletterForm> {
  final _emailController = TextEditingController();
  bool _isLoading = false;
  String? _message;
  bool _isSuccess = false;

  @override
  void dispose() {
    _emailController.dispose();
    super.dispose();
  }

  Future<void> _subscribe() async {
    final email = _emailController.text.trim();

    // Validation
    if (email.isEmpty) {
      setState(() {
        _message = '⚠️ Veuillez entrer votre email';
        _isSuccess = false;
      });
      return;
    }

    if (!BrevoService.isValidEmail(email)) {
      setState(() {
        _message = '⚠️ Email invalide';
        _isSuccess = false;
      });
      return;
    }

    setState(() {
      _isLoading = true;
      _message = null;
    });

    try {
      final success = await BrevoService.addToNewsletter(email: email);

      if (success) {
        setState(() {
          _isSuccess = true;
          _message = '✅ Inscription réussie! Consultez vos emails.';
        });

        // Réinitialiser après 4 secondes
        Future.delayed(const Duration(seconds: 4), () {
          if (mounted) {
            _emailController.clear();
            setState(() {
              _message = null;
              _isSuccess = false;
            });
          }
        });
      } else {
        setState(() {
          _isSuccess = false;
          _message = '❌ Erreur lors de l\'inscription';
        });
      }
    } catch (e) {
      setState(() {
        _isSuccess = false;
        _message = '❌ Une erreur est survenue';
      });
    } finally {
      setState(() {
        _isLoading = false;
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        const Text(
          'Restons en contact',
          style: TextStyle(
            fontSize: 18,
            fontWeight: FontWeight.bold,
            color: Colors.white,
          ),
        ),
        const SizedBox(height: 20),

        // Message de statut
        if (_message != null) ...[
          Container(
            padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 10),
            margin: const EdgeInsets.only(bottom: 12),
            decoration: BoxDecoration(
              color: _isSuccess
                  ? const Color(0xFF28A745).withValues(alpha: 0.2)
                  : const Color(0xFFDC3545).withValues(alpha: 0.2),
              borderRadius: BorderRadius.circular(8),
              border: Border.all(
                color: _isSuccess
                    ? const Color(0xFF28A745)
                    : const Color(0xFFDC3545),
                width: 1,
              ),
            ),
            child: Text(
              _message!,
              style: TextStyle(
                color: _isSuccess ? Colors.white : Colors.white,
                fontSize: 12,
                fontWeight: FontWeight.w500,
              ),
            ),
          ),
        ],

        // Formulaire d'inscription
        Container(
          decoration: BoxDecoration(
            color: Colors.white.withValues(alpha: 0.1),
            borderRadius: AppConstants.borderRadiusPill,
          ),
          padding: EdgeInsets.all(AppConstants.spacing4),
          child: Row(
            children: [
              Expanded(
                child: TextField(
                  controller: _emailController,
                  enabled: !_isLoading,
                  style: const TextStyle(color: Colors.white, fontSize: 14),
                  decoration: InputDecoration(
                    hintText: 'Entrez votre email',
                    hintStyle: TextStyle(
                      color: Colors.white.withValues(alpha: 0.5),
                      fontSize: 14,
                    ),
                    border: InputBorder.none,
                    contentPadding: const EdgeInsets.symmetric(
                      horizontal: 20,
                      vertical: 12,
                    ),
                  ),
                  onSubmitted: (_) => _isLoading ? null : _subscribe(),
                ),
              ),
              Container(
                decoration: BoxDecoration(
                  gradient: _isLoading
                      ? const LinearGradient(
                          colors: [Color(0xFFCCCCCC), Color(0xFF999999)],
                        )
                      : AppColors.purpleGradient,
                  borderRadius: BorderRadius.circular(999),
                ),
                child: Material(
                  color: Colors.transparent,
                  child: InkWell(
                    borderRadius: BorderRadius.circular(999),
                    onTap: _isLoading ? null : _subscribe,
                    child: Padding(
                      padding: const EdgeInsets.symmetric(
                        horizontal: 24,
                        vertical: 12,
                      ),
                      child: _isLoading
                          ? const SizedBox(
                              width: 56,
                              height: 18,
                              child: Center(
                                child: SizedBox(
                                  width: 16,
                                  height: 16,
                                  child: CircularProgressIndicator(
                                    strokeWidth: 2,
                                    valueColor: AlwaysStoppedAnimation<Color>(
                                      Colors.white,
                                    ),
                                  ),
                                ),
                              ),
                            )
                          : const Text(
                              'S\'inscrire',
                              style: TextStyle(
                                color: Colors.white,
                                fontSize: 14,
                                fontWeight: FontWeight.w600,
                              ),
                            ),
                    ),
                  ),
                ),
              ),
            ],
          ),
        ),
      ],
    );
  }
}
