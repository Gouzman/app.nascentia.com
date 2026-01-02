import 'package:flutter/material.dart';
import '../theme/app_colors.dart';
import '../theme/app_text_styles.dart';
import '../widgets/section_container.dart';

/// Section "Calendrier Intelligent"
class CalendarSection extends StatefulWidget {
  const CalendarSection({Key? key}) : super(key: key);

  @override
  State<CalendarSection> createState() => _CalendarSectionState();
}

class _CalendarSectionState extends State<CalendarSection> {
  int _hoveredFeatureIndex = -1;

  @override
  Widget build(BuildContext context) {
    final screenWidth = MediaQuery.of(context).size.width;
    final isSmall = screenWidth < 600;
    final isMedium = screenWidth >= 600 && screenWidth < 1024;

    return SectionContainer(
      backgroundColor: AppColors.lightBg,
      child: Container(
        constraints: const BoxConstraints(maxWidth: 1400),
        padding: EdgeInsets.symmetric(
          horizontal: isSmall ? 20 : (isMedium ? 40 : 80),
          vertical: isSmall ? 60 : 100,
        ),
        decoration: BoxDecoration(
          gradient: LinearGradient(
            begin: Alignment.topCenter,
            end: Alignment.bottomCenter,
            colors: [
              AppColors.white,
              AppColors.lightBg,
              AppColors.white,
            ],
            stops: const [0.0, 0.5, 1.0],
          ),
        ),
        child: Column(
          children: [
            // Badge "Calendrier Intelligent"
            _buildBadge(isSmall),
            SizedBox(height: isSmall ? 24 : 32),

            // Titre
            _buildTitle(context, isSmall),
            SizedBox(height: isSmall ? 16 : 24),

            // Description
            _buildDescription(context, isSmall, isMedium),
            SizedBox(height: isSmall ? 40 : 60),

            // Features en grid
            _buildFeatureCards(context, isSmall, isMedium),
          ],
        ),
      ),
    );
  }

  // Badge "Calendrier Intelligent"
  Widget _buildBadge(bool isSmall) {
    return Container(
      padding: EdgeInsets.symmetric(
        horizontal: isSmall ? 16 : 24,
        vertical: isSmall ? 8 : 12,
      ),
      decoration: BoxDecoration(
        gradient: LinearGradient(
          colors: [
            AppColors.purple.withValues(alpha: 0.1),
            AppColors.primary.withValues(alpha: 0.1),
          ],
        ),
        borderRadius: BorderRadius.circular(50),
        border: Border.all(
          color: AppColors.purple.withValues(alpha: 0.3),
          width: 1,
        ),
      ),
      child: Row(
        mainAxisSize: MainAxisSize.min,
        children: [
          Icon(
            Icons.calendar_today_outlined,
            color: AppColors.purple,
            size: isSmall ? 16 : 20,
          ),
          SizedBox(width: isSmall ? 6 : 8),
          Text(
            'CALENDRIER INTELLIGENT',
            style: TextStyle(
              fontSize: isSmall ? 11 : 13,
              fontWeight: FontWeight.w700,
              letterSpacing: 1.2,
              color: AppColors.purple,
            ),
          ),
        ],
      ),
    );
  }

  // Titre
  Widget _buildTitle(BuildContext context, bool isSmall) {
    return Text(
      'Un calendrier personnalisé pour maximiser vos chances',
      textAlign: TextAlign.center,
      style: (isSmall
              ? AppTextStyles.headlineMedium(context)
              : AppTextStyles.displayMedium(context))
          .copyWith(
        color: AppColors.purple,
        height: 1.3,
      ),
    );
  }

  // Description
  Widget _buildDescription(BuildContext context, bool isSmall, bool isMedium) {
    return Container(
      constraints: BoxConstraints(maxWidth: isMedium ? 700 : 900),
      child: Text(
        'En fonction du sexe choisi, NASCENTIA génère un calendrier intelligent '
        'qui vous accompagne tout au long de votre parcours avec des informations '
        'précises et personnalisées.',
        textAlign: TextAlign.center,
        style: AppTextStyles.bodyLarge(context).copyWith(
          color: AppColors.greyText,
          height: 1.8,
        ),
      ),
    );
  }

