import 'package:json_annotation/json_annotation.dart';

part 'child_home_overview_response_model.g.dart';

@JsonSerializable(createToJson: false)
class ChildTaskResponseModel {
  const ChildTaskResponseModel({
    required this.title,
    required this.status,
    required this.reward,
  });

  final String title;
  final String status;
  final String reward;

  factory ChildTaskResponseModel.fromJson(Map<String, dynamic> json) =>
      _$ChildTaskResponseModelFromJson(json);
}

@JsonSerializable(createToJson: false)
class ChildHomeOverviewResponseModel {
  const ChildHomeOverviewResponseModel({
    required this.title,
    required this.summary,
    required this.baseUrl,
    required this.endpoint,
    required this.tasks,
    required this.tips,
  });

  final String title;
  final String summary;
  @JsonKey(name: 'base_url')
  final String baseUrl;
  final String endpoint;
  final List<ChildTaskResponseModel> tasks;
  final List<String> tips;

  factory ChildHomeOverviewResponseModel.fromJson(Map<String, dynamic> json) =>
      _$ChildHomeOverviewResponseModelFromJson(json);
}
