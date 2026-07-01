import 'package:elfulk/src/core/constants/app_spacing.dart';
import 'package:flutter/material.dart';

extension SpacingExtension on BuildContext {
  AppSpacing get spacing => AppSpacing.of(this);
}