  // Features en grid
  Widget _buildFeatureCards(BuildContext context, bool isSmall, bool isMedium) {
    final features = [
      {
        'icon': Icons.event_available_outlined,
        'title': 'Périodes Favorables',
        'description': 'Identifiez les moments optimaux pour la conception',
      },
      {
        'icon': Icons.calendar_month_outlined,
        'title': 'Dates de Menstruation',
        'description': 'Suivez votre cycle avec précision',
      },
      {
        'icon': Icons.favorite_outline,
        'title': 'Périodes de Fertilité',
        'description': 'Maximisez vos chances naturellement',
      },
      {
        'icon': Icons.star_outline,
        'title': 'Mois Optimaux',
        'description': 'Planifiez selon le sexe désiré',
      },
    ];

    if (isSmall) {
      return Column(
        children: features
            .asMap()
            .entries
            .map((entry) => Padding(
                  padding: EdgeInsets.only(
                    bottom: entry.key < features.length - 1 ? 20 : 0,
                  ),
                  child: _buildFeatureCard(
                    entry.value['icon'] as IconData,
                    entry.value['title'] as String,
                    entry.value['description'] as String,
                    entry.key,
                    isSmall,
                  ),
                ))
            .toList(),
      );
    }

    return Wrap(
      spacing: 20,
      runSpacing: 20,
      alignment: WrapAlignment.center,
      children: features
          .asMap()
          .entries
          .map((entry) => SizedBox(
                width: isMedium ? (screenWidth - 100) / 2 - 10 : 280,
                child: _buildFeatureCard(
                  entry.value['icon'] as IconData,
                  entry.value['title'] as String,
                  entry.value['description'] as String,
                  entry.key,
                  isSmall,
                ),
              ))
          .toList(),
    );
  }

  double get screenWidth => MediaQuery.of(context).size.width;

  Widget _buildFeatureCard(
    IconData icon,
    String title,
    String description,
    int index,
    bool isSmall,
  ) {
    final isHovered = _hoveredFeatureIndex == index;

    return MouseRegion(
      onEnter: (_) => setState(() => _hoveredFeatureIndex = index),
      onExit: (_) => setState(() => _hoveredFeatureIndex = -1),
      child: AnimatedContainer(
        duration: const Duration(milliseconds: 300),
        curve: Curves.easeOut,
        decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(20),
          gradient: isHovered
              ? LinearGradient(
                  colors: [
                    AppColors.purple,
                    AppColors.primary,
                    AppColors.secondary,
                    AppColors.purple,
                  ],
                  begin: Alignment.topLeft,
                  end: Alignment.bottomRight,
                )
              : null,
          boxShadow: [
            BoxShadow(
              color: Colors.black.withValues(alpha: 0.05),
              blurRadius: 15,
              offset: const Offset(0, 6),
            ),
          ],
        ),
        padding: EdgeInsets.all(isHovered ? 2 : 1),
        transform: Matrix4.identity()..translate(0.0, isHovered ? -6.0 : 0.0),
        child: Container(
          padding: EdgeInsets.all(isSmall ? 24 : 32),
          decoration: BoxDecoration(
            color: AppColors.white,
            borderRadius: BorderRadius.circular(18),
            border: !isHovered
                ? Border.all(
                    color: AppColors.greyLight.withValues(alpha: 0.3),
                    width: 1,
                  )
                : null,
          ),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              // Icône
              Container(
                width: isSmall ? 56 : 64,
                height: isSmall ? 56 : 64,
                decoration: BoxDecoration(
                  gradient: LinearGradient(
                    colors: [
                      AppColors.purple.withValues(alpha: 0.1),
                      AppColors.primary.withValues(alpha: 0.1),
                    ],
                  ),
                  shape: BoxShape.circle,
                ),
                child: Icon(
                  icon,
                  size: isSmall ? 28 : 32,
                  color: AppColors.purple,
                ),
              ),
              SizedBox(height: isSmall ? 16 : 20),

              // Titre
              Text(
                title,
                style: AppTextStyles.headlineSmall(context).copyWith(
                  color: AppColors.darkText,
                ),
              ),
              SizedBox(height: isSmall ? 8 : 12),

              // Description
              Text(
                description,
                style: AppTextStyles.bodyMedium(context).copyWith(
                  color: AppColors.greyText,
                  height: 1.6,
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
