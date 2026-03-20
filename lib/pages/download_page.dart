import 'package:flutter/material.dart';
import '../models/review.dart';
import '../services/download_service.dart';
import '../theme/app_colors.dart';
import '../theme/app_text_styles.dart';
import '../widgets/scroll_reveal.dart';
import '../widgets/top_navigation_bar.dart';
import '../widgets/app_footer.dart';
import 'dart:html' as html;

/// Page de téléchargement NASCENTIA - Style App Store
class DownloadPage extends StatefulWidget {
  const DownloadPage({Key? key}) : super(key: key);

  @override
  State<DownloadPage> createState() => _DownloadPageState();
}

class _DownloadPageState extends State<DownloadPage> {
  late final ScrollController _screenshotController;
  int _currentScreenshot = 0;
  bool _isDownloadHovered = false;
  final ScrollController _scrollController = ScrollController();
  bool _isNavScrolled = false;

  List<Review> _reviews = [];
  int _downloadsCount = 0;
  bool _isLoading = true;
  String? _loadError;
  int? _filterRating;
  // null = pas voté, true = utile, false = pas utile
  final Map<String, bool?> _helpfulVotes = {};
  // compteur local (initialisé depuis DB, mis à jour à chaque vote)
  final Map<String, int> _helpfulCounts = {};

  double get _averageRating => _reviews.isEmpty
      ? 0
      : _reviews.map((r) => r.rating).reduce((a, b) => a + b) /
          _reviews.length;

  int get _reviewsCount => _reviews.length;

  Map<int, int> get _ratingDistribution {
    final dist = {1: 0, 2: 0, 3: 0, 4: 0, 5: 0};
    for (final r in _reviews) {
      dist[r.rating] = (dist[r.rating] ?? 0) + 1;
    }
    return dist;
  }

  List<Review> get _filteredReviews => _filterRating == null
      ? _reviews
      : _reviews.where((r) => r.rating == _filterRating).toList();

  @override
  void initState() {
    super.initState();
    _screenshotController = ScrollController();
    _loadData();
    _scrollController.addListener(() {
      final scrolled = _scrollController.offset > 100;
      if (scrolled != _isNavScrolled) {
        setState(() => _isNavScrolled = scrolled);
      }
    });
  }

  @override
  void dispose() {
    _screenshotController.dispose();
    _scrollController.dispose();
    super.dispose();
  }

  Future<void> _loadData() async {
    setState(() {
      _isLoading = true;
      _loadError = null;
    });
    try {
      final results = await Future.wait([
        DownloadService.getReviews(),
        DownloadService.getDownloadsCount(),
      ]);
      if (mounted) {
        final reviews = results[0] as List<Review>;
        setState(() {
          _reviews = reviews;
          _downloadsCount = results[1] as int;
          _isLoading = false;
          for (final r in reviews) {
            _helpfulCounts[r.id] = r.helpfulCount;
          }
        });
      }
    } catch (e) {
      if (mounted) {
        setState(() {
          _loadError = 'Impossible de charger les données.';
          _isLoading = false;
        });
      }
    }
  }

  String _relativeDate(DateTime dt) {
    final diff = DateTime.now().difference(dt);
    if (diff.inDays < 1) return 'aujourd\'hui';
    if (diff.inDays == 1) return 'il y a 1 jour';
    if (diff.inDays < 7) return 'il y a ${diff.inDays} jours';
    if (diff.inDays < 14) return 'il y a 1 semaine';
    if (diff.inDays < 30) return 'il y a ${(diff.inDays / 7).floor()} semaines';
    if (diff.inDays < 60) return 'il y a 1 mois';
    return 'il y a ${(diff.inDays / 30).floor()} mois';
  }

