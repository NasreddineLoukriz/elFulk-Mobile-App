// GENERATED CODE - DO NOT MODIFY BY HAND
// coverage:ignore-file
// ignore_for_file: type=lint
// ignore_for_file: unused_element, deprecated_member_use, deprecated_member_use_from_same_package, use_function_type_syntax_for_parameters, unnecessary_const, avoid_init_to_null, invalid_override_different_default_values_named, prefer_expression_function_bodies, annotate_overrides, invalid_annotation_target, unnecessary_question_mark

part of 'parent_requests_bloc.dart';

// **************************************************************************
// FreezedGenerator
// **************************************************************************

// dart format off
T _$identity<T>(T value) => value;
/// @nodoc
mixin _$ParentRequestsEvent {





@override
bool operator ==(Object other) {
  return identical(this, other) || (other.runtimeType == runtimeType&&other is ParentRequestsEvent);
}


@override
int get hashCode => runtimeType.hashCode;

@override
String toString() {
  return 'ParentRequestsEvent()';
}


}

/// @nodoc
class $ParentRequestsEventCopyWith<$Res>  {
$ParentRequestsEventCopyWith(ParentRequestsEvent _, $Res Function(ParentRequestsEvent) __);
}


/// Adds pattern-matching-related methods to [ParentRequestsEvent].
extension ParentRequestsEventPatterns on ParentRequestsEvent {
/// A variant of `map` that fallback to returning `orElse`.
///
/// It is equivalent to doing:
/// ```dart
/// switch (sealedClass) {
///   case final Subclass value:
///     return ...;
///   case _:
///     return orElse();
/// }
/// ```

@optionalTypeArgs TResult maybeMap<TResult extends Object?>({TResult Function( ParentRequestsLoadDataEvent value)?  loadData,TResult Function( ParentRequestsCreateRequestEvent value)?  createRequest,TResult Function( ParentRequestsUpdateRequestStatusEvent value)?  updateRequestStatus,TResult Function( ParentRequestsClearFeedbackEvent value)?  clearFeedback,required TResult orElse(),}){
final _that = this;
switch (_that) {
case ParentRequestsLoadDataEvent() when loadData != null:
return loadData(_that);case ParentRequestsCreateRequestEvent() when createRequest != null:
return createRequest(_that);case ParentRequestsUpdateRequestStatusEvent() when updateRequestStatus != null:
return updateRequestStatus(_that);case ParentRequestsClearFeedbackEvent() when clearFeedback != null:
return clearFeedback(_that);case _:
  return orElse();

}
}
/// A `switch`-like method, using callbacks.
///
/// Callbacks receives the raw object, upcasted.
/// It is equivalent to doing:
/// ```dart
/// switch (sealedClass) {
///   case final Subclass value:
///     return ...;
///   case final Subclass2 value:
///     return ...;
/// }
/// ```

@optionalTypeArgs TResult map<TResult extends Object?>({required TResult Function( ParentRequestsLoadDataEvent value)  loadData,required TResult Function( ParentRequestsCreateRequestEvent value)  createRequest,required TResult Function( ParentRequestsUpdateRequestStatusEvent value)  updateRequestStatus,required TResult Function( ParentRequestsClearFeedbackEvent value)  clearFeedback,}){
final _that = this;
switch (_that) {
case ParentRequestsLoadDataEvent():
return loadData(_that);case ParentRequestsCreateRequestEvent():
return createRequest(_that);case ParentRequestsUpdateRequestStatusEvent():
return updateRequestStatus(_that);case ParentRequestsClearFeedbackEvent():
return clearFeedback(_that);case _:
  throw StateError('Unexpected subclass');

}
}
/// A variant of `map` that fallback to returning `null`.
///
/// It is equivalent to doing:
/// ```dart
/// switch (sealedClass) {
///   case final Subclass value:
///     return ...;
///   case _:
///     return null;
/// }
/// ```

@optionalTypeArgs TResult? mapOrNull<TResult extends Object?>({TResult? Function( ParentRequestsLoadDataEvent value)?  loadData,TResult? Function( ParentRequestsCreateRequestEvent value)?  createRequest,TResult? Function( ParentRequestsUpdateRequestStatusEvent value)?  updateRequestStatus,TResult? Function( ParentRequestsClearFeedbackEvent value)?  clearFeedback,}){
final _that = this;
switch (_that) {
case ParentRequestsLoadDataEvent() when loadData != null:
return loadData(_that);case ParentRequestsCreateRequestEvent() when createRequest != null:
return createRequest(_that);case ParentRequestsUpdateRequestStatusEvent() when updateRequestStatus != null:
return updateRequestStatus(_that);case ParentRequestsClearFeedbackEvent() when clearFeedback != null:
return clearFeedback(_that);case _:
  return null;

}
}
/// A variant of `when` that fallback to an `orElse` callback.
///
/// It is equivalent to doing:
/// ```dart
/// switch (sealedClass) {
///   case Subclass(:final field):
///     return ...;
///   case _:
///     return orElse();
/// }
/// ```

@optionalTypeArgs TResult maybeWhen<TResult extends Object?>({TResult Function()?  loadData,TResult Function( String childName,  String requestType,  String note)?  createRequest,TResult Function( String requestId,  String status,  String reviewNote)?  updateRequestStatus,TResult Function()?  clearFeedback,required TResult orElse(),}) {final _that = this;
switch (_that) {
case ParentRequestsLoadDataEvent() when loadData != null:
return loadData();case ParentRequestsCreateRequestEvent() when createRequest != null:
return createRequest(_that.childName,_that.requestType,_that.note);case ParentRequestsUpdateRequestStatusEvent() when updateRequestStatus != null:
return updateRequestStatus(_that.requestId,_that.status,_that.reviewNote);case ParentRequestsClearFeedbackEvent() when clearFeedback != null:
return clearFeedback();case _:
  return orElse();

}
}
/// A `switch`-like method, using callbacks.
///
/// As opposed to `map`, this offers destructuring.
/// It is equivalent to doing:
/// ```dart
/// switch (sealedClass) {
///   case Subclass(:final field):
///     return ...;
///   case Subclass2(:final field2):
///     return ...;
/// }
/// ```

@optionalTypeArgs TResult when<TResult extends Object?>({required TResult Function()  loadData,required TResult Function( String childName,  String requestType,  String note)  createRequest,required TResult Function( String requestId,  String status,  String reviewNote)  updateRequestStatus,required TResult Function()  clearFeedback,}) {final _that = this;
switch (_that) {
case ParentRequestsLoadDataEvent():
return loadData();case ParentRequestsCreateRequestEvent():
return createRequest(_that.childName,_that.requestType,_that.note);case ParentRequestsUpdateRequestStatusEvent():
return updateRequestStatus(_that.requestId,_that.status,_that.reviewNote);case ParentRequestsClearFeedbackEvent():
return clearFeedback();case _:
  throw StateError('Unexpected subclass');

}
}
/// A variant of `when` that fallback to returning `null`
///
/// It is equivalent to doing:
/// ```dart
/// switch (sealedClass) {
///   case Subclass(:final field):
///     return ...;
///   case _:
///     return null;
/// }
/// ```

@optionalTypeArgs TResult? whenOrNull<TResult extends Object?>({TResult? Function()?  loadData,TResult? Function( String childName,  String requestType,  String note)?  createRequest,TResult? Function( String requestId,  String status,  String reviewNote)?  updateRequestStatus,TResult? Function()?  clearFeedback,}) {final _that = this;
switch (_that) {
case ParentRequestsLoadDataEvent() when loadData != null:
return loadData();case ParentRequestsCreateRequestEvent() when createRequest != null:
return createRequest(_that.childName,_that.requestType,_that.note);case ParentRequestsUpdateRequestStatusEvent() when updateRequestStatus != null:
return updateRequestStatus(_that.requestId,_that.status,_that.reviewNote);case ParentRequestsClearFeedbackEvent() when clearFeedback != null:
return clearFeedback();case _:
  return null;

}
}

}

