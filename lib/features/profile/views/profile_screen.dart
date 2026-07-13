import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:shamba_ai/core/theme/app_theme.dart';
import 'package:shamba_ai/features/profile/controllers/profile_controller.dart';

class ProfileScreen extends StatelessWidget {
  const ProfileScreen({super.key});

  @override
  Widget build(BuildContext context) {
    final ctrl = Get.put(ProfileController());
    final user = ctrl.currentUser;

    return Scaffold(
      body: Container(
        decoration: const BoxDecoration(gradient: AppColors.bgGradient),
        child: SafeArea(
          child: ListView(
            padding: const EdgeInsets.fromLTRB(20, 16, 20, 28),
            children: [
              Row(
                children: [
                  _IconButton(
                    icon: Icons.arrow_back_ios_new_rounded,
                    onTap: Get.back,
                  ),
                  const SizedBox(width: 14),
                  Text('Profile', style: AppTextStyles.titleLarge),
                ],
              ),
              const SizedBox(height: 28),
              _ProfileHeader(ctrl: ctrl),
              const SizedBox(height: 24),
              _Section(
                title: 'Account',
                children: [
                  _ProfileInput(
                    label: 'Full name',
                    initialValue: ctrl.displayName.value,
                    hintText: 'Your name',
                    onChanged: ctrl.setDisplayName,
                  ),
                  const SizedBox(height: 16),
                  _ProfileInput(
                    label: 'Photo URL',
                    initialValue: ctrl.photoUrl.value,
                    hintText: 'https://example.com/photo.jpg',
                    onChanged: ctrl.setPhotoUrl,
                  ),
                  const SizedBox(height: 16),
                  _ReadOnlyInfo(
                    label: 'Email',
                    value: user?.email ?? 'Not set',
                  ),
                  const SizedBox(height: 12),
                  _ReadOnlyInfo(
                    label: 'Phone',
                    value: user?.phoneNumber ?? 'Not set',
                  ),
                ],
              ),
              const SizedBox(height: 18),
              _Section(
                title: 'Language',
                children: [
                  Obx(
                    () => _LanguageToggle(
                      selected: ctrl.languageCode.value,
                      onChanged: ctrl.setLanguage,
                    ),
                  ),
                ],
              ),
              const SizedBox(height: 24),
              Obx(
                () => _PrimaryAction(
                  label: 'Save profile',
                  isLoading: ctrl.isLoading.value,
                  onTap: ctrl.saveProfile,
                ),
              ),
              const SizedBox(height: 14),
              Obx(
                () => _SecondaryAction(
                  label: 'Log out',
                  isLoading: ctrl.isLoading.value,
                  onTap: ctrl.signOut,
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}

class _ProfileHeader extends StatelessWidget {
  final ProfileController ctrl;
  const _ProfileHeader({required this.ctrl});

  @override
  Widget build(BuildContext context) {
    return Obx(() {
      final name = ctrl.displayName.value.trim();
      final photo = ctrl.photoUrl.value.trim();

      return Container(
        padding: const EdgeInsets.all(18),
        decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(20),
          gradient: AppColors.cardGradient,
          border: Border.all(color: AppColors.border),
        ),
        child: Row(
          children: [
            CircleAvatar(
              radius: 32,
              backgroundColor: AppColors.primaryDark,
              backgroundImage: photo.isEmpty ? null : NetworkImage(photo),
              child: photo.isEmpty
                  ? Text(
                      name.isEmpty ? 'S' : name.characters.first.toUpperCase(),
                      style: AppTextStyles.headlineMedium,
                    )
                  : null,
            ),
            const SizedBox(width: 16),
            Expanded(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    name.isEmpty ? 'ShambaAI Farmer' : name,
                    style: AppTextStyles.titleLarge,
                  ),
                  const SizedBox(height: 4),
                  Text(
                    'Manage your account and app preferences',
                    style: AppTextStyles.bodySmall,
                  ),
                ],
              ),
            ),
          ],
        ),
      );
    });
  }
}

class _Section extends StatelessWidget {
  final String title;
  final List<Widget> children;
  const _Section({required this.title, required this.children});

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(title, style: AppTextStyles.labelLarge),
        const SizedBox(height: 10),
        Container(
          padding: const EdgeInsets.all(16),
          decoration: BoxDecoration(
            color: AppColors.bgCard,
            borderRadius: BorderRadius.circular(18),
            border: Border.all(color: AppColors.border),
          ),
          child: Column(children: children),
        ),
      ],
    );
  }
}

class _ProfileInput extends StatelessWidget {
  final String label;
  final String initialValue;
  final String hintText;
  final ValueChanged<String> onChanged;

