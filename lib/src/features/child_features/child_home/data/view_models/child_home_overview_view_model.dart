import 'package:elfulk/src/features/child_features/child_home/data/response_models/child_home_overview_response_model.dart';

class ChildTaskViewModel {
  const ChildTaskViewModel({
    required this.title,
    required this.status,
    required this.reward,
  });

  final String title;
  final String status;
  final String reward;

  factory ChildTaskViewModel.fromResponseModel(
    ChildTaskResponseModel responseModel,
  ) {
    return ChildTaskViewModel(
      title: responseModel.title,
      status: responseModel.status,
      reward: responseModel.reward,
    );
  }
}

class ChildHomeOverviewViewModel {
  const ChildHomeOverviewViewModel({
    required this.title,
    required this.summary,
    required this.baseUrl,
    required this.endpoint,
    required this.tasks,
    required this.tips,
  });

  final String title;
  final String summary;
  final String baseUrl;
  final String endpoint;
  final List<ChildTaskViewModel> tasks;
  final List<String> tips;

  factory ChildHomeOverviewViewModel.fromResponseModel(
    ChildHomeOverviewResponseModel responseModel,
  ) {
    return ChildHomeOverviewViewModel(
      title: responseModel.title,
      summary: responseModel.summary,
      baseUrl: responseModel.baseUrl,
      endpoint: responseModel.endpoint,
      tasks: responseModel.tasks
          .map(ChildTaskViewModel.fromResponseModel)
          .toList(),
      tips: responseModel.tips,
    );
  }
}
