// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'parent_requests_overview_response_model.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

ParentRequestItemResponseModel _$ParentRequestItemResponseModelFromJson(
  Map<String, dynamic> json,
) => ParentRequestItemResponseModel(
  id: json['id'] as String,
  childName: json['child_name'] as String,
  requestType: json['request_type'] as String,
  status: json['status'] as String,
  requestedAt: json['requested_at'] as String,
  note: json['note'] as String,
);

ParentRequestsOverviewResponseModel
_$ParentRequestsOverviewResponseModelFromJson(Map<String, dynamic> json) =>
    ParentRequestsOverviewResponseModel(
      title: json['title'] as String,
      summary: json['summary'] as String,
      baseUrl: json['base_url'] as String,
      endpoint: json['endpoint'] as String,
      postEndpoint: json['post_endpoint'] as String,
      patchEndpointTemplate: json['patch_endpoint_template'] as String,
      recommendedEvents: (json['recommended_events'] as List<dynamic>)
          .map((e) => e as String)
          .toList(),
      requests: (json['requests'] as List<dynamic>)
          .map(
            (e) => ParentRequestItemResponseModel.fromJson(
              e as Map<String, dynamic>,
            ),
          )
          .toList(),
    );
