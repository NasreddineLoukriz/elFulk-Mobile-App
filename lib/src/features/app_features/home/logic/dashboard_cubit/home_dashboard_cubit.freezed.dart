// GENERATED CODE - DO NOT MODIFY BY HAND
// coverage:ignore-file
// ignore_for_file: type=lint
// ignore_for_file: unused_element, deprecated_member_use, deprecated_member_use_from_same_package, use_function_type_syntax_for_parameters, unnecessary_const, avoid_init_to_null, invalid_override_different_default_values_named, prefer_expression_function_bodies, annotate_overrides, invalid_annotation_target, unnecessary_question_mark

part of 'home_dashboard_cubit.dart';

// **************************************************************************
// FreezedGenerator
// **************************************************************************

// dart format off
T _$identity<T>(T value) => value;
/// @nodoc
mixin _$HomeDashboardState {





@override
bool operator ==(Object other) {
  return identical(this, other) || (other.runtimeType == runtimeType&&other is HomeDashboardState);
}


@override
int get hashCode => runtimeType.hashCode;

@override
String toString() {
  return 'HomeDashboardState()';
}


}

/// @nodoc
class $HomeDashboardStateCopyWith<$Res>  {
$HomeDashboardStateCopyWith(HomeDashboardState _, $Res Function(HomeDashboardState) __);
}


