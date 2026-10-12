import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

import 'package:elfulk/src/core/helpers/helpers.dart';
import 'package:elfulk/src/core/widgets/app_dashed_divider.dart';
import 'package:elfulk/src/core/widgets/app_sheets.dart';

/// عمود واحد في عجلة الاختيار (مثال: ساعات `['01','02 ساعات','03']`).
class PickerColumnData {
  /// القيم المعروضة من الأعلى للأسفل.
  final List<String> values;

  /// المؤشر الابتدائي.
  final int initialIndex;

  const PickerColumnData({required this.values, this.initialIndex = 0});
}

/// نتيجة ستارة الوقت: التبويب المختار والقيم المختارة لكل عمود.
class TimePickerResult {
  /// مؤشر التبويب العلوي (0 عند غياب التبويبات).
  final int tab;

  /// القيمة المختارة من كل عمود بالترتيب.
  final List<String> values;

  const TimePickerResult({required this.tab, required this.values});
}

/// يعرض ستارة منتقي الوقت بعجلات حسب التصميم (عربي RTL).
///
/// قبة بيضاء: مقبض + عنوان + تبويبات مقسمة اختيارية + صندوق عجلات
/// بخطين منقطين حول الصف المختار + زر حفظ. تُرجع [TimePickerResult]
/// أو `null` عند الإغلاق. ترتيب الأعمدة يمين→يسار كما تُمرَّر
/// (مثال: ساعات يميناً، دقائق يساراً).
Future<TimePickerResult?> showTimePickerSheet({
  required BuildContext context,
  required String title,
  required String saveLabel,
  List<String>? tabs,
  int initialTab = 0,
  required List<PickerColumnData> columns,
}) {
  assert(columns.isNotEmpty, 'at least one column is required');

  return showAppBottomSheet<TimePickerResult>(
    context: context,
    builder: (BuildContext sheetContext) => _TimePickerBody(
      title: title,
      saveLabel: saveLabel,
      tabs: tabs ?? const <String>[],
      initialTab: initialTab,
      columns: columns,
    ),
  );
}

class _TimePickerBody extends StatefulWidget {
  final String title;
  final String saveLabel;
  final List<String> tabs;
  final int initialTab;
  final List<PickerColumnData> columns;

  const _TimePickerBody({
    required this.title,
    required this.saveLabel,
    required this.tabs,
    required this.initialTab,
    required this.columns,
  });

  @override
  State<_TimePickerBody> createState() => _TimePickerBodyState();
}

class _TimePickerBodyState extends State<_TimePickerBody> {
  late int _tab;
  late List<int> _selected;
  late List<FixedExtentScrollController> _controllers;

  static const double _itemExtent = 44;

  @override
  void initState() {
    super.initState();
    _tab = widget.tabs.isEmpty
        ? 0
        : widget.initialTab.clamp(0, widget.tabs.length - 1);
    _selected = [
      for (final PickerColumnData column in widget.columns)
        column.initialIndex.clamp(0, column.values.length - 1),
    ];
    _controllers = [
      for (int i = 0; i < widget.columns.length; i++)
        FixedExtentScrollController(initialItem: _selected[i]),
    ];
  }

