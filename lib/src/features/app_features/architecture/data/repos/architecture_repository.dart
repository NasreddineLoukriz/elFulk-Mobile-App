import 'package:elfulk/src/core/config/app_environment.dart';
import 'package:elfulk/src/features/app_features/architecture/data/view_models/architecture_overview_view_model.dart';

class ArchitectureRepository {
  ArchitectureRepository(this._environment);

  final AppEnvironment _environment;

  ArchitectureOverviewViewModel loadOverview() {
    return ArchitectureOverviewViewModel(
      startupSteps: <String>[
        'Flavor entrypoint selects development or production configuration.',
        'bootApp initializes Flutter bindings, preserves the splash, ensures screen metrics, and starts Firebase.',
        'setupGetIt configures the shared dev or prod base URL, Dio, API services, repositories, and logic factories.',
        'ElFulkApp wraps MaterialApp.router with ScreenUtilInit and wires theme and GoRouter.',
        'Route builders create feature-level BlocProviders with GetIt factories.',
        'Logic layers map response models into view models before the UI consumes state.',
        'Dummy Dio responses keep the networking layer active without requiring a real backend yet.',
      ],
      layers: <ArchitectureLayerViewModel>[
        const ArchitectureLayerViewModel(
          name: 'app',
          responsibility:
              'Own startup orchestration and keep flavor entrypoints small.',
          directories: <String>[
            'lib/main_development.dart',
            'lib/main_production.dart',
            'lib/src/app/boot/',
          ],
          note:
              'Keeps flavor boot logic and startup orchestration out of feature code.',
        ),
        const ArchitectureLayerViewModel(
          name: 'core',
          responsibility:
              'Provide routing, DI, networking helpers, generic helpers and utils, shared theme, and reusable widgets.',
          directories: <String>[
            'lib/src/core/config/',
            'lib/src/core/helpers/',
            'lib/src/core/networking/',
            'lib/src/core/theme/',
            'lib/src/core/widgets/',
          ],
          note: 'This is where shared app infrastructure lives.',
        ),
        const ArchitectureLayerViewModel(
          name: 'features',
          responsibility:
              'Split product areas into app, parent, and child groups with data, logic, and ui.',
          directories: <String>[
            'lib/src/features/app_features/',
            'lib/src/features/parent_features/',
            'lib/src/features/child_features/',
          ],
          note:
              'Each group owns its own models, repos, Cubits or Blocs, and screens.',
        ),
      ],
      folderTree: '''lib/
  main_development.dart
  main_production.dart
  src/
    app/
      boot/
        boot_app.dart
    core/
      app/
        elfulk_app.dart
      config/
        app_environment.dart
        di/
          dependency_injection.dart
        routing/
          app_router.dart
          routes.dart
      helpers/
        helpers.dart
        src/
          utils/
      networking/
        app/
        parent/
        child/
        error/
        helper/
      theme/
        app_theme.dart
      widgets/
        app_section_card.dart
    features/
      app_features/
        home/
          data/
            response_models/
            view_models/
        architecture/
          data/
            view_models/
      parent_features/
        parent_home/
          data/
            response_models/
            view_models/
        parent_requests/
          data/
            request_models/
            response_models/
            view_models/
      child_features/
        child_home/
          data/
            response_models/
            view_models/''',
      implementationPatterns: <ArchitecturePatternViewModel>[
        const ArchitecturePatternViewModel(
          pattern: 'setupGetIt() bootstraps dependencies before runApp.',
          implementation:
              'ElFulk registers Dio, API services, repositories, and logic factories in setupGetIt().',
        ),
        const ArchitecturePatternViewModel(
          pattern:
              'ScreenUtil is initialized at startup and used through responsive extension units.',
          implementation:
              'ElFulk now calls ScreenUtil.ensureScreenSize(), wraps the app in ScreenUtilInit, and uses .w, .h, .r, and .sp in shared UI.',
        ),
        const ArchitecturePatternViewModel(
          pattern:
              'core/helpers centralizes reusable formatters, validators, spacing, extensions, and app helper functions.',
          implementation:
              'ElFulk now exposes the same core/helpers barrel pattern with reusable utils, storage, asset paths, URL helpers, and ScreenUtil spacing helpers.',
        ),
        const ArchitecturePatternViewModel(
          pattern:
              'GoRouter centralizes navigation with route-level providers.',
          implementation:
              'ElFulk now uses GoRouter with route-level BlocProvider creation for Cubit and Bloc examples across app, parent, and child flows.',
        ),
        const ArchitecturePatternViewModel(
          pattern:
              'Repositories wrap API services and normalize outcomes through ApiResult.',
          implementation:
              'ElFulk now uses ApiResult, ApiErrorHandler, DioFactory, and dummy API services to mirror that flow.',
        ),
        ArchitecturePatternViewModel(
          pattern:
              'Feature groups map to app-facing roles and product domains.',
          implementation:
              'ElFulk now uses app_features, parent_features, and child_features for that split in the ${_environment.apiEnvironmentLabel} flavor.',
        ),
      ],
      nextMilestones: <String>[
        'Swap the dummy Dio interceptor with real HTTP responses without changing Cubit or repository contracts.',
        'Add additional app_features such as auth, notifications, and settings using the same networking helpers.',
        'Use the parent_requests Bloc pattern when a feature needs GET plus POST or PATCH coordination.',
        'Keep the UI layer bound to view_models only as the codebase grows.',
      ],
    );
  }
}