/// @nodoc


class ParentRequestsLoadDataEvent implements ParentRequestsEvent {
  const ParentRequestsLoadDataEvent();
  






@override
bool operator ==(Object other) {
  return identical(this, other) || (other.runtimeType == runtimeType&&other is ParentRequestsLoadDataEvent);
}


@override
int get hashCode => runtimeType.hashCode;

@override
String toString() {
  return 'ParentRequestsEvent.loadData()';
}


}




/// @nodoc


class ParentRequestsCreateRequestEvent implements ParentRequestsEvent {
  const ParentRequestsCreateRequestEvent(this.childName, this.requestType, this.note);
  

 final  String childName;
 final  String requestType;
 final  String note;

/// Create a copy of ParentRequestsEvent
/// with the given fields replaced by the non-null parameter values.
@JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
$ParentRequestsCreateRequestEventCopyWith<ParentRequestsCreateRequestEvent> get copyWith => _$ParentRequestsCreateRequestEventCopyWithImpl<ParentRequestsCreateRequestEvent>(this, _$identity);



@override
bool operator ==(Object other) {
  return identical(this, other) || (other.runtimeType == runtimeType&&other is ParentRequestsCreateRequestEvent&&(identical(other.childName, childName) || other.childName == childName)&&(identical(other.requestType, requestType) || other.requestType == requestType)&&(identical(other.note, note) || other.note == note));
}


@override
int get hashCode => Object.hash(runtimeType,childName,requestType,note);

@override
String toString() {
  return 'ParentRequestsEvent.createRequest(childName: $childName, requestType: $requestType, note: $note)';
}


}

