// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'feature_module_response_model.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

FeatureModuleResponseModel _$FeatureModuleResponseModelFromJson(
  Map<String, dynamic> json,
) => FeatureModuleResponseModel(
  name: json['name'] as String,
  description: json['description'] as String,
  status: json['status'] as String,
  folders: (json['folders'] as List<dynamic>).map((e) => e as String).toList(),
  nextStep: json['next_step'] as String,
);
