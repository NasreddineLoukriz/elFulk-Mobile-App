import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

import 'package:elfulk/src/core/widgets/app_section_card.dart';
import 'package:elfulk/src/features/parent_features/parent_requests/data/view_models/parent_requests_overview_view_model.dart';
import 'package:elfulk/src/features/parent_features/parent_requests/logic/bloc/parent_requests_bloc.dart';

class ParentRequestsScreen extends StatelessWidget {
  const ParentRequestsScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<ParentRequestsBloc, ParentRequestsState>(
      builder: (BuildContext context, ParentRequestsState state) {
        return state.when(
          initial: () => const _ParentRequestsLoadingView(),
          loading: () => const _ParentRequestsLoadingView(),
          loaded:
              (
                ParentRequestsOverviewViewModel overview,
                bool isCreatingRequest,
                bool isUpdatingRequest,
                String? feedbackMessage,
              ) => _ParentRequestsLoadedView(
                overview: overview,
                isCreatingRequest: isCreatingRequest,
                isUpdatingRequest: isUpdatingRequest,
                feedbackMessage: feedbackMessage,
              ),
          error: (error) => _ParentRequestsErrorView(message: error.detail),
        );
      },
    );
  }
}

class _ParentRequestsLoadedView extends StatelessWidget {
  const _ParentRequestsLoadedView({
    required this.overview,
    required this.isCreatingRequest,
    required this.isUpdatingRequest,
    required this.feedbackMessage,
  });

  final ParentRequestsOverviewViewModel overview;
  final bool isCreatingRequest;
  final bool isUpdatingRequest;
  final String? feedbackMessage;

  @override
  Widget build(BuildContext context) {
    final ThemeData theme = Theme.of(context);
    final bool isBusy = isCreatingRequest || isUpdatingRequest;

    return Scaffold(
      appBar: AppBar(
        title: const Text('Parent Requests'),
        actions: <Widget>[
          IconButton(
            onPressed: isBusy
                ? null
                : () {
                    context.read<ParentRequestsBloc>().add(
                      const ParentRequestsEvent.loadData(),
                    );
                  },
            icon: const Icon(Icons.refresh),
            tooltip: 'Reload GET example',
          ),
        ],
      ),
      body: ListView(
        padding: EdgeInsets.all(20.r),
        children: <Widget>[
          if (feedbackMessage != null) ...<Widget>[
            AppSectionCard(
              eyebrow: 'Mutation result',
              title: feedbackMessage!,
              accentColor: const Color(0xFF0F766E),
              child: Align(
                alignment: Alignment.centerLeft,
                child: TextButton(
                  onPressed: () {
                    context.read<ParentRequestsBloc>().add(
                      const ParentRequestsEvent.clearFeedback(),
                    );
                  },
                  child: const Text('Dismiss message'),
                ),
              ),
            ),
            SizedBox(height: 20.h),
          ],
          AppSectionCard(
            eyebrow: 'Bloc Example',
            title: overview.title,
            accentColor: const Color(0xFF1D4ED8),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: <Widget>[
                Text(overview.summary, style: theme.textTheme.bodyLarge),
                SizedBox(height: 16.h),
                Wrap(
                  spacing: 10,
                  runSpacing: 10,
                  children: <Widget>[
                    _InfoChip(label: 'Base URL', value: overview.baseUrl),
                    _InfoChip(label: 'GET', value: overview.endpoint),
                    _InfoChip(label: 'POST', value: overview.postEndpoint),
                    _InfoChip(
                      label: 'PATCH',
                      value: overview.patchEndpointTemplate,
                    ),
                  ],
                ),
                SizedBox(height: 16.h),
                Text(
                  'Event flow: ParentRequestsBloc -> ParentRequestsRepository -> ParentApiService -> DioFactory -> DummyApiInterceptor',
                  style: theme.textTheme.bodyMedium,
                ),
              ],
            ),
          ),
          SizedBox(height: 20.h),
          AppSectionCard(
            eyebrow: 'Bloc Events',
            title: 'Why this screen uses Bloc instead of Cubit',
            accentColor: const Color(0xFF7C3AED),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: overview.recommendedEvents
                  .map(
                    (String eventLabel) => Padding(
                      padding: EdgeInsets.only(bottom: 12.h),
                      child: Row(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: <Widget>[
                          Container(
                            width: 8.w,
                            height: 8.w,
                            margin: EdgeInsets.only(top: 7.h),
                            decoration: const BoxDecoration(
                              color: Color(0xFF7C3AED),
                              shape: BoxShape.circle,
                            ),
                          ),
                          SizedBox(width: 12.w),
                          Expanded(
                            child: Text(
                              eventLabel,
                              style: theme.textTheme.bodyLarge,
                            ),
                          ),
                        ],
                      ),
                    ),
                  )
                  .toList(),
            ),
          ),
          SizedBox(height: 20.h),
          AppSectionCard(
            eyebrow: 'POST Example',
            title: 'Create a dummy parent request',
            accentColor: const Color(0xFF0F766E),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: <Widget>[
                Text(
                  'The button below dispatches a create intent and the Bloc builds the request model before calling the repository.',
                  style: theme.textTheme.bodyLarge,
                ),
                SizedBox(height: 16.h),
                FilledButton.tonal(
                  onPressed: isBusy
                      ? null
                      : () {
                          context.read<ParentRequestsBloc>().add(
                            ParentRequestsEvent.createRequest(
                              'Mariam',
                              'Lesson extension',
                              'Created from the parent Bloc example to exercise POST and refresh.',
                            ),
                          );
                        },
                  child: Text(
                    isCreatingRequest
                        ? 'Creating request...'
                        : 'Create dummy POST request',
                  ),
                ),
              ],
            ),
          ),
          SizedBox(height: 20.h),
          AppSectionCard(
            eyebrow: 'PATCH Example',
            title: 'Approve or inspect pending requests',
            accentColor: const Color(0xFFB7791F),
            child: Column(
              children: overview.requests
                  .map(
                    (ParentRequestItemViewModel request) =>
                        _ParentRequestTile(request: request, isBusy: isBusy),
                  )
                  .toList(),
            ),
          ),
        ],
      ),
    );
  }
}

