import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

import 'package:elfulk/src/core/helpers/helpers.dart';
import 'package:elfulk/src/features/parent_features/profile/data/help_content.dart';

/// اختيار اللغة حسب التصميم (عربي RTL).
///
/// يحفظ الاختيار في `SharedPreferences` فوراً. التطبيق الفوري داخل
/// الجلسة يتطلب إدارة locale على مستوى التطبيق (غير موجودة بعد —
/// موثقة كـ TODO) فيُطبق عند إعادة التشغيل.
class LanguageScreen extends StatefulWidget {
  const LanguageScreen({super.key});

  @override
  State<LanguageScreen> createState() => _LanguageScreenState();
}

class _LanguageScreenState extends State<LanguageScreen> {
  String _code = 'ar';
  bool _loaded = false;

  @override
  void initState() {
    super.initState();
    SharedPrefHelper.getString(SharedPrefKeys.locale, 'ar').then(
      (String value) {
        if (mounted) {
          setState(() {
            _code = value;
            _loaded = true;
          });
        }
      },
    );
  }

  @override
  Widget build(BuildContext context) {
    final ThemeData theme = Theme.of(context);

    return Scaffold(
      appBar: AppBar(title: const Text('اللغة'), centerTitle: true),
      body: SafeArea(
        child: !_loaded
            ? const Center(child: CircularProgressIndicator())
            : ListView.separated(
                padding: context.spacing.pagePadding,
                itemCount: HelpContent.languages.length,
                separatorBuilder: (context, _) =>
                    SizedBox(height: context.spacing.sm.h),
                itemBuilder: (context, index) {
                  final LanguageOption option =
                      HelpContent.languages[index];
                  final bool selected = option.code == _code;

                  return Material(
                    color: theme.cardTheme.color,
                    shape: RoundedRectangleBorder(
                      borderRadius:
                          BorderRadius.circular(context.radius.xl.r),
                      side: selected
                          ? BorderSide(
                              color: theme.colorScheme.primary,
                              width: 1.5,
                            )
                          : BorderSide.none,
                    ),
                    clipBehavior: Clip.antiAlias,
                    child: ListTile(
                      key: ValueKey('language-option-${option.code}'),
                      title: Text(
                        option.label,
                        style: TextStyle(
                          fontSize: 15.sp,
                          fontWeight: FontWeight.w700,
                          color: theme.colorScheme.onSurface,
                        ),
                      ),
                      trailing: selected
                          ? Icon(
                              Icons.check_circle_rounded,
                              color: theme.colorScheme.primary,
                            )
                          : null,
                      onTap: () async {
                        await SharedPrefHelper.setData(
                          SharedPrefKeys.locale,
                          option.code,
                        );
                        if (context.mounted) {
                          setState(() => _code = option.code);
                          ScaffoldMessenger.of(context).showSnackBar(
                            const SnackBar(
                              content: Text(
                                'تم حفظ اللغة. تُطبق عند إعادة تشغيل التطبيق.',
                              ),
                            ),
                          );
                        }
                      },
                    ),
                  );
                },
              ),
      ),
    );
  }
}
