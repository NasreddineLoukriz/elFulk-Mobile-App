part of 'parent_requests_bloc.dart';

@freezed
class ParentRequestsEvent with _$ParentRequestsEvent {
  const factory ParentRequestsEvent.loadData() = ParentRequestsLoadDataEvent;
  const factory ParentRequestsEvent.createRequest(
    String childName,
    String requestType,
    String note,
  ) = ParentRequestsCreateRequestEvent;
  const factory ParentRequestsEvent.updateRequestStatus(
    String requestId,
    String status,
    String reviewNote,
  ) = ParentRequestsUpdateRequestStatusEvent;
  const factory ParentRequestsEvent.clearFeedback() =
      ParentRequestsClearFeedbackEvent;
}
