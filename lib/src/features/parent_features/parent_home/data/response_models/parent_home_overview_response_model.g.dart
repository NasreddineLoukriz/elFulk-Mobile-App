// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'parent_home_overview_response_model.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

ParentHighlightResponseModel _$ParentHighlightResponseModelFromJson(
  Map<String, dynamic> json,
) => ParentHighlightResponseModel(
  label: json['label'] as String,
  value: json['value'] as String,
  detail: json['detail'] as String,
);

ParentHomeOverviewResponseModel _$ParentHomeOverviewResponseModelFromJson(
  Map<String, dynamic> json,
) => ParentHomeOverviewResponseModel(
  title: json['title'] as String,
  summary: json['summary'] as String,
  baseUrl: json['base_url'] as String,
  endpoint: json['endpoint'] as String,
  highlights: (json['highlights'] as List<dynamic>)
      .map(
        (e) => ParentHighlightResponseModel.fromJson(e as Map<String, dynamic>),
      )
      .toList(),
  nextActions: (json['next_actions'] as List<dynamic>)
      .map((e) => e as String)
      .toList(),
);
