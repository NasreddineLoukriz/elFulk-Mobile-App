// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'home_overview_response_model.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

HomeOverviewResponseModel _$HomeOverviewResponseModelFromJson(
  Map<String, dynamic> json,
) => HomeOverviewResponseModel(
  headline: json['headline'] as String,
  summary: json['summary'] as String,
  baseUrl: json['base_url'] as String,
  endpoint: json['endpoint'] as String,
  principles: (json['principles'] as List<dynamic>)
      .map((e) => e as String)
      .toList(),
  modules: (json['modules'] as List<dynamic>)
      .map(
        (e) => FeatureModuleResponseModel.fromJson(e as Map<String, dynamic>),
      )
      .toList(),
  nextMilestones: (json['next_milestones'] as List<dynamic>)
      .map((e) => e as String)
      .toList(),
);
