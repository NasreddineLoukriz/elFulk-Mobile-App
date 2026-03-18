import 'package:json_annotation/json_annotation.dart';

part 'parent_requests_overview_response_model.g.dart';

@JsonSerializable(createToJson: false)
class ParentRequestItemResponseModel {
  const ParentRequestItemResponseModel({
    required this.id,
    required this.childName,
    required this.requestType,
    required this.status,
    required this.requestedAt,
    required this.note,
  });

  final String id;
  @JsonKey(name: 'child_name')
  final String childName;
  @JsonKey(name: 'request_type')
  final String requestType;
  final String status;
  @JsonKey(name: 'requested_at')
  final String requestedAt;
  final String note;

  factory ParentRequestItemResponseModel.fromJson(Map<String, dynamic> json) =>
      _$ParentRequestItemResponseModelFromJson(json);
}

@JsonSerializable(createToJson: false)
class ParentRequestsOverviewResponseModel {
  const ParentRequestsOverviewResponseModel({
    required this.title,
    required this.summary,
    required this.baseUrl,
    required this.endpoint,
    required this.postEndpoint,
    required this.patchEndpointTemplate,
    required this.recommendedEvents,
    required this.requests,
  });

  final String title;
  final String summary;
  @JsonKey(name: 'base_url')
  final String baseUrl;
  final String endpoint;
  @JsonKey(name: 'post_endpoint')
  final String postEndpoint;
  @JsonKey(name: 'patch_endpoint_template')
  final String patchEndpointTemplate;
  @JsonKey(name: 'recommended_events')
  final List<String> recommendedEvents;
  final List<ParentRequestItemResponseModel> requests;

  factory ParentRequestsOverviewResponseModel.fromJson(
    Map<String, dynamic> json,
  ) => _$ParentRequestsOverviewResponseModelFromJson(json);
}
