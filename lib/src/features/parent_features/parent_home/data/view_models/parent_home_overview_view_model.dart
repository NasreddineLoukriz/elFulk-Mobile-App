import 'package:elfulk/src/features/parent_features/parent_home/data/response_models/parent_home_overview_response_model.dart';

class ParentHighlightViewModel {
  const ParentHighlightViewModel({
    required this.label,
    required this.value,
    required this.detail,
  });

  final String label;
  final String value;
  final String detail;

  factory ParentHighlightViewModel.fromResponseModel(
    ParentHighlightResponseModel responseModel,
  ) {
    return ParentHighlightViewModel(
      label: responseModel.label,
      value: responseModel.value,
      detail: responseModel.detail,
    );
  }
}

class ParentHomeOverviewViewModel {
  const ParentHomeOverviewViewModel({
    required this.title,
    required this.summary,
    required this.baseUrl,
    required this.endpoint,
    required this.highlights,
    required this.nextActions,
  });

  final String title;
  final String summary;
  final String baseUrl;
  final String endpoint;
  final List<ParentHighlightViewModel> highlights;
  final List<String> nextActions;

  factory ParentHomeOverviewViewModel.fromResponseModel(
    ParentHomeOverviewResponseModel responseModel,
  ) {
    return ParentHomeOverviewViewModel(
      title: responseModel.title,
      summary: responseModel.summary,
      baseUrl: responseModel.baseUrl,
      endpoint: responseModel.endpoint,
      highlights: responseModel.highlights
          .map(ParentHighlightViewModel.fromResponseModel)
          .toList(),
      nextActions: responseModel.nextActions,
    );
  }
}
