import 'package:flutter/material.dart';
import 'package:flutter_animate/flutter_animate.dart';
import 'package:get/get.dart';
import 'package:shamba_ai/core/theme/app_theme.dart';
import 'package:shamba_ai/core/services/storage_service.dart';
import 'package:shamba_ai/routes/app_routes.dart';
import 'package:shamba_ai/l10n/app_localizations.dart';

class HomeScreen extends StatelessWidget {
  const HomeScreen({super.key});

  String _greeting() {
    final hour = DateTime.now().hour;
    if (hour < 12) return 'goodMorning';
    if (hour < 17) return 'goodAfternoon';
    return 'goodEvening';
  }

  @override
  Widget build(BuildContext context) {
    final l = AppLocalizations.of(context);
    final phone = StorageService.getPhone() ?? '';

    return Scaffold(
      body: Container(
        decoration: const BoxDecoration(gradient: AppColors.bgGradient),
        child: SafeArea(
          child: CustomScrollView(
            slivers: [
              SliverToBoxAdapter(child: _buildHeader(l, phone)),
              SliverPadding(
                padding: const EdgeInsets.symmetric(horizontal: 20),
                sliver: SliverGrid(
                  delegate: SliverChildListDelegate(_buildModuleCards(l, context)),
                  gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
                    crossAxisCount: 2,
                    crossAxisSpacing: 14,
                    mainAxisSpacing: 14,
                    childAspectRatio: 1.1,
                  ),
                ),
              ),
              const SliverToBoxAdapter(child: SizedBox(height: 32)),
            ],
          ),
        ),
      ),
    );
  }

  Widget _buildHeader(AppLocalizations l, String phone) {
    final greetingKey = _greeting();
    final greetingMap = {
      'goodMorning': l.goodMorning,
      'goodAfternoon': l.goodAfternoon,
      'goodEvening': l.goodEvening,
    };
    final greeting = greetingMap[greetingKey] ?? l.goodMorning;

    return Padding(
      padding: const EdgeInsets.fromLTRB(20, 16, 20, 24),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Row(
            children: [
              Expanded(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      '$greeting 👋',
                      style: AppTextStyles.bodyMedium.copyWith(
                        color: AppColors.primaryLight,
                      ),
                    ).animate().fadeIn(duration: 500.ms),
                    const SizedBox(height: 4),
                    Text(
                      'ShambaAI',
                      style: AppTextStyles.displayMedium,
                    ).animate().fadeIn(delay: 100.ms, duration: 600.ms),
                  ],
                ),
              ),
              // Notification icon
              GestureDetector(
                onTap: () => Get.toNamed(AppRoutes.notifications),
                child: Container(
                  width: 46,
                  height: 46,
                  decoration: BoxDecoration(
                    borderRadius: BorderRadius.circular(14),
                    color: AppColors.bgCard,
                    border: const Border.fromBorderSide(
                      BorderSide(color: AppColors.border),
                    ),
                  ),
                  child: const Icon(
                    Icons.notifications_none_rounded,
                    color: AppColors.textPrimary,
                    size: 22,
                  ),
                ),
              ).animate().fadeIn(delay: 200.ms, duration: 500.ms),
            ],
          ),

          const SizedBox(height: 20),

          // Farm summary card
          GestureDetector(
            onTap: () => Get.toNamed(AppRoutes.farmProfile),
            child: Container(
              padding: const EdgeInsets.all(18),
              decoration: BoxDecoration(
                borderRadius: BorderRadius.circular(20),
                gradient: AppColors.primaryGradient,
                boxShadow: [
                  BoxShadow(
                    color: AppColors.primaryLight.withOpacity(0.25),
                    blurRadius: 20,
                    offset: const Offset(0, 6),
                  ),
                ],
              ),
              child: Row(
                children: [
                  const Text('🏡', style: TextStyle(fontSize: 36)),
                  const SizedBox(width: 14),
                  Expanded(
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text(
                          'My Farm',
                          style: AppTextStyles.titleMedium.copyWith(
                            color: Colors.white,
                          ),
                        ),
                        Text(
                          '0 active crops • Tap to set up',
                          style: AppTextStyles.bodySmall.copyWith(
                            color: Colors.white70,
                          ),
                        ),
                      ],
                    ),
                  ),
                  const Icon(
                    Icons.arrow_forward_ios_rounded,
                    color: Colors.white70,
                    size: 16,
                  ),
                ],
              ),
            ),
          ).animate().fadeIn(delay: 250.ms, duration: 600.ms).slideY(begin: 0.1),

          const SizedBox(height: 24),

          Text(
            'Farm Modules',
            style: AppTextStyles.titleLarge,
          ).animate().fadeIn(delay: 350.ms, duration: 500.ms),
          const SizedBox(height: 4),
        ],
      ),
    );
  }

  List<Widget> _buildModuleCards(AppLocalizations l, BuildContext context) {
    final modules = [
      _ModuleData(
        emoji: '🌱',
        label: l.myCrops,
        subtitle: 'Track your crops',
        gradient: AppColors.primaryGradient,
        route: AppRoutes.cropTracking,
        locked: false,
      ),
      _ModuleData(
        emoji: '🔬',
        label: l.aiDiagnosis,
        subtitle: 'Phase 2',
        gradient: const LinearGradient(
          colors: [Color(0xFF6B3FA0), Color(0xFF3B1F5C)],
        ),
        route: null,
        locked: true,
      ),
      _ModuleData(
        emoji: '🌤️',
        label: l.weather,
        subtitle: 'Phase 3',
        gradient: const LinearGradient(
          colors: [Color(0xFF1A5C7A), Color(0xFF0A3347)],
        ),
        route: null,
        locked: true,
      ),
      _ModuleData(
        emoji: '📈',
        label: l.market,
        subtitle: 'Phase 3',
        gradient: const LinearGradient(
          colors: [Color(0xFF7A4A1A), Color(0xFF4A2C0A)],
        ),
        route: null,
        locked: true,
      ),
      _ModuleData(
        emoji: '🤖',
        label: l.advisory,
        subtitle: 'Phase 3',
        gradient: const LinearGradient(
          colors: [Color(0xFF1A1A7A), Color(0xFF0A0A4A)],
        ),
        route: null,
        locked: true,
      ),
      _ModuleData(
        emoji: '🏡',
        label: l.farmProfile,
        subtitle: 'Set up your farm',
        gradient: AppColors.cardGradient,
        route: AppRoutes.farmProfile,
        locked: false,
      ),
    ];

    return modules
        .asMap()
        .entries
        .map((e) => _ModuleCard(data: e.value, index: e.key))
        .toList();
  }
}

