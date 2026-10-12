import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

import 'package:elfulk/src/core/helpers/helpers.dart';
import 'package:elfulk/src/core/widgets/app_confirmation_dialog.dart';
import 'package:elfulk/src/core/widgets/device_card.dart';
import 'package:elfulk/src/core/widgets/helpers/show_app_confirmation_dialog.dart';

/// جهاز مرتبط واحد (بيانات عرض ثابتة حتى Phase 2).
class LinkedDevice {
  final String name;
  final String user;
  final String status;
  final bool paused;

  const LinkedDevice({
    required this.name,
    required this.user,
    required this.status,
    this.paused = false,
  });

  LinkedDevice copyWith({String? status, bool? paused}) {
    return LinkedDevice(
      name: name,
      user: user,
      status: status ?? this.status,
      paused: paused ?? this.paused,
    );
  }
}

/// الأجهزة المرتبطة حسب التصميم (عربي RTL).
///
/// قائمة بطاقات أجهزة حقيقية السلوك محلياً: القفل بحوار تأكيد،
/// الإيقاف يبدّل الحالة نصياً، التعديل يعيد التسمية عبر ستارة.
/// (مزامنة حقيقية في Phase 2 للخادم.)
class LinkedDevicesScreen extends StatefulWidget {
  const LinkedDevicesScreen({super.key});

  @override
  State<LinkedDevicesScreen> createState() => _LinkedDevicesScreenState();
}

class _LinkedDevicesScreenState extends State<LinkedDevicesScreen> {
  final List<LinkedDevice> _devices = [
    const LinkedDevice(
      name: 'جهاز أنس اللوحي',
      user: 'المستخدم أنس مالك.',
      status: 'نشط حاليا',
    ),
    const LinkedDevice(
      name: 'هاتف ليلى',
      user: 'المستخدمة ليلى مالك.',
      status: 'نشط حاليا',
    ),
  ];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text('الأجهزة المرتبطة'), centerTitle: true),
      body: SafeArea(
        child: ListView.separated(
          padding: context.spacing.pagePadding,
          itemCount: _devices.length,
          separatorBuilder: (context, _) =>
              SizedBox(height: context.spacing.md.h),
          itemBuilder: (context, index) {
            final LinkedDevice device = _devices[index];
            return DeviceCard(
              key: ValueKey('linked-device-$index'),
              deviceName: device.name,
              userName: device.user,
              statusLabel: 'الحالة',
              statusValue: device.status,
              usageLabel: 'مدة الاستخدام',
              usageValue: '03 س و 10 د',
              enrolledLabel: 'تاريخ التسجيل',
              enrolledValue: '30 أكتوبر 2026',
              onLock: () => _lock(context, index),
              onPause: () => setState(() {
                _devices[index] = device.copyWith(
                  paused: !device.paused,
                  status: device.paused ? 'نشط حاليا' : 'موقوف مؤقتاً',
                );
              }),
              onEdit: () => _rename(context, index),
            );
          },
        ),
      ),
    );
  }

  /// القفل: حوار منزلق حقيقي ثم إشعار.
  Future<void> _lock(BuildContext context, int index) async {
    final bool? confirmed = await showAppConfirmationDialog(
      context: context,
      config: AppConfirmationConfig(
        title: 'هل تريد قفل الجهاز فوراً؟',
        message:
            'سيتم قفل ${_devices[index].name} فوراً ولن يتمكن الطفل من استخدامه.',
        icon: const Icon(Icons.lock_outline_rounded),
        primaryActionType: AppConfirmationPrimaryActionType.destructive,
        primaryActionLabel: 'قفل الجهاز فوراً',
        secondaryActionLabel: 'إلغاء',
        slideTextDirection: TextDirection.rtl,
      ),
    );
    if (confirmed == true && context.mounted) {
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(
          content: Text('تم قفل ${_devices[index].name}.'),
        ),
      );
    }
  }

  /// إعادة التسمية: ستارة حقل + حفظ يحدّث الاسم فعلياً.
  Future<void> _rename(BuildContext context, int index) async {
    final TextEditingController controller =
        TextEditingController(text: _devices[index].name);
    try {
      final String? name = await showModalBottomSheet<String>(
        context: context,
        isScrollControlled: true,
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.vertical(
            top: Radius.circular(context.radius.x3l.r),
          ),
        ),
        builder: (BuildContext sheetContext) => Padding(
          padding: EdgeInsets.only(
            left: context.spacing.lg.w,
            right: context.spacing.lg.w,
            top: context.spacing.lg.h,
            bottom: MediaQuery.of(sheetContext).viewInsets.bottom +
                context.spacing.lg.h,
          ),
          child: Column(
            mainAxisSize: MainAxisSize.min,
            crossAxisAlignment: CrossAxisAlignment.stretch,
            children: [
              Text(
                'تعديل اسم الجهاز',
                textAlign: TextAlign.center,
                style: TextStyle(
                  fontSize: 16.sp,
                  fontWeight: FontWeight.w800,
                ),
              ),
              SizedBox(height: context.spacing.md.h),
              TextField(
                controller: controller,
                textAlign: TextAlign.end,
                decoration: const InputDecoration(
                  hintText: 'اسم الجهاز',
                ),
              ),
              SizedBox(height: context.spacing.md.h),
              SizedBox(
                height: 42.h,
                child: ElevatedButton(
                  onPressed: () => Navigator.of(sheetContext)
                      .pop(controller.text.trim()),
                  style: ElevatedButton.styleFrom(
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(
                        context.radius.xxl.r,
                      ),
                    ),
                    elevation: 0,
                  ),
                  child: const Text('حفظ'),
                ),
              ),
            ],
          ),
        ),
      );
      if (name != null && name.isNotEmpty && context.mounted) {
        setState(() {
          final LinkedDevice device = _devices[index];
          _devices[index] = LinkedDevice(
            name: name,
            user: device.user,
            status: device.status,
            paused: device.paused,
          );
        });
      }
    } finally {
      controller.dispose();
    }
  }
}
