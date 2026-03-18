import 'package:json_annotation/json_annotation.dart';

part 'feature_module_response_model.g.dart';

@JsonSerializable(createToJson: false)
class FeatureModuleResponseModel {
  const FeatureModuleResponseModel({
    required this.name,
    required this.description,
    required this.status,
    required this.folders,
    required this.nextStep,
  });

  final String name;
  final String description;
  final String status;
  final List<String> folders;
  @JsonKey(name: 'next_step')
  final String nextStep;

  factory FeatureModuleResponseModel.fromJson(Map<String, dynamic> json) =>
      _$FeatureModuleResponseModelFromJson(json);
}