  @override
  Widget build(BuildContext context) {
    final screenWidth = MediaQuery.of(context).size.width;
    final isMobile = screenWidth < 768;
    final isTablet = screenWidth >= 768 && screenWidth < 1024;

    return Scaffold(
      backgroundColor: AppColors.lightBg,
      body: Stack(
        children: [
          SingleChildScrollView(
            controller: _scrollController,
            child: Column(
              children: [
                // Nav en position normale (scrolle avec le contenu)
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
                  ScrollReveal(
                    duration: const Duration(milliseconds: 700),
                    child: _buildStatsRow(isMobile),
                  ),
                  const SizedBox(height: 40),

                  // Bouton de téléchargement principal
                  ScrollReveal(
                    delay: const Duration(milliseconds: 80),
                    duration: const Duration(milliseconds: 640),
                    child: _buildDownloadButton(isMobile),
                  ),
                  const SizedBox(height: 50),

                  // Screenshots
                  ScrollReveal(
                    duration: const Duration(milliseconds: 780),
                    child: _buildScreenshotsSection(isMobile, isTablet),
                  ),
                  const SizedBox(height: 60),

                  // À propos
                  ScrollReveal(
                    duration: const Duration(milliseconds: 720),
                    child: _buildAboutSection(context, isMobile),
                  ),
                  const SizedBox(height: 50),

                  // Description détaillée
                  ScrollReveal(
                    delay: const Duration(milliseconds: 60),
                    duration: const Duration(milliseconds: 660),
                    child: _buildDescriptionSection(context, isMobile),
                  ),
                  const SizedBox(height: 50),

                  // Fonctionnalités
                  ScrollReveal(
                    duration: const Duration(milliseconds: 750),
                    child: _buildFeaturesSection(context, isMobile),
                  ),
                  const SizedBox(height: 50),

                  // Informations techniques
                  ScrollReveal(
                    delay: const Duration(milliseconds: 40),
                    duration: const Duration(milliseconds: 680),
                    child: _buildTechnicalInfo(context, isMobile),
                  ),
                  const SizedBox(height: 50),

                  // Avis et notes
                  ScrollReveal(
                    duration: const Duration(milliseconds: 720),
                    child: _buildReviewsSection(context, isMobile),
                  ),
                ],
              ),
            ),

                // Footer
                const AppFooter(),
              ],
            ),
          ),

          // Nav sticky — slide depuis le haut quand on dépasse la nav originale
          Positioned(
            top: 0,
            left: 0,
            right: 0,
            child: AnimatedSlide(
              offset: _isNavScrolled ? Offset.zero : const Offset(0, -1.5),
              duration: const Duration(milliseconds: 350),
              curve: Curves.easeOutCubic,
              child: AnimatedOpacity(
                opacity: _isNavScrolled ? 1.0 : 0.0,
                duration: const Duration(milliseconds: 250),
                child: IgnorePointer(
                  ignoring: !_isNavScrolled,
                  child: const TopNavigationBar(isScrolled: true),
                ),
              ),
            ),
          ),
        ],
      ),
    );
  }

  // Header avec icône et infos principales
  Widget _buildHeader(BuildContext context, bool isMobile) {
   return Row(
  crossAxisAlignment: CrossAxisAlignment.start,
  children: [

    // LOGO
    Container(
      width: isMobile ? 96 : 140,
      height: isMobile ? 96 : 140,
      decoration: BoxDecoration(
        color: AppColors.white,
        borderRadius: BorderRadius.circular(30),
        boxShadow: [
          BoxShadow(
            color: Colors.black.withValues(alpha: 0.08),
            blurRadius: 18,
            offset: const Offset(0, 6),
          ),
        ],
      ),
      child: Padding(
        padding: EdgeInsets.all(isMobile ? 4 : 6),
        child: Image.asset(
          'lib/assets/images/logo-nascentia.png',
          fit: BoxFit.contain,
        ),
      ),
    ),

    SizedBox(width: isMobile ? 16 : 24),

    // TEXTE APPLICATION
    Expanded(
      flex: 2,
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [

          Text(
            'NASCENTIA',
            style: isMobile
                ? AppTextStyles.headlineMedium(context)
                : AppTextStyles.headlineLarge(context),
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

    const SizedBox(width: 40),

    // BADGES SÉCURITÉ
    Expanded(
      flex: 2,
      child: _buildSecurityBadges(),
    ),
  ],
);
  }

  // Stats row
  Widget _buildStatsRow(bool isMobile) {
    final ratingStr = _averageRating == 0
        ? '—'
        : _averageRating.toStringAsFixed(1);
    final reviewsStr = '$_reviewsCount avis';
    final downloadsStr = _downloadsCount == 0
        ? '—'
        : '${(_downloadsCount / 1000).round()}k+';

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
                _buildStatItem(Icons.star, ratingStr, reviewsStr),
                const Divider(height: 32),
                _buildStatItem(Icons.download, downloadsStr, 'Téléchargements'),
                const Divider(height: 32),
                _buildStatItem(Icons.info_outline, '18+', 'Âge requis'),
              ],
            )
          : Row(
              mainAxisAlignment: MainAxisAlignment.spaceAround,
              children: [
                _buildStatItem(Icons.star, ratingStr, reviewsStr),
                Container(
                    width: 1,
                    height: 50,
                    color: AppColors.greyLight.withValues(alpha: 0.3)),
                _buildStatItem(Icons.download, downloadsStr, 'Téléchargements'),
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
              style: AppTextStyles.headlineSmall(context).copyWith(
                color: AppColors.darkText,
              ),
            ),
          ],
        ),
        const SizedBox(height: 4),
        Text(
          label,
          style: AppTextStyles.bodySmall(context),
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


      onTap: () {
                try {
                  final url = Uri.base.resolve('downloads/nascentia.apk').toString();

                  final anchor = html.AnchorElement(href: url)
                    ..setAttribute("download", "nascentia.apk")
                    ..style.display = "none";

                  html.document.body!.append(anchor);

                  anchor.click();

                  anchor.remove();
                } catch (e) {
                  print('Erreur téléchargement APK: $e');
                }
              },





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
          transform: Matrix4.translationValues(
              0.0, _isDownloadHovered ? -4.0 : 0.0, 0.0),
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
                style: AppTextStyles.titleMedium(context).copyWith(
                  color: AppColors.white,
                  fontWeight: FontWeight.w700,
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
    const screenshots = [
      'lib/assets/images/Download_ScrenShot-1.jpg',
      'lib/assets/images/Download_ScrenShot-2.png',
      'lib/assets/images/Download_ScrenShot-3.png',
      'lib/assets/images/Download_ScrenShot-4.png',
      'lib/assets/images/Download_ScrenShot-5.png',
      'lib/assets/images/Download_ScrenShot-6.png',
    ];
    final imageWidth = isMobile ? 140.0 : 200.0;
    final imageHeight = isMobile ? 280.0 : 400.0;
    final scrollStep = imageWidth + (isMobile ? 12.0 : 16.0);

    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          'Aperçu de l\'application',
          style: AppTextStyles.headlineSmall(context),
        ),
        const SizedBox(height: 24),
        Stack(
          alignment: Alignment.center,
          children: [
            // Liste horizontale originale
            SingleChildScrollView(
              controller: _screenshotController,
              scrollDirection: Axis.horizontal,
              child: Row(
                children: screenshots.asMap().entries.map((entry) {
                  final index = entry.key;
                  final path = entry.value;
                  final isSelected = _currentScreenshot == index;

                  return Padding(
                    padding: EdgeInsets.only(right: isMobile ? 12 : 16),
                    child: GestureDetector(
                      onTap: () => setState(() => _currentScreenshot = index),
                      child: AnimatedContainer(
                        duration: const Duration(milliseconds: 280),
                        curve: Curves.easeOutCubic,
                        width: imageWidth,
                        height: imageHeight,
                        decoration: BoxDecoration(
                          borderRadius: BorderRadius.circular(20),
                          border: isSelected
                              ? Border.all(color: AppColors.primary, width: 3)
                              : Border.all(
                                  color: AppColors.greyLight
                                      .withValues(alpha: 0.15),
                                  width: 1,
                                ),
                          boxShadow: [
                            BoxShadow(
                              color: Colors.black.withValues(
                                  alpha: isSelected ? 0.18 : 0.08),
                              blurRadius: isSelected ? 24 : 12,
                              offset: Offset(0, isSelected ? 10 : 4),
                            ),
                          ],
                        ),
                        child: ClipRRect(
                          borderRadius:
                              BorderRadius.circular(isSelected ? 17 : 20),
                          child: Image.asset(
                            path,
                            fit: BoxFit.cover,
                            errorBuilder: (_, __, ___) => Container(
                              color:
                                  AppColors.greyLight.withValues(alpha: 0.1),
                              child: const Center(
                                child: Icon(
                                    Icons.image_not_supported_outlined,
                                    color: Colors.grey),
                              ),
                            ),
                          ),
                        ),
                      ),
                    ),
                  );
                }).toList(),
              ),
            ),

            // Bouton gauche
            Positioned(
              left: 0,
              child: _buildScrollArrow(
                icon: Icons.chevron_left_rounded,
                onTap: () => _screenshotController.animateTo(
                  (_screenshotController.offset - scrollStep).clamp(
                      0, _screenshotController.position.maxScrollExtent),
                  duration: const Duration(milliseconds: 350),
                  curve: Curves.easeOutCubic,
                ),
              ),
            ),

            // Bouton droite
            Positioned(
              right: 0,
              child: _buildScrollArrow(
                icon: Icons.chevron_right_rounded,
                onTap: () => _screenshotController.animateTo(
                  (_screenshotController.offset + scrollStep).clamp(
                      0, _screenshotController.position.maxScrollExtent),
                  duration: const Duration(milliseconds: 350),
                  curve: Curves.easeOutCubic,
                ),
              ),
            ),
          ],
        ),
      ],
    );
  }

  Widget _buildScrollArrow(
      {required IconData icon, required VoidCallback onTap}) {
    return GestureDetector(
      onTap: onTap,
      child: Container(
        width: 32,
        height: 32,
        decoration: BoxDecoration(
          color: Colors.white.withValues(alpha: 0.90),
          shape: BoxShape.circle,
          boxShadow: [
            BoxShadow(
              color: Colors.black.withValues(alpha: 0.10),
              blurRadius: 8,
              offset: const Offset(0, 2),
            ),
          ],
        ),
        child: Icon(icon, size: 20,
            color: AppColors.darkText.withValues(alpha: 0.55)),
      ),
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
          style: AppTextStyles.headlineSmall(context),
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
        'accent': AppColors.primary,
      },
      {
        'icon': Icons.calendar_today_outlined,
        'title': 'Calendrier intelligent',
        'description': 'Planification selon vos objectifs',
        'accent': AppColors.purple,
      },
      {
        'icon': Icons.favorite_outline,
        'title': 'Suivi personnalisé',
        'description': 'Accompagnement sur mesure',
        'accent': AppColors.secondary,
      },
      {
        'icon': Icons.security_outlined,
        'title': 'Données sécurisées',
        'description': 'Confidentialité garantie',
        'accent': AppColors.successGreen,
      },
    ];

    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          'Fonctionnalités principales',
          style: AppTextStyles.headlineSmall(context),
        ),
        const SizedBox(height: 24),
        Column(
          children: features.asMap().entries.map((entry) {
            final index = entry.key;
            final feature = entry.value;
            final accentColor = feature['accent'] as Color;

            return Column(
              children: [
                Container(
                  decoration: BoxDecoration(
                    border: Border(
                      left: BorderSide(color: accentColor, width: 3),
                    ),
                  ),
                  padding: const EdgeInsets.symmetric(
                      horizontal: 20, vertical: 16),
                  child: Row(
                    children: [
                      Expanded(
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Text(
                              feature['title'] as String,
                              style: AppTextStyles.titleMedium(context)
                                  .copyWith(fontWeight: FontWeight.w600),
                            ),
                            const SizedBox(height: 4),
                            Text(
                              feature['description'] as String,
                              style: AppTextStyles.bodySmall(context),
                            ),
                          ],
                        ),
                      ),
                      const SizedBox(width: 16),
                      Icon(
                        feature['icon'] as IconData,
                        size: 28,
                        color: accentColor,
                      ),
                    ],
                  ),
                ),
                if (index < features.length - 1)
                  Divider(
                      color: AppColors.greyLight.withValues(alpha: 0.2)),
              ],
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
          style: AppTextStyles.headlineSmall(context),
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
              Divider(height: 32, color: AppColors.greyLight.withValues(alpha: 0.08)),
              _buildInfoRow('Taille', '45 MB'),
              Divider(height: 32, color: AppColors.greyLight.withValues(alpha: 0.08)),
              _buildInfoRow('Mis à jour le', '15 décembre 2025'),
              Divider(height: 32, color: AppColors.greyLight.withValues(alpha: 0.08)),
              _buildInfoRow('Développeur', 'NASCENTIA Health Tech'),
              Divider(height: 32, color: AppColors.greyLight.withValues(alpha: 0.08)),
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

        // Vue d'ensemble de la note (histogramme style Play Store)
        if (!_isLoading && _reviews.isNotEmpty)
          _buildRatingOverview(isMobile),
        if (!_isLoading && _reviews.isNotEmpty) const SizedBox(height: 20),

        // Bouton pour ajouter un commentaire
        _buildAddReviewButton(isMobile),
        const SizedBox(height: 20),

        // Filtres par étoiles
        if (!_isLoading && _reviews.isNotEmpty)
          _buildFilterChips(),
        if (!_isLoading && _reviews.isNotEmpty) const SizedBox(height: 20),

        if (_isLoading)
          const Center(
            child: Padding(
              padding: EdgeInsets.all(32),
              child: CircularProgressIndicator(),
            ),
          )
        else if (_loadError != null)
          Center(
            child: Padding(
              padding: const EdgeInsets.all(32),
              child: Text(
                _loadError!,
                style: TextStyle(color: AppColors.greyText),
              ),
            ),
          )
        else
          Container(
            padding: EdgeInsets.all(isMobile ? 20 : 32),
            decoration: BoxDecoration(
              color: AppColors.white,
              borderRadius: BorderRadius.circular(16),
            ),
            child: _reviews.isEmpty
                ? Center(
                    child: Padding(
                      padding: const EdgeInsets.all(16),
                      child: Text(
                        'Aucun avis pour le moment. Soyez le premier !',
                        style: AppTextStyles.bodyMedium(context).copyWith(
                          color: AppColors.greyText,
                        ),
                      ),
                    ),
                  )
                : _filteredReviews.isEmpty
                    ? Center(
                        child: Padding(
                          padding: const EdgeInsets.all(16),
                          child: Text(
                            'Aucun avis pour cette note.',
                            style: AppTextStyles.bodyMedium(context).copyWith(
                              color: AppColors.greyText,
                            ),
                          ),
                        ),
                      )
                    : Column(
                    children: _filteredReviews.asMap().entries.map((entry) {
                      final index = entry.key;
                      final review = entry.value;
                      return Column(
                        children: [
                          _buildReviewCard(
                            review.authorName,
                            review.rating,
                            review.title,
                            review.comment,
                            _relativeDate(review.createdAt),
                            reviewId: review.id,
                          ),
                          if (index < _filteredReviews.length - 1)
                            const Divider(height: 40),
                        ],
                      );
                    }).toList(),
                  ),
          ),
      ],
    );
  }

  // Histogramme style Play Store : grand score + barres de distribution
  Widget _buildRatingOverview(bool isMobile) {
    final dist = _ratingDistribution;
    final maxCount = dist.values.reduce((a, b) => a > b ? a : b);

    final scoreWidget = Column(
      mainAxisAlignment: MainAxisAlignment.center,
      children: [
        Text(
          _averageRating.toStringAsFixed(1),
          style: AppTextStyles.headlineLarge(context).copyWith(
            fontSize: 64,
            fontWeight: FontWeight.w900,
            letterSpacing: -2,
          ),
        ),
        Row(
          mainAxisSize: MainAxisSize.min,
          children: List.generate(5, (i) {
            final filled = i < _averageRating.round();
            return Icon(
              filled ? Icons.star_rounded : Icons.star_outline_rounded,
              size: 20,
              color: Colors.amber,
            );
          }),
        ),
        const SizedBox(height: 4),
        Text(
          '$_reviewsCount avis',
          style: AppTextStyles.bodySmall(context),
        ),
      ],
    );

    final barsWidget = Column(
      mainAxisAlignment: MainAxisAlignment.center,
      children: List.generate(5, (i) {
        final star = 5 - i;
        final count = dist[star] ?? 0;
        final fraction = maxCount == 0 ? 0.0 : count / maxCount;
        return Padding(
          padding: const EdgeInsets.symmetric(vertical: 3),
          child: Row(
            children: [
              Text(
                '$star',
                style: AppTextStyles.labelSmall(context).copyWith(
                  color: AppColors.darkText,
                ),
              ),
              const SizedBox(width: 4),
              const Icon(Icons.star_rounded, size: 13, color: Colors.amber),
              const SizedBox(width: 8),
              Expanded(
                child: ClipRRect(
                  borderRadius: BorderRadius.circular(4),
                  child: LinearProgressIndicator(
                    value: fraction,
                    backgroundColor:
                        AppColors.greyLight.withValues(alpha: 0.35),
                    valueColor:
                        const AlwaysStoppedAnimation<Color>(Colors.amber),
                    minHeight: 8,
                  ),
                ),
              ),
              const SizedBox(width: 8),
              SizedBox(
                width: 22,
                child: Text(
                  '$count',
                  textAlign: TextAlign.right,
                  style: AppTextStyles.labelSmall(context),
                ),
              ),
            ],
          ),
        );
      }),
    );

    return Container(
      padding: EdgeInsets.all(isMobile ? 20 : 28),
      decoration: BoxDecoration(
        color: AppColors.white,
        borderRadius: BorderRadius.circular(16),
      ),
      child: isMobile
          ? Column(
              children: [
                scoreWidget,
                const SizedBox(height: 20),
                barsWidget,
              ],
            )
          : Row(
              crossAxisAlignment: CrossAxisAlignment.center,
              children: [
                SizedBox(width: 140, child: scoreWidget),
                const SizedBox(width: 32),
                Expanded(child: barsWidget),
              ],
            ),
    );
  }

  // Chips de filtre par étoiles style Play Store
  Widget _buildFilterChips() {
    return SingleChildScrollView(
      scrollDirection: Axis.horizontal,
      child: Row(
        children: [
          _buildFilterChip(null, 'Toutes les notes'),
          const SizedBox(width: 8),
          ...List.generate(5, (i) {
            final star = 5 - i;
            return Padding(
              padding: const EdgeInsets.only(right: 8),
              child: _buildFilterChip(star, '$star étoile${star > 1 ? 's' : ''}'),
            );
          }),
        ],
      ),
    );
  }

  Widget _buildFilterChip(int? star, String label) {
    final isSelected = _filterRating == star;
    return GestureDetector(
      onTap: () => setState(() => _filterRating = star),
      child: AnimatedContainer(
        duration: const Duration(milliseconds: 200),
        padding:
            const EdgeInsets.symmetric(horizontal: 16, vertical: 8),
        decoration: BoxDecoration(
          color: isSelected
              ? AppColors.primary.withValues(alpha: 0.1)
              : AppColors.white,
          borderRadius: BorderRadius.circular(20),
          border: Border.all(
            color: isSelected ? AppColors.primary : AppColors.greyLight.withValues(alpha: 0.25),
            width: isSelected ? 2 : 1,
          ),
        ),
        child: Row(
          mainAxisSize: MainAxisSize.min,
          children: [
            if (star != null) ...[
              const Icon(Icons.star_rounded, size: 14, color: Colors.amber),
              const SizedBox(width: 4),
            ],
            Text(
              label,
              style: AppTextStyles.labelSmall(context).copyWith(
                color: isSelected ? AppColors.primary : AppColors.greyText,
                fontWeight:
                    isSelected ? FontWeight.w700 : FontWeight.w500,
              ),
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildReviewCard(
      String name, int rating, String title, String comment, String date,
      {String? reviewId}) {
    final vote = reviewId != null ? _helpfulVotes[reviewId] : null;

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
        // Bandeau "Ce contenu vous a-t-il été utile ?"
        if (reviewId != null) ...[
          const SizedBox(height: 14),
          Row(
            children: [
              Text(
                'Ce contenu vous a-t-il été utile ?',
                style: AppTextStyles.bodySmall(context).copyWith(
                  color: AppColors.greyText,
                ),
              ),
              const SizedBox(width: 12),
              _buildHelpfulButton(
                label: 'Oui',
                selected: vote == true,
                onTap: () => _handleHelpfulVote(reviewId, true),
              ),
              const SizedBox(width: 8),
              _buildHelpfulButton(
                label: 'Non',
                selected: vote == false,
                onTap: () => _handleHelpfulVote(reviewId, false),
              ),
            ],
          ),
          // Compteur de votes utiles
          if ((_helpfulCounts[reviewId] ?? 0) > 0) ...[
            const SizedBox(height: 6),
            Text(
              '${_formatHelpfulCount(_helpfulCounts[reviewId]!)} personne${_helpfulCounts[reviewId]! > 1 ? 's ont' : ' a'} trouvé cet avis utile',
              style: AppTextStyles.labelSmall(context).copyWith(
                color: AppColors.greyText,
                fontWeight: FontWeight.w400,
              ),
            ),
          ],
        ],
      ],
    );
  }

  void _handleHelpfulVote(String reviewId, bool isYes) {
    final currentVote = _helpfulVotes[reviewId];
    setState(() {
      if (isYes) {
        if (currentVote == true) {
          // Annuler le vote utile
          _helpfulVotes[reviewId] = null;
          _helpfulCounts[reviewId] = (_helpfulCounts[reviewId] ?? 1) - 1;
        } else {
          // Voter utile (depuis null ou non)
          if (currentVote == null) {
            _helpfulCounts[reviewId] = (_helpfulCounts[reviewId] ?? 0) + 1;
            DownloadService.incrementHelpful(reviewId);
          }
          _helpfulVotes[reviewId] = true;
        }
      } else {
        // Bouton Non : toggle sans compteur public
        _helpfulVotes[reviewId] = currentVote == false ? null : false;
      }
    });
  }

  String _formatHelpfulCount(int count) {
    final s = count.toString();
    final buf = StringBuffer();
    for (int i = 0; i < s.length; i++) {
      if (i > 0 && (s.length - i) % 3 == 0) buf.write('\u00a0');
      buf.write(s[i]);
    }
    return buf.toString();
  }

  Widget _buildHelpfulButton({
    required String label,
    required bool selected,
    required VoidCallback onTap,
  }) {
    return GestureDetector(
      onTap: onTap,
      child: AnimatedContainer(
        duration: const Duration(milliseconds: 180),
        padding: const EdgeInsets.symmetric(horizontal: 14, vertical: 5),
        decoration: BoxDecoration(
          color: selected
              ? AppColors.primary.withValues(alpha: 0.1)
              : Colors.transparent,
          borderRadius: BorderRadius.circular(16),
          border: Border.all(
            color: selected ? AppColors.primary : AppColors.greyLight.withValues(alpha: 0.25),
            width: selected ? 1.5 : 1,
          ),
        ),
        child: Text(
          label,
          style: AppTextStyles.labelSmall(context).copyWith(
            color: selected ? AppColors.primary : AppColors.greyText,
            fontWeight: selected ? FontWeight.w700 : FontWeight.w500,
          ),
        ),
      ),
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
                style: AppTextStyles.titleSmall(context).copyWith(
                  color: AppColors.primary,
                  fontWeight: FontWeight.w700,
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
    bool isSubmitting = false;
    String? validationError;
    final nameController = TextEditingController();
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
                            onPressed: isSubmitting
                                ? null
                                : () => Navigator.pop(dialogContext),
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
                            onTap: isSubmitting
                                ? null
                                : () {
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

                      // Nom
                      Text(
                        'Votre nom',
                        style: AppTextStyles.bodyMedium(context).copyWith(
                          fontWeight: FontWeight.w600,
                        ),
                      ),
                      const SizedBox(height: 8),
                      TextField(
                        controller: nameController,
                        enabled: !isSubmitting,
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

                      // Titre de l'avis
                      Text(
                        'Titre de votre avis',
                        style: AppTextStyles.bodyMedium(context).copyWith(
                          fontWeight: FontWeight.w600,
                        ),
                      ),
                      const SizedBox(height: 8),
                      TextField(
                        controller: titleController,
                        enabled: !isSubmitting,
                        decoration: InputDecoration(
                          hintText: 'Ex: Application excellente !',
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
                        enabled: !isSubmitting,
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
                      const SizedBox(height: 16),

                      // Message d'erreur de validation
                      if (validationError != null)
                        Padding(
                          padding: const EdgeInsets.only(bottom: 12),
                          child: Row(
                            children: [
                              const Icon(Icons.error_outline,
                                  color: AppColors.errorRed, size: 16),
                              const SizedBox(width: 6),
                              Flexible(
                                child: Text(
                                  validationError!,
                                  style: const TextStyle(
                                    color: AppColors.errorRed,
                                    fontSize: 13,
                                  ),
                                ),
                              ),
                            ],
                          ),
                        ),

                      // Boutons
                      Row(
                        children: [
                          Expanded(
                            child: TextButton(
                              onPressed: isSubmitting
                                  ? null
                                  : () => Navigator.pop(dialogContext),
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
                              onPressed: isSubmitting
                                  ? null
                                  : () async {
                                      final name = nameController.text.trim();
                                      final title =
                                          titleController.text.trim();
                                      final comment =
                                          commentController.text.trim();
                                      if (name.isEmpty ||
                                          title.isEmpty ||
                                          comment.isEmpty) {
                                        setDialogState(() => validationError =
                                            'Veuillez remplir tous les champs.');
                                        return;
                                      }

                                      setDialogState(() {
                                        validationError = null;
                                        isSubmitting = true;
                                      });
                                      try {
                                        await DownloadService.submitReview(
                                          name: name,
                                          rating: selectedRating,
                                          title: title,
                                          comment: comment,
                                        );
                                        Navigator.pop(dialogContext);
                                        if (mounted) {
                                          ScaffoldMessenger.of(this.context)
                                              .showSnackBar(
                                            SnackBar(
                                              content: const Text(
                                                'Merci pour votre avis !',
                                                style: TextStyle(
                                                    fontWeight:
                                                        FontWeight.w600),
                                              ),
                                              backgroundColor:
                                                  AppColors.primary,
                                              behavior:
                                                  SnackBarBehavior.floating,
                                              shape: RoundedRectangleBorder(
                                                borderRadius:
                                                    BorderRadius.circular(10),
                                              ),
                                            ),
                                          );
                                          _loadData();
                                        }
                                      } catch (e) {
                                        setDialogState(
                                            () => isSubmitting = false);
                                        if (mounted) {
                                          ScaffoldMessenger.of(this.context)
                                              .showSnackBar(
                                            SnackBar(
                                              content: const Text(
                                                'Erreur lors de la publication. Réessayez.',
                                                style: TextStyle(
                                                    fontWeight:
                                                        FontWeight.w600),
                                              ),
                                              backgroundColor: Colors.red,
                                              behavior:
                                                  SnackBarBehavior.floating,
                                              shape: RoundedRectangleBorder(
                                                borderRadius:
                                                    BorderRadius.circular(10),
                                              ),
                                            ),
                                          );
                                        }
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
                              child: isSubmitting
                                  ? const SizedBox(
                                      width: 20,
                                      height: 20,
                                      child: CircularProgressIndicator(
                                        strokeWidth: 2,
                                        color: AppColors.white,
                                      ),
                                    )
                                  : const Text(
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
  Widget _buildSecurityBadges() {
  return Column(
    crossAxisAlignment: CrossAxisAlignment.start,
    children: [

      const SizedBox(height: 12),

      _buildSecurityItem('Application officielle NASCENTIA'),

      _buildSecurityItem('Signée numériquement'),

      _buildSecurityItem(
        'Vérifiée par 70 antivirus',
        link:
            'https://www.virustotal.com/gui/file/03270bdbc14b3280904d16981f753704fa976d75f696cbb1f02b1262f991bcd8/detection',
      ),

      _buildSecurityItem('Téléchargement sécurisé'),

      _buildSecurityItem('Mise à jour automatique'),
    ],
  );
}

/** Nouvelle ajoute de verification de l'application  */
Widget _buildSecurityItem(String text, {String? link}) {
  return Padding(
    padding: const EdgeInsets.only(bottom: 6),
    child: GestureDetector(
      onTap: link != null
          ? () {
              html.window.open(link, "_blank");
            }
          : null,
      child: Row(
        children: [

          Container(
            width: 20,
            height: 20,
            decoration: const BoxDecoration(
              color: Color(0xFF2ECC71),
              shape: BoxShape.circle,
            ),
            child: const Icon(
              Icons.check,
              color: Colors.white,
              size: 14,
            ),
          ),

          const SizedBox(width: 8),

          Text(
            text,
            style: const TextStyle(
              fontSize: 14,
              fontWeight: FontWeight.w500,
            ),
          ),

          if (link != null) ...[
            const SizedBox(width: 6),
            const Icon(
              Icons.open_in_new,
              size: 14,
              color: Colors.grey,
            )
          ]
        ],
      ),
    ),
  );
}
/** fin du code */


}