  const _ProfileInput({
    required this.label,
    required this.initialValue,
    required this.hintText,
    required this.onChanged,
  });

  @override
  Widget build(BuildContext context) {
    return TextFormField(
      initialValue: initialValue,
      onChanged: onChanged,
      style: AppTextStyles.titleMedium,
      decoration: InputDecoration(labelText: label, hintText: hintText),
    );
  }
}

class _ReadOnlyInfo extends StatelessWidget {
  final String label;
  final String value;
  const _ReadOnlyInfo({required this.label, required this.value});

  @override
  Widget build(BuildContext context) {
    return Row(
      children: [
        Expanded(child: Text(label, style: AppTextStyles.bodySmall)),
        const SizedBox(width: 12),
        Flexible(
          flex: 2,
          child: Text(
            value,
            style: AppTextStyles.bodyMedium,
            textAlign: TextAlign.right,
            overflow: TextOverflow.ellipsis,
          ),
        ),
      ],
    );
  }
}

class _LanguageToggle extends StatelessWidget {
  final String selected;
  final ValueChanged<String> onChanged;
  const _LanguageToggle({required this.selected, required this.onChanged});

  @override
  Widget build(BuildContext context) {
    return Container(
      height: 48,
      padding: const EdgeInsets.all(4),
      decoration: BoxDecoration(
        color: AppColors.bgSurface,
        borderRadius: BorderRadius.circular(14),
      ),
      child: Row(
        children: [
          _LanguageButton(
            label: 'English',
            selected: selected == 'en',
            onTap: () => onChanged('en'),
          ),
          _LanguageButton(
            label: 'Kiswahili',
            selected: selected == 'sw',
            onTap: () => onChanged('sw'),
          ),
        ],
      ),
    );
  }
}

class _LanguageButton extends StatelessWidget {
  final String label;
  final bool selected;
  final VoidCallback onTap;
  const _LanguageButton({
    required this.label,
    required this.selected,
    required this.onTap,
  });

  @override
  Widget build(BuildContext context) {
    return Expanded(
      child: GestureDetector(
        onTap: onTap,
        child: AnimatedContainer(
          duration: const Duration(milliseconds: 180),
          decoration: BoxDecoration(
            borderRadius: BorderRadius.circular(10),
            gradient: selected ? AppColors.primaryGradient : null,
          ),
          child: Center(
            child: Text(
              label,
              style: AppTextStyles.labelMedium.copyWith(
                color: selected ? Colors.white : AppColors.textSecondary,
              ),
            ),
          ),
        ),
      ),
    );
  }
}

class _PrimaryAction extends StatelessWidget {
  final String label;
  final bool isLoading;
  final VoidCallback onTap;
  const _PrimaryAction({
    required this.label,
    required this.isLoading,
    required this.onTap,
  });

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: isLoading ? null : onTap,
      child: Container(
        width: double.infinity,
        height: 56,
        decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(16),
          gradient: AppColors.primaryGradient,
        ),
        child: Center(
          child: isLoading
              ? const SizedBox(
                  width: 22,
                  height: 22,
                  child: CircularProgressIndicator(
                    strokeWidth: 2.4,
                    color: Colors.white,
                  ),
                )
              : Text(label, style: AppTextStyles.labelLarge),
        ),
      ),
    );
  }
}

class _SecondaryAction extends StatelessWidget {
  final String label;
  final bool isLoading;
  final VoidCallback onTap;
  const _SecondaryAction({
    required this.label,
    required this.isLoading,
    required this.onTap,
  });

  @override
  Widget build(BuildContext context) {
    return OutlinedButton(
      onPressed: isLoading ? null : onTap,
      style: OutlinedButton.styleFrom(
        foregroundColor: AppColors.error,
        side: const BorderSide(color: AppColors.error),
      ),
      child: Text(label),
    );
  }
}

class _IconButton extends StatelessWidget {
  final IconData icon;
  final VoidCallback onTap;
  const _IconButton({required this.icon, required this.onTap});

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: onTap,
      child: Container(
        width: 44,
        height: 44,
        decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(14),
          color: AppColors.bgCard,
          border: const Border.fromBorderSide(
            BorderSide(color: AppColors.border),
          ),
        ),
        child: Icon(icon, color: AppColors.textPrimary, size: 18),
      ),
    );
  }
}
