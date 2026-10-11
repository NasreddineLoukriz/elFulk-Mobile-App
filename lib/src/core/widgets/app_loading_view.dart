import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

import 'package:elfulk/src/core/helpers/helpers.dart';

/// مؤشر تحميل موحد لحالات `loading` في الشاشات.
///
/// مؤشر دائري متمركز بحشوة سخية. (هياكل skeleton المتحركة مؤجلة
/// لمرحلة لاحقة — لا حزمة shimmer في المشروع حالياً.)
class AppLoadingView extends StatelessWidget {
  const AppLoadingView({super.key});

  @override
  Widget build(BuildContext context) {
    return Padding(
      key: const ValueKey('app-loading-view'),
      padding: EdgeInsets.all(context.spacing.xl.r),
      child: const Center(child: CircularProgressIndicator()),
    );
  }
}