class _ModuleData {
  final String emoji;
  final String label;
  final String subtitle;
  final LinearGradient gradient;
  final String? route;
  final bool locked;

  const _ModuleData({
    required this.emoji,
    required this.label,
    required this.subtitle,
    required this.gradient,
    required this.route,
    required this.locked,
  });
}

class _ModuleCard extends StatelessWidget {
  final _ModuleData data;
  final int index;

  const _ModuleCard({required this.data, required this.index});

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: data.locked
          ? () => Get.snackbar(
                'Coming Soon',
                '${data.label} unlocks in a future phase',
                backgroundColor: AppColors.bgCard,
                colorText: AppColors.textPrimary,
                borderRadius: 14,
                margin: const EdgeInsets.all(16),
                duration: const Duration(seconds: 2),
              )
          : () => Get.toNamed(data.route!),
      child: Container(
        decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(20),
          gradient: data.gradient,
          border: Border.all(color: AppColors.border.withOpacity(0.5)),
          boxShadow: [
            BoxShadow(
              color: Colors.black.withOpacity(0.15),
              blurRadius: 10,
              offset: const Offset(0, 4),
            ),
          ],
        ),
        child: Stack(
          children: [
            Padding(
              padding: const EdgeInsets.all(16),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(data.emoji, style: const TextStyle(fontSize: 32)),
                  const Spacer(),
                  Text(data.label, style: AppTextStyles.titleMedium),
                  const SizedBox(height: 2),
                  Text(
                    data.subtitle,
                    style: AppTextStyles.bodySmall.copyWith(
                      color: data.locked
                          ? AppColors.textHint
                          : AppColors.textSecondary,
                    ),
                  ),
                ],
              ),
            ),
            if (data.locked)
              Positioned(
                top: 12,
                right: 12,
                child: Container(
                  padding: const EdgeInsets.symmetric(horizontal: 8, vertical: 4),
                  decoration: BoxDecoration(
                    color: Colors.black.withOpacity(0.4),
                    borderRadius: BorderRadius.circular(8),
                    border: Border.all(color: AppColors.border.withOpacity(0.5)),
                  ),
                  child: Row(
                    mainAxisSize: MainAxisSize.min,
                    children: [
                      const Icon(Icons.lock_outline_rounded,
                          size: 10, color: AppColors.textHint),
                      const SizedBox(width: 3),
                      Text(
                        'Soon',
                        style: AppTextStyles.bodySmall.copyWith(fontSize: 10),
                      ),
                    ],
                  ),
                ),
              ),
          ],
        ),
      )
          .animate()
          .fadeIn(
            delay: Duration(milliseconds: 400 + (index * 80)),
            duration: 500.ms,
          )
          .scale(
            begin: const Offset(0.92, 0.92),
            curve: Curves.easeOutBack,
          ),
    );
  }
}
