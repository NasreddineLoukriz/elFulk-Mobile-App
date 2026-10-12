import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:go_router/go_router.dart';

import 'package:elfulk/src/core/config/routing/routes.dart';
import 'package:elfulk/src/core/helpers/helpers.dart';
import 'package:elfulk/src/core/widgets/app_confirmation_dialog.dart';
import 'package:elfulk/src/core/widgets/app_filter_chip.dart';
import 'package:elfulk/src/core/widgets/category_chip.dart';
import 'package:elfulk/src/core/widgets/content_card.dart';
import 'package:elfulk/src/core/widgets/empty_state.dart';
import 'package:elfulk/src/core/widgets/helpers/show_app_confirmation_dialog.dart';
import 'package:elfulk/src/core/widgets/options_sheet.dart';
import 'package:elfulk/src/core/widgets/search_field.dart';
import 'package:elfulk/src/features/parent_features/content/data/content_seed.dart';

/// مكتبة المحتوى حسب التصميم (عربي RTL).
///
/// بحث حي + رقاقات فلترة + بطاقة ملخص + بطاقات عناصر (شارات +
/// قائمة ⋮) + ستائر (فلترة متقدمة/إجراءات/نسخ). النوع من بارامتر
/// `type` في المسار. الحالة محلية (تُغذى خادمياً Phase 2).
class LibraryScreen extends StatefulWidget {
  final ContentType type;

  const LibraryScreen({super.key, required this.type});

  @override
  State<LibraryScreen> createState() => _LibraryScreenState();
}

class _LibraryScreenState extends State<LibraryScreen> {
  final TextEditingController _search = TextEditingController();
  String _query = '';
  int _chip = 0;
  late List<String> _hidden;

  static const List<String> _chips = <String>[
    'الكل',
    'مقترحة لطفلك',
    'المضافة',
  ];

  @override
  void initState() {
    super.initState();
    _hidden = [];
  }

  @override
  void dispose() {
    _search.dispose();
    super.dispose();
  }

  String get _typeLabel => switch (widget.type) {
    ContentType.games => 'الألعاب',
    ContentType.stories => 'القصص',
    ContentType.videos => 'الفيديوهات',
  };

  List<ContentItem> get _visible {
    final List<ContentItem> all = ContentSeed.ofType(widget.type)
        .where((ContentItem item) {
          if (_hidden.contains(item.id)) return false;
          if (_query.isNotEmpty && !item.title.contains(_query)) return false;
          return true;
        })
        .toList();
    return all;
  }

  @override
  Widget build(BuildContext context) {
    final ThemeData theme = Theme.of(context);
    final List<ContentItem> items = _visible;

    return Scaffold(
      appBar: AppBar(
        title: Text('مكتبة $_typeLabel'),
        centerTitle: true,
        actions: [
          IconButton(
            key: const ValueKey('library-menu'),
            icon: const Icon(Icons.more_vert_rounded),
            onPressed: () => _cardActions(context, null),
          ),
        ],
      ),
      body: SafeArea(
        child: ListView(
          padding: context.spacing.pagePadding,
          children: [
            SearchField(
              hint: 'هل تبحث عن شيء معين؟',
              controller: _search,
              onChanged: (String v) => setState(() => _query = v.trim()),
              onFilter: () => _advancedFilter(context),
            ),
            SizedBox(height: context.spacing.md.h),
            SingleChildScrollView(
              scrollDirection: Axis.horizontal,
              child: Row(
                children: [
                  for (int i = 0; i < _chips.length; i++) ...[
                    AppFilterChip(
                      label: _chips[i],
                      selected: i == _chip,
                      onSelected: () => setState(() => _chip = i),
                    ),
                    if (i < _chips.length - 1)
                      SizedBox(width: context.spacing.sm.w),
                  ],
                ],
              ),
            ),
            SizedBox(height: context.spacing.md.h),
            _SummaryBanner(typeLabel: _typeLabel, count: items.length),
            SizedBox(height: context.spacing.md.h),
            if (items.isEmpty)
              const EmptyState(
                icon: Icons.search_off_rounded,
                title: 'لا نتائج مطابقة',
                message: 'جرّب كلمة بحث مختلفة أو أزل الفلاتر.',
              )
            else
              for (final ContentItem item in items) ...[
                ContentCard(
                  key: ValueKey('library-card-${item.id}'),
                  art: Container(
                    color: item.artColor.withValues(alpha: 0.25),
                    child: Center(
                      child: Icon(
                        widget.type == ContentType.games
                            ? Icons.sports_esports_outlined
                            : widget.type == ContentType.stories
                            ? Icons.menu_book_outlined
                            : Icons.play_circle_outline_rounded,
                        size: 56.sp,
                        color: item.artColor,
                      ),
                    ),
                  ),
                  title: item.title,
                  badges: [
                    for (int t = 0; t < item.tags.length; t++)
                      ContentBadge(
                        label: item.tags[t],
                        background: const [
                          Color(0xFFFDD6D6),
                          Color(0xFFFEEDC9),
                          Color(0xFFD1E9E7),
                        ][t % 3],
                        foreground: const [
                          Color(0xFFD32F2F),
                          Color(0xFFF59E0B),
                          Color(0xFF2E8C84),
                        ][t % 3],
                      ),
                    ContentBadge(
                      label: item.badge,
                      background: theme.colorScheme.surfaceContainerHighest,
                      foreground: theme.colorScheme.onSurface,
                    ),
                  ],
                  actionLabel: widget.type == ContentType.games
                      ? 'الدخول الى اللعبة'
                      : 'عرض التفاصيل',
                  onAction: () => _openDetails(context, item),
                  onMenu: () => _cardActions(context, item),
                ),
                SizedBox(height: context.spacing.md.h),
              ],
          ],
        ),
      ),
    );
  }

