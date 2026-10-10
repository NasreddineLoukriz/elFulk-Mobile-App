import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

import 'package:elfulk/src/core/helpers/helpers.dart';
import 'package:elfulk/src/core/widgets/slide_to_confirm_button.dart';

/// يحدد أي زر إجراء رئيسي يعرضه [AppConfirmationDialog].
///
/// - [destructive]: زر [SlideToConfirmButton] بعرض كامل يجب على المستخدم
///   سحبه للتأكيد. يُستخدم للإجراءات الخطيرة غير القابلة للتراجع (حذف
///   الحساب، حذف ملف الطفل، إعادة ضبط المصنع).
/// - [normal]: زر `ElevatedButton` قياسي بعرض كامل بنفس ستايل
///   `PrimaryButton` في المشروع. يُستخدم للتأكيدات القابلة للتراجع
///   منخفضة التكلفة.
enum AppConfirmationPrimaryActionType {
  /// زر السحب للتأكيد للإجراءات الخطيرة.
  destructive,

  /// زر مملوء قياسي للتأكيدات العادية.
  normal,
}

/// إعدادات ثابتة مدفوعة بالبارامترات لضبط [AppConfirmationDialog].
///
/// كل نص ظاهر وأيقونة ولون يُمرَّر من مكان الاستدعاء — هذا الكلاس لا
/// يحتوي **أي نص أو ألوان أو أيقونات ثابتة**. جميع حقول `Color?` تعود
/// لقيم مأخوذة من `Theme.of(context).colorScheme`، فتبقى أماكن الاستدعاء
/// نظيفة ويحترم الحوار مظهري الوضع الفاتح والداكن.
///
/// مثال (ملاحظة: لا توجد فئة `AppIcons` في هذا المشروع — تُمرَّر الأيقونات
/// عبر `SvgPicture.asset(AssetsPathHelper.<name>)`):
///
/// ```dart
/// await showAppConfirmationDialog(
///   context: context,
///   config: AppConfirmationConfig(
///     title: 'هل انت متأكد من حذف الحساب الشخصي ؟',
///     message: 'سيؤدي حذف حسابك إلى إزالة جميع بيانات أطفالك، إعدادات '
///         'الحماية، والأجهزة المرتبطة بشكل كامل ونهائي.',
///     icon: SvgPicture.asset(AssetsPathHelper.trash),
///     primaryActionType: AppConfirmationPrimaryActionType.destructive,
///     primaryActionLabel: 'حذف حسابي',
///     secondaryActionLabel: 'إلغاء',
///   ),
/// );
/// ```
class AppConfirmationConfig {
  /// عنوان الحوار (مثال: `'هل انت متأكد من حذف الحساب الشخصي ؟'`).
  final String title;

  /// النص التوضيحي المعروض أسفل العنوان.
  final String message;

  /// أيقونة العلامة المعروضة داخل الدائرة العلوية
  /// (غالباً `SvgPicture.asset(...)` أو [Icon]).
  final Widget icon;

  /// نص زر الإجراء الرئيسي (زر التأكيد).
  final String primaryActionLabel;

  /// نص الزر الثانوي (زر الإلغاء/الرجوع).
  final String secondaryActionLabel;

  /// نسخة زر الإجراء الرئيسي المطلوب عرضها.
  final AppConfirmationPrimaryActionType primaryActionType;

  /// لون الزر الرئيسي / لون تقدم السحب.
  ///
  /// الافتراضي: `colorScheme.error` لوضع [AppConfirmationPrimaryActionType.destructive]
  /// و`colorScheme.primary` لوضع [AppConfirmationPrimaryActionType.normal].
  final Color? primaryActionColor;

  /// لون مقدمة الزر الثانوي (النص).
  ///
  /// الافتراضي: `colorScheme.onSurface`.
  final Color? secondaryActionColor;

  /// لون خلفية الزر الثانوي المملوء.
  ///
  /// الافتراضي: `colorScheme.surfaceContainerHighest` (تعبئة محايدة
  /// تطابق التصميم في الوضعين الفاتح والداكن).
  final Color? secondaryActionBackgroundColor;

  /// خلفية الدائرة العلوية للأيقونة.
  ///
  /// الافتراضي: لون الإجراء الرئيسي المحسوم بشفافية 12%.
  final Color? iconBackgroundColor;

  /// لون مقدمة الأيقونة داخل الدائرة العلوية.
  ///
  /// الافتراضي: لون الإجراء الرئيسي المحسوم.
  final Color? iconColor;

