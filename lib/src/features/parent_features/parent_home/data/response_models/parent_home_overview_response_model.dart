import 'package:json_annotation/json_annotation.dart';

part 'parent_home_overview_response_model.g.dart';

@JsonSerializable(createToJson: false)
class ParentHighlightResponseModel {
  const ParentHighlightResponseModel({
    required this.label,
    required this.value,
    required this.detail,
  });

  final String label;
  final String value;
  final String detail;

  factory ParentHighlightResponseModel.fromJson(Map<String, dynamic> json) =>
      _$ParentHighlightResponseModelFromJson(json);
}

@JsonSerializable(createToJson: false)
class ParentHomeOverviewResponseModel {
  const ParentHomeOverviewResponseModel({
    required this.title,
    required this.summary,
    required this.baseUrl,
    required this.endpoint,
    required this.highlights,
    required this.nextActions,
  });

  final String title;
  final String summary;
  @JsonKey(name: 'base_url')
  final String baseUrl;
  final String endpoint;
  final List<ParentHighlightResponseModel> highlights;
  @JsonKey(name: 'next_actions')
  final List<String> nextActions;

  factory ParentHomeOverviewResponseModel.fromJson(Map<String, dynamic> json) =>
      _$ParentHomeOverviewResponseModelFromJson(json);
}