  void _openDetails(BuildContext context, ContentItem item) {
    context.push(
      Uri(
        path: Routes.detailsScreen,
        queryParameters: {'id': item.id},
      ).toString(),
    );
  }

  /// ستارة الفلترة المتقدمة (عرض توضيحي يصفّي محلياً).
  Future<void> _advancedFilter(BuildContext context) async {
    await showFilterSheet(
      context: context,
      title: 'الفلترة المتقدمة',
      groups: const [
        FilterGroup(
          title: 'حسب الحالة:',
          options: [
            FilterOption(label: 'الكل'),
            FilterOption(label: 'المضافة لمكتبة طفلك'),
            FilterOption(label: 'المخفية مؤقتًا'),
          ],
        ),
        FilterGroup(
          title: 'الترتيب:',
          options: [
            FilterOption(label: 'الأحدث إضافة'),
            FilterOption(label: 'الأكثر لعبًا'),
          ],
        ),
      ],
    );
  }

  /// ستارة إجراءات البطاقة (تفاصيل/نسخ/إخفاء/إبلاغ/حذف).
  Future<void> _cardActions(BuildContext context, ContentItem? item) async {
    final int? choice = await showActionSheet(
      context: context,
      title: item?.title ?? 'إجراءات المكتبة',
      actions: const [
        SheetActionItem(label: 'التفاصيل', icon: Icons.info_outline_rounded),
        SheetActionItem(
          label: 'نسخ إلى مكتبة طفل آخر',
          icon: Icons.copy_outlined,
        ),
        SheetActionItem(
          label: 'إخفاء مؤقت',
          icon: Icons.visibility_off_outlined,
        ),
        SheetActionItem(label: 'الإبلاغ عن مشكلة', icon: Icons.flag_outlined),
      ],
      destructiveLabel: 'حذف من المكتبة',
      destructiveIcon: Icons.delete_outline_rounded,
    );
    if (!context.mounted) return;
    if (choice == null) return;
    if (choice == -1 && item != null) {
      final bool? confirmed = await showAppConfirmationDialog(
        context: context,
        config: AppConfirmationConfig(
          title: 'حذف "${item.title}"؟',
          message: 'سيتم حذف هذا العنصر من مكتبة طفلك. يمكن التراجع لاحقاً.',
          icon: const Icon(Icons.delete_outline_rounded),
          primaryActionType: AppConfirmationPrimaryActionType.normal,
          primaryActionLabel: 'حذف',
          secondaryActionLabel: 'إلغاء',
        ),
      );
      if (confirmed == true && context.mounted) {
        setState(() => _hidden.add(item.id));
        ScaffoldMessenger.of(context).showSnackBar(
          const SnackBar(content: Text('تم حذف العنصر من المكتبة.')),
        );
      }
      return;
    }
    if (choice == 0 && item != null) {
      _openDetails(context, item);
      return;
    }
    if (context.mounted) {
      ScaffoldMessenger.of(context)
          .showSnackBar(const SnackBar(content: Text('تم تسجيل الإجراء.')));
    }
  }
}

/// بانر ملخص المكتبة (إجمالي/مضافة/تحديث + زر استكشاف).
class _SummaryBanner extends StatelessWidget {
  final String typeLabel;
  final int count;

  const _SummaryBanner({required this.typeLabel, required this.count});

  @override
  Widget build(BuildContext context) {
    final ThemeData theme = Theme.of(context);

    return Material(
      color: theme.cardTheme.color,
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(context.radius.xxl.r),
      ),
      clipBehavior: Clip.antiAlias,
      child: Padding(
        padding: EdgeInsets.all(context.spacing.md.r),
        child: Column(
          children: [
            Icon(
              Icons.dashboard_customize_outlined,
              size: 28.sp,
              color: theme.colorScheme.primary,
            ),
            SizedBox(height: context.spacing.sm.h),
            Text(
              'كل $typeLabel المتاحة',
              style: TextStyle(
                fontSize: 15.sp,
                fontWeight: FontWeight.w800,
                color: theme.colorScheme.onSurface,
              ),
            ),
            Text(
              'تصفح المتاح واختر ما يناسب طفلك.',
              style: TextStyle(
                fontSize: 13.sp,
                color: theme.colorScheme.onSurface.withValues(alpha: 0.6),
              ),
            ),
            SizedBox(height: context.spacing.sm.h),
            Text(
              '$count عناصر معروضة',
              style: TextStyle(
                fontSize: 13.sp,
                fontWeight: FontWeight.w700,
                color: theme.colorScheme.primary,
              ),
            ),
          ],
        ),
      ),
    );
  }
}
