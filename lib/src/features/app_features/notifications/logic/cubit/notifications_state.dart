part of 'notifications_cubit.dart';

// ملاحظة: makeCollectionsUnmodifiable=false لأن مولّد freezed يُخرج
// `required final` لمعاملات القوائم وهو ما يرفضه المحلل الحالي.
@Freezed(makeCollectionsUnmodifiable: false)
class NotificationsState with _$NotificationsState {
  const factory NotificationsState.initial() = _Initial;
  const factory NotificationsState.loading() = NotificationsLoading;
  const factory NotificationsState.loaded({
    required List<NotificationItem> items,
    required NotificationFilter filter,
  }) = NotificationsLoaded;
  const factory NotificationsState.error(ApiErrorModel error) =
      NotificationsError;
}
