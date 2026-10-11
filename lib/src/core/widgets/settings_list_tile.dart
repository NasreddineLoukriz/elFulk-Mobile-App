import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

import 'package:elfulk/src/core/helpers/helpers.dart';

/// عنصر التحكم النهائي (trailing) الذي يعرضه [SettingsListTile].
///
/// هرمية مغلقة تحمل بياناتها معها، فيختار مكان الاستدعاء المصنع
/// المناسب دون فرض شكل أيقونة ثابت:
/// ```dart
/// SettingsListTile(
///   title: 'إشعارات التنبيهات الحرجة.',
///   trailing: SettingsTileTrailing.switch_(
///     value: alertsEnabled,
///     onChanged: (v) => setState(() => alertsEnabled = v),
///   ),
///   onTap: () {},
/// )
/// ```
///
/// ملاحظة: اختيرت فئة مغلقة (sealed) بدل `enum` لأن قيم الـ enum ثوابت
/// وقت الترجمة ولا يمكن بناؤها ببارامترات (مثل `value` و`onChanged`)
/// عند الاستدعاء.
sealed class SettingsTileTrailing {
  const SettingsTileTrailing();

  /// لا يوجد عنصر نهائي.
  const factory SettingsTileTrailing.none() = _NoneTrailing;

  /// مفتاح `Switch` مادي قياسي.
  ///
  /// [value] هي الحالة الحالية (يملكها الأب: cubit أو state) و[onChanged]
  /// تُستدعى عند التبديل. [activeTrackColor] اختياري لتخصيص لون المسار
  /// عند التفعيل، وبدونه تُستخدم ألوان الثيم.
  const factory SettingsTileTrailing.switch_({
    required bool value,
    required ValueChanged<bool> onChanged,
    Color? activeTrackColor,
  }) = _SwitchTrailing;

  /// أيقونة سهم (chevron) تشير لاتجاه التنقل: يساراً في RTL ويميناً
  /// في LTR.
  const factory SettingsTileTrailing.chevron() = _ChevronTrailing;

  /// نص قيمة صغير وخافت (مثال: `'العربية'`).
  const factory SettingsTileTrailing.value(String text) = _ValueTrailing;
}

/// لا يوجد عنصر نهائي.
class _NoneTrailing extends SettingsTileTrailing {
  const _NoneTrailing();
}

/// مفتاح تبديل مادي مع قيمته ودالة التغيير.
class _SwitchTrailing extends SettingsTileTrailing {
  /// الحالة الحالية للمفتاح (يملكها الأب).
  final bool value;

  /// تُستدعى عند تبديل المستخدم للمفتاح.
  final ValueChanged<bool> onChanged;

  /// لون مسار المفتاح عند التفعيل (اختياري).
  final Color? activeTrackColor;

  const _SwitchTrailing({
    required this.value,
    required this.onChanged,
    this.activeTrackColor,
  });
}

/// سهم تنقل.
class _ChevronTrailing extends SettingsTileTrailing {
  const _ChevronTrailing();
}

/// نص قيمة معروض.
class _ValueTrailing extends SettingsTileTrailing {
  /// نص القيمة المعروضة (مثال: `'العربية'`).
  final String text;

  const _ValueTrailing(this.text);
}