/// @nodoc
abstract mixin class $ParentRequestsCreateRequestEventCopyWith<$Res> implements $ParentRequestsEventCopyWith<$Res> {
  factory $ParentRequestsCreateRequestEventCopyWith(ParentRequestsCreateRequestEvent value, $Res Function(ParentRequestsCreateRequestEvent) _then) = _$ParentRequestsCreateRequestEventCopyWithImpl;
@useResult
$Res call({
 String childName, String requestType, String note
});




}
/// @nodoc
class _$ParentRequestsCreateRequestEventCopyWithImpl<$Res>
    implements $ParentRequestsCreateRequestEventCopyWith<$Res> {
  _$ParentRequestsCreateRequestEventCopyWithImpl(this._self, this._then);

  final ParentRequestsCreateRequestEvent _self;
  final $Res Function(ParentRequestsCreateRequestEvent) _then;

/// Create a copy of ParentRequestsEvent
/// with the given fields replaced by the non-null parameter values.
@pragma('vm:prefer-inline') $Res call({Object? childName = null,Object? requestType = null,Object? note = null,}) {
  return _then(ParentRequestsCreateRequestEvent(
null == childName ? _self.childName : childName // ignore: cast_nullable_to_non_nullable
as String,null == requestType ? _self.requestType : requestType // ignore: cast_nullable_to_non_nullable
as String,null == note ? _self.note : note // ignore: cast_nullable_to_non_nullable
as String,
  ));
}


}

/// @nodoc


class ParentRequestsUpdateRequestStatusEvent implements ParentRequestsEvent {
  const ParentRequestsUpdateRequestStatusEvent(this.requestId, this.status, this.reviewNote);
  

 final  String requestId;
 final  String status;
 final  String reviewNote;

/// Create a copy of ParentRequestsEvent
/// with the given fields replaced by the non-null parameter values.
@JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
$ParentRequestsUpdateRequestStatusEventCopyWith<ParentRequestsUpdateRequestStatusEvent> get copyWith => _$ParentRequestsUpdateRequestStatusEventCopyWithImpl<ParentRequestsUpdateRequestStatusEvent>(this, _$identity);



@override
bool operator ==(Object other) {
  return identical(this, other) || (other.runtimeType == runtimeType&&other is ParentRequestsUpdateRequestStatusEvent&&(identical(other.requestId, requestId) || other.requestId == requestId)&&(identical(other.status, status) || other.status == status)&&(identical(other.reviewNote, reviewNote) || other.reviewNote == reviewNote));
}


@override
int get hashCode => Object.hash(runtimeType,requestId,status,reviewNote);

@override
String toString() {
  return 'ParentRequestsEvent.updateRequestStatus(requestId: $requestId, status: $status, reviewNote: $reviewNote)';
}


}

/// @nodoc
abstract mixin class $ParentRequestsUpdateRequestStatusEventCopyWith<$Res> implements $ParentRequestsEventCopyWith<$Res> {
  factory $ParentRequestsUpdateRequestStatusEventCopyWith(ParentRequestsUpdateRequestStatusEvent value, $Res Function(ParentRequestsUpdateRequestStatusEvent) _then) = _$ParentRequestsUpdateRequestStatusEventCopyWithImpl;
@useResult
$Res call({
 String requestId, String status, String reviewNote
});




}
/// @nodoc
class _$ParentRequestsUpdateRequestStatusEventCopyWithImpl<$Res>
    implements $ParentRequestsUpdateRequestStatusEventCopyWith<$Res> {
  _$ParentRequestsUpdateRequestStatusEventCopyWithImpl(this._self, this._then);

  final ParentRequestsUpdateRequestStatusEvent _self;
  final $Res Function(ParentRequestsUpdateRequestStatusEvent) _then;

/// Create a copy of ParentRequestsEvent
/// with the given fields replaced by the non-null parameter values.
@pragma('vm:prefer-inline') $Res call({Object? requestId = null,Object? status = null,Object? reviewNote = null,}) {
  return _then(ParentRequestsUpdateRequestStatusEvent(
null == requestId ? _self.requestId : requestId // ignore: cast_nullable_to_non_nullable
as String,null == status ? _self.status : status // ignore: cast_nullable_to_non_nullable
as String,null == reviewNote ? _self.reviewNote : reviewNote // ignore: cast_nullable_to_non_nullable
as String,
  ));
}


}

