import 'package:elfulk/src/features/app_features/home/data/response_models/feature_module_response_model.dart';
import 'package:elfulk/src/features/app_features/home/data/response_models/home_overview_response_model.dart';

class FeatureModuleViewModel {
  const FeatureModuleViewModel({
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
  final String nextStep;

  factory FeatureModuleViewModel.fromResponseModel(
    FeatureModuleResponseModel responseModel,
  ) {
    return FeatureModuleViewModel(
      name: responseModel.name,
      description: responseModel.description,
      status: responseModel.status,
      folders: responseModel.folders,
      nextStep: responseModel.nextStep,
    );
  }
}

class HomeOverviewViewModel {
  const HomeOverviewViewModel({
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
  final String baseUrl;
  final String endpoint;
  final List<String> principles;
  final List<FeatureModuleViewModel> modules;
  final List<String> nextMilestones;

  factory HomeOverviewViewModel.fromResponseModel(
    HomeOverviewResponseModel responseModel,
  ) {
    return HomeOverviewViewModel(
      headline: responseModel.headline,
      summary: responseModel.summary,
      baseUrl: responseModel.baseUrl,
      endpoint: responseModel.endpoint,
      principles: responseModel.principles,
      modules: responseModel.modules
          .map(FeatureModuleViewModel.fromResponseModel)
          .toList(),
      nextMilestones: responseModel.nextMilestones,
    );
  }
}
