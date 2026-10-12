// GENERATED CODE - DO NOT MODIFY BY HAND
// coverage:ignore-file
// ignore_for_file: type=lint
// ignore_for_file: unused_element, deprecated_member_use, deprecated_member_use_from_same_package, use_function_type_syntax_for_parameters, unnecessary_const, avoid_init_to_null, invalid_override_different_default_values_named, prefer_expression_function_bodies, annotate_overrides, invalid_annotation_target, unnecessary_question_mark

part of 'notifications_cubit.dart';

// **************************************************************************
// FreezedGenerator
// **************************************************************************

// dart format off
T _$identity<T>(T value) => value;
/// @nodoc
mixin _$NotificationsState {





@override
bool operator ==(Object other) {
  return identical(this, other) || (other.runtimeType == runtimeType&&other is NotificationsState);
}


@override
int get hashCode => runtimeType.hashCode;

@override
String toString() {
  return 'NotificationsState()';
}


}

/// @nodoc
class $NotificationsStateCopyWith<$Res>  {
$NotificationsStateCopyWith(NotificationsState _, $Res Function(NotificationsState) __);
}


/// Adds pattern-matching-related methods to [NotificationsState].
extension NotificationsStatePatterns on NotificationsState {
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

@optionalTypeArgs TResult maybeMap<TResult extends Object?>({TResult Function( _Initial value)?  initial,TResult Function( NotificationsLoading value)?  loading,TResult Function( NotificationsLoaded value)?  loaded,TResult Function( NotificationsError value)?  error,required TResult orElse(),}){
final _that = this;
switch (_that) {
case _Initial() when initial != null:
return initial(_that);case NotificationsLoading() when loading != null:
return loading(_that);case NotificationsLoaded() when loaded != null:
return loaded(_that);case NotificationsError() when error != null:
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

@optionalTypeArgs TResult map<TResult extends Object?>({required TResult Function( _Initial value)  initial,required TResult Function( NotificationsLoading value)  loading,required TResult Function( NotificationsLoaded value)  loaded,required TResult Function( NotificationsError value)  error,}){
final _that = this;
switch (_that) {
case _Initial():
return initial(_that);case NotificationsLoading():
return loading(_that);case NotificationsLoaded():
return loaded(_that);case NotificationsError():
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

@optionalTypeArgs TResult? mapOrNull<TResult extends Object?>({TResult? Function( _Initial value)?  initial,TResult? Function( NotificationsLoading value)?  loading,TResult? Function( NotificationsLoaded value)?  loaded,TResult? Function( NotificationsError value)?  error,}){
final _that = this;
switch (_that) {
case _Initial() when initial != null:
return initial(_that);case NotificationsLoading() when loading != null:
return loading(_that);case NotificationsLoaded() when loaded != null:
return loaded(_that);case NotificationsError() when error != null:
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

@optionalTypeArgs TResult maybeWhen<TResult extends Object?>({TResult Function()?  initial,TResult Function()?  loading,TResult Function( List<NotificationItem> items,  NotificationFilter filter)?  loaded,TResult Function( ApiErrorModel error)?  error,required TResult orElse(),}) {final _that = this;
switch (_that) {
case _Initial() when initial != null:
return initial();case NotificationsLoading() when loading != null:
return loading();case NotificationsLoaded() when loaded != null:
return loaded(_that.items,_that.filter);case NotificationsError() when error != null:
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

@optionalTypeArgs TResult when<TResult extends Object?>({required TResult Function()  initial,required TResult Function()  loading,required TResult Function( List<NotificationItem> items,  NotificationFilter filter)  loaded,required TResult Function( ApiErrorModel error)  error,}) {final _that = this;
switch (_that) {
case _Initial():
return initial();case NotificationsLoading():
return loading();case NotificationsLoaded():
return loaded(_that.items,_that.filter);case NotificationsError():
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

@optionalTypeArgs TResult? whenOrNull<TResult extends Object?>({TResult? Function()?  initial,TResult? Function()?  loading,TResult? Function( List<NotificationItem> items,  NotificationFilter filter)?  loaded,TResult? Function( ApiErrorModel error)?  error,}) {final _that = this;
switch (_that) {
case _Initial() when initial != null:
return initial();case NotificationsLoading() when loading != null:
return loading();case NotificationsLoaded() when loaded != null:
return loaded(_that.items,_that.filter);case NotificationsError() when error != null:
return error(_that.error);case _:
  return null;

}
}

}

/// @nodoc


class _Initial implements NotificationsState {
  const _Initial();
  






@override
bool operator ==(Object other) {
  return identical(this, other) || (other.runtimeType == runtimeType&&other is _Initial);
}


@override
int get hashCode => runtimeType.hashCode;

@override
String toString() {
  return 'NotificationsState.initial()';
}


}




/// @nodoc


class NotificationsLoading implements NotificationsState {
  const NotificationsLoading();
  






@override
bool operator ==(Object other) {
  return identical(this, other) || (other.runtimeType == runtimeType&&other is NotificationsLoading);
}


@override
int get hashCode => runtimeType.hashCode;

@override
String toString() {
  return 'NotificationsState.loading()';
}


}




/// @nodoc


class NotificationsLoaded implements NotificationsState {
  const NotificationsLoaded({required this.items, required this.filter});
  

 final  List<NotificationItem> items;
 final  NotificationFilter filter;

/// Create a copy of NotificationsState
/// with the given fields replaced by the non-null parameter values.
@JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
$NotificationsLoadedCopyWith<NotificationsLoaded> get copyWith => _$NotificationsLoadedCopyWithImpl<NotificationsLoaded>(this, _$identity);



@override
bool operator ==(Object other) {
  return identical(this, other) || (other.runtimeType == runtimeType&&other is NotificationsLoaded&&const DeepCollectionEquality().equals(other.items, items)&&(identical(other.filter, filter) || other.filter == filter));
}


@override
int get hashCode => Object.hash(runtimeType,const DeepCollectionEquality().hash(items),filter);

@override
String toString() {
  return 'NotificationsState.loaded(items: $items, filter: $filter)';
}


}

/// @nodoc
abstract mixin class $NotificationsLoadedCopyWith<$Res> implements $NotificationsStateCopyWith<$Res> {
  factory $NotificationsLoadedCopyWith(NotificationsLoaded value, $Res Function(NotificationsLoaded) _then) = _$NotificationsLoadedCopyWithImpl;
@useResult
$Res call({
 List<NotificationItem> items, NotificationFilter filter
});




}
/// @nodoc
class _$NotificationsLoadedCopyWithImpl<$Res>
    implements $NotificationsLoadedCopyWith<$Res> {
  _$NotificationsLoadedCopyWithImpl(this._self, this._then);

  final NotificationsLoaded _self;
  final $Res Function(NotificationsLoaded) _then;

/// Create a copy of NotificationsState
/// with the given fields replaced by the non-null parameter values.
@pragma('vm:prefer-inline') $Res call({Object? items = null,Object? filter = null,}) {
  return _then(NotificationsLoaded(
items: null == items ? _self.items : items // ignore: cast_nullable_to_non_nullable
as List<NotificationItem>,filter: null == filter ? _self.filter : filter // ignore: cast_nullable_to_non_nullable
as NotificationFilter,
  ));
}


}

/// @nodoc


class NotificationsError implements NotificationsState {
  const NotificationsError(this.error);
  

 final  ApiErrorModel error;

/// Create a copy of NotificationsState
/// with the given fields replaced by the non-null parameter values.
@JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
$NotificationsErrorCopyWith<NotificationsError> get copyWith => _$NotificationsErrorCopyWithImpl<NotificationsError>(this, _$identity);



@override
bool operator ==(Object other) {
  return identical(this, other) || (other.runtimeType == runtimeType&&other is NotificationsError&&(identical(other.error, error) || other.error == error));
}


@override
int get hashCode => Object.hash(runtimeType,error);

@override
String toString() {
  return 'NotificationsState.error(error: $error)';
}


}

/// @nodoc
abstract mixin class $NotificationsErrorCopyWith<$Res> implements $NotificationsStateCopyWith<$Res> {
  factory $NotificationsErrorCopyWith(NotificationsError value, $Res Function(NotificationsError) _then) = _$NotificationsErrorCopyWithImpl;
@useResult
$Res call({
 ApiErrorModel error
});




}
/// @nodoc
class _$NotificationsErrorCopyWithImpl<$Res>
    implements $NotificationsErrorCopyWith<$Res> {
  _$NotificationsErrorCopyWithImpl(this._self, this._then);

  final NotificationsError _self;
  final $Res Function(NotificationsError) _then;

/// Create a copy of NotificationsState
/// with the given fields replaced by the non-null parameter values.
@pragma('vm:prefer-inline') $Res call({Object? error = null,}) {
  return _then(NotificationsError(
null == error ? _self.error : error // ignore: cast_nullable_to_non_nullable
as ApiErrorModel,
  ));
}


}

// dart format on