/// صف إعدادات قابل لإعادة الاستخدام ومدفوع بالبارامترات بالكامل.
///
/// ترسم البلاطة بطاقتها الخاصة (خلفية + زاوية مستديرة) فلا يحتاج مكان
/// الاستدعاء لتغليفها بأي حاوية — وتتعطّل البطاقة بتمرير
/// [backgroundColor] شفافاً مع [borderRadius] صفرياً عند تجميع صفوف
/// في بطاقة واحدة كبيرة.
///
/// يغطي هذا الـ widget كل نسخ صفوف الإعدادات دون تكرار الكود:
/// عنوان وأيقونة بداية وعنصر نهائي ([SettingsTileTrailing]) في صف
/// تفاعلي، يليه فاصل بعرض كامل ثم كتلة وصفية ثابتة اختيارية
/// ([subtitle]) تحت الفاصل — لا أزرار تحت الفاصل أبداً — ثم فاصل
/// سفلي اختياري. النسخة التحذيرية (عنوان ملوّن + أيقونة تحذير)
/// تتحقق بالبارامترات فقط (`titleColor` و`leading`) دون widget مخصص.
///
/// التخطيط داخل البطاقة: حاوية بحشوة أفقية ورأسية من التوكنز وحد أدنى
/// للارتفاع (`48.h`) تضم `Row` (أيقونة البداية ← العنوان المتمدّد ←
/// العنصر النهائي). عند `onTap` غير فارغ يُغلَّف الصف وحده بـ `InkWell`
/// (الكتلة الوصفية خارج منطقة الضغط دائماً)، وإلا يكون الصف
/// غير تفاعلي.
///
/// آمن لاتجاه RTL: تنعكس خانتا البداية والنهاية مع اتجاه
/// [Directionality] المحيط تلقائياً، فيبقى المثلث التحذيري والمفتاح
/// في موضعيهما الصحيحين في اللغة العربية.
///
/// جميع المقاسات تستخدم `flutter_screenutil` وجميع الألوان الاحتياطية
/// من `Theme.of(context).colorScheme`.
///
/// مثال النسخة المرجعية (صف "إشعارات التنبيهات الحرجة"):
/// ```dart
/// SettingsListTile(
///   title: 'إشعارات التنبيهات الحرجة.',
///   subtitle: 'تنبيهك فورًا عند أي محاولة لتجاوز القيود أو العبث '
///       'بإعدادات الحماية.',
///   leading: const Icon(Icons.warning_amber_rounded),
///   trailing: SettingsTileTrailing.switch_(
///     value: enabled,
///     onChanged: onChanged,
///   ),
///   onTap: () {},
/// )
/// ```
class SettingsListTile extends StatelessWidget {
  /// عنوان الصف (مثال: `'إشعارات التنبيهات الحرجة.'`).
  final String title;

  /// نص وصفي اختياري يشرح فائدة الميزة (فائدة التفعيل أو الإلغاء).
  /// يُعرض فقط عندما يكون غير فارغ وغير فارغ المحتوى (`null` أو `''`
  /// تعني بلا وصف).
  ///
  /// يُرسم ككتلة ثابتة تحت فاصل الصف (خارج منطقة الضغط دائماً)،
  /// ويفصل بينه وبين الصف فاصل بعرض كامل يظهر فقط مع وجود الوصف.
  final String? subtitle;

  /// أيقونة البداية (أي widget: `SvgPicture.asset(...)` أو [Icon]).
  ///
  /// تُعرض داخل مربع ملوّن بزاوية مستديرة (`40.w`).
  final Widget? leading;

  /// خلفية مربع أيقونة البداية (`40.w` بزاوية مستديرة).
  ///
  /// عند تمريرها تُعرض الأيقونة داخل المربع الملوّن، وعند `null`
  /// (الافتراضي) تُعرض الأيقونة عارية كما في التصميم المرجعي.
  final Color? leadingBackgroundColor;

  /// لون مقدمة أيقونة البداية (يُطبَّق عبر `IconTheme` على أبناء [Icon]).
  ///
  /// الافتراضي: `colorScheme.primary`.
  final Color? leadingForegroundColor;

  /// لون نص العنوان.
  ///
  /// الافتراضي: `colorScheme.onSurface`. مرّر لوناً أحمر (مثل
  /// `colorScheme.error`) للنسخة التحذيرية/الحذفية.
  final Color? titleColor;

  /// عنصر التحكم النهائي.
  ///
  /// الافتراضي: [SettingsTileTrailing.none].
  final SettingsTileTrailing trailing;