  /// يُستدعى عند تأكيد المستخدم للإجراء الرئيسي (ضغط الزر العادي أو
  /// إكمال السحب). يُغلق الحوار تلقائياً بعد تنفيذ هذا الـ callback.
  final VoidCallback? onPrimaryAction;

  /// يُستدعى عند ضغط المستخدم على الزر الثانوي.
  ///
  /// الافتراضي: `Navigator.of(context).pop(false)` عند عدم تمريره.
  final VoidCallback? onSecondaryAction;

  /// يتجاوز اتجاه [Directionality] المحيط لمسار السحب للتأكيد
  /// (وضع destructive فقط).
  ///
  /// عند `null` (الافتراضي) يتبع السحب الاتجاه المحيط. مرّر
  /// `TextDirection.rtl` لفرض سحب من اليمين إلى اليسار (مثال: نص عربي
  /// للحذف معروض بينما يعمل التطبيق باتجاه LTR محيط).
  final TextDirection? slideTextDirection;

  /// الـ widget المعروض داخل قرص السحب المصمت (وضع destructive فقط).
  ///
  /// الافتراضي: أيقونة سلة مهملات بيضاء (بلون `onError` من الثيم).
  final Widget? thumbIcon;

  /// الـ widget المعروض داخل دائرة الوجهة الشبح عند نهاية مسار السحب
  /// (وضع destructive فقط).
  ///
  /// الافتراضي: أيقونة سلة مهملات بلون الإجراء الرئيسي.
  final Widget? hintIcon;

  const AppConfirmationConfig({
    required this.title,
    required this.message,
    required this.icon,
    required this.primaryActionLabel,
    required this.secondaryActionLabel,
    required this.primaryActionType,
    this.primaryActionColor,
    this.secondaryActionColor,
    this.secondaryActionBackgroundColor,
    this.iconBackgroundColor,
    this.iconColor,
    this.onPrimaryAction,
    this.onSecondaryAction,
    this.slideTextDirection,
    this.thumbIcon,
    this.hintIcon,
  });
}

/// حوار تأكيد قابل لإعادة الاستخدام ومدفوع بالبارامترات بالكامل،
/// يحتوي على زرين مكدسين عمودياً بالضبط.
///
/// التخطيط (من الأعلى للأسفل): دائرة أيقونة العلامة (`56.w`)، ثم العنوان
/// المتمركز (`headlineSmall`، `20.sp`، `w700`)، ثم النص المتمركز
/// (`bodyMedium`، `14.sp`، `onSurface` بشفافية 60%)، ثم زر الإجراء
/// الرئيسي (`42.h`)، ثم زر الإجراء الثانوي (`42.h`).
///
/// الزر الرئيسي قابل للتبديل عبر [AppConfirmationConfig.primaryActionType]:
/// وضع [AppConfirmationPrimaryActionType.destructive] يعرض
/// [SlideToConfirmButton]، ووضع [AppConfirmationPrimaryActionType.normal]
/// يعرض زر `ElevatedButton` بعرض كامل.
///
/// هذا الـ widget عديم الحالة ولا يملك أي نص أو ألوان أو أيقونات — كل
/// شيء يأتي من [config] أو من الثيم المحيط. وهو آمن لاتجاه RTL: العنوان
/// والنص واتجاه السحب تتبع اتجاه [Directionality] المحيط.
///
/// يُفضّل عرضه عبر `showAppConfirmationDialog` التي تحوّل الإغلاق إلى
/// `true` (تم الإجراء الرئيسي) أو `false` (الثانوي) أو `null`
/// (أُغلق بالضغط خارج الحوار / زر الرجوع).
class AppConfirmationDialog extends StatelessWidget {
  /// كائن البارامترات الذي يقود كل عنصر مرئي ونصي.
  final AppConfirmationConfig config;

  const AppConfirmationDialog({
    super.key,
    required this.config,
  });

