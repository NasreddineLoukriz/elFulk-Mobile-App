import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

import 'package:elfulk/src/core/helpers/helpers.dart';
import 'package:elfulk/src/core/widgets/app_sheets.dart';

/// خيار واحد في مجموعة فلترة (مثال: `ألعاب سهلة` + شارة خضراء).
class FilterOption {
  /// النص المعروض.
  final String label;

  /// شارة صغيرة يمين النص (null = بلا شارة).
  final Widget? badge;

  const FilterOption({required this.label, this.badge});
}

/// مجموعة فلترة بعنوان (مثال: `حسب الحالة:` + خياراتها).
class FilterGroup {
  final String title;
  final List<FilterOption> options;
  final int initialIndex;

  const FilterGroup({
    required this.title,
    required this.options,
    this.initialIndex = 0,
  });
}

/// يعرض ستارة فلترة بمجموعات radio حسب التصميم (عربي RTL).
///
/// كل مجموعة: عنوان يميناً + صفوف (شارة ومحتوى يميناً + دائرة
/// اختيار يساراً). تُرجع مؤشرات المختار لكل مجموعة أو `null`.
Future<List<int>?> showFilterSheet({
  required BuildContext context,
  required String title,
  required List<FilterGroup> groups,
}) {
  return showAppBottomSheet<List<int>>(
    context: context,
    builder: (BuildContext sheetContext) =>
        _FilterSheetBody(title: title, groups: groups),
  );
}

class _FilterSheetBody extends StatefulWidget {
  final String title;
  final List<FilterGroup> groups;

  const _FilterSheetBody({required this.title, required this.groups});

  @override
  State<_FilterSheetBody> createState() => _FilterSheetBodyState();
}

class _FilterSheetBodyState extends State<_FilterSheetBody> {
  late List<int> _selected;

  @override
  void initState() {
    super.initState();
    _selected = [
      for (final FilterGroup group in widget.groups)
        group.initialIndex.clamp(0, group.options.length - 1),
    ];
  }

  @override
  Widget build(BuildContext context) {
    final ThemeData theme = Theme.of(context);

    return Column(
      mainAxisSize: MainAxisSize.min,
      crossAxisAlignment: CrossAxisAlignment.stretch,
      children: [
        SheetTitle(text: widget.title),
        SizedBox(height: context.spacing.md.h),
        for (int g = 0; g < widget.groups.length; g++) ...[
          Text(
            widget.groups[g].title,
            textAlign: TextAlign.end,
            style: TextStyle(
              fontSize: 13.sp,
              fontWeight: FontWeight.w700,
              color: theme.colorScheme.onSurface.withValues(alpha: 0.6),
            ),
          ),
          SizedBox(height: context.spacing.sm.h),
          Container(
            decoration: BoxDecoration(
              border: Border.all(color: theme.colorScheme.outlineVariant),
              borderRadius: BorderRadius.circular(context.radius.lg.r),
            ),
            child: Column(
              mainAxisSize: MainAxisSize.min,
              children: [
                for (int o = 0; o < widget.groups[g].options.length; o++) ...[
                  _FilterRow(
                    option: widget.groups[g].options[o],
                    selected: _selected[g] == o,
                    onTap: () => setState(() => _selected[g] = o),
                  ),
                  if (o < widget.groups[g].options.length - 1)
                    Divider(
                      height: 1.h,
                      thickness: 1.h,
                      indent: context.spacing.md.w,
                      endIndent: context.spacing.md.w,
                      color: theme.colorScheme.outlineVariant,
                    ),
                ],
              ],
            ),
          ),
          if (g < widget.groups.length - 1)
            SizedBox(height: context.spacing.md.h),
        ],
      ],
    );
  }
}

/// صف خيار واحد: شارة ومحتوى يميناً + دائرة اختيار يساراً.
class _FilterRow extends StatelessWidget {
  final FilterOption option;
  final bool selected;
  final VoidCallback onTap;

  const _FilterRow({
    required this.option,
    required this.selected,
    required this.onTap,
  });

  @override
  Widget build(BuildContext context) {
    final ThemeData theme = Theme.of(context);

    return GestureDetector(
      onTap: onTap,
      behavior: HitTestBehavior.opaque,
      child: Padding(
        padding: EdgeInsets.symmetric(
          horizontal: context.spacing.md.w,
          vertical: context.spacing.sm.h,
        ),
        child: Row(
          children: [
            Expanded(
              child: Row(
                mainAxisAlignment: MainAxisAlignment.end,
                children: [
                  Flexible(
                    child: Text(
                      option.label,
                      textAlign: TextAlign.end,
                      overflow: TextOverflow.ellipsis,
                      style: TextStyle(
                        fontSize: 14.sp,
                        fontWeight: FontWeight.w600,
                        color: theme.colorScheme.onSurface,
                      ),
                    ),
                  ),
                  if (option.badge != null) ...[
                    SizedBox(width: context.spacing.sm.w),
                    option.badge!,
                  ],
                ],
              ),
            ),
            SizedBox(width: context.spacing.sm.w),
            Container(
              width: 22.w,
              height: 22.h,
              decoration: BoxDecoration(
                shape: BoxShape.circle,
                border: Border.all(
                  color: selected
                      ? theme.colorScheme.primary
                      : theme.colorScheme.outline,
                  width: 1.5,
                ),
              ),
              child: selected
                  ? Center(
                      child: Container(
                        width: 12.w,
                        height: 12.h,
                        decoration: BoxDecoration(
                          shape: BoxShape.circle,
                          color: theme.colorScheme.primary,
                        ),
                      ),
                    )
                  : null,
            ),
          ],
        ),
      ),
    );
  }
}

