import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:go_router/go_router.dart';

import 'package:elfulk/src/core/config/di/dependency_injection.dart';
import 'package:elfulk/src/features/app_features/auth/logic/cubit/auth_cubit.dart';
import 'package:elfulk/src/features/app_features/auth/ui/screens/login_screen.dart';
import 'package:elfulk/src/features/app_features/auth/ui/screens/reset_password_screen.dart';
import 'package:elfulk/src/features/app_features/auth/ui/screens/register_screen.dart';
import 'package:elfulk/src/features/app_features/auth/ui/screens/forget_password_screen.dart';
import 'package:elfulk/src/features/app_features/architecture/logic/cubit/architecture_cubit.dart';
import 'package:elfulk/src/features/app_features/architecture/ui/screens/architecture_overview_screen.dart';
import 'package:elfulk/src/features/app_features/home/ui/screens/home_screen.dart';
import 'package:elfulk/src/features/parent_features/add_child/ui/screens/add_child_screen.dart';
import 'package:elfulk/src/features/parent_features/add_child/ui/screens/Add_new_child_screen.dart';
import 'package:elfulk/src/features/child_features/child_home/logic/cubit/child_home_cubit.dart';
import 'package:elfulk/src/features/child_features/child_home/ui/screens/child_home_screen.dart';
import 'package:elfulk/src/features/parent_features/parent_home/ui/screens/parent_home_screen.dart';
import 'package:elfulk/src/features/parent_features/parent_requests/logic/bloc/parent_requests_bloc.dart';
import 'package:elfulk/src/features/parent_features/parent_requests/ui/screens/parent_requests_screen.dart';
import 'package:elfulk/src/features/app_features/onboarding/logic/cubit/onboarding_cubit.dart';
import 'package:elfulk/src/features/app_features/onboarding/ui/screens/onboarding_screen.dart';
import 'package:elfulk/src/features/app_features/dev_hub/ui/screens/dev_hub_screen.dart';
import 'package:elfulk/src/core/widgets/parent_shell_scaffold.dart';
import 'package:elfulk/src/features/app_features/home/logic/dashboard_cubit/home_dashboard_cubit.dart';
import 'package:elfulk/src/features/app_features/notifications/logic/cubit/notifications_cubit.dart';
import 'package:elfulk/src/features/app_features/notifications/ui/screens/notifications_screen.dart';
import 'package:elfulk/src/features/parent_features/control_center/ui/screens/control_home_screen.dart';
import 'package:elfulk/src/features/parent_features/control_center/ui/screens/rules_hub_screen.dart';
import 'package:elfulk/src/features/parent_features/control_center/ui/screens/time_hub_screen.dart';
import 'package:elfulk/src/features/parent_features/content/data/content_seed.dart';
import 'package:elfulk/src/features/parent_features/content/ui/screens/content_hub_screen.dart';
import 'package:elfulk/src/features/parent_features/content/ui/screens/details_screen.dart';
import 'package:elfulk/src/features/parent_features/content/ui/screens/library_screen.dart';
import 'package:elfulk/src/features/parent_features/content/ui/screens/reader_screen.dart';
import 'package:elfulk/src/features/parent_features/profile/data/help_content.dart';
import 'package:elfulk/src/features/parent_features/profile/ui/screens/account_settings_screen.dart';
import 'package:elfulk/src/features/parent_features/profile/ui/screens/app_settings_screen.dart';
import 'package:elfulk/src/features/parent_features/profile/ui/screens/appearance_screen.dart';
import 'package:elfulk/src/features/parent_features/profile/ui/screens/change_password_screen.dart';
import 'package:elfulk/src/features/parent_features/profile/ui/screens/contact_us_screen.dart';
import 'package:elfulk/src/features/parent_features/profile/ui/screens/edit_personal_info_screen.dart';
import 'package:elfulk/src/features/parent_features/profile/ui/screens/faq_screen.dart';
import 'package:elfulk/src/features/parent_features/profile/ui/screens/help_screen.dart';
import 'package:elfulk/src/features/parent_features/profile/ui/screens/language_screen.dart';
import 'package:elfulk/src/features/parent_features/profile/ui/screens/linked_devices_screen.dart';
import 'package:elfulk/src/features/parent_features/profile/ui/screens/profile_screen.dart';
import 'package:elfulk/src/features/parent_features/profile/ui/screens/static_info_screen.dart';

