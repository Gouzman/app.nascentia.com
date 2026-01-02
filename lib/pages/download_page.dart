import 'package:flutter/material.dart';
import '../theme/app_colors.dart';
import '../theme/app_text_styles.dart';
import '../widgets/top_navigation_bar.dart';
import '../widgets/app_footer.dart';

/// Page de téléchargement NASCENTIA - Style App Store
class DownloadPage extends StatefulWidget {
  const DownloadPage({Key? key}) : super(key: key);

  @override
  State<DownloadPage> createState() => _DownloadPageState();
}

class _DownloadPageState extends State<DownloadPage> {
  int _selectedScreenshot = 0;
  bool _isDownloadHovered = false;

  @override
  Widget build(BuildContext context) {
    final screenWidth = MediaQuery.of(context).size.width;
    final isMobile = screenWidth < 768;
    final isTablet = screenWidth >= 768 && screenWidth < 1024;

    return Scaffold(
      backgroundColor: AppColors.lightBg,
      body: SingleChildScrollView(
        child: Column(
          children: [
            // Navigation
            const TopNavigationBar(),

            // Contenu principal
            Container(
              constraints: const BoxConstraints(maxWidth: 1200),
              padding: EdgeInsets.symmetric(
                horizontal: isMobile ? 20 : (isTablet ? 40 : 60),
                vertical: isMobile ? 30 : 60,
              ),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  // Header avec icône et infos principales
                  _buildHeader(context, isMobile),
                  const SizedBox(height: 40),

                  // Stats row (note, téléchargements, âge)
                  _buildStatsRow(isMobile),
                  const SizedBox(height: 40),

                  // Bouton de téléchargement principal
                  _buildDownloadButton(isMobile),
                  const SizedBox(height: 50),

                  // Screenshots
                  _buildScreenshotsSection(isMobile, isTablet),
                  const SizedBox(height: 60),

                  // À propos
                  _buildAboutSection(context, isMobile),
                  const SizedBox(height: 50),

                  // Description détaillée
                  _buildDescriptionSection(context, isMobile),
                  const SizedBox(height: 50),

                  // Fonctionnalités
                  _buildFeaturesSection(context, isMobile),
                  const SizedBox(height: 50),

                  // Informations techniques
                  _buildTechnicalInfo(context, isMobile),
                  const SizedBox(height: 50),

                  // Avis et notes
                  _buildReviewsSection(context, isMobile),
                ],
              ),
            ),

            // Footer
            const AppFooter(),
          ],
        ),
      ),
    );
  }

  // Header avec icône et infos principales
  Widget _buildHeader(BuildContext context, bool isMobile) {
    return Row(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        // Icône de l'app
        Container(
          width: isMobile ? 80 : 120,
          height: isMobile ? 80 : 120,
          decoration: BoxDecoration(
            borderRadius: BorderRadius.circular(20),
            gradient: AppColors.primaryGradient,
            boxShadow: [
              BoxShadow(
                color: AppColors.primary.withValues(alpha: 0.3),
                blurRadius: 20,
                offset: const Offset(0, 8),
              ),
            ],
          ),
          child: Center(
            child: Icon(
              Icons.baby_changing_station,
              size: isMobile ? 40 : 60,
              color: AppColors.white,
            ),
          ),
        ),
        SizedBox(width: isMobile ? 16 : 24),

        // Infos textuelles
        Expanded(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(
                'NASCENTIA',
                style: isMobile
                    ? AppTextStyles.headlineMedium(context)
                    : AppTextStyles.headlineLarge(context).copyWith(
                        fontWeight: FontWeight.w900,
                      ),
              ),
              const SizedBox(height: 8),
              Text(
                'NASCENTIA Health Tech',
                style: AppTextStyles.bodyMedium(context).copyWith(
                  color: AppColors.primary,
                  fontWeight: FontWeight.w600,
                ),
              ),
              const SizedBox(height: 4),
              Text(
                'Santé & Bien-être • Planification familiale',
                style: AppTextStyles.bodySmall(context).copyWith(
                  color: AppColors.greyText,
                ),
              ),
            ],
          ),
        ),
      ],
    );
  }

  // Stats row
  Widget _buildStatsRow(bool isMobile) {
    return Container(
      padding: EdgeInsets.all(isMobile ? 20 : 32),
      decoration: BoxDecoration(
        color: AppColors.white,
        borderRadius: BorderRadius.circular(16),
        border: Border.all(
          color: AppColors.greyLight.withValues(alpha: 0.2),
        ),
      ),
      child: isMobile
          ? Column(
              children: [
                _buildStatItem(Icons.star, '4.8', '2 341 avis'),
                const Divider(height: 32),
                _buildStatItem(Icons.download, '10k+', 'Téléchargements'),
                const Divider(height: 32),
                _buildStatItem(Icons.info_outline, '18+', 'Âge requis'),
              ],
            )
          : Row(
              mainAxisAlignment: MainAxisAlignment.spaceAround,
              children: [
                _buildStatItem(Icons.star, '4.8', '2 341 avis'),
                Container(
                    width: 1,
                    height: 50,
                    color: AppColors.greyLight.withValues(alpha: 0.3)),
                _buildStatItem(Icons.download, '10k+', 'Téléchargements'),
                Container(
                    width: 1,
                    height: 50,
                    color: AppColors.greyLight.withValues(alpha: 0.3)),
                _buildStatItem(Icons.info_outline, '18+', 'Âge requis'),
              ],
            ),
    );
  }

  Widget _buildStatItem(IconData icon, String value, String label) {
    return Column(
      children: [
        Row(
          mainAxisSize: MainAxisSize.min,
          children: [
            Icon(icon, color: AppColors.primary, size: 20),
            const SizedBox(width: 6),
            Text(
              value,
              style: TextStyle(
                fontSize: 24,
                fontWeight: FontWeight.w700,
                color: AppColors.darkText,
              ),
            ),
          ],
        ),
        const SizedBox(height: 4),
        Text(
          label,
          style: TextStyle(
            fontSize: 13,
            color: AppColors.greyText,
          ),
        ),
      ],
    );
  }

  // Bouton de téléchargement principal
  Widget _buildDownloadButton(bool isMobile) {
    return MouseRegion(
      onEnter: (_) => setState(() => _isDownloadHovered = true),
      onExit: (_) => setState(() => _isDownloadHovered = false),
      child: GestureDetector(
        onTap: () {},
        child: AnimatedContainer(
          duration: const Duration(milliseconds: 300),
          curve: Curves.easeOut,
          width: double.infinity,
          padding: EdgeInsets.symmetric(vertical: isMobile ? 18 : 22),
          decoration: BoxDecoration(
            gradient: AppColors.primaryGradient,
            borderRadius: BorderRadius.circular(12),
            boxShadow: [
              BoxShadow(
                color: AppColors.primary
                    .withValues(alpha: _isDownloadHovered ? 0.4 : 0.3),
                blurRadius: _isDownloadHovered ? 30 : 20,
                offset: Offset(0, _isDownloadHovered ? 12 : 8),
              ),
            ],
          ),
          transform: Matrix4.identity()
            ..translate(0.0, _isDownloadHovered ? -4.0 : 0.0),
          child: Row(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Icon(
                Icons.download_rounded,
                color: AppColors.white,
                size: isMobile ? 24 : 28,
              ),
              const SizedBox(width: 12),
              Text(
                'Télécharger gratuitement',
                style: TextStyle(
                  fontSize: isMobile ? 18 : 20,
                  fontWeight: FontWeight.w700,
                  color: AppColors.white,
                  letterSpacing: 0.5,
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }

  // Screenshots section
  Widget _buildScreenshotsSection(bool isMobile, bool isTablet) {
    final screenshots = [
      {'icon': Icons.calendar_month, 'color': AppColors.purple},
      {'icon': Icons.analytics, 'color': AppColors.primary},
      {'icon': Icons.favorite, 'color': AppColors.secondary},
      {'icon': Icons.insights, 'color': const Color(0xFF7B3AA0)},
    ];

    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          'Aperçu de l\'application',
          style: AppTextStyles.headlineSmall(context).copyWith(
            fontWeight: FontWeight.w700,
          ),
        ),
        const SizedBox(height: 24),
        SingleChildScrollView(
          scrollDirection: Axis.horizontal,
          child: Row(
            children: screenshots.asMap().entries.map((entry) {
              final index = entry.key;
              final screenshot = entry.value;
              final isSelected = _selectedScreenshot == index;

              return Padding(
                padding: EdgeInsets.only(right: isMobile ? 12 : 16),
                child: GestureDetector(
                  onTap: () => setState(() => _selectedScreenshot = index),
                  child: AnimatedContainer(
                    duration: const Duration(milliseconds: 300),
                    width: isMobile ? 140 : 200,
                    height: isMobile ? 280 : 400,
                    decoration: BoxDecoration(
                      gradient: LinearGradient(
                        begin: Alignment.topLeft,
                        end: Alignment.bottomRight,
                        colors: [
                          screenshot['color'] as Color,
                          (screenshot['color'] as Color).withValues(alpha: 0.8),
                        ],
                      ),
                      borderRadius: BorderRadius.circular(20),
                      border: isSelected
                          ? Border.all(
                              color: AppColors.primary,
                              width: 3,
                            )
                          : null,
                      boxShadow: [
                        BoxShadow(
                          color: (screenshot['color'] as Color)
                              .withValues(alpha: 0.3),
                          blurRadius: isSelected ? 25 : 15,
                          offset: Offset(0, isSelected ? 12 : 8),
                        ),
                      ],
                    ),
                    child: Center(
                      child: Icon(
                        screenshot['icon'] as IconData,
                        size: isMobile ? 60 : 80,
                        color: AppColors.white,
                      ),
                    ),
                  ),
                ),
              );
            }).toList(),
          ),
        ),
      ],
    );
  }

  // À propos
  Widget _buildAboutSection(BuildContext context, bool isMobile) {
    return Container(
      padding: EdgeInsets.all(isMobile ? 24 : 32),
      decoration: BoxDecoration(
        color: AppColors.white,
        borderRadius: BorderRadius.circular(16),
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(
            'À propos de cette application',
            style: AppTextStyles.headlineSmall(context).copyWith(
              fontWeight: FontWeight.w700,
            ),
          ),
          const SizedBox(height: 16),
          Text(
            'NASCENTIA est votre compagnon de planification familiale basé sur '
            'une méthode scientifique validée. Déterminez ou planifiez le sexe '
            'de votre futur enfant avec une précision de 90%.',
            style: AppTextStyles.bodyLarge(context).copyWith(
              color: AppColors.greyText,
              height: 1.7,
            ),
          ),
        ],
      ),
    );
  }

  // Description détaillée
  Widget _buildDescriptionSection(BuildContext context, bool isMobile) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          'Description complète',
          style: AppTextStyles.headlineSmall(context).copyWith(
            fontWeight: FontWeight.w700,
          ),
        ),
        const SizedBox(height: 16),
        Container(
          padding: EdgeInsets.all(isMobile ? 24 : 32),
          decoration: BoxDecoration(
            color: AppColors.white,
            borderRadius: BorderRadius.circular(16),
          ),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(
                'Créée en mars 2022, NASCENTIA est une start-up spécialisée dans l\'expertise '
                'scientifique, technologique et informatique appliquée à la santé reproductive.\n\n'
                'Notre solution combine :\n',
                style: AppTextStyles.bodyLarge(context).copyWith(
                  color: AppColors.greyText,
                  height: 1.7,
                ),
              ),
              const SizedBox(height: 16),
              _buildBulletPoint(
                  'Méthode mathématique validée scientifiquement'),
              _buildBulletPoint('Calendrier intelligent personnalisé'),
              _buildBulletPoint('Suivi du cycle et périodes de fertilité'),
              _buildBulletPoint('Accompagnement éthique et responsable'),
              _buildBulletPoint('Interface intuitive et sécurisée'),
            ],
          ),
        ),
      ],
    );
  }

  Widget _buildBulletPoint(String text) {
    return Padding(
      padding: const EdgeInsets.only(bottom: 12),
      child: Row(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Icon(
            Icons.check_circle,
            size: 20,
            color: AppColors.primary,
          ),
          const SizedBox(width: 12),
          Expanded(
            child: Text(
              text,
              style: AppTextStyles.bodyMedium(context).copyWith(
                color: AppColors.greyText,
              ),
            ),
          ),
        ],
      ),
    );
  }

  // Fonctionnalités
  Widget _buildFeaturesSection(BuildContext context, bool isMobile) {
    final features = [
      {
        'icon': Icons.analytics_outlined,
        'title': 'Détermination précise',
        'description': '90% de fiabilité validée cliniquement',
      },
      {
        'icon': Icons.calendar_today_outlined,
        'title': 'Calendrier intelligent',
        'description': 'Planification selon vos objectifs',
      },
      {
        'icon': Icons.favorite_outline,
        'title': 'Suivi personnalisé',
        'description': 'Accompagnement sur mesure',
      },
      {
        'icon': Icons.security_outlined,
        'title': 'Données sécurisées',
        'description': 'Confidentialité garantie',
      },
    ];

    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          'Fonctionnalités principales',
          style: AppTextStyles.headlineSmall(context).copyWith(
            fontWeight: FontWeight.w700,
          ),
        ),
        const SizedBox(height: 24),
        Wrap(
          spacing: isMobile ? 12 : 20,
          runSpacing: isMobile ? 12 : 20,
          children: features.map((feature) {
            return Container(
              width: isMobile
                  ? double.infinity
                  : (MediaQuery.of(context).size.width - 140) / 2,
              padding: EdgeInsets.all(isMobile ? 20 : 24),
              decoration: BoxDecoration(
                color: AppColors.white,
                borderRadius: BorderRadius.circular(16),
                border: Border.all(
                  color: AppColors.greyLight.withValues(alpha: 0.3),
                ),
              ),
              child: Row(
                children: [
                  Container(
                    width: 56,
                    height: 56,
                    decoration: BoxDecoration(
                      gradient: LinearGradient(
                        colors: [
                          AppColors.primary.withValues(alpha: 0.1),
                          AppColors.purple.withValues(alpha: 0.1),
                        ],
                      ),
                      shape: BoxShape.circle,
                    ),
                    child: Icon(
                      feature['icon'] as IconData,
                      color: AppColors.primary,
                      size: 28,
                    ),
                  ),
                  const SizedBox(width: 16),
                  Expanded(
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text(
                          feature['title'] as String,
                          style: AppTextStyles.titleMedium(context).copyWith(
                            fontWeight: FontWeight.w700,
                          ),
                        ),
                        const SizedBox(height: 4),
                        Text(
                          feature['description'] as String,
                          style: AppTextStyles.bodySmall(context).copyWith(
                            color: AppColors.greyText,
                          ),
                        ),
                      ],
                    ),
                  ),
                ],
              ),
            );
          }).toList(),
        ),
      ],
    );
  }

  // Informations techniques
  Widget _buildTechnicalInfo(BuildContext context, bool isMobile) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          'Informations',
          style: AppTextStyles.headlineSmall(context).copyWith(
            fontWeight: FontWeight.w700,
          ),
        ),
        const SizedBox(height: 24),
        Container(
          padding: EdgeInsets.all(isMobile ? 20 : 24),
          decoration: BoxDecoration(
            color: AppColors.white,
            borderRadius: BorderRadius.circular(16),
          ),
          child: Column(
            children: [
              _buildInfoRow('Version', '2.1.0'),
              const Divider(height: 32),
              _buildInfoRow('Taille', '45 MB'),
              const Divider(height: 32),
              _buildInfoRow('Mis à jour le', '15 décembre 2025'),
              const Divider(height: 32),
              _buildInfoRow('Développeur', 'NASCENTIA Health Tech'),
              const Divider(height: 32),
              _buildInfoRow('Compatibilité', 'Android 6.0+, iOS 13.0+'),
            ],
          ),
        ),
      ],
    );
  }

  Widget _buildInfoRow(String label, String value) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      children: [
        Text(
          label,
          style: AppTextStyles.bodyMedium(context).copyWith(
            color: const Color.fromARGB(255, 176, 176, 176),
          ),
        ),
        Flexible(
          child: Text(
            value,
            textAlign: TextAlign.right,
            style: AppTextStyles.bodyMedium(context).copyWith(
              color: AppColors.darkText,
              fontWeight: FontWeight.w600,
            ),
          ),
        ),
      ],
    );
  }

  // Section avis
  Widget _buildReviewsSection(BuildContext context, bool isMobile) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            Text(
              'Notes et avis',
              style: AppTextStyles.headlineSmall(context).copyWith(
                fontWeight: FontWeight.w700,
              ),
            ),
            TextButton(
              onPressed: () {},
              child: Text(
                'Voir tout',
                style: TextStyle(
                  color: AppColors.primary,
                  fontWeight: FontWeight.w600,
                ),
              ),
            ),
          ],
        ),
        const SizedBox(height: 24),

        // Bouton pour ajouter un commentaire
        _buildAddReviewButton(isMobile),
        const SizedBox(height: 20),

        Container(
          padding: EdgeInsets.all(isMobile ? 20 : 32),
          decoration: BoxDecoration(
            color: AppColors.white,
            borderRadius: BorderRadius.circular(16),
          ),
          child: Column(
            children: [
              _buildReviewCard(
                'Sophie L.',
                5,
                'Application excellente !',
                'Très satisfaite de NASCENTIA. L\'interface est intuitive et les résultats sont précis. Je recommande !',
                '2 jours',
              ),
              const Divider(height: 40),
              _buildReviewCard(
                'Marc D.',
                5,
                'Méthode scientifique efficace',
                'La méthode fonctionne vraiment. Nous sommes ravis du résultat après avoir suivi les recommandations.',
                '1 semaine',
              ),
              const Divider(height: 40),
              _buildReviewCard(
                'Amina K.',
                4,
                'Très utile',
                'Application complète avec un bon suivi. Le calendrier intelligent aide vraiment à la planification.',
                '2 semaines',
              ),
            ],
          ),
        ),
      ],
    );
  }

  Widget _buildReviewCard(
      String name, int rating, String title, String comment, String date) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Row(
          children: [
            CircleAvatar(
              radius: 20,
              backgroundColor: AppColors.primary.withValues(alpha: 0.2),
              child: Text(
                name[0],
                style: TextStyle(
                  color: AppColors.primary,
                  fontWeight: FontWeight.w700,
                ),
              ),
            ),
            const SizedBox(width: 12),
            Expanded(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    name,
                    style: AppTextStyles.bodyMedium(context).copyWith(
                      fontWeight: FontWeight.w600,
                    ),
                  ),
                  Row(
                    children: List.generate(5, (index) {
                      return Icon(
                        index < rating ? Icons.star : Icons.star_border,
                        size: 16,
                        color: Colors.amber,
                      );
                    }),
                  ),
                ],
              ),
            ),
            Text(
              date,
              style: AppTextStyles.bodySmall(context).copyWith(
                color: AppColors.greyText,
              ),
            ),
          ],
        ),
        const SizedBox(height: 12),
        Text(
          title,
          style: AppTextStyles.bodyMedium(context).copyWith(
            fontWeight: FontWeight.w700,
          ),
        ),
        const SizedBox(height: 8),
        Text(
          comment,
          style: AppTextStyles.bodyMedium(context).copyWith(
            color: AppColors.greyText,
            height: 1.6,
          ),
        ),
      ],
    );
  }

  // Bouton pour ajouter un avis
  Widget _buildAddReviewButton(bool isMobile) {
    return MouseRegion(
      cursor: SystemMouseCursors.click,
      child: GestureDetector(
        onTap: () => _showReviewDialog(),
        child: Container(
          width: double.infinity,
          padding: EdgeInsets.symmetric(
            vertical: isMobile ? 16 : 18,
            horizontal: isMobile ? 20 : 24,
          ),
          decoration: BoxDecoration(
            color: AppColors.white,
            borderRadius: BorderRadius.circular(12),
            border: Border.all(
              color: AppColors.primary,
              width: 2,
            ),
          ),
          child: Row(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Icon(
                Icons.rate_review_outlined,
                color: AppColors.primary,
                size: isMobile ? 20 : 24,
              ),
              const SizedBox(width: 12),
              Text(
                'Écrire un avis',
                style: TextStyle(
                  fontSize: isMobile ? 16 : 18,
                  fontWeight: FontWeight.w700,
                  color: AppColors.primary,
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }

  // Dialogue pour ajouter un avis
  void _showReviewDialog() {
    int selectedRating = 5;
    final titleController = TextEditingController();
    final commentController = TextEditingController();

    showDialog(
      context: context,
      builder: (BuildContext dialogContext) {
        return StatefulBuilder(
          builder: (context, setDialogState) {
            return Dialog(
              shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(20),
              ),
              child: Container(
                constraints: const BoxConstraints(maxWidth: 500),
                padding: const EdgeInsets.all(32),
                child: SingleChildScrollView(
                  child: Column(
                    mainAxisSize: MainAxisSize.min,
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      // Header
                      Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          Text(
                            'Votre avis',
                            style:
                                AppTextStyles.headlineSmall(context).copyWith(
                              fontWeight: FontWeight.w700,
                            ),
                          ),
                          IconButton(
                            onPressed: () => Navigator.pop(dialogContext),
                            icon: const Icon(Icons.close),
                          ),
                        ],
                      ),
                      const SizedBox(height: 24),

                      // Sélection de note
                      Text(
                        'Votre note',
                        style: AppTextStyles.bodyMedium(context).copyWith(
                          fontWeight: FontWeight.w600,
                        ),
                      ),
                      const SizedBox(height: 12),
                      Row(
                        children: List.generate(5, (index) {
                          return GestureDetector(
                            onTap: () {
                              setDialogState(() {
                                selectedRating = index + 1;
                              });
                            },
                            child: Padding(
                              padding: const EdgeInsets.only(right: 8),
                              child: Icon(
                                index < selectedRating
                                    ? Icons.star
                                    : Icons.star_border,
                                size: 36,
                                color: Colors.amber,
                              ),
                            ),
                          );
                        }),
                      ),
                      const SizedBox(height: 24),

                      // Nom de la personne
                      Text(
                        'Votre nom',
                        style: AppTextStyles.bodyMedium(context).copyWith(
                          fontWeight: FontWeight.w600,
                        ),
                      ),
                      const SizedBox(height: 8),
                      TextField(
                        controller: titleController,
                        decoration: InputDecoration(
                          hintText: 'Ex: Sophie Martin',
                          border: OutlineInputBorder(
                            borderRadius: BorderRadius.circular(12),
                          ),
                          focusedBorder: OutlineInputBorder(
                            borderRadius: BorderRadius.circular(12),
                            borderSide: BorderSide(
                              color: AppColors.primary,
                              width: 2,
                            ),
                          ),
                        ),
                      ),
                      const SizedBox(height: 20),

                      // Commentaire
                      Text(
                        'Votre commentaire',
                        style: AppTextStyles.bodyMedium(context).copyWith(
                          fontWeight: FontWeight.w600,
                        ),
                      ),
                      const SizedBox(height: 8),
                      TextField(
                        controller: commentController,
                        maxLines: 5,
                        decoration: InputDecoration(
                          hintText:
                              'Partagez votre expérience avec NASCENTIA...',
                          border: OutlineInputBorder(
                            borderRadius: BorderRadius.circular(12),
                          ),
                          focusedBorder: OutlineInputBorder(
                            borderRadius: BorderRadius.circular(12),
                            borderSide: BorderSide(
                              color: AppColors.primary,
                              width: 2,
                            ),
                          ),
                        ),
                      ),
                      const SizedBox(height: 32),

                      // Boutons
                      Row(
                        children: [
                          Expanded(
                            child: TextButton(
                              onPressed: () => Navigator.pop(dialogContext),
                              style: TextButton.styleFrom(
                                padding:
                                    const EdgeInsets.symmetric(vertical: 16),
                              ),
                              child: Text(
                                'Annuler',
                                style: TextStyle(
                                  color: AppColors.greyText,
                                  fontWeight: FontWeight.w600,
                                ),
                              ),
                            ),
                          ),
                          const SizedBox(width: 16),
                          Expanded(
                            child: ElevatedButton(
                              onPressed: () {
                                // Logique de soumission
                                if (titleController.text.isNotEmpty &&
                                    commentController.text.isNotEmpty) {
                                  Navigator.pop(dialogContext);
                                  // Afficher un message de confirmation
                                  ScaffoldMessenger.of(context).showSnackBar(
                                    SnackBar(
                                      content: const Text(
                                        'Merci pour votre avis !',
                                        style: TextStyle(
                                            fontWeight: FontWeight.w600),
                                      ),
                                      backgroundColor: AppColors.primary,
                                      behavior: SnackBarBehavior.floating,
                                      shape: RoundedRectangleBorder(
                                        borderRadius: BorderRadius.circular(10),
                                      ),
                                    ),
                                  );
                                }
                              },
                              style: ElevatedButton.styleFrom(
                                backgroundColor: AppColors.primary,
                                padding:
                                    const EdgeInsets.symmetric(vertical: 16),
                                shape: RoundedRectangleBorder(
                                  borderRadius: BorderRadius.circular(12),
                                ),
                              ),
                              child: const Text(
                                'Publier',
                                style: TextStyle(
                                  color: AppColors.white,
                                  fontWeight: FontWeight.w700,
                                ),
                              ),
                            ),
                          ),
                        ],
                      ),
                    ],
                  ),
                ),
              ),
            );
          },
        );
      },
    );
  }
}
