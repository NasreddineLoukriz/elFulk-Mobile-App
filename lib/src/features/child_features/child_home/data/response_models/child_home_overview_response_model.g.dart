// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'child_home_overview_response_model.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

ChildTaskResponseModel _$ChildTaskResponseModelFromJson(
  Map<String, dynamic> json,
) => ChildTaskResponseModel(
  title: json['title'] as String,
  status: json['status'] as String,
  reward: json['reward'] as String,
);

ChildHomeOverviewResponseModel _$ChildHomeOverviewResponseModelFromJson(
  Map<String, dynamic> json,
) => ChildHomeOverviewResponseModel(
  title: json['title'] as String,
  summary: json['summary'] as String,
  baseUrl: json['base_url'] as String,
  endpoint: json['endpoint'] as String,
  tasks: (json['tasks'] as List<dynamic>)
      .map((e) => ChildTaskResponseModel.fromJson(e as Map<String, dynamic>))
      .toList(),
  tips: (json['tips'] as List<dynamic>).map((e) => e as String).toList(),
);
