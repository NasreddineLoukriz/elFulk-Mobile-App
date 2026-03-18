import 'package:elfulk/src/features/parent_features/parent_requests/data/response_models/parent_requests_overview_response_model.dart';

class ParentRequestItemViewModel {
  const ParentRequestItemViewModel({
    required this.id,
    required this.childName,
    required this.requestType,
    required this.status,
    required this.requestedAt,
    required this.note,
  });

  final String id;
  final String childName;
  final String requestType;
  final String status;
  final String requestedAt;
  final String note;

  factory ParentRequestItemViewModel.fromResponseModel(
    ParentRequestItemResponseModel responseModel,
  ) {
    return ParentRequestItemViewModel(
      id: responseModel.id,
      childName: responseModel.childName,
      requestType: responseModel.requestType,
      status: responseModel.status,
      requestedAt: responseModel.requestedAt,
      note: responseModel.note,
    );
  }
}

class ParentRequestsOverviewViewModel {
  const ParentRequestsOverviewViewModel({
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
  final String baseUrl;
  final String endpoint;
  final String postEndpoint;
  final String patchEndpointTemplate;
  final List<String> recommendedEvents;
  final List<ParentRequestItemViewModel> requests;

  factory ParentRequestsOverviewViewModel.fromResponseModel(
    ParentRequestsOverviewResponseModel responseModel,
  ) {
    return ParentRequestsOverviewViewModel(
      title: responseModel.title,
      summary: responseModel.summary,
      baseUrl: responseModel.baseUrl,
      endpoint: responseModel.endpoint,
      postEndpoint: responseModel.postEndpoint,
      patchEndpointTemplate: responseModel.patchEndpointTemplate,
      recommendedEvents: responseModel.recommendedEvents,
      requests: responseModel.requests
          .map(ParentRequestItemViewModel.fromResponseModel)
          .toList(),
    );
  }
}
