import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

import 'package:elfulk/src/core/helpers/helpers.dart';
import 'package:elfulk/src/core/widgets/group_card.dart';
import 'package:elfulk/src/core/widgets/section_header.dart';
import 'package:elfulk/src/core/widgets/settings_list_tile.dart';
import 'package:elfulk/src/core/widgets/time_picker_sheet.dart';

/// عنصر تحكم واحد في مجموعة (مفتاح + زر تخصيص اختياري).
class _TimeControl {
  final String key;
  final String title;
  final String subtitle;
  final IconData icon;
  final Color badge;
  final String? actionLabel;
  final TimePickerConfig? picker;

  const _TimeControl({
    required this.key,
    required this.title,
    required this.subtitle,
    required this.icon,
    required this.badge,
    this.actionLabel,
    this.picker,
  });
}

/// إعدادات منتقي مجموعة واحدة.
class TimePickerConfig {
  final String title;
  final String saveLabel;
  final List<String>? tabs;
  final List<PickerColumnData> Function() columns;

  const TimePickerConfig({
    required this.title,
    required this.saveLabel,
    this.tabs,
    required this.columns,
  });
}

/// مجموعة واحدة (عنوان قسم + بطاقة عناصر).
class _TimeGroup {
  final String header;
  final List<_TimeControl> controls;

  const _TimeGroup({required this.header, required this.controls});
}

/// مركز تخصيص الوقت حسب التصميم (عربي RTL).
///
/// مجموعات بمفاتيح تبديل محلية + أزرار تخصيص تفتح ستائر العجلات +
/// زر إعادة التعيين. الحالة محلية للجلسة (تُحفظ خادمياً Phase 2).
class TimeHubScreen extends StatefulWidget {
  const TimeHubScreen({super.key});

  @override
  State<TimeHubScreen> createState() => _TimeHubScreenState();
}

class _TimeHubScreenState extends State<TimeHubScreen> {
  final Map<String, bool> _enabled = {
    'master': true,
    'daily': true,
    'content': false,
    'weekly': true,
    'night': true,
    'school': false,
    'weekend': false,
    'session': true,
  };

  static List<String> _hours(int max, String unit) => [
    for (int i = 0; i <= max; i++) '$i $unit',
  ];

  static List<String> _minutes() => [for (int i = 0; i < 60; i++) '$i دقيقة'];

