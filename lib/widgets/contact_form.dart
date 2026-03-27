import 'package:flutter/material.dart';
import '../theme/app_colors.dart';
import '../theme/app_constants.dart';
import '../theme/app_text_styles.dart';
import '../services/brevo_service.dart';

/// Widget de formulaire de contact professionnel avec validation
class ContactForm extends StatefulWidget {
  const ContactForm({Key? key}) : super(key: key);

  @override
  State<ContactForm> createState() => _ContactFormState();
}

class _ContactFormState extends State<ContactForm> {
  final _formKey = GlobalKey<FormState>();
  final _nameController = TextEditingController();
  final _emailController = TextEditingController();
  final _subjectController = TextEditingController();
  final _messageController = TextEditingController();

  bool _isLoading = false;
  String? _statusMessage;
  bool _isSuccess = false;

  @override
  void dispose() {
    _nameController.dispose();
    _emailController.dispose();
    _subjectController.dispose();
    _messageController.dispose();
    super.dispose();
  }

  Future<void> _submitForm() async {
    // Validation du formulaire
    if (!_formKey.currentState!.validate()) {
      return;
    }

    setState(() {
      _isLoading = true;
      _statusMessage = null;
    });

    try {
      // Envoi de l'email via Brevo
      final success = await BrevoService.sendContactEmail(
        name: _nameController.text.trim(),
        email: _emailController.text.trim(),
        subject: _subjectController.text.trim(),
        message: _messageController.text.trim(),
      );

      if (success) {
        // Envoyer un email de confirmation automatique (optionnel)
        await BrevoService.sendAutoReplyEmail(
          recipientEmail: _emailController.text.trim(),
          recipientName: _nameController.text.trim(),
        );

        setState(() {
          _isSuccess = true;
          _statusMessage = '✅ Message envoyé avec succès! Nous vous répondrons sous 24-48h.';
        });

        // Réinitialiser le formulaire après 3 secondes
        Future.delayed(const Duration(seconds: 3), () {
          if (mounted) {
            _formKey.currentState!.reset();
            _nameController.clear();
            _emailController.clear();
            _subjectController.clear();
            _messageController.clear();
            setState(() {
              _statusMessage = null;
              _isSuccess = false;
            });
          }
        });
      } else {
        setState(() {
          _isSuccess = false;
          _statusMessage = '❌ Erreur lors de l\'envoi. Veuillez réessayer ou nous contacter directement.';
        });
      }
    } catch (e) {
      setState(() {
        _isSuccess = false;
        _statusMessage = '❌ Une erreur est survenue. Veuillez réessayer.';
      });
    } finally {
      setState(() {
        _isLoading = false;
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    final isMobile = (MediaQuery.maybeOf(context)?.size.width ?? 1024) < 768;

    return Form(
      key: _formKey,
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.stretch,
        children: [
          // Nom complet
          _buildTextField(
            controller: _nameController,
            label: 'Nom complet',
            hint: 'Ex: Jean Dupont',
            icon: Icons.person_outline,
            validator: (value) {
              if (value == null || value.trim().isEmpty) {
                return '⚠️ Veuillez entrer votre nom';
              }
              if (value.trim().length < 2) {
                return '⚠️ Le nom doit contenir au moins 2 caractères';
              }
              return null;
            },
          ),

          SizedBox(height: isMobile ? 16 : 20),

          // Email
          _buildTextField(
            controller: _emailController,
            label: 'Adresse email',
            hint: 'Ex: votre.email@example.com',
            icon: Icons.email_outlined,
            keyboardType: TextInputType.emailAddress,
            validator: (value) {
              if (value == null || value.trim().isEmpty) {
                return '⚠️ Veuillez entrer votre email';
              }
              if (!BrevoService.isValidEmail(value.trim())) {
                return '⚠️ Veuillez entrer un email valide';
              }
              return null;
            },
          ),

          SizedBox(height: isMobile ? 16 : 20),

          // Sujet
          _buildTextField(
            controller: _subjectController,
            label: 'Sujet',
            hint: 'Ex: Demande d\'information',
            icon: Icons.subject_outlined,
            validator: (value) {
              if (value == null || value.trim().isEmpty) {
                return '⚠️ Veuillez entrer un sujet';
              }
              if (value.trim().length < 3) {
                return '⚠️ Le sujet doit contenir au moins 3 caractères';
              }
              return null;
            },
          ),

          SizedBox(height: isMobile ? 16 : 20),

          // Message
          _buildTextField(
            controller: _messageController,
            label: 'Message',
            hint: 'Écrivez votre message ici...',
            icon: Icons.message_outlined,
            maxLines: 5,
            validator: (value) {
              if (value == null || value.trim().isEmpty) {
                return '⚠️ Veuillez entrer votre message';
              }
              if (value.trim().length < 10) {
                return '⚠️ Le message doit contenir au moins 10 caractères';
              }
              return null;
            },
          ),

          SizedBox(height: isMobile ? 24 : 32),

          // Message de statut
          if (_statusMessage != null)
            Container(
              padding: const EdgeInsets.all(16),
              margin: const EdgeInsets.only(bottom: 16),
              decoration: BoxDecoration(
                color: _isSuccess
                    ? const Color(0xFFD4EDDA)
                    : const Color(0xFFF8D7DA),
                borderRadius: BorderRadius.circular(12),
                border: Border.all(
                  color: _isSuccess
                      ? const Color(0xFF28A745)
                      : const Color(0xFFDC3545),
                  width: 1,
                ),
              ),
              child: Text(
                _statusMessage!,
                style: TextStyle(
                  color: _isSuccess
                      ? const Color(0xFF155724)
                      : const Color(0xFF721C24),
                  fontSize: 14,
                  fontWeight: FontWeight.w500,
                ),
                textAlign: TextAlign.center,
              ),
            ),

          // Bouton d'envoi
          MouseRegion(
            cursor: SystemMouseCursors.click,
            child: GestureDetector(
              onTap: _isLoading ? null : _submitForm,
              child: Container(
                padding: EdgeInsets.symmetric(
                  vertical: isMobile ? 18 : 20,
                ),
                decoration: BoxDecoration(
                  gradient: _isLoading
                      ? const LinearGradient(
                          colors: [Color(0xFFCCCCCC), Color(0xFF999999)],
                        )
                      : AppColors.primaryGradient,
                  borderRadius: BorderRadius.circular(AppConstants.radiusPill),
                  boxShadow: _isLoading
                      ? []
                      : [
                          BoxShadow(
                            color: AppColors.primary.withValues(alpha: 0.3),
                            blurRadius: 16,
                            offset: const Offset(0, 4),
                          ),
                        ],
                ),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  mainAxisSize: MainAxisSize.min,
                  children: [
                    if (_isLoading)
                      const SizedBox(
                        width: 20,
                        height: 20,
                        child: CircularProgressIndicator(
                          strokeWidth: 2,
                          valueColor: AlwaysStoppedAnimation<Color>(Colors.white),
                        ),
                      )
                    else
                      const Icon(
                        Icons.send_rounded,
                        color: Colors.white,
                        size: 20,
                      ),
                    const SizedBox(width: 12),
                    Text(
                      _isLoading ? 'Envoi en cours...' : 'Envoyer le message',
                      textAlign: TextAlign.center,
                      style: TextStyle(
                        color: Colors.white,
                        fontSize: isMobile ? 16 : 18,
                        fontWeight: FontWeight.w700,
                        letterSpacing: 0.3,
                      ),
                    ),
                  ],
                ),
              ),
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildTextField({
    required TextEditingController controller,
    required String label,
    required String hint,
    required IconData icon,
    int maxLines = 1,
    TextInputType? keyboardType,
    String? Function(String?)? validator,
  }) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        // Label
        Padding(
          padding: const EdgeInsets.only(left: 4, bottom: 8),
          child: Text(
            label,
            style: AppTextStyles.labelMedium(context).copyWith(
              fontWeight: FontWeight.w600,
              color: AppColors.greyText,
            ),
          ),
        ),

        // Champ de texte
        TextFormField(
          controller: controller,
          maxLines: maxLines,
          keyboardType: keyboardType,
          validator: validator,
          style: const TextStyle(
            fontSize: 16,
            color: AppColors.greyText,
          ),
          decoration: InputDecoration(
            hintText: hint,
            hintStyle: TextStyle(
              color: AppColors.greyText.withValues(alpha: 0.6),
              fontSize: 15,
            ),
            prefixIcon: Icon(
              icon,
              color: AppColors.primary,
              size: 22,
            ),
            filled: true,
            fillColor: Colors.grey.shade50,
            border: OutlineInputBorder(
              borderRadius: BorderRadius.circular(12),
              borderSide: BorderSide(
                color: Colors.grey.shade300,
                width: 1,
              ),
            ),
            enabledBorder: OutlineInputBorder(
              borderRadius: BorderRadius.circular(12),
              borderSide: BorderSide(
                color: Colors.grey.shade300,
                width: 1,
              ),
            ),
            focusedBorder: OutlineInputBorder(
              borderRadius: BorderRadius.circular(12),
              borderSide: const BorderSide(
                color: AppColors.primary,
                width: 2,
              ),
            ),
            errorBorder: OutlineInputBorder(
              borderRadius: BorderRadius.circular(12),
              borderSide: const BorderSide(
                color: Color(0xFFDC3545),
                width: 1,
              ),
            ),
            focusedErrorBorder: OutlineInputBorder(
              borderRadius: BorderRadius.circular(12),
              borderSide: const BorderSide(
                color: Color(0xFFDC3545),
                width: 2,
              ),
            ),
            contentPadding: EdgeInsets.symmetric(
              horizontal: 16,
              vertical: maxLines > 1 ? 16 : 14,
            ),
          ),
        ),
      ],
    );
  }
}
