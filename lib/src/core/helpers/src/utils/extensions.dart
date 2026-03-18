import 'package:flutter/material.dart';

extension AppContext on BuildContext {
  Size get screenSize => MediaQuery.sizeOf(this);

  double get screenWidth => screenSize.width;

  double get screenHeight => screenSize.height;

  ThemeData get theme => Theme.of(this);

  TextTheme get textTheme => theme.textTheme;

  ColorScheme get colorScheme => theme.colorScheme;

  Locale get locale => Localizations.localeOf(this);

  bool get isArabicLocale => locale.languageCode == 'ar';
}

extension NullableStringExtension on String? {
  bool isNullOrEmpty() => this == null || this!.trim().isEmpty;

  String orEmpty() => this ?? '';
}

extension StringExtension on String {
  String toUpperCaseFirstLetter() {
    if (isEmpty) {
      return this;
    }

    return this[0].toUpperCase() + substring(1);
  }
}

extension ListExtension<T> on List<T>? {
  bool isNullOrEmpty() => this == null || this!.isEmpty;
}

extension IndexedIterable<E> on Iterable<E> {
  Iterable<T> mapIndexed<T>(T Function(E element, int index) builder) sync* {
    int index = 0;
    for (final E element in this) {
      yield builder(element, index);
      index += 1;
    }
  }
}

class ModalBottomSheetPage<T> extends Page<T> {
  const ModalBottomSheetPage({
    required this.child,
    this.enableDrag = true,
    this.fullWidth = false,
    super.key,
  });

  final Widget child;
  final bool enableDrag;
  final bool fullWidth;

  @override
  Route<T> createRoute(BuildContext context) => ModalBottomSheetRoute<T>(
    settings: this,
    isScrollControlled: true,
    backgroundColor: Colors.transparent,
    enableDrag: enableDrag,
    constraints: fullWidth
        ? BoxConstraints.tightFor(width: MediaQuery.sizeOf(context).width)
        : null,
    builder: (BuildContext context) => child,
  );
}

class AlertDialogPage<T> extends Page<T> {
  const AlertDialogPage({required this.child, super.key});

  final Widget child;

  @override
  Route<T> createRoute(BuildContext context) => DialogRoute<T>(
    barrierDismissible: false,
    settings: this,
    context: context,
    builder: (BuildContext context) => child,
  );
}
