import 'package:flutter/material.dart';

/// نوع المحتوى (ألعاب/قصص/فيديوهات).
enum ContentType { games, stories, videos }

/// عنصر محتوى واحد (بيانات عرض ثابتة — تُغذى خادمياً Phase 2).
class ContentItem {
  final String id;
  final ContentType type;
  final String title;
  final List<String> tags;
  final String badge;
  final String description;
  final Color artColor;

  const ContentItem({
    required this.id,
    required this.type,
    required this.title,
    required this.tags,
    required this.badge,
    required this.description,
    required this.artColor,
  });
}

/// بذر المكتبة (عربي).
class ContentSeed {
  const ContentSeed._();

  static const List<ContentItem> games = <ContentItem>[
    ContentItem(
      id: 'g1',
      type: ContentType.games,
      title: 'مستكشف الفضاء',
      tags: ['الفضاء والكون', 'علوم وتجارب', 'منطق وتفكير'],
      badge: 'جديد',
      description: 'لعبة استكشاف فضائية تعلم الطفل الكواكب والمجرات باللعب.',
      artColor: Color(0xFF5079D2),
    ),
    ContentItem(
      id: 'g2',
      type: ContentType.games,
      title: 'ذاكرة الحيوانات',
      tags: ['حيوانات وطبيعة', 'ذاكرة وتركيز'],
      badge: 'تمت الإضافة',
      description: 'لعبة ذاكرة ممتعة بأصوات الحيوانات وصورها.',
      artColor: Color(0xFF937A74),
    ),
  ];

  static const List<ContentItem> stories = <ContentItem>[
    ContentItem(
      id: 's1',
      type: ContentType.stories,
      title: 'قصة معركة بدر كاملة',
      tags: ['الأنبياء والسيرة', 'التاريخ والتراث', 'تربية وقيم'],
      badge: '4 من 12 فصل',
      description: 'قصة معركة بدر كاملة مع مواقف مفيدة، مكتوبة بلغة مبسطة تناسب الأطفال.',
      artColor: Color(0xFFE9AA7F),
    ),
  ];

  static const List<ContentItem> videos = <ContentItem>[
    ContentItem(
      id: 'v1',
      type: ContentType.videos,
      title: 'الأرنب السريع وأصدقاء الغابة',
      tags: ['تربية وقيم', 'علوم وتعليم'],
      badge: '15:12',
      description: 'حلقة مرحة عن الصداقة والتعاون في الغابة.',
      artColor: Color(0xFF43A047),
    ),
  ];

  /// كل العناصر للبحث برقم المعرف.
  static ContentItem? byId(String id) {
    for (final List<ContentItem> list in [games, stories, videos]) {
      for (final ContentItem item in list) {
        if (item.id == id) return item;
      }
    }
    return null;
  }

  /// عناصر نوع معين.
  static List<ContentItem> ofType(ContentType type) => switch (type) {
    ContentType.games => games,
    ContentType.stories => stories,
    ContentType.videos => videos,
  };

  /// تحويل بارامتر المسار لنوع (`games` افتراضياً).
  static ContentType parseType(String? raw) => switch (raw) {
    'stories' => ContentType.stories,
    'videos' => ContentType.videos,
    _ => ContentType.games,
  };
}