/// عنصر إجراء واحد في ستارة الإجراءات.
class SheetActionItem {
  /// النص المعروض.
  final String label;

  /// الأيقونة يمين النص (null = بلا أيقونة).
  final IconData? icon;

  /// لون الأيقونة (افتراضياً لون السطح).
  final Color? iconColor;

  const SheetActionItem({required this.label, this.icon, this.iconColor});
}

/// يعرض ستارة إجراءات (صفوف تنقل + زر تدميري سفلي) حسب التصميم.
///
/// تُرجع مؤشر الصف المضغوط، أو `-1` لزر التدمير، أو `null` للإغلاق.
Future<int?> showActionSheet({
  required BuildContext context,
  required String title,
  required List<SheetActionItem> actions,
  String? destructiveLabel,
  IconData? destructiveIcon,
}) {
  return showAppBottomSheet<int>(
    context: context,
    builder: (BuildContext sheetContext) => Column(
      mainAxisSize: MainAxisSize.min,
      crossAxisAlignment: CrossAxisAlignment.stretch,
      children: [
        SheetTitle(text: title),
        SizedBox(height: context.spacing.md.h),
        Container(
          decoration: BoxDecoration(
            border: Border.all(
              color: Theme.of(sheetContext).colorScheme.outlineVariant,
            ),
            borderRadius: BorderRadius.circular(context.radius.lg.r),
          ),
          child: Column(
            mainAxisSize: MainAxisSize.min,
            children: [
              for (int i = 0; i < actions.length; i++) ...[
                _ActionRow(
                  item: actions[i],
                  onTap: () => Navigator.of(sheetContext).pop(i),
                ),
                if (i < actions.length - 1)
                  Divider(
                    height: 1.h,
                    thickness: 1.h,
                    indent: context.spacing.md.w,
                    endIndent: context.spacing.md.w,
                    color: Theme.of(sheetContext).colorScheme.outlineVariant,
                  ),
              ],
            ],
          ),
        ),
        if (destructiveLabel != null) ...[
          SizedBox(height: context.spacing.md.h),
          SizedBox(
            height: 48.h,
            child: ElevatedButton(
              key: const ValueKey('action-sheet-destructive'),
              onPressed: () => Navigator.of(sheetContext).pop(-1),
              style: ElevatedButton.styleFrom(
                backgroundColor: Theme.of(sheetContext).colorScheme.error,
                foregroundColor: Theme.of(sheetContext).colorScheme.onError,
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(context.radius.lg.r),
                ),
                elevation: 0,
              ),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.center,
                mainAxisSize: MainAxisSize.min,
                children: [
                  Flexible(
                    child: Text(
                      destructiveLabel,
                      textAlign: TextAlign.center,
                      overflow: TextOverflow.ellipsis,
                      style: TextStyle(
                        fontSize: 14.sp,
                        fontWeight: FontWeight.w700,
                      ),
                    ),
                  ),
                  if (destructiveIcon != null) ...[
                    SizedBox(width: context.spacing.sm.w),
                    Icon(destructiveIcon, size: 18.sp),
                  ],
                ],
              ),
            ),
          ),
        ],
      ],
    ),
  );
}

/// صف إجراء: تسمية وأيقونة يميناً + شيفرون يساراً.
class _ActionRow extends StatelessWidget {
  final SheetActionItem item;
  final VoidCallback onTap;

  const _ActionRow({required this.item, required this.onTap});

  @override
  Widget build(BuildContext context) {
    final ThemeData theme = Theme.of(context);
    final bool isRtl = Directionality.of(context) == TextDirection.rtl;

    return GestureDetector(
      onTap: onTap,
      behavior: HitTestBehavior.opaque,
      child: Padding(
        padding: EdgeInsets.symmetric(
          horizontal: context.spacing.md.w,
          vertical: context.spacing.sm.h,
        ),
        child: Row(
          children: [
            Expanded(
              child: Row(
                mainAxisAlignment: MainAxisAlignment.end,
                children: [
                  Flexible(
                    child: Text(
                      item.label,
                      textAlign: TextAlign.end,
                      overflow: TextOverflow.ellipsis,
                      style: TextStyle(
                        fontSize: 14.sp,
                        fontWeight: FontWeight.w600,
                        color: theme.colorScheme.onSurface,
                      ),
                    ),
                  ),
                  if (item.icon != null) ...[
                    SizedBox(width: context.spacing.sm.w),
                    Icon(
                      item.icon,
                      size: 18.sp,
                      color:
                          item.iconColor ??
                          theme.colorScheme.onSurface.withValues(alpha: 0.6),
                    ),
                  ],
                ],
              ),
            ),
            SizedBox(width: context.spacing.sm.w),
            // الاتجاه مثبّت على LTR حتى لا ينعكس الشيفرون
            // تلقائياً داخل RTL.
            Icon(
              isRtl ? Icons.chevron_left_rounded : Icons.chevron_right_rounded,
              size: 20.sp,
              color: theme.colorScheme.onSurface.withValues(alpha: 0.4),
              textDirection: TextDirection.ltr,
            ),
          ],
        ),
      ),
    );
  }
}
