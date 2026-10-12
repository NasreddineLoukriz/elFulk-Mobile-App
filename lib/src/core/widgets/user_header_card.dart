import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

import 'package:elfulk/src/core/helpers/helpers.dart';
import 'package:elfulk/src/core/widgets/stat_cell.dart';

/// بطاقة ترويسة الحساب الشخصي حسب التصميم المرجعي (عربي RTL).
///
/// صف علوي (قائمة `⋮` + الاسم + الصورة)، ثم البريد باتجاه LTR، ثم
/// صف إحصائيات ثلاثي بفواصل. الألوان والقيم كلها بارامترات.
class UserHeaderCard extends StatelessWidget {
  /// اسم المستخدم المعروض.
  final String name;

  /// البريد الإلكتروني (يُعرض باتجاه LTR دائماً).
  final String email;

  /// الصورة الرمزية (null = دائرة متدرجة بالحرف الأول).
  final Widget? avatar;

  /// لونا تدرج الأفاتار الافتراضي (teal كما في التصميم).
  final List<Color> avatarGradient;

  /// الإحصائيات الثلاث (تسمية/قيمة/لون).
  final List<StatData> stats;

  /// يُستدعى عند ضغط قائمة `⋮` (null = بلا زر).
  final VoidCallback? onMenu;

  /// لون خلفية البطاقة (افتراضياً لون البطاقة من الثيم).
  final Color? backgroundColor;

  const UserHeaderCard({
    super.key,
    required this.name,
    required this.email,
    this.avatar,
    this.avatarGradient = const <Color>[
      Color(0xFF55B5A6),
      Color(0xFF2E8C84),
    ],
    this.stats = const <StatData>[],
    this.onMenu,
    this.backgroundColor,
  });

  @override
  Widget build(BuildContext context) {
    final ThemeData theme = Theme.of(context);
    final String first =
        name.characters.isEmpty ? '' : name.characters.first;

    return Material(
      color: backgroundColor ?? theme.cardTheme.color,
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(context.radius.xxl.r),
      ),
      clipBehavior: Clip.antiAlias,
      child: Padding(
        padding: EdgeInsets.all(context.spacing.md.r),
        child: Column(
          mainAxisSize: MainAxisSize.min,
          crossAxisAlignment: CrossAxisAlignment.stretch,
          children: [
            Row(
              children: [
                SizedBox(
                  width: 44.w,
                  height: 44.h,
                  child: avatar ??
                      Container(
                        decoration: BoxDecoration(
                          shape: BoxShape.circle,
                          gradient: LinearGradient(
                            begin: Alignment.topCenter,
                            end: Alignment.bottomCenter,
                            colors: avatarGradient,
                          ),
                        ),
                        child: Center(
                          child: Text(
                            first,
                            style: TextStyle(
                              fontSize: 18.sp,
                              fontWeight: FontWeight.w700,
                              color: Colors.white,
                            ),
                          ),
                        ),
                      ),
                ),
                SizedBox(width: context.spacing.sm.w),
                Expanded(
                  child: Text(
                    name,
                    key: const ValueKey('user-header-name'),
                    textAlign: TextAlign.end,
                    style: TextStyle(
                      fontSize: 16.sp,
                      fontWeight: FontWeight.w700,
                      color: theme.colorScheme.onSurface,
                    ),
                  ),
                ),
                if (onMenu != null) ...[
                  SizedBox(width: context.spacing.sm.w),
                  GestureDetector(
                    key: const ValueKey('user-header-menu'),
                    onTap: onMenu,
                    behavior: HitTestBehavior.opaque,
                    child: Icon(
                      Icons.more_horiz_rounded,
                      size: 20.sp,
                      color: theme.colorScheme.onSurface
                          .withValues(alpha: 0.5),
                    ),
                  ),
                ],
              ],
            ),
            Text(
              email,
              key: const ValueKey('user-header-email'),
              textAlign: TextAlign.end,
              textDirection: TextDirection.ltr,
              style: TextStyle(
                fontSize: 13.sp,
                color:
                    theme.colorScheme.onSurface.withValues(alpha: 0.6),
              ),
            ),
            if (stats.isNotEmpty) ...[
              SizedBox(height: context.spacing.sm.h),
              Row(
                children: [
                  for (int i = 0; i < stats.length; i++) ...[
                    Expanded(
                      child: StatCell(
                        label: stats[i].label,
                        value: stats[i].value,
                        valueColor: stats[i].valueColor,
                      ),
                    ),
                    if (i < stats.length - 1)
                      Container(
                        width: 1.w,
                        height: 32.h,
                        color: theme.colorScheme.outlineVariant,
                      ),
                  ],
                ],
              ),
            ],
          ],
        ),
      ),
    );
  }
}

/// إحصائية واحدة في ترويسة الحساب.
class StatData {
  final String label;
  final String value;
  final Color? valueColor;

  const StatData({
    required this.label,
    required this.value,
    this.valueColor,
  });
}