  List<_TimeGroup> get _groups => [
    _TimeGroup(
      header: 'ادارة نظام الوقت بشكل عام',
      controls: [
        _TimeControl(
          key: 'master',
          title: 'إدارة الوقت',
          subtitle: 'تفعيل نظام إدارة الوقت الكامل للجهاز.',
          icon: Icons.schedule_outlined,
          badge: const Color(0xFFF4AA08),
        ),
      ],
    ),
    _TimeGroup(
      header: 'حدود الاستخدام',
      controls: [
        _TimeControl(
          key: 'daily',
          title: 'الحد اليومي',
          subtitle: 'تحديد إجمالي الوقت المسموح به يوميا.',
          icon: Icons.timer_outlined,
          badge: const Color(0xFF2E8C84),
          actionLabel: 'تخصيص إجمالي الوقت المسموح به',
          picker: TimePickerConfig(
            title: 'تخصيص إجمالي الوقت المسموح به',
            saveLabel: 'حفظ المدخلات',
            columns: () => [
              PickerColumnData(values: _hours(12, 'ساعات'), initialIndex: 2),
              PickerColumnData(values: _minutes(), initialIndex: 30),
            ],
          ),
        ),
        _TimeControl(
          key: 'content',
          title: 'حدود حسب نوع المحتوى',
          subtitle: 'حدود منفصلة للفيديوهات والقصص والألعاب.',
          icon: Icons.push_pin_outlined,
          badge: const Color(0xFFF03A3A),
          actionLabel: 'تخصيص حسب نوع المحتوى',
          picker: TimePickerConfig(
            title: 'تخصيص حسب نوع المحتوى',
            saveLabel: 'حفظ المدخلات',
            tabs: const ['الفيديوهات', 'القصص', 'الالعاب'],
            columns: () => [
              PickerColumnData(values: _hours(12, 'ساعات'), initialIndex: 2),
              PickerColumnData(values: _minutes(), initialIndex: 30),
            ],
          ),
        ),
      ],
    ),
    _TimeGroup(
      header: 'جدول الاستخدام',
      controls: [
        _TimeControl(
          key: 'weekly',
          title: 'البرنامج الأسبوعي',
          subtitle: 'جدولة أيام الاستخدام المسموحة.',
          icon: Icons.calendar_month_outlined,
          badge: const Color(0xFF2E8C84),
          actionLabel: 'تخصيص البرنامج الأسبوعي',
          picker: TimePickerConfig(
            title: 'تخصيص البرنامج الأسبوعي',
            saveLabel: 'حفظ المدخلات',
            tabs: const [
              'السبت',
              'الأحد',
              'الاثنين',
              'الثلاثاء',
              'الأربعاء',
              'الخميس',
              'الجمعة',
            ],
            columns: () => [
              PickerColumnData(values: _hours(12, 'ساعات'), initialIndex: 2),
              PickerColumnData(values: _minutes(), initialIndex: 0),
            ],
          ),
        ),
        _TimeControl(
          key: 'night',
          title: 'القفل الليلي',
          subtitle: 'قفل كامل للجهاز خلال ساعات الليل.',
          icon: Icons.nightlight_outlined,
          badge: const Color(0xFF1B3A57),
          actionLabel: 'تخصيص القفل الليلي',
          picker: TimePickerConfig(
            title: 'تخصيص القفل الليلي',
            saveLabel: 'حفظ المدخلات',
            tabs: const ['من', 'الى'],
            columns: () => [
              PickerColumnData(
                values: [for (int i = 0; i < 24; i++) '$i'],
                initialIndex: 21,
              ),
              PickerColumnData(values: _minutes(), initialIndex: 30),
              const PickerColumnData(
                values: ['صباحاً', 'مساءً', 'ليلاً'],
                initialIndex: 2,
              ),
            ],
          ),
        ),
        _TimeControl(
          key: 'school',
          title: 'وضع ليلة المدرسة',
          subtitle: 'منع استخدام الجهاز أثناء وقت النوم المدرسي من 9 ليلا الى 7 صباحا.',
          icon: Icons.school_outlined,
          badge: const Color(0xFFF59E0B),
        ),
        _TimeControl(
          key: 'weekend',
          title: 'وضع عطلة نهاية الأسبوع',
          subtitle: 'السماح باستخدام أكبر خلال العطلة.',
          icon: Icons.calendar_month_outlined,
          badge: const Color(0xFF2E8C84),
        ),
      ],
    ),
    _TimeGroup(
      header: 'إدارة الجلسات',
      controls: [
        _TimeControl(
          key: 'session',
          title: 'مدة الجلسة',
          subtitle: 'المدة القصوى التي يمكن للطفل قضاؤها متواصلة.',
          icon: Icons.timer_outlined,
          badge: const Color(0xFF2E8C84),
          actionLabel: 'تخصيص مدة الجلسة',
          picker: TimePickerConfig(
            title: 'تخصيص مدة الجلسة',
            saveLabel: 'حفظ المدخلات',
            columns: () => const [
              PickerColumnData(
                values: ['15 دقيقة', '30 دقيقة', '45 دقيقة', '60 دقيقة'],
                initialIndex: 1,
              ),
            ],
          ),
        ),
      ],
    ),
  ];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text('تخصيص الوقت'), centerTitle: true),
      body: SafeArea(
        child: ListView.separated(
          padding: context.spacing.pagePadding,
          itemCount: _groups.length,
          separatorBuilder: (context, _) =>
              SizedBox(height: context.spacing.md.h),
          itemBuilder: (context, index) {
            final _TimeGroup group = _groups[index];
            return Column(
              mainAxisSize: MainAxisSize.min,
              crossAxisAlignment: CrossAxisAlignment.stretch,
              children: [
                SectionHeader(title: group.header),
                SizedBox(height: context.spacing.sm.h),
                GroupCard(
                  children: [
                    for (final _TimeControl control in group.controls)
                      _ControlTile(
                        control: control,
                        value: _enabled[control.key] ?? false,
                        onChanged: (bool v) =>
                            setState(() => _enabled[control.key] = v),
                        onAction: control.actionLabel == null
                            ? null
                            : () => _openPicker(context, control),
                        onReset: control.actionLabel == null
                            ? null
                            : () => _reset(context, control),
                      ),
                  ],
                ),
              ],
            );
          },
        ),
      ),
    );
  }

  /// يفتح ستارة المنتقي الخاصة بالمجموعة ويعرض النتيجة.
  Future<void> _openPicker(BuildContext context, _TimeControl control) async {
    final TimePickerConfig? config = control.picker;
    if (config == null) return;
    final TimePickerResult? result = await showTimePickerSheet(
      context: context,
      title: config.title,
      saveLabel: config.saveLabel,
      tabs: config.tabs,
      columns: config.columns(),
    );
    if (result != null && context.mounted) {
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(content: Text('تم الحفظ: ${result.values.join(' ')}')),
      );
    }
  }

  /// يعيد المجموعة للوضع الافتراضي (تفعيل) مع إشعار.
  void _reset(BuildContext context, _TimeControl control) {
    setState(() => _enabled[control.key] = true);
    ScaffoldMessenger.of(
      context,
    ).showSnackBar(const SnackBar(content: Text('تمت إعادة الضبط الافتراضي.')));
  }
}