class _ParentRequestTile extends StatelessWidget {
  const _ParentRequestTile({required this.request, required this.isBusy});

  final ParentRequestItemViewModel request;
  final bool isBusy;

  @override
  Widget build(BuildContext context) {
    final ThemeData theme = Theme.of(context);
    final bool canApprove = request.status == 'pending' && !isBusy;

    return Container(
      width: double.infinity,
      margin: EdgeInsets.only(bottom: 14.h),
      padding: EdgeInsets.all(18.r),
      decoration: BoxDecoration(
        color: const Color(0xFFFAF8F3),
        borderRadius: BorderRadius.circular(22.r),
        border: Border.all(color: const Color(0xFFE0D7C8)),
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: <Widget>[
          Wrap(
            spacing: 10,
            runSpacing: 10,
            children: <Widget>[
              _InfoChip(label: 'ID', value: request.id),
              _InfoChip(label: 'Child', value: request.childName),
              _InfoChip(label: 'Status', value: request.status),
            ],
          ),
          SizedBox(height: 12.h),
          Text(
            request.requestType,
            style: theme.textTheme.titleMedium?.copyWith(
              fontWeight: FontWeight.w700,
            ),
          ),
          SizedBox(height: 8.h),
          Text(request.note, style: theme.textTheme.bodyLarge),
          SizedBox(height: 8.h),
          Text(
            'Requested at ${request.requestedAt}',
            style: theme.textTheme.bodyMedium,
          ),
          SizedBox(height: 16.h),
          FilledButton.tonal(
            onPressed: canApprove
                ? () {
                    context.read<ParentRequestsBloc>().add(
                      ParentRequestsEvent.updateRequestStatus(
                        request.id,
                        'approved',
                        'Approved from the parent Bloc example using a PATCH request model.',
                      ),
                    );
                  }
                : null,
            child: Text(
              request.status == 'pending'
                  ? 'Approve via PATCH'
                  : 'Already ${request.status}',
            ),
          ),
        ],
      ),
    );
  }
}

class _ParentRequestsLoadingView extends StatelessWidget {
  const _ParentRequestsLoadingView();

  @override
  Widget build(BuildContext context) {
    return const Scaffold(body: Center(child: CircularProgressIndicator()));
  }
}

class _ParentRequestsErrorView extends StatelessWidget {
  const _ParentRequestsErrorView({required this.message});

  final String message;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text('Parent Requests')),
      body: Center(
        child: Padding(
          padding: EdgeInsets.all(24.r),
          child: Text(message, textAlign: TextAlign.center),
        ),
      ),
    );
  }
}

class _InfoChip extends StatelessWidget {
  const _InfoChip({required this.label, required this.value});

  final String label;
  final String value;

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: EdgeInsets.symmetric(horizontal: 12.w, vertical: 8.h),
      decoration: BoxDecoration(
        color: const Color(0xFFF0F7F5),
        borderRadius: BorderRadius.circular(999.r),
      ),
      child: Text('$label: $value'),
    );
  }
}
