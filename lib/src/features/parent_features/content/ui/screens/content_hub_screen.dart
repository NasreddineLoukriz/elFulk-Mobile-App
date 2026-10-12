import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:go_router/go_router.dart';

import 'package:elfulk/src/core/config/routing/routes.dart';
import 'package:elfulk/src/core/helpers/helpers.dart';
import 'package:elfulk/src/core/widgets/category_chip.dart';
import 'package:elfulk/src/core/widgets/content_card.dart';

/// مركز المحتوى حسب التصميم (عربي RTL).
///
/// 3 بطاقات فئات كبيرة (فيديوهات/قصص/ألعاب): أيقونة + عنوان + وصف +
/// زرّين (أساسي للدخول + ثانوي للافتراضي). الدخول يفتح المكتبة
/// بالنوع المناسب.
class ContentHubScreen extends StatelessWidget {
  const ContentHubScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text('مركز المحتوى'), centerTitle: true),
      body: SafeArea(
        child: ListView.separated(
          padding: context.spacing.pagePadding,
          itemCount: 3,
          separatorBuilder: (context, _) =>
              SizedBox(height: context.spacing.md.h),
          itemBuilder: (context, index) {
            return _HubCard(
              icon: [
                Icons.play_circle_outline_rounded,
                Icons.menu_book_outlined,
                Icons.sports_esports_outlined,
              ][index],
              title: const [
                'مكتبة الفيديوهات',
                'مكتبة القصص',
                'مكتبة الألعاب',
              ][index],
              description: const [
                'تصفح كل الفيديوهات المتاحة واختر ما يناسب طفلك.',
                'قصص هادفة بمستويات قراءة متدرجة.',
                'ألعاب تعليمية آمنة ومناسبة للعمر.',
              ][index],
              typeQuery: const ['videos', 'stories', 'games'][index],
            );
          },
        ),
      ),
    );
  }
}

class _HubCard extends StatelessWidget {
  final IconData icon;
  final String title;
  final String description;
  final String typeQuery;

  const _HubCard({
    required this.icon,
    required this.title,
    required this.description,
    required this.typeQuery,
  });

  @override
  Widget build(BuildContext context) {
    final ThemeData theme = Theme.of(context);

    return ContentCard(
      art: Container(
        color: theme.colorScheme.primary.withValues(alpha: 0.12),
        child: Center(
          child: Icon(icon, size: 64.sp, color: theme.colorScheme.primary),
        ),
      ),
      artHeight: 140,
      title: title,
      badges: const [
        ContentBadge(
          label: 'محتوى آمن',
          background: Color(0xFFD1E9E7),
          foreground: Color(0xFF2E8C84),
        ),
      ],
      actionLabel: 'الدخول إلى المكتبة',
      onAction: () => context.push(
        Uri(
          path: Routes.libraryScreen,
          queryParameters: {'type': typeQuery},
        ).toString(),
      ),
    );
  }
}
