// GENERATED CODE - DO NOT MODIFY BY HAND
// coverage:ignore-file
// ignore_for_file: type=lint
// ignore_for_file: unused_element, deprecated_member_use, deprecated_member_use_from_same_package, use_function_type_syntax_for_parameters, unnecessary_const, avoid_init_to_null, invalid_override_different_default_values_named, prefer_expression_function_bodies, annotate_overrides, invalid_annotation_target, unnecessary_question_mark

part of 'child_home_cubit.dart';

// **************************************************************************
// FreezedGenerator
// **************************************************************************

// dart format off
T _$identity<T>(T value) => value;
/// @nodoc
mixin _$ChildHomeState {





@override
bool operator ==(Object other) {
  return identical(this, other) || (other.runtimeType == runtimeType&&other is ChildHomeState);
}


@override
int get hashCode => runtimeType.hashCode;

@override
String toString() {
  return 'ChildHomeState()';
}


}

/// @nodoc
class $ChildHomeStateCopyWith<$Res>  {
$ChildHomeStateCopyWith(ChildHomeState _, $Res Function(ChildHomeState) __);
}


/// Adds pattern-matching-related methods to [ChildHomeState].
extension ChildHomeStatePatterns on ChildHomeState {
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

@optionalTypeArgs TResult maybeMap<TResult extends Object?>({TResult Function( _Initial value)?  initial,TResult Function( ChildHomeLoading value)?  loading,TResult Function( ChildHomeLoaded value)?  loaded,TResult Function( ChildHomeError value)?  error,required TResult orElse(),}){
final _that = this;
switch (_that) {
case _Initial() when initial != null:
return initial(_that);case ChildHomeLoading() when loading != null:
return loading(_that);case ChildHomeLoaded() when loaded != null:
return loaded(_that);case ChildHomeError() when error != null:
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

@optionalTypeArgs TResult map<TResult extends Object?>({required TResult Function( _Initial value)  initial,required TResult Function( ChildHomeLoading value)  loading,required TResult Function( ChildHomeLoaded value)  loaded,required TResult Function( ChildHomeError value)  error,}){
final _that = this;
switch (_that) {
case _Initial():
return initial(_that);case ChildHomeLoading():
return loading(_that);case ChildHomeLoaded():
return loaded(_that);case ChildHomeError():
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

@optionalTypeArgs TResult? mapOrNull<TResult extends Object?>({TResult? Function( _Initial value)?  initial,TResult? Function( ChildHomeLoading value)?  loading,TResult? Function( ChildHomeLoaded value)?  loaded,TResult? Function( ChildHomeError value)?  error,}){
final _that = this;
switch (_that) {
case _Initial() when initial != null:
return initial(_that);case ChildHomeLoading() when loading != null:
return loading(_that);case ChildHomeLoaded() when loaded != null:
return loaded(_that);case ChildHomeError() when error != null:
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

@optionalTypeArgs TResult maybeWhen<TResult extends Object?>({TResult Function()?  initial,TResult Function()?  loading,TResult Function( ChildHomeOverviewViewModel overview)?  loaded,TResult Function( ApiErrorModel error)?  error,required TResult orElse(),}) {final _that = this;
switch (_that) {
case _Initial() when initial != null:
return initial();case ChildHomeLoading() when loading != null:
return loading();case ChildHomeLoaded() when loaded != null:
return loaded(_that.overview);case ChildHomeError() when error != null:
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

@optionalTypeArgs TResult when<TResult extends Object?>({required TResult Function()  initial,required TResult Function()  loading,required TResult Function( ChildHomeOverviewViewModel overview)  loaded,required TResult Function( ApiErrorModel error)  error,}) {final _that = this;
switch (_that) {
case _Initial():
return initial();case ChildHomeLoading():
return loading();case ChildHomeLoaded():
return loaded(_that.overview);case ChildHomeError():
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

@optionalTypeArgs TResult? whenOrNull<TResult extends Object?>({TResult? Function()?  initial,TResult? Function()?  loading,TResult? Function( ChildHomeOverviewViewModel overview)?  loaded,TResult? Function( ApiErrorModel error)?  error,}) {final _that = this;
switch (_that) {
case _Initial() when initial != null:
return initial();case ChildHomeLoading() when loading != null:
return loading();case ChildHomeLoaded() when loaded != null:
return loaded(_that.overview);case ChildHomeError() when error != null:
return error(_that.error);case _:
  return null;

}
}

}

/// @nodoc


class _Initial implements ChildHomeState {
  const _Initial();
  






@override
bool operator ==(Object other) {
  return identical(this, other) || (other.runtimeType == runtimeType&&other is _Initial);
}


@override
int get hashCode => runtimeType.hashCode;

@override
String toString() {
  return 'ChildHomeState.initial()';
}


}




/// @nodoc


class ChildHomeLoading implements ChildHomeState {
  const ChildHomeLoading();
  






@override
bool operator ==(Object other) {
  return identical(this, other) || (other.runtimeType == runtimeType&&other is ChildHomeLoading);
}


@override
int get hashCode => runtimeType.hashCode;

@override
String toString() {
  return 'ChildHomeState.loading()';
}


}




/// @nodoc


class ChildHomeLoaded implements ChildHomeState {
  const ChildHomeLoaded(this.overview);
  

 final  ChildHomeOverviewViewModel overview;

/// Create a copy of ChildHomeState
/// with the given fields replaced by the non-null parameter values.
@JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
$ChildHomeLoadedCopyWith<ChildHomeLoaded> get copyWith => _$ChildHomeLoadedCopyWithImpl<ChildHomeLoaded>(this, _$identity);



@override
bool operator ==(Object other) {
  return identical(this, other) || (other.runtimeType == runtimeType&&other is ChildHomeLoaded&&(identical(other.overview, overview) || other.overview == overview));
}


@override
int get hashCode => Object.hash(runtimeType,overview);

@override
String toString() {
  return 'ChildHomeState.loaded(overview: $overview)';
}


}

/// @nodoc
abstract mixin class $ChildHomeLoadedCopyWith<$Res> implements $ChildHomeStateCopyWith<$Res> {
  factory $ChildHomeLoadedCopyWith(ChildHomeLoaded value, $Res Function(ChildHomeLoaded) _then) = _$ChildHomeLoadedCopyWithImpl;
@useResult
$Res call({
 ChildHomeOverviewViewModel overview
});




}
/// @nodoc
class _$ChildHomeLoadedCopyWithImpl<$Res>
    implements $ChildHomeLoadedCopyWith<$Res> {
  _$ChildHomeLoadedCopyWithImpl(this._self, this._then);

  final ChildHomeLoaded _self;
  final $Res Function(ChildHomeLoaded) _then;

/// Create a copy of ChildHomeState
/// with the given fields replaced by the non-null parameter values.
@pragma('vm:prefer-inline') $Res call({Object? overview = null,}) {
  return _then(ChildHomeLoaded(
null == overview ? _self.overview : overview // ignore: cast_nullable_to_non_nullable
as ChildHomeOverviewViewModel,
  ));
}


}

/// @nodoc


class ChildHomeError implements ChildHomeState {
  const ChildHomeError(this.error);
  

 final  ApiErrorModel error;

/// Create a copy of ChildHomeState
/// with the given fields replaced by the non-null parameter values.
@JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
$ChildHomeErrorCopyWith<ChildHomeError> get copyWith => _$ChildHomeErrorCopyWithImpl<ChildHomeError>(this, _$identity);



@override
bool operator ==(Object other) {
  return identical(this, other) || (other.runtimeType == runtimeType&&other is ChildHomeError&&(identical(other.error, error) || other.error == error));
}


@override
int get hashCode => Object.hash(runtimeType,error);

@override
String toString() {
  return 'ChildHomeState.error(error: $error)';
}


}

/// @nodoc
abstract mixin class $ChildHomeErrorCopyWith<$Res> implements $ChildHomeStateCopyWith<$Res> {
  factory $ChildHomeErrorCopyWith(ChildHomeError value, $Res Function(ChildHomeError) _then) = _$ChildHomeErrorCopyWithImpl;
@useResult
$Res call({
 ApiErrorModel error
});




}
/// @nodoc
class _$ChildHomeErrorCopyWithImpl<$Res>
    implements $ChildHomeErrorCopyWith<$Res> {
  _$ChildHomeErrorCopyWithImpl(this._self, this._then);

  final ChildHomeError _self;
  final $Res Function(ChildHomeError) _then;

/// Create a copy of ChildHomeState
/// with the given fields replaced by the non-null parameter values.
@pragma('vm:prefer-inline') $Res call({Object? error = null,}) {
  return _then(ChildHomeError(
null == error ? _self.error : error // ignore: cast_nullable_to_non_nullable
as ApiErrorModel,
  ));
}


}

// dart format on