  /// لون خلفية بطاقة البلاطة.
  ///
  /// الافتراضي: لون البطاقة من الثيم. مرّر شفافاً مع [borderRadius]
  /// صفرياً لتعطيل البطاقة عند تجميع صفوف في حاوية خارجية.
  final Color? backgroundColor;

  /// نصف قطر زوايا بطاقة البلاطة.
  ///
  /// الافتراضي: `AppRadius.xxl` كما في التصميم المرجعي.
  final double? borderRadius;

  /// حد بطاقة البلاطة.
  ///
  /// الافتراضي: بلا حد (التباين مع خلفية الصفحة يكفي كما في التصميم).
  final BorderSide? borderSide;

  /// إظهار الفاصل السفلي (بإزاحة أفقية) في نهاية البلاطة.
  ///
  /// الافتراضي: `true`. يُستخدم عند تكديس بلاطات بلا بطاقات داخل
  /// حاوية واحدة؛ أما مع البطاقة الذاتية (الوضع المرجعي) فمرّر
  /// `false` إذ تُغلق البطاقة نفسها. (فاصل الصف الأوسط بعرض كامل
  /// ويظهر فقط مع وجود [subtitle]).
  final bool showDivider;

  /// تُستدعى عند ضغط صف العنوان فقط (الكتلة الوصفية خارج منطقة
  /// الضغط). عند `null` يكون الصف غير تفاعلي (بلا `InkWell`).
  final VoidCallback? onTap;

  const SettingsListTile({
    super.key,
    required this.title,
    this.subtitle,
    this.leading,
    this.leadingBackgroundColor,
    this.leadingForegroundColor,
    this.titleColor,
    this.trailing = const SettingsTileTrailing.none(),
    this.backgroundColor,
    this.borderRadius,
    this.borderSide,
    this.showDivider = true,
    this.onTap,
  });

