import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:go_router/go_router.dart';

import 'package:elfulk/src/core/config/routing/routes.dart';
import 'package:elfulk/src/core/helpers/helpers.dart';
import 'package:elfulk/src/core/widgets/app_confirmation_dialog.dart';
import 'package:elfulk/src/core/widgets/app_sheets.dart';
import 'package:elfulk/src/core/widgets/custom_text_field.dart';
import 'package:elfulk/src/core/widgets/helpers/show_app_confirmation_dialog.dart';
import 'package:elfulk/src/core/widgets/settings_list_tile.dart';

/// إعدادات الحساب حسب التصميم (عربي RTL).
///
/// بطاقة مجمعة: تعديل البيانات، تغيير كلمة المرور، تغيير رمز القفل
/// (سلسلة ستائر)، حذف الحساب (حواران متسلسلان).
class AccountSettingsScreen extends StatelessWidget {
  const AccountSettingsScreen({super.key});

  @override
  Widget build(BuildContext context) {
    final ThemeData theme = Theme.of(context);

    return Scaffold(
      appBar: AppBar(title: const Text('إعدادات الحساب'), centerTitle: true),
      body: SafeArea(
        child: ListView(
          padding: context.spacing.pagePadding,
          children: [
            _GroupCard(
              children: [
                _menuTile(
                  context,
                  theme,
                  title: 'تعديل البيانات الشخصية',
                  icon: Icons.person_outline_rounded,
                  onTap: () => context.push(Routes.editPersonalInfoScreen),
                ),
                _menuTile(
                  context,
                  theme,
                  title: 'تغيير كلمة مرور الحساب',
                  icon: Icons.lock_outline_rounded,
                  onTap: () => context.push(Routes.changePasswordScreen),
                ),
                _menuTile(
                  context,
                  theme,
                  title: 'تغيير رمز القفل الأبوي',
                  icon: Icons.pin_outlined,
                  onTap: () => _changePinFlow(context),
                ),
                SettingsListTile(
                  title: 'حذف الحساب',
                  leading: const Icon(Icons.delete_outline_rounded),
                  leadingBackgroundColor:
                      theme.colorScheme.surfaceContainerHighest,
                  titleColor: theme.colorScheme.error,
                  backgroundColor: Colors.transparent,
                  borderRadius: 0,
                  showDivider: false,
                  onTap: () => _deleteAccountFlow(context),
                ),
              ],
            ),
          ],
        ),
      ),
    );
  }

  SettingsListTile _menuTile(
    BuildContext context,
    ThemeData theme, {
    required String title,
    required IconData icon,
    required VoidCallback onTap,
  }) {
    return SettingsListTile(
      title: title,
      leading: Icon(icon),
      leadingBackgroundColor:
          theme.colorScheme.surfaceContainerHighest,
      trailing: const SettingsTileTrailing.chevron(),
      backgroundColor: Colors.transparent,
      borderRadius: 0,
      showDivider: false,
      dashedDivider: true,
      onTap: onTap,
    );
  }

