import 'package:json_annotation/json_annotation.dart';

import 'package:elfulk/src/features/app_features/home/data/response_models/feature_module_response_model.dart';

part 'home_overview_response_model.g.dart';

@JsonSerializable(createToJson: false)
class HomeOverviewResponseModel {
  const HomeOverviewResponseModel({
    required this.headline,
    required this.summary,
    required this.baseUrl,
    required this.endpoint,
    required this.principles,
    required this.modules,
    required this.nextMilestones,
  });

  final String headline;
  final String summary;
  @JsonKey(name: 'base_url')
  final String baseUrl;
  final String endpoint;
  final List<String> principles;
  final List<FeatureModuleResponseModel> modules;
  @JsonKey(name: 'next_milestones')
  final List<String> nextMilestones;

  factory HomeOverviewResponseModel.fromJson(Map<String, dynamic> json) =>
      _$HomeOverviewResponseModelFromJson(json);
}