/// صف تحكم واحد: بلاطة تبديل + زر إجراء + زر إعادة تعيين.
class _ControlTile extends StatelessWidget {
  final _TimeControl control;
  final bool value;
  final ValueChanged<bool> onChanged;
  final VoidCallback? onAction;
  final VoidCallback? onReset;

  const _ControlTile({
    required this.control,
    required this.value,
    required this.onChanged,
    required this.onAction,
    required this.onReset,
  });

  @override
  Widget build(BuildContext context) {
    final ThemeData theme = Theme.of(context);

    return Column(
      mainAxisSize: MainAxisSize.min,
      crossAxisAlignment: CrossAxisAlignment.stretch,
      children: [
        SettingsListTile(
          title: control.title,
          subtitle: control.subtitle,
          leading: Icon(control.icon),
          leadingBackgroundColor: control.badge.withValues(alpha: 0.12),
          leadingForegroundColor: control.badge,
          trailing: SettingsTileTrailing.switch_(
            value: value,
            onChanged: onChanged,
          ),
          backgroundColor: Colors.transparent,
          borderRadius: 0,
          showDivider: onAction != null,
          dashedDivider: true,
        ),
        if (onAction != null) ...[
          Padding(
            padding: EdgeInsets.fromLTRB(
              context.spacing.md.w,
              0,
              context.spacing.md.w,
              context.spacing.md.h,
            ),
            child: Row(
              children: [
                Expanded(
                  child: SizedBox(
                    height: 44.h,
                    child: ElevatedButton(
                      key: ValueKey('time-cta-${control.key}'),
                      onPressed: onAction,
                      style: ElevatedButton.styleFrom(
                        backgroundColor: theme.colorScheme.primary,
                        foregroundColor: theme.colorScheme.onPrimary,
                        shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(
                            context.radius.lg.r,
                          ),
                        ),
                        elevation: 0,
                      ),
                      child: Text(
                        control.actionLabel ?? '',
                        textAlign: TextAlign.center,
                        overflow: TextOverflow.ellipsis,
                        style: TextStyle(
                          fontSize: 14.sp,
                          fontWeight: FontWeight.w700,
                        ),
                      ),
                    ),
                  ),
                ),
                if (onReset != null) ...[
                  SizedBox(width: context.spacing.sm.w),
                  GestureDetector(
                    key: ValueKey('time-reset-${control.key}'),
                    onTap: onReset,
                    behavior: HitTestBehavior.opaque,
                    child: Container(
                      width: 36.w,
                      height: 36.h,
                      decoration: BoxDecoration(
                        color: theme.colorScheme.primary.withValues(
                          alpha: 0.12,
                        ),
                        shape: BoxShape.circle,
                      ),
                      child: Center(
                        child: Icon(
                          Icons.refresh_rounded,
                          size: 18.sp,
                          color: theme.colorScheme.primary,
                        ),
                      ),
                    ),
                  ),
                ],
              ],
            ),
          ),
        ],
      ],
    );
  }
}