/// @nodoc


class ParentRequestsClearFeedbackEvent implements ParentRequestsEvent {
  const ParentRequestsClearFeedbackEvent();
  






@override
bool operator ==(Object other) {
  return identical(this, other) || (other.runtimeType == runtimeType&&other is ParentRequestsClearFeedbackEvent);
}


@override
int get hashCode => runtimeType.hashCode;

@override
String toString() {
  return 'ParentRequestsEvent.clearFeedback()';
}


}




/// @nodoc
mixin _$ParentRequestsState {





@override
bool operator ==(Object other) {
  return identical(this, other) || (other.runtimeType == runtimeType&&other is ParentRequestsState);
}


@override
int get hashCode => runtimeType.hashCode;

@override
String toString() {
  return 'ParentRequestsState()';
}


}

/// @nodoc
class $ParentRequestsStateCopyWith<$Res>  {
$ParentRequestsStateCopyWith(ParentRequestsState _, $Res Function(ParentRequestsState) __);
}


/// Adds pattern-matching-related methods to [ParentRequestsState].
extension ParentRequestsStatePatterns on ParentRequestsState {
/// A variant of `map` that fallback to returning `orElse`.
///
/// It is equivalent to doing:
/// ```dart
/// switch (sealedClass) {
///   case final Subclass value:
///     return ...;
///   case _:
///     return orElse();
/// }
/// ```

@optionalTypeArgs TResult maybeMap<TResult extends Object?>({TResult Function( _Initial value)?  initial,TResult Function( ParentRequestsLoading value)?  loading,TResult Function( ParentRequestsLoaded value)?  loaded,TResult Function( ParentRequestsError value)?  error,required TResult orElse(),}){
final _that = this;
switch (_that) {
case _Initial() when initial != null:
return initial(_that);case ParentRequestsLoading() when loading != null:
return loading(_that);case ParentRequestsLoaded() when loaded != null:
return loaded(_that);case ParentRequestsError() when error != null:
return error(_that);case _:
  return orElse();

}
}
/// A `switch`-like method, using callbacks.
///
/// Callbacks receives the raw object, upcasted.
/// It is equivalent to doing:
/// ```dart
/// switch (sealedClass) {
///   case final Subclass value:
///     return ...;
///   case final Subclass2 value:
///     return ...;
/// }
/// ```

@optionalTypeArgs TResult map<TResult extends Object?>({required TResult Function( _Initial value)  initial,required TResult Function( ParentRequestsLoading value)  loading,required TResult Function( ParentRequestsLoaded value)  loaded,required TResult Function( ParentRequestsError value)  error,}){
final _that = this;
switch (_that) {
case _Initial():
return initial(_that);case ParentRequestsLoading():
return loading(_that);case ParentRequestsLoaded():
return loaded(_that);case ParentRequestsError():
return error(_that);case _:
  throw StateError('Unexpected subclass');

}
}
/// A variant of `map` that fallback to returning `null`.
///
/// It is equivalent to doing:
/// ```dart
/// switch (sealedClass) {
///   case final Subclass value:
///     return ...;
///   case _:
///     return null;
/// }
/// ```

@optionalTypeArgs TResult? mapOrNull<TResult extends Object?>({TResult? Function( _Initial value)?  initial,TResult? Function( ParentRequestsLoading value)?  loading,TResult? Function( ParentRequestsLoaded value)?  loaded,TResult? Function( ParentRequestsError value)?  error,}){
final _that = this;
switch (_that) {
case _Initial() when initial != null:
return initial(_that);case ParentRequestsLoading() when loading != null:
return loading(_that);case ParentRequestsLoaded() when loaded != null:
return loaded(_that);case ParentRequestsError() when error != null:
return error(_that);case _:
  return null;

}
}
/// A variant of `when` that fallback to an `orElse` callback.
///
/// It is equivalent to doing:
/// ```dart
/// switch (sealedClass) {
///   case Subclass(:final field):
///     return ...;
///   case _:
///     return orElse();
/// }
/// ```

@optionalTypeArgs TResult maybeWhen<TResult extends Object?>({TResult Function()?  initial,TResult Function()?  loading,TResult Function( ParentRequestsOverviewViewModel overview,  bool isCreatingRequest,  bool isUpdatingRequest,  String? feedbackMessage)?  loaded,TResult Function( ApiErrorModel error)?  error,required TResult orElse(),}) {final _that = this;
switch (_that) {
case _Initial() when initial != null:
return initial();case ParentRequestsLoading() when loading != null:
return loading();case ParentRequestsLoaded() when loaded != null:
return loaded(_that.overview,_that.isCreatingRequest,_that.isUpdatingRequest,_that.feedbackMessage);case ParentRequestsError() when error != null:
return error(_that.error);case _:
  return orElse();

}
}
/// A `switch`-like method, using callbacks.
///
/// As opposed to `map`, this offers destructuring.
/// It is equivalent to doing:
/// ```dart
/// switch (sealedClass) {
///   case Subclass(:final field):
///     return ...;
///   case Subclass2(:final field2):
///     return ...;
/// }
/// ```

@optionalTypeArgs TResult when<TResult extends Object?>({required TResult Function()  initial,required TResult Function()  loading,required TResult Function( ParentRequestsOverviewViewModel overview,  bool isCreatingRequest,  bool isUpdatingRequest,  String? feedbackMessage)  loaded,required TResult Function( ApiErrorModel error)  error,}) {final _that = this;
switch (_that) {
case _Initial():
return initial();case ParentRequestsLoading():
return loading();case ParentRequestsLoaded():
return loaded(_that.overview,_that.isCreatingRequest,_that.isUpdatingRequest,_that.feedbackMessage);case ParentRequestsError():
return error(_that.error);case _:
  throw StateError('Unexpected subclass');

}
}
/// A variant of `when` that fallback to returning `null`
///
/// It is equivalent to doing:
/// ```dart
/// switch (sealedClass) {
///   case Subclass(:final field):
///     return ...;
///   case _:
///     return null;
/// }
/// ```

@optionalTypeArgs TResult? whenOrNull<TResult extends Object?>({TResult? Function()?  initial,TResult? Function()?  loading,TResult? Function( ParentRequestsOverviewViewModel overview,  bool isCreatingRequest,  bool isUpdatingRequest,  String? feedbackMessage)?  loaded,TResult? Function( ApiErrorModel error)?  error,}) {final _that = this;
switch (_that) {
case _Initial() when initial != null:
return initial();case ParentRequestsLoading() when loading != null:
return loading();case ParentRequestsLoaded() when loaded != null:
return loaded(_that.overview,_that.isCreatingRequest,_that.isUpdatingRequest,_that.feedbackMessage);case ParentRequestsError() when error != null:
return error(_that.error);case _:
  return null;

}
}

}