  @override
  void dispose() {
    for (final FixedExtentScrollController controller in _controllers) {
      controller.dispose();
    }
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final ThemeData theme = Theme.of(context);

    return Column(
      mainAxisSize: MainAxisSize.min,
      crossAxisAlignment: CrossAxisAlignment.stretch,
      children: [
        Container(
          padding: EdgeInsets.symmetric(
            horizontal: context.spacing.md.w,
            vertical: context.spacing.sm.h,
          ),
          decoration: BoxDecoration(
            border: Border.all(color: theme.colorScheme.outlineVariant),
            borderRadius: BorderRadius.circular(context.radius.lg.r),
          ),
          child: Row(
            children: [
              Expanded(
                child: Text(
                  widget.title,
                  textAlign: TextAlign.center,
                  style: TextStyle(
                    fontSize: 16.sp,
                    fontWeight: FontWeight.w800,
                    color: theme.colorScheme.onSurface,
                  ),
                ),
              ),
              Icon(
                Icons.chevron_right_rounded,
                size: 22.sp,
                color: theme.colorScheme.onSurface.withValues(alpha: 0.5),
                textDirection: TextDirection.ltr,
              ),
            ],
          ),
        ),
        if (widget.tabs.isNotEmpty) ...[
          SizedBox(height: context.spacing.md.h),
          Container(
            padding: EdgeInsets.all(4.r),
            decoration: BoxDecoration(
              color: theme.colorScheme.surfaceContainerHighest,
              borderRadius: BorderRadius.circular(context.radius.lg.r),
            ),
            child: Row(
              children: [
                for (int i = 0; i < widget.tabs.length; i++)
                  Expanded(
                    child: GestureDetector(
                      key: ValueKey('time-picker-tab-$i'),
                      onTap: () => setState(() => _tab = i),
                      behavior: HitTestBehavior.opaque,
                      child: Container(
                        padding: EdgeInsets.symmetric(vertical: 10.h),
                        decoration: BoxDecoration(
                          color: i == _tab
                              ? theme.colorScheme.surface
                              : Colors.transparent,
                          borderRadius: BorderRadius.circular(
                            context.radius.md.r,
                          ),
                          boxShadow: i == _tab
                              ? [
                                  BoxShadow(
                                    color: theme.shadowColor.withValues(
                                      alpha: 0.12,
                                    ),
                                    blurRadius: 4.r,
                                    offset: const Offset(0, 1),
                                  ),
                                ]
                              : null,
                        ),
                        child: Text(
                          widget.tabs[i],
                          textAlign: TextAlign.center,
                          style: TextStyle(
                            fontSize: 14.sp,
                            fontWeight: FontWeight.w700,
                            color: i == _tab
                                ? theme.colorScheme.onSurface
                                : theme.colorScheme.onSurface.withValues(
                                    alpha: 0.55,
                                  ),
                          ),
                        ),
                      ),
                    ),
                  ),
              ],
            ),
          ),
        ],
        SizedBox(height: context.spacing.md.h),
        Container(
          height: 150.h,
          decoration: BoxDecoration(
            border: Border.all(color: theme.colorScheme.outlineVariant),
            borderRadius: BorderRadius.circular(context.radius.xl.r),
          ),
          clipBehavior: Clip.antiAlias,
          child: Stack(
            children: [
              Row(
                children: [
                  for (int i = 0; i < widget.columns.length; i++)
                    Expanded(
                      child: ListWheelScrollView.useDelegate(
                        controller: _controllers[i],
                        itemExtent: _itemExtent.h,
                        perspective: 0.003,
                        diameterRatio: 1.6,
                        physics: const FixedExtentScrollPhysics(),
                        onSelectedItemChanged: (int index) =>
                            setState(() => _selected[i] = index),
                        childDelegate: ListWheelChildBuilderDelegate(
                          childCount: widget.columns[i].values.length,
                          builder: (context, index) {
                            if (index < 0 ||
                                index >= widget.columns[i].values.length) {
                              return null;
                            }
                            final bool selected = index == _selected[i];
                            return Center(
                              child: Text(
                                widget.columns[i].values[index],
                                style: TextStyle(
                                  fontSize: selected ? 18.sp : 15.sp,
                                  fontWeight: selected
                                      ? FontWeight.w800
                                      : FontWeight.w400,
                                  color: selected
                                      ? theme.colorScheme.onSurface
                                      : theme.colorScheme.onSurface.withValues(
                                          alpha: 0.4,
                                        ),
                                ),
                              ),
                            );
                          },
                        ),
                      ),
                    ),
                ],
              ),
              // خطان منقطان يؤطران الصف المختار (منتصف الصندوق).
              PositionedDirectional(
                top: (150.h - _itemExtent.h) / 2,
                start: 12.w,
                end: 12.w,
                child: const AppDashedDivider(),
              ),
              PositionedDirectional(
                bottom: (150.h - _itemExtent.h) / 2,
                start: 12.w,
                end: 12.w,
                child: const AppDashedDivider(),
              ),
            ],
          ),
        ),
        SizedBox(height: context.spacing.lg.h),
        SizedBox(
          height: 50.h,
          child: ElevatedButton(
            key: const ValueKey('time-picker-save'),
            onPressed: () => Navigator.of(context).pop(
              TimePickerResult(
                tab: _tab,
                values: [
                  for (int i = 0; i < widget.columns.length; i++)
                    widget.columns[i].values[_selected[i]],
                ],
              ),
            ),
            style: ElevatedButton.styleFrom(
              backgroundColor: theme.colorScheme.primary,
              foregroundColor: theme.colorScheme.onPrimary,
              shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(context.radius.xl.r),
              ),
              elevation: 0,
            ),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.center,
              mainAxisSize: MainAxisSize.min,
              children: [
                Container(
                  width: 20.w,
                  height: 20.h,
                  decoration: BoxDecoration(
                    border: Border.all(
                      color: theme.colorScheme.onPrimary,
                      width: 1.5,
                    ),
                    borderRadius: BorderRadius.circular(6.r),
                  ),
                  child: Center(
                    child: Icon(
                      Icons.check_rounded,
                      size: 14.sp,
                      color: theme.colorScheme.onPrimary,
                    ),
                  ),
                ),
                SizedBox(width: context.spacing.sm.w),
                Flexible(
                  child: Text(
                    widget.saveLabel,
                    textAlign: TextAlign.center,
                    overflow: TextOverflow.ellipsis,
                    style: TextStyle(
                      fontSize: 15.sp,
                      fontWeight: FontWeight.w700,
                    ),
                  ),
                ),
              ],
            ),
          ),
        ),
      ],
    );
  }
}