  @override
  Widget build(BuildContext context) {
    final ThemeData theme = Theme.of(context);

    final bool isDestructive =
        config.primaryActionType ==
        AppConfirmationPrimaryActionType.destructive;
    final Color primary = config.primaryActionColor ??
        (isDestructive
            ? theme.colorScheme.error
            : theme.colorScheme.primary);
    final Color secondary =
        config.secondaryActionColor ?? theme.colorScheme.onSurface;
    final Color secondaryBg =
        config.secondaryActionBackgroundColor ??
            theme.colorScheme.surfaceContainerHighest;
    final Color iconFg = config.iconColor ?? primary;
    final Color iconBg = config.iconBackgroundColor ??
        primary.withValues(alpha: 0.12);

    void handlePrimary() {
      config.onPrimaryAction?.call();
      Navigator.of(context).pop(true);
    }

    void handleSecondary() {
      if (config.onSecondaryAction != null) {
        config.onSecondaryAction!();
      } else {
        Navigator.of(context).pop(false);
      }
    }

    // ملاحظة: استُخدم [Dialog] قصداً وليس [AlertDialog].
    // يقيس AlertDialog محتواه عبر الأبعاد الجوهرية (intrinsics) بينما
    // لا يستطيع LayoutBuilder (المستخدم في SlideToConfirmButton) توفيرها،
    // مما يكسر التخطيط بالكامل.
    return Dialog(
      backgroundColor: theme.colorScheme.surface,
      shape: RoundedRectangleBorder(
        borderRadius:
            BorderRadius.circular(context.radius.xl.r),
      ),
      insetPadding: EdgeInsets.symmetric(
        horizontal: 40.w,
        vertical: 24.h,
      ),
      child: Padding(
        padding: EdgeInsets.symmetric(
          horizontal: context.spacing.lg.w,
          vertical: context.spacing.lg.h,
        ),
        child: Column(
          mainAxisSize: MainAxisSize.min,
          children: [
          Container(
            width: 56.w,
            height: 56.w,
            decoration: BoxDecoration(
              color: iconBg,
              shape: BoxShape.circle,
            ),
            child: Center(
              child: IconTheme(
                data: IconThemeData(color: iconFg, size: 24.sp),
                child: config.icon,
              ),
            ),
          ),
          SizedBox(height: context.spacing.sm.h),
          Text(
            config.title,
            key: const ValueKey('app-confirmation-title'),
            textAlign: TextAlign.center,
            style: theme.textTheme.headlineSmall?.copyWith(
                  fontSize: 20.sp,
                  fontWeight: FontWeight.w700,
                  color: theme.colorScheme.onSurface,
                ) ??
                TextStyle(
                  fontSize: 20.sp,
                  fontWeight: FontWeight.w700,
                  color: theme.colorScheme.onSurface,
                ),
          ),
          SizedBox(height: context.spacing.sm.h),
          Text(
            config.message,
            key: const ValueKey('app-confirmation-message'),
            textAlign: TextAlign.center,
            style: theme.textTheme.bodyMedium?.copyWith(
                  fontSize: 14.sp,
                  fontWeight: FontWeight.w400,
                  color: theme.colorScheme.onSurface
                      .withValues(alpha: 0.6),
                ) ??
                TextStyle(
                  fontSize: 14.sp,
                  fontWeight: FontWeight.w400,
                  color: theme.colorScheme.onSurface
                      .withValues(alpha: 0.6),
                ),
          ),
          SizedBox(height: context.spacing.lg.h),
          if (isDestructive)
            SlideToConfirmButton(
              label: config.primaryActionLabel,
              progressColor: primary,
              textDirection: config.slideTextDirection,
              thumbIcon: config.thumbIcon,
              hintIcon: config.hintIcon,
              onConfirmed: handlePrimary,
            )
          else
            SizedBox(
              width: double.infinity,
              height: 42.h,
              child: ElevatedButton(
                key: const ValueKey(
                    'app-confirmation-primary-normal'),
                onPressed: handlePrimary,
                style: ElevatedButton.styleFrom(
                  backgroundColor: primary,
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(
                      context.radius.xxl.r,
                    ),
                  ),
                  elevation: 0,
                ),
                child: Text(
                  config.primaryActionLabel,
                  style: theme.textTheme.titleMedium?.copyWith(
                        fontSize: 16.sp,
                        fontWeight: FontWeight.w600,
                      ) ??
                      TextStyle(
                        fontSize: 16.sp,
                        fontWeight: FontWeight.w600,
                      ),
                ),
              ),
            ),
          SizedBox(height: context.spacing.sm.h),
          SizedBox(
            width: double.infinity,
            height: 42.h,
            child: ElevatedButton(
              key: const ValueKey('app-confirmation-secondary'),
              onPressed: handleSecondary,
              style: ElevatedButton.styleFrom(
                backgroundColor: secondaryBg,
                foregroundColor: secondary,
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(
                    context.radius.xxl.r,
                  ),
                ),
                elevation: 0,
              ),
              child: Text(
                config.secondaryActionLabel,
                style: theme.textTheme.titleMedium?.copyWith(
                      fontSize: 16.sp,
                      fontWeight: FontWeight.w600,
                    ) ??
                    TextStyle(
                      fontSize: 16.sp,
                      fontWeight: FontWeight.w600,
                    ),
              ),
            ),
          ),
          ],
        ),
      ),
    );
  }
}
