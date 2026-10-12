import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:freezed_annotation/freezed_annotation.dart';

import 'package:elfulk/src/core/networking/error/api_error_model.dart';
import 'package:elfulk/src/core/networking/helper/api_result.dart';
import 'package:elfulk/src/features/app_features/notifications/data/models/notification_item.dart';
import 'package:elfulk/src/features/app_features/notifications/data/repos/notifications_repository.dart';

part 'notifications_cubit.freezed.dart';
part 'notifications_state.dart';

/// يدير قائمة الإشعارات: التحميل والفلترة والتجاهل (الحالة يملكها هنا).
class NotificationsCubit extends Cubit<NotificationsState> {
  NotificationsCubit(this._repository)
    : super(const NotificationsState.initial());

  final NotificationsRepository _repository;
  List<NotificationItem> _all = const <NotificationItem>[];
  NotificationFilter _filter = NotificationFilter.all;

  Future<void> load() async {
    emit(const NotificationsState.loading());

    final ApiResult<List<NotificationItem>> result = await _repository
        .fetchNotifications();
    result.when(
      success: (List<NotificationItem> items) {
        _all = items;
        emit(NotificationsState.loaded(items: _visible(), filter: _filter));
      },
      failure: (ApiErrorModel error) => emit(NotificationsState.error(error)),
    );
  }

  /// تغيير فلتر العرض (يبقي كل العناصر مخزنة).
  void selectFilter(NotificationFilter filter) {
    _filter = filter;
    state.maybeWhen(
      loaded: (_, _) =>
          emit(NotificationsState.loaded(items: _visible(), filter: _filter)),
      orElse: () {},
    );
  }

  /// تجاهل بطاقة (إزالتها من القائمة المعروضة).
  void dismiss(String id) {
    _all = _all.where((NotificationItem i) => i.id != id).toList();
    state.maybeWhen(
      loaded: (_, _) =>
          emit(NotificationsState.loaded(items: _visible(), filter: _filter)),
      orElse: () {},
    );
  }

  List<NotificationItem> _visible() => _all.where(_filter.matches).toList();
}