  @override
  Widget build(BuildContext context) {
    final ThemeData theme = Theme.of(context);
    final bool hasSubtitle = subtitle?.isNotEmpty == true;

    final Widget content = Container(
      constraints: BoxConstraints(
        minHeight: 48.h,
      ),
      padding: EdgeInsets.symmetric(
        horizontal: context.spacing.md.w,
        vertical: context.spacing.sm.h,
      ),
      child: Row(
        children: [
          if (leading != null) ...[
            _buildLeading(context, theme),
            SizedBox(width: context.spacing.md.w),
          ],
          Expanded(
            child: Text(
              title,
              key: const ValueKey('settings-tile-title'),
              style: theme.textTheme.titleMedium?.copyWith(
                    fontSize: 16.sp,
                    fontWeight: FontWeight.w700,
                    color:
                        titleColor ?? theme.colorScheme.onSurface,
                  ) ??
                  TextStyle(
                    fontSize: 16.sp,
                    fontWeight: FontWeight.w700,
                    color:
                        titleColor ?? theme.colorScheme.onSurface,
                  ),
            ),
          ),
          ..._trailingGapAndWidget(context, theme),
        ],
      ),
    );

    final Widget tile = onTap == null
        ? content
        : InkWell(
            onTap: onTap,
            child: content,
          );

    // البطاقة الذاتية: خلفية وزاوية مستديرة مع قصّ المحتوى عليها
    // (بما فيه تموّج InkWell والفواصل بعرض كامل).
    return Material(
      color: backgroundColor ?? theme.cardTheme.color,
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(
          borderRadius ?? context.radius.xxl.r,
        ),
        side: borderSide ?? BorderSide.none,
      ),
      clipBehavior: Clip.antiAlias,
      child: Column(
        mainAxisSize: MainAxisSize.min,
        crossAxisAlignment: CrossAxisAlignment.stretch,
        children: [
        tile,
        if (hasSubtitle) ...[
          const Divider(
            key: ValueKey('settings-tile-divider-mid'),
            height: 1,
            thickness: 1,
          ),
          Padding(
            padding: EdgeInsets.symmetric(
              horizontal: context.spacing.md.w,
              vertical: context.spacing.sm.h,
            ),
            child: Text(
              subtitle!,
              key: const ValueKey('settings-tile-subtitle'),
              style: theme.textTheme.bodyMedium?.copyWith(
                    fontSize: 13.sp,
                    fontWeight: FontWeight.w400,
                    color: theme.colorScheme.onSurface
                        .withValues(alpha: 0.6),
                  ) ??
                  TextStyle(
                    fontSize: 13.sp,
                    fontWeight: FontWeight.w400,
                    color: theme.colorScheme.onSurface
                        .withValues(alpha: 0.6),
                  ),
            ),
          ),
        ],
        if (showDivider)
          Divider(
            key: const ValueKey('settings-tile-divider'),
            height: 1.h,
            thickness: 1.h,
            indent: context.spacing.md.w,
            endIndent: context.spacing.md.w,
            color: theme.colorScheme.outlineVariant,
          ),
        ],
      ),
    );
  }

  /// يبني أيقونة البداية: داخل مربع ملوّن عند تمرير
  /// [leadingBackgroundColor]، وعارية بدونه (كما في التصميم المرجعي).
  Widget _buildLeading(BuildContext context, ThemeData theme) {
    final Widget icon = IconTheme(
      data: IconThemeData(
        color:
            leadingForegroundColor ?? theme.colorScheme.primary,
        size: 22.sp,
      ),
      child: leading!,
    );

    if (leadingBackgroundColor == null) return Center(child: icon);

    return Container(
      width: 40.w,
      height: 40.h,
      decoration: BoxDecoration(
        color: leadingBackgroundColor,
        borderRadius: BorderRadius.circular(context.radius.lg.r),
      ),
      child: Padding(
        padding: EdgeInsets.all(8.w),
        child: Center(child: icon),
      ),
    );
  }

  /// يبني الفجوة وعنصر [trailing] (أو لا شيء عند `none`).
  List<Widget> _trailingGapAndWidget(
    BuildContext context,
    ThemeData theme,
  ) {
    final SettingsTileTrailing t = trailing;
    switch (t) {
      case _NoneTrailing():
        return const <Widget>[];
      case _SwitchTrailing(
          value: final bool value,
          onChanged: final ValueChanged<bool> onChanged,
          activeTrackColor: final Color? activeTrackColor,
        ):
        return <Widget>[
          SizedBox(width: context.spacing.md.w),
          Switch(
            key: const ValueKey('settings-tile-switch'),
            value: value,
            onChanged: onChanged,
            activeTrackColor: activeTrackColor,
          ),
        ];
      case _ChevronTrailing():
        final bool isRtl =
            Directionality.of(context) == TextDirection.rtl;
        return <Widget>[
          SizedBox(width: context.spacing.md.w),
          // ملاحظة: اتجاه النص مثبّت على LTR حتى لا ينعكس السهم
          // تلقائياً (matchTextDirection=true في chevron_left كان
          // سيعرضه معكوساً داخل RTL).
          Icon(
            key: const ValueKey('settings-tile-chevron'),
            isRtl
                ? Icons.chevron_left_rounded
                : Icons.chevron_right_rounded,
            size: 20.sp,
            color:
                theme.colorScheme.onSurface.withValues(alpha: 0.4),
            textDirection: TextDirection.ltr,
          ),
        ];
      case _ValueTrailing(text: final String text):
        return <Widget>[
          SizedBox(width: context.spacing.md.w),
          Text(
            text,
            key: const ValueKey('settings-tile-value'),
            style: theme.textTheme.bodyMedium?.copyWith(
                  fontSize: 13.sp,
                  fontWeight: FontWeight.w400,
                  color: theme.colorScheme.onSurface
                      .withValues(alpha: 0.6),
                ) ??
                TextStyle(
                  fontSize: 13.sp,
                  fontWeight: FontWeight.w400,
                  color: theme.colorScheme.onSurface
                      .withValues(alpha: 0.6),
                ),
          ),
        ];
    }
  }
}
