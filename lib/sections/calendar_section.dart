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
    final isMobile = screenWidth < 768; // R4 — breakpoint unifié
    final isTablet = screenWidth >= 768 && screenWidth < 1024;

    // R5 — SectionContainer gère déjà le padding ; Container interne supprimé
    return SectionContainer(
      backgroundColor: AppColors.lightBg,
      child: Column(
        children: [
          _buildBadge(isMobile),
          SizedBox(height: isMobile ? 24 : 32),
          _buildTitle(context, isMobile),
          SizedBox(height: isMobile ? 16 : 24),
          _buildDescription(context, isMobile),
          SizedBox(height: isMobile ? 40 : 60),
          _buildFeatureCards(context, screenWidth, isMobile, isTablet),
        ],
      ),
    );
  }

  Widget _buildBadge(bool isMobile) {
    return Container(
      padding: EdgeInsets.symmetric(
        horizontal: isMobile ? 16 : 24,
        vertical: isMobile ? 8 : 12,
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
          Icon(Icons.calendar_today_outlined,
              color: AppColors.purple, size: isMobile ? 16 : 20),
          SizedBox(width: isMobile ? 6 : 8),
          Text(
            'CALENDRIER INTELLIGENT',
            style: TextStyle(
              fontSize: isMobile ? 12 : 13,
              fontWeight: FontWeight.w700,
              letterSpacing: 1.2,
              color: AppColors.purple,
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildTitle(BuildContext context, bool isMobile) {
    return Text(
      'Un calendrier personnalisé pour maximiser vos chances',
      textAlign: TextAlign.center,
      style: (isMobile
              ? AppTextStyles.headlineMedium(context)
              : AppTextStyles.displayMedium(context))
          .copyWith(color: AppColors.purple, height: 1.3),
    );
  }

  Widget _buildDescription(BuildContext context, bool isMobile) {
    return ConstrainedBox(
      constraints: BoxConstraints(maxWidth: isMobile ? 600 : 800),
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

  Widget _buildFeatureCards(
    BuildContext context,
    double screenWidth,
    bool isMobile,
    bool isTablet,
  ) {
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

    if (isMobile) {
      return Column(
        children: features
            .asMap()
            .entries
            .map((entry) => Padding(
                  padding: EdgeInsets.only(
                    bottom: entry.key < features.length - 1 ? 20 : 0,
                  ),
                  child: _buildFeatureCard(
                    context,
                    entry.value['icon'] as IconData,
                    entry.value['title'] as String,
                    entry.value['description'] as String,
                    entry.key,
                    isMobile,
                  ),
                ))
            .toList(),
      );
    }

    // R4 — Utiliser le screenWidth passé en paramètre (plus de getter)
    final cardWidth = isTablet ? (screenWidth - 100) / 2 - 10 : 280.0;

    return Wrap(
      spacing: 20,
      runSpacing: 20,
      alignment: WrapAlignment.center,
      children: features
          .asMap()
          .entries
          .map((entry) => SizedBox(
                width: cardWidth,
                child: _buildFeatureCard(
                  context,
                  entry.value['icon'] as IconData,
                  entry.value['title'] as String,
                  entry.value['description'] as String,
                  entry.key,
                  isMobile,
                ),
              ))
          .toList(),
    );
  }

  Widget _buildFeatureCard(
    BuildContext context,
    IconData icon,
    String title,
    String description,
    int index,
    bool isMobile,
  ) {
    final isHovered = _hoveredFeatureIndex == index;
    final titleStyle = AppTextStyles.headlineSmall(context).copyWith(
      color: AppColors.darkText,
      fontSize: !isMobile && title == 'Dates de Menstruation' ? 30 : null,
    );

    // R10 — Gradient hover adouci : 2 couleurs
    return MouseRegion(
      onEnter: (_) => setState(() => _hoveredFeatureIndex = index),
      onExit: (_) => setState(() => _hoveredFeatureIndex = -1),
      child: AnimatedContainer(
        duration: const Duration(milliseconds: 300),
        curve: Curves.easeOut,
        decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(20),
          gradient: isHovered
              ? const LinearGradient(
                  colors: [AppColors.purple, AppColors.primary],
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
        transform: Matrix4.translationValues(0.0, isHovered ? -6.0 : 0.0, 0.0),
        child: Container(
          padding: EdgeInsets.all(isMobile ? 24 : 32),
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
              Container(
                width: isMobile ? 56 : 64,
                height: isMobile ? 56 : 64,
                decoration: BoxDecoration(
                  gradient: LinearGradient(
                    colors: [
                      AppColors.purple.withValues(alpha: 0.1),
                      AppColors.primary.withValues(alpha: 0.1),
                    ],
                  ),
                  shape: BoxShape.circle,
                ),
                child: Icon(icon,
                    size: isMobile ? 28 : 32, color: AppColors.purple),
              ),
              SizedBox(height: isMobile ? 16 : 20),
              Text(
                title,
                style: titleStyle,
              ),
              SizedBox(height: isMobile ? 8 : 12),
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
