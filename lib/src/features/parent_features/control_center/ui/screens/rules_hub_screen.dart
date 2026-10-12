import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

import 'package:elfulk/src/core/helpers/helpers.dart';
import 'package:elfulk/src/core/widgets/group_card.dart';
import 'package:elfulk/src/core/widgets/section_header.dart';
import 'package:elfulk/src/core/widgets/settings_list_tile.dart';

/// قاعدة واحدة في مركز القواعد (عنوان + وصف + مفتاح).
class _RuleItem {
  final String id;
  final String title;
  final String subtitle;
  final IconData icon;
  final Color color;

  const _RuleItem({
    required this.id,
    required this.title,
    required this.subtitle,
    required this.icon,
    required this.color,
  });
}

/// مركز تخصيص القواعد حسب التصميم (عربي RTL).
///
/// مجموعتان (وصول/سلوك) من صفوف التبديل — كلها مفعّلة افتراضياً
/// كما في التصميم. الحالة محلية للجلسة (تُحفظ خادمياً Phase 2).
class RulesHubScreen extends StatefulWidget {
  const RulesHubScreen({super.key});

  @override
  State<RulesHubScreen> createState() => _RulesHubScreenState();
}

class _RulesHubScreenState extends State<RulesHubScreen> {
  final Set<String> _enabled = {
    'search',
    'autoplay',
    'replay',
    'suggest',
    'zap',
    'single',
    'skip',
    'pause',
    'repeat',
  };

  static const List<_RuleItem> _access = <_RuleItem>[
    _RuleItem(
      id: 'search',
      title: 'البحث الحر',
      subtitle: 'يسمح للطفل بالبحث عن المحتوى بحرية داخل المنصة.',
      icon: Icons.search_rounded,
      color: Color(0xFF2E8C84),
    ),
    _RuleItem(
      id: 'autoplay',
      title: 'تشغيل الفيديو التالي تلقائيا',
      subtitle: 'يشغل الفيديو التالي تلقائيا بعد انتهاء الحالي.',
      icon: Icons.play_circle_outline_rounded,
      color: Color(0xFFF03A3A),
    ),
    _RuleItem(
      id: 'replay',
      title: 'إعادة تشغيل المحتوى',
      subtitle: 'يسمح للطفل بإعادة تشغيل الفيديو من البداية.',
      icon: Icons.replay_rounded,
      color: Color(0xFFF59E0B),
    ),
    _RuleItem(
      id: 'suggest',
      title: 'اقتراح محتوى مشابه',
      subtitle: 'يعرض محتوى مشابها لاهتمامات الطفل.',
      icon: Icons.tune_rounded,
      color: Color(0xFF2E8C84),
    ),
  ];

  static const List<_RuleItem> _behavior = <_RuleItem>[
    _RuleItem(
      id: 'zap',
      title: 'حد التبديل السريع للمحتوى',
      subtitle: 'يمنع التنقل السريع المتكرر بين المحتويات.',
      icon: Icons.bolt_outlined,
      color: Color(0xFFF4AA08),
    ),
    _RuleItem(
      id: 'single',
      title: 'حصر النشاط في فئة واحدة',
      subtitle: 'يقصر جلسة الطفل على فئة محتوى واحدة.',
      icon: Icons.sell_outlined,
      color: Color(0xFF43A047),
    ),
    _RuleItem(
      id: 'skip',
      title: 'منع التخطي السريع',
      subtitle: 'يمنع تخطي أجزاء الفيديو بسرعة.',
      icon: Icons.skip_next_outlined,
      color: Color(0xFF2E8C84),
    ),
    _RuleItem(
      id: 'pause',
      title: 'إيقاف مؤقت بعد الاستخدام الطويل',
      subtitle: 'يوقف التشغيل تلقائيا بعد مدة متواصلة.',
      icon: Icons.pause_circle_outline_rounded,
      color: Color(0xFFF03A3A),
    ),
    _RuleItem(
      id: 'repeat',
      title: 'منع تكرار نفس المحتوى',
      subtitle: 'يمنع إعادة نفس الفيديو أكثر من مرة.',
      icon: Icons.replay_circle_filled_outlined,
      color: Color(0xFFF4AA08),
    ),
  ];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text('تخصيص القواعد'), centerTitle: true),
      body: SafeArea(
        child: ListView(
          padding: context.spacing.pagePadding,
          children: [
            _RuleGroup(
              title: 'قواعد الوصول',
              rules: _access,
              enabled: _enabled,
              onChanged: _toggle,
            ),
            SizedBox(height: context.spacing.lg.h),
            _RuleGroup(
              title: 'قواعد السلوك',
              rules: _behavior,
              enabled: _enabled,
              onChanged: _toggle,
            ),
          ],
        ),
      ),
    );
  }

  void _toggle(String id, bool value) {
    setState(() {
      if (value) {
        _enabled.add(id);
      } else {
        _enabled.remove(id);
      }
    });
  }
}

/// مجموعة قواعد: عنوان قسم + بطاقة صفوف تبديل.
class _RuleGroup extends StatelessWidget {
  final String title;
  final List<_RuleItem> rules;
  final Set<String> enabled;
  final void Function(String id, bool value) onChanged;

  const _RuleGroup({
    required this.title,
    required this.rules,
    required this.enabled,
    required this.onChanged,
  });

  @override
  Widget build(BuildContext context) {
    return Column(
      mainAxisSize: MainAxisSize.min,
      crossAxisAlignment: CrossAxisAlignment.stretch,
      children: [
        SectionHeader(title: title),
        SizedBox(height: context.spacing.sm.h),
        GroupCard(
          children: [
            for (int i = 0; i < rules.length; i++)
              SettingsListTile(
                key: ValueKey('rules-tile-${rules[i].id}'),
                title: rules[i].title,
                subtitle: rules[i].subtitle,
                leading: Icon(rules[i].icon),
                leadingBackgroundColor:
                    rules[i].color.withValues(alpha: 0.12),
                leadingForegroundColor: rules[i].color,
                trailing: SettingsTileTrailing.switch_(
                  value: enabled.contains(rules[i].id),
                  onChanged: (bool v) => onChanged(rules[i].id, v),
                ),
                backgroundColor: Colors.transparent,
                borderRadius: 0,
                showDivider: i < rules.length - 1,
              ),
          ],
        ),
      ],
    );
  }
}
