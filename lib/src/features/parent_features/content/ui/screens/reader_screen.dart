import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

import 'package:elfulk/src/core/helpers/helpers.dart';
import 'package:elfulk/src/core/widgets/app_error_card.dart';
import 'package:elfulk/src/core/widgets/reader_widgets.dart';
import 'package:elfulk/src/features/parent_features/content/data/content_seed.dart';

/// قارئ القصص حسب التصميم (عربي RTL).
///
/// تقدم مجزأ (يُملأ من اليمين) + رسم توضيحي + بطاقة نص الفصل +
/// زرّي السابق/التالي. الصفحات محتوى ثابت تجريبي (تُغذى خادمياً
/// Phase 2). التنقل يحدّث التقدم فعلياً.
class ReaderScreen extends StatefulWidget {
  final String itemId;

  const ReaderScreen({super.key, required this.itemId});

  @override
  State<ReaderScreen> createState() => _ReaderScreenState();
}

class _ReaderScreenState extends State<ReaderScreen> {
  static const List<String> _pages = <String>[
    'في قديم الزمان، في قرية هادئة تحفها الجبال الخضراء، عاش أرنب صغير '
        'يُدعى لولو. كان لولو فضولياً يحب الاستكشاف، وفي كل صباح يخرج '
        'مع أصدقائه ليتعلم شيئاً جديداً عن الغابة وسكانها.',
    'وفي أحد الأيام، قرر الأصدقاء تنظيم سباق كبير. تدرب لولو كل يوم، '
        'وتعلم أن الفوز الحقيقي ليس في السرعة بل في المثابرة ومساعدة '
        'الآخرين عند التعثر.',
    'وفي نهاية السباق، فازت السلحفاة الحكيمة لأنها لم تتوقف أبداً. '
        'احتفل الجميع، وتعلم لولو درساً لن ينساه: الصبر والمثابرة '
        'يصنعان الأبطال.',
  ];

  int _page = 0;

  @override
  Widget build(BuildContext context) {
    final ThemeData theme = Theme.of(context);
    final ContentItem? item = ContentSeed.byId(widget.itemId);

    return Scaffold(
      appBar: AppBar(
        title: Text(item?.title ?? 'القارئ'),
        centerTitle: true,
        actions: const [Icon(Icons.more_vert_rounded)],
      ),
      body: SafeArea(
        child: item == null
            ? Padding(
                padding: context.spacing.pagePadding,
                child: const AppErrorCard(message: 'العنصر المطلوب غير موجود.'),
              )
            : ListView(
                padding: context.spacing.pagePadding,
                children: [
                  ReaderProgress(total: _pages.length, read: _page + 1),
                  SizedBox(height: context.spacing.md.h),
                  Container(
                    height: 180.h,
                    width: double.infinity,
                    decoration: BoxDecoration(
                      color: item.artColor.withValues(alpha: 0.25),
                      borderRadius: BorderRadius.circular(context.radius.xxl.r),
                    ),
                    clipBehavior: Clip.antiAlias,
                    child: Center(
                      child: Icon(
                        Icons.menu_book_outlined,
                        size: 64.sp,
                        color: item.artColor,
                      ),
                    ),
                  ),
                  SizedBox(height: context.spacing.md.h),
                  Material(
                    color: theme.cardTheme.color,
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(context.radius.xxl.r),
                    ),
                    clipBehavior: Clip.antiAlias,
                    child: Padding(
                      padding: EdgeInsets.all(context.spacing.lg.r),
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.stretch,
                        children: [
                          Text(
                            'الفصل ${_page + 1}',
                            textAlign: TextAlign.center,
                            style: TextStyle(
                              fontSize: 16.sp,
                              fontWeight: FontWeight.w800,
                              color: theme.colorScheme.onSurface,
                            ),
                          ),
                          SizedBox(height: context.spacing.sm.h),
                          Text(
                            _pages[_page],
                            textAlign: TextAlign.justify,
                            style: TextStyle(
                              fontSize: 15.sp,
                              height: 1.9,
                              color: theme.colorScheme.onSurface.withValues(
                                alpha: 0.85,
                              ),
                            ),
                          ),
                        ],
                      ),
                    ),
                  ),
                  SizedBox(height: context.spacing.lg.h),
                  ReaderNav(
                    prevLabel: 'الفصل السابقة',
                    nextLabel: 'الفصل التالية',
                    prevEnabled: _page > 0,
                    nextEnabled: _page < _pages.length - 1,
                    onPrev: () => setState(() => _page--),
                    onNext: () => setState(() => _page++),
                  ),
                ],
              ),
      ),
    );
  }
}