/// @nodoc


class _Initial implements ParentRequestsState {
  const _Initial();
  






@override
bool operator ==(Object other) {
  return identical(this, other) || (other.runtimeType == runtimeType&&other is _Initial);
}


@override
int get hashCode => runtimeType.hashCode;

@override
String toString() {
  return 'ParentRequestsState.initial()';
}


}




/// @nodoc


class ParentRequestsLoading implements ParentRequestsState {
  const ParentRequestsLoading();
  






@override
bool operator ==(Object other) {
  return identical(this, other) || (other.runtimeType == runtimeType&&other is ParentRequestsLoading);
}


@override
int get hashCode => runtimeType.hashCode;

@override
String toString() {
  return 'ParentRequestsState.loading()';
}


}




/// @nodoc


class ParentRequestsLoaded implements ParentRequestsState {
  const ParentRequestsLoaded({required this.overview, this.isCreatingRequest = false, this.isUpdatingRequest = false, this.feedbackMessage});
  

 final  ParentRequestsOverviewViewModel overview;
@JsonKey() final  bool isCreatingRequest;
@JsonKey() final  bool isUpdatingRequest;
 final  String? feedbackMessage;

/// Create a copy of ParentRequestsState
/// with the given fields replaced by the non-null parameter values.
@JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
$ParentRequestsLoadedCopyWith<ParentRequestsLoaded> get copyWith => _$ParentRequestsLoadedCopyWithImpl<ParentRequestsLoaded>(this, _$identity);



@override
bool operator ==(Object other) {
  return identical(this, other) || (other.runtimeType == runtimeType&&other is ParentRequestsLoaded&&(identical(other.overview, overview) || other.overview == overview)&&(identical(other.isCreatingRequest, isCreatingRequest) || other.isCreatingRequest == isCreatingRequest)&&(identical(other.isUpdatingRequest, isUpdatingRequest) || other.isUpdatingRequest == isUpdatingRequest)&&(identical(other.feedbackMessage, feedbackMessage) || other.feedbackMessage == feedbackMessage));
}


@override
int get hashCode => Object.hash(runtimeType,overview,isCreatingRequest,isUpdatingRequest,feedbackMessage);

@override
String toString() {
  return 'ParentRequestsState.loaded(overview: $overview, isCreatingRequest: $isCreatingRequest, isUpdatingRequest: $isUpdatingRequest, feedbackMessage: $feedbackMessage)';
}


}