  /// سلسلة تغيير الرمز: الحالي ← الجديد ← التأكيد (مع تحقق التطابق).
  Future<void> _changePinFlow(BuildContext context) async {
    final String? current = await showPinEntrySheet(
      context: context,
      title: 'أدخل رمز القفل الحالي',
      confirmLabel: 'التالي',
      forgotLabel: 'هل نسيت رمز المرور؟ إعادة تعيين',
      onForgot: () {
        Navigator.of(context).pop();
        _verifyPasswordFlow(context);
      },
    );
    if (current == null || !context.mounted) return;
    final String? fresh = await showPinEntrySheet(
      context: context,
      title: 'إعادة تعيين رمز القفل الأبوي',
      hint: 'قم بإدخال رمز القفل الجديد.',
      confirmLabel: 'التالي',
    );
    if (fresh == null || !context.mounted) return;
    final String? confirm = await showPinEntrySheet(
      context: context,
      title: 'إعادة تعيين رمز القفل الأبوي',
      hint: 'قم بتأكيد رمز القفل الجديد.',
      confirmLabel: 'حفظ التعديلات',
    );
    if (confirm == null || !context.mounted) return;
    if (confirm != fresh) {
      if (context.mounted) {
        ScaffoldMessenger.of(context).showSnackBar(
          const SnackBar(content: Text('الرمزان غير متطابقين.')),
        );
      }
      return;
    }
    if (context.mounted) {
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(content: Text('تم حفظ رمز القفل الجديد.')),
      );
    }
  }

  /// تحقق كلمة مرور الحساب (لوحة نظام) قبل إعادة التعيين.
  Future<void> _verifyPasswordFlow(BuildContext context) async {
    final TextEditingController controller = TextEditingController();
    try {
      final bool? ok = await showAppBottomSheet<bool>(
        context: context,
        builder: (BuildContext sheetContext) => Column(
          mainAxisSize: MainAxisSize.min,
          crossAxisAlignment: CrossAxisAlignment.stretch,
          children: [
            const SheetTitle(text: 'نسيت رمز القفل الابوي'),
            SizedBox(height: context.spacing.md.h),
            CustomTextField(
              hintText: 'قم بإدخال كلمة المرور الخاص بالحساب',
              prefixIcon: SvgPicture.asset('assets/icons/lock.svg'),
              isPassword: true,
              controller: controller,
            ),
            SizedBox(height: context.spacing.lg.h),
            SizedBox(
              height: 42.h,
              child: ElevatedButton(
                onPressed: () => Navigator.of(sheetContext).pop(
                  controller.text.isNotEmpty,
                ),
                style: ElevatedButton.styleFrom(
                  backgroundColor:
                      Theme.of(sheetContext).colorScheme.primary,
                  foregroundColor:
                      Theme.of(sheetContext).colorScheme.onPrimary,
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(
                      context.radius.xxl.r,
                    ),
                  ),
                  elevation: 0,
                ),
                child: const Text('التالي'),
              ),
            ),
          ],
        ),
      );
      if (ok == true && context.mounted) {
        _changePinFlow(context);
      }
    } finally {
      controller.dispose();
    }
  }

  /// حذف الحساب: حوار تأكيد منزلق ثم تحذير نهائي.
  Future<void> _deleteAccountFlow(BuildContext context) async {
    final bool? first = await showAppConfirmationDialog(
      context: context,
      config: AppConfirmationConfig(
        title: 'هل انت متأكد من حذف الحساب الشخصي ؟',
        message:
            'سيؤدي حذف حسابك إلى إزالة جميع بيانات أطفالك، إعدادات '
            'الحماية، والأجهزة المرتبطة بشكل كامل ونهائي.',
        icon: SvgPicture.asset('assets/icons/trash.svg'),
        primaryActionType: AppConfirmationPrimaryActionType.destructive,
        primaryActionLabel: 'حذف حسابي',
        secondaryActionLabel: 'إلغاء',
        slideTextDirection: TextDirection.rtl,
      ),
    );
    if (first != true || !context.mounted) return;
    final bool? last = await showAppConfirmationDialog(
      context: context,
      config: AppConfirmationConfig(
        title: 'تحذير نهائي قبل الحذف',
        message:
            'هذه الخطوة نهائية ولا يمكن التراجع عنها. سيتم تسجيل خروجك '
            'وحذف كل شيء مرتبط بحسابك.',
        icon: SvgPicture.asset('assets/icons/trash.svg'),
        primaryActionType: AppConfirmationPrimaryActionType.destructive,
        primaryActionLabel: 'تأكيد الحذف النهائي',
        secondaryActionLabel: 'تراجع',
        slideTextDirection: TextDirection.rtl,
      ),
    );
    if (last == true && context.mounted) {
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(content: Text('تم إرسال طلب حذف الحساب.')),
      );
    }
  }
}

/// بطاقة مجموعة: خلفية وزاوية مستديرة تحتضن صفوفاً شفافة.
class _GroupCard extends StatelessWidget {
  final List<Widget> children;

  const _GroupCard({required this.children});

  @override
  Widget build(BuildContext context) {
    final ThemeData theme = Theme.of(context);

    return Material(
      color: theme.cardTheme.color,
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(context.radius.xxl.r),
      ),
      clipBehavior: Clip.antiAlias,
      child: Column(
        mainAxisSize: MainAxisSize.min,
        crossAxisAlignment: CrossAxisAlignment.stretch,
        children: children,
      ),
    );
  }
}