import '../../../features/app_features/auth/ui/screens/otp_verification_screen.dart';

import 'package:elfulk/src/core/config/app_environment.dart';
import 'package:elfulk/src/core/helpers/helpers.dart';

import 'routes.dart';

class AppRouter {
  AppRouter._();

  static GoRouter? _router;

  static GoRouter get router => _router ??= _buildRouter();

  static GoRouter _buildRouter() {
    final AppEnvironment environment = getIt<AppEnvironment>();

    return GoRouter(
      initialLocation: environment.isProduction
          ? Routes.onboardingScreen
          : Routes.devHubScreen,
      redirect: (context, state) async {
        if (environment.isProduction &&
            state.matchedLocation == Routes.devHubScreen) {
          return Routes.onboardingScreen;
        }

        final bool done = await OnboardingCubit.isOnboardingDone();
        if (done && state.matchedLocation == Routes.onboardingScreen) {
          return Routes.loginScreen;
        }
        return null;
      },
      routes: <RouteBase>[
        // ✅ Route onboarding — première dans la liste
        GoRoute(
          path: Routes.onboardingScreen,
          pageBuilder: (context, state) => MaterialPage<void>(
            child: BlocProvider(
              create: (_) => OnboardingCubit(),
              child: const OnboardingScreen(),
            ),
          ),
        ),
        // P0 parent shell — TEMP branch mapping until P1/P3 replace the
        // placeholder screens with the real tab destinations:
        // home→home, activity→requests, control→child_home, account→parent.
        // Branch order matches ParentBottomNav.items.
        StatefulShellRoute.indexedStack(
          builder:
              (
                BuildContext context,
                GoRouterState state,
                StatefulNavigationShell navigationShell,
              ) {
                return ParentShellScaffold(navigationShell: navigationShell);
              },
          branches: <StatefulShellBranch>[
            StatefulShellBranch(
              routes: <RouteBase>[
                GoRoute(
                  path: Routes.homeScreen,
                  pageBuilder: (BuildContext context, GoRouterState state) =>
                      MaterialPage<void>(
                        child: MultiBlocProvider(
                          providers: [
                            BlocProvider<HomeDashboardCubit>(
                              create: (_) =>
                                  getIt<HomeDashboardCubit>()..load(),
                            ),
                            BlocProvider<NotificationsCubit>(
                              create: (_) =>
                                  getIt<NotificationsCubit>()..load(),
                            ),
                          ],
                          child: const HomeScreen(),
                        ),
                      ),
                ),
              ],
            ),
            StatefulShellBranch(
              routes: <RouteBase>[
                GoRoute(
                  path: Routes.parentRequestsScreen,
                  pageBuilder: (BuildContext context, GoRouterState state) =>
                      MaterialPage<void>(
                        child: BlocProvider<ParentRequestsBloc>(
                          create: (_) =>
                              getIt<ParentRequestsBloc>()
                                ..add(const ParentRequestsEvent.loadData()),
                          child: const ParentRequestsScreen(),
                        ),
                      ),
                ),
              ],
            ),
            StatefulShellBranch(
              routes: <RouteBase>[
                GoRoute(
                  path: Routes.controlCenterScreen,
                  pageBuilder: (BuildContext context, GoRouterState state) =>
                      const MaterialPage<void>(child: ControlHomeScreen()),
                ),
              ],
            ),
            StatefulShellBranch(
              routes: <RouteBase>[
                GoRoute(
                  path: Routes.parentHomeScreen,
                  pageBuilder: (BuildContext context, GoRouterState state) =>
                      const MaterialPage<void>(child: ProfileScreen()),
                ),
              ],
            ),
          ],
        ),
        GoRoute(
          path: Routes.notificationsScreen,
          pageBuilder: (BuildContext context, GoRouterState state) =>
              MaterialPage<void>(
                child: BlocProvider<NotificationsCubit>(
                  create: (_) => getIt<NotificationsCubit>()..load(),
                  child: const NotificationsScreen(),
                ),
              ),
        ),
        GoRoute(
          path: Routes.parentKidsScreen,
          pageBuilder: (BuildContext context, GoRouterState state) =>
              MaterialPage<void>(
                child: BlocProvider<HomeDashboardCubit>(
                  create: (_) => getIt<HomeDashboardCubit>()..load(),
                  child: const ParentHomeScreen(),
                ),
              ),
        ),
        GoRoute(
          path: Routes.appSettingsScreen,
          pageBuilder: (BuildContext context, GoRouterState state) =>
              const MaterialPage<void>(child: AppSettingsScreen()),
        ),
        GoRoute(
          path: Routes.accountSettingsScreen,
          pageBuilder: (BuildContext context, GoRouterState state) =>
              const MaterialPage<void>(child: AccountSettingsScreen()),
        ),
        GoRoute(
          path: Routes.editPersonalInfoScreen,
          pageBuilder: (BuildContext context, GoRouterState state) =>
              const MaterialPage<void>(child: EditPersonalInfoScreen()),
        ),
        GoRoute(
          path: Routes.changePasswordScreen,
          pageBuilder: (BuildContext context, GoRouterState state) =>
              const MaterialPage<void>(child: ChangePasswordScreen()),
        ),
        GoRoute(
          path: Routes.contactUsScreen,
          pageBuilder: (BuildContext context, GoRouterState state) =>
              const MaterialPage<void>(child: ContactUsScreen()),
        ),
        GoRoute(
          path: Routes.helpScreen,
          pageBuilder: (BuildContext context, GoRouterState state) =>
              const MaterialPage<void>(child: HelpScreen()),
        ),
        GoRoute(
          path: Routes.aboutScreen,
          pageBuilder: (BuildContext context, GoRouterState state) =>
              const MaterialPage<void>(
                child: StaticInfoScreen(
                  title: HelpContent.aboutTitle,
                  body: HelpContent.aboutBody,
                ),
              ),
        ),
        GoRoute(
          path: Routes.privacyScreen,
          pageBuilder: (BuildContext context, GoRouterState state) =>
              const MaterialPage<void>(
                child: StaticInfoScreen(
                  title: HelpContent.privacyTitle,
                  body: HelpContent.privacyBody,
                ),
              ),
        ),
        GoRoute(
          path: Routes.faqScreen,
          pageBuilder: (BuildContext context, GoRouterState state) =>
              const MaterialPage<void>(child: FaqScreen()),
        ),
        GoRoute(
          path: Routes.languageScreen,
          pageBuilder: (BuildContext context, GoRouterState state) =>
              const MaterialPage<void>(child: LanguageScreen()),
        ),
        GoRoute(
          path: Routes.appearanceScreen,
          pageBuilder: (BuildContext context, GoRouterState state) =>
              const MaterialPage<void>(child: AppearanceScreen()),
        ),
        GoRoute(
          path: Routes.linkedDevicesScreen,
          pageBuilder: (BuildContext context, GoRouterState state) =>
              const MaterialPage<void>(child: LinkedDevicesScreen()),
        ),
        GoRoute(
          path: Routes.loginScreen,
          pageBuilder: (BuildContext context, GoRouterState state) =>
              MaterialPage<void>(
                child: BlocProvider<AuthCubit>(
                  create: (_) => getIt<AuthCubit>(),
                  child: const LoginScreen(),
                ),
              ),
        ),
        GoRoute(
          path: Routes.registerScreen,
          pageBuilder: (BuildContext context, GoRouterState state) =>
              MaterialPage<void>(
                child: BlocProvider<AuthCubit>(
                  create: (_) => getIt<AuthCubit>(),
                  child: const RegisterScreen(),
                ),
              ),
        ),
        GoRoute(
          path: Routes.otpVerificationScreen,
          pageBuilder: (BuildContext context, GoRouterState state) {
            final OtpVerificationType type =
                state.uri.queryParameters['type'] == 'email'
                ? OtpVerificationType.emailVerification
                : OtpVerificationType.passwordReset;
            return MaterialPage<void>(child: OtpVerificationScreen(type: type));
          },
        ),
        GoRoute(
          path: Routes.forgetPasswordScreen,
          pageBuilder: (BuildContext context, GoRouterState state) =>
              const MaterialPage<void>(child: ForgetPasswordScreen()),
        ),
        GoRoute(
          path: Routes.resetPasswordScreen,
          pageBuilder: (BuildContext context, GoRouterState state) =>
              const MaterialPage<void>(child: ResetPasswordScreen()),
        ),
        GoRoute(
          path: Routes.addChildScreen,
          pageBuilder: (BuildContext context, GoRouterState state) =>
              const MaterialPage<void>(child: AddChildScreen()),
        ),
        GoRoute(
          path: Routes.addNewChildScreen,
          pageBuilder: (BuildContext context, GoRouterState state) =>
              const MaterialPage<void>(child: AddNewChildScreen()),
        ),
        GoRoute(
          path: Routes.childHomeScreen,
          pageBuilder: (BuildContext context, GoRouterState state) =>
              MaterialPage<void>(
                child: BlocProvider<ChildHomeCubit>(
                  create: (_) => getIt<ChildHomeCubit>()..loadOverview(),
                  child: const ChildHomeScreen(),
                ),
              ),
        ),
        GoRoute(
          path: Routes.timeHubScreen,
          pageBuilder: (BuildContext context, GoRouterState state) =>
              const MaterialPage<void>(child: TimeHubScreen()),
        ),
        GoRoute(
          path: Routes.rulesHubScreen,
          pageBuilder: (BuildContext context, GoRouterState state) =>
              const MaterialPage<void>(child: RulesHubScreen()),
        ),
        GoRoute(
          path: Routes.contentHubScreen,
          pageBuilder: (BuildContext context, GoRouterState state) =>
              const MaterialPage<void>(child: ContentHubScreen()),
        ),
        GoRoute(
          path: Routes.libraryScreen,
          pageBuilder: (BuildContext context, GoRouterState state) {
            final ContentType type = ContentSeed.parseType(
              state.uri.queryParameters['type'],
            );
            return MaterialPage<void>(child: LibraryScreen(type: type));
          },
        ),
        GoRoute(
          path: Routes.detailsScreen,
          pageBuilder: (BuildContext context, GoRouterState state) =>
              MaterialPage<void>(
                child: DetailsScreen(
                  itemId: state.uri.queryParameters['id'] ?? '',
                ),
              ),
        ),
        GoRoute(
          path: Routes.readerScreen,
          pageBuilder: (BuildContext context, GoRouterState state) =>
              MaterialPage<void>(
                child: ReaderScreen(
                  itemId: state.uri.queryParameters['id'] ?? '',
                ),
              ),
        ),
        GoRoute(
          path: Routes.architectureScreen,
          pageBuilder: (BuildContext context, GoRouterState state) =>
              MaterialPage<void>(
                child: BlocProvider<ArchitectureCubit>(
                  create: (_) => getIt<ArchitectureCubit>()..loadOverview(),
                  child: const ArchitectureOverviewScreen(),
                ),
              ),
        ),
        GoRoute(
          path: Routes.devHubScreen,
          pageBuilder: (BuildContext context, GoRouterState state) =>
              const MaterialPage<void>(child: DevHubScreen()),
        ),
      ],
      errorBuilder: (BuildContext context, GoRouterState state) {
        return Scaffold(
          appBar: AppBar(title: const Text('Unknown route')),
          body: Center(
            child: Padding(
              padding: EdgeInsets.all(context.spacing.lg.r),
              child: Text(
                'No screen is registered for ${state.uri.toString()}.',
                textAlign: TextAlign.center,
              ),
            ),
          ),
        );
      },
    );
  }
}