/// @nodoc
abstract mixin class $ParentRequestsLoadedCopyWith<$Res> implements $ParentRequestsStateCopyWith<$Res> {
  factory $ParentRequestsLoadedCopyWith(ParentRequestsLoaded value, $Res Function(ParentRequestsLoaded) _then) = _$ParentRequestsLoadedCopyWithImpl;
@useResult
$Res call({
 ParentRequestsOverviewViewModel overview, bool isCreatingRequest, bool isUpdatingRequest, String? feedbackMessage
});




}
/// @nodoc
class _$ParentRequestsLoadedCopyWithImpl<$Res>
    implements $ParentRequestsLoadedCopyWith<$Res> {
  _$ParentRequestsLoadedCopyWithImpl(this._self, this._then);

  final ParentRequestsLoaded _self;
  final $Res Function(ParentRequestsLoaded) _then;

/// Create a copy of ParentRequestsState
/// with the given fields replaced by the non-null parameter values.
@pragma('vm:prefer-inline') $Res call({Object? overview = null,Object? isCreatingRequest = null,Object? isUpdatingRequest = null,Object? feedbackMessage = freezed,}) {
  return _then(ParentRequestsLoaded(
overview: null == overview ? _self.overview : overview // ignore: cast_nullable_to_non_nullable
as ParentRequestsOverviewViewModel,isCreatingRequest: null == isCreatingRequest ? _self.isCreatingRequest : isCreatingRequest // ignore: cast_nullable_to_non_nullable
as bool,isUpdatingRequest: null == isUpdatingRequest ? _self.isUpdatingRequest : isUpdatingRequest // ignore: cast_nullable_to_non_nullable
as bool,feedbackMessage: freezed == feedbackMessage ? _self.feedbackMessage : feedbackMessage // ignore: cast_nullable_to_non_nullable
as String?,
  ));
}


}

/// @nodoc


class ParentRequestsError implements ParentRequestsState {
  const ParentRequestsError(this.error);
  

 final  ApiErrorModel error;

/// Create a copy of ParentRequestsState
/// with the given fields replaced by the non-null parameter values.
@JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
$ParentRequestsErrorCopyWith<ParentRequestsError> get copyWith => _$ParentRequestsErrorCopyWithImpl<ParentRequestsError>(this, _$identity);



@override
bool operator ==(Object other) {
  return identical(this, other) || (other.runtimeType == runtimeType&&other is ParentRequestsError&&(identical(other.error, error) || other.error == error));
}


@override
int get hashCode => Object.hash(runtimeType,error);

@override
String toString() {
  return 'ParentRequestsState.error(error: $error)';
}


}

/// @nodoc
abstract mixin class $ParentRequestsErrorCopyWith<$Res> implements $ParentRequestsStateCopyWith<$Res> {
  factory $ParentRequestsErrorCopyWith(ParentRequestsError value, $Res Function(ParentRequestsError) _then) = _$ParentRequestsErrorCopyWithImpl;
@useResult
$Res call({
 ApiErrorModel error
});




}
/// @nodoc
class _$ParentRequestsErrorCopyWithImpl<$Res>
    implements $ParentRequestsErrorCopyWith<$Res> {
  _$ParentRequestsErrorCopyWithImpl(this._self, this._then);

  final ParentRequestsError _self;
  final $Res Function(ParentRequestsError) _then;

/// Create a copy of ParentRequestsState
/// with the given fields replaced by the non-null parameter values.
@pragma('vm:prefer-inline') $Res call({Object? error = null,}) {
  return _then(ParentRequestsError(
null == error ? _self.error : error // ignore: cast_nullable_to_non_nullable
as ApiErrorModel,
  ));
}


}

// dart format on