/// Adds pattern-matching-related methods to [HomeDashboardState].
extension HomeDashboardStatePatterns on HomeDashboardState {
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

@optionalTypeArgs TResult maybeMap<TResult extends Object?>({TResult Function( _Initial value)?  initial,TResult Function( HomeDashboardLoading value)?  loading,TResult Function( HomeDashboardLoaded value)?  loaded,TResult Function( HomeDashboardError value)?  error,required TResult orElse(),}){
final _that = this;
switch (_that) {
case _Initial() when initial != null:
return initial(_that);case HomeDashboardLoading() when loading != null:
return loading(_that);case HomeDashboardLoaded() when loaded != null:
return loaded(_that);case HomeDashboardError() when error != null:
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

@optionalTypeArgs TResult map<TResult extends Object?>({required TResult Function( _Initial value)  initial,required TResult Function( HomeDashboardLoading value)  loading,required TResult Function( HomeDashboardLoaded value)  loaded,required TResult Function( HomeDashboardError value)  error,}){
final _that = this;
switch (_that) {
case _Initial():
return initial(_that);case HomeDashboardLoading():
return loading(_that);case HomeDashboardLoaded():
return loaded(_that);case HomeDashboardError():
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

@optionalTypeArgs TResult? mapOrNull<TResult extends Object?>({TResult? Function( _Initial value)?  initial,TResult? Function( HomeDashboardLoading value)?  loading,TResult? Function( HomeDashboardLoaded value)?  loaded,TResult? Function( HomeDashboardError value)?  error,}){
final _that = this;
switch (_that) {
case _Initial() when initial != null:
return initial(_that);case HomeDashboardLoading() when loading != null:
return loading(_that);case HomeDashboardLoaded() when loaded != null:
return loaded(_that);case HomeDashboardError() when error != null:
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

@optionalTypeArgs TResult maybeWhen<TResult extends Object?>({TResult Function()?  initial,TResult Function()?  loading,TResult Function( HomeDashboard dashboard)?  loaded,TResult Function( ApiErrorModel error)?  error,required TResult orElse(),}) {final _that = this;
switch (_that) {
case _Initial() when initial != null:
return initial();case HomeDashboardLoading() when loading != null:
return loading();case HomeDashboardLoaded() when loaded != null:
return loaded(_that.dashboard);case HomeDashboardError() when error != null:
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

@optionalTypeArgs TResult when<TResult extends Object?>({required TResult Function()  initial,required TResult Function()  loading,required TResult Function( HomeDashboard dashboard)  loaded,required TResult Function( ApiErrorModel error)  error,}) {final _that = this;
switch (_that) {
case _Initial():
return initial();case HomeDashboardLoading():
return loading();case HomeDashboardLoaded():
return loaded(_that.dashboard);case HomeDashboardError():
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

@optionalTypeArgs TResult? whenOrNull<TResult extends Object?>({TResult? Function()?  initial,TResult? Function()?  loading,TResult? Function( HomeDashboard dashboard)?  loaded,TResult? Function( ApiErrorModel error)?  error,}) {final _that = this;
switch (_that) {
case _Initial() when initial != null:
return initial();case HomeDashboardLoading() when loading != null:
return loading();case HomeDashboardLoaded() when loaded != null:
return loaded(_that.dashboard);case HomeDashboardError() when error != null:
return error(_that.error);case _:
  return null;

}
}

}

/// @nodoc


class _Initial implements HomeDashboardState {
  const _Initial();
  






@override
bool operator ==(Object other) {
  return identical(this, other) || (other.runtimeType == runtimeType&&other is _Initial);
}


@override
int get hashCode => runtimeType.hashCode;

@override
String toString() {
  return 'HomeDashboardState.initial()';
}


}




/// @nodoc


class HomeDashboardLoading implements HomeDashboardState {
  const HomeDashboardLoading();
  






@override
bool operator ==(Object other) {
  return identical(this, other) || (other.runtimeType == runtimeType&&other is HomeDashboardLoading);
}


@override
int get hashCode => runtimeType.hashCode;

@override
String toString() {
  return 'HomeDashboardState.loading()';
}


}




/// @nodoc


class HomeDashboardLoaded implements HomeDashboardState {
  const HomeDashboardLoaded(this.dashboard);
  

 final  HomeDashboard dashboard;

/// Create a copy of HomeDashboardState
/// with the given fields replaced by the non-null parameter values.
@JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
$HomeDashboardLoadedCopyWith<HomeDashboardLoaded> get copyWith => _$HomeDashboardLoadedCopyWithImpl<HomeDashboardLoaded>(this, _$identity);



@override
bool operator ==(Object other) {
  return identical(this, other) || (other.runtimeType == runtimeType&&other is HomeDashboardLoaded&&(identical(other.dashboard, dashboard) || other.dashboard == dashboard));
}


@override
int get hashCode => Object.hash(runtimeType,dashboard);

@override
String toString() {
  return 'HomeDashboardState.loaded(dashboard: $dashboard)';
}


}

/// @nodoc
abstract mixin class $HomeDashboardLoadedCopyWith<$Res> implements $HomeDashboardStateCopyWith<$Res> {
  factory $HomeDashboardLoadedCopyWith(HomeDashboardLoaded value, $Res Function(HomeDashboardLoaded) _then) = _$HomeDashboardLoadedCopyWithImpl;
@useResult
$Res call({
 HomeDashboard dashboard
});




}
/// @nodoc
class _$HomeDashboardLoadedCopyWithImpl<$Res>
    implements $HomeDashboardLoadedCopyWith<$Res> {
  _$HomeDashboardLoadedCopyWithImpl(this._self, this._then);

  final HomeDashboardLoaded _self;
  final $Res Function(HomeDashboardLoaded) _then;

/// Create a copy of HomeDashboardState
/// with the given fields replaced by the non-null parameter values.
@pragma('vm:prefer-inline') $Res call({Object? dashboard = null,}) {
  return _then(HomeDashboardLoaded(
null == dashboard ? _self.dashboard : dashboard // ignore: cast_nullable_to_non_nullable
as HomeDashboard,
  ));
}


}

/// @nodoc


class HomeDashboardError implements HomeDashboardState {
  const HomeDashboardError(this.error);
  

 final  ApiErrorModel error;

/// Create a copy of HomeDashboardState
/// with the given fields replaced by the non-null parameter values.
@JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
$HomeDashboardErrorCopyWith<HomeDashboardError> get copyWith => _$HomeDashboardErrorCopyWithImpl<HomeDashboardError>(this, _$identity);



@override
bool operator ==(Object other) {
  return identical(this, other) || (other.runtimeType == runtimeType&&other is HomeDashboardError&&(identical(other.error, error) || other.error == error));
}


@override
int get hashCode => Object.hash(runtimeType,error);

@override
String toString() {
  return 'HomeDashboardState.error(error: $error)';
}


}

/// @nodoc
abstract mixin class $HomeDashboardErrorCopyWith<$Res> implements $HomeDashboardStateCopyWith<$Res> {
  factory $HomeDashboardErrorCopyWith(HomeDashboardError value, $Res Function(HomeDashboardError) _then) = _$HomeDashboardErrorCopyWithImpl;
@useResult
$Res call({
 ApiErrorModel error
});




}
/// @nodoc
class _$HomeDashboardErrorCopyWithImpl<$Res>
    implements $HomeDashboardErrorCopyWith<$Res> {
  _$HomeDashboardErrorCopyWithImpl(this._self, this._then);

  final HomeDashboardError _self;
  final $Res Function(HomeDashboardError) _then;

/// Create a copy of HomeDashboardState
/// with the given fields replaced by the non-null parameter values.
@pragma('vm:prefer-inline') $Res call({Object? error = null,}) {
  return _then(HomeDashboardError(
null == error ? _self.error : error // ignore: cast_nullable_to_non_nullable
as ApiErrorModel,
  ));
}


}

// dart format on
