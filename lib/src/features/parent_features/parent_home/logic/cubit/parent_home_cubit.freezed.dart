// GENERATED CODE - DO NOT MODIFY BY HAND
// coverage:ignore-file
// ignore_for_file: type=lint
// ignore_for_file: unused_element, deprecated_member_use, deprecated_member_use_from_same_package, use_function_type_syntax_for_parameters, unnecessary_const, avoid_init_to_null, invalid_override_different_default_values_named, prefer_expression_function_bodies, annotate_overrides, invalid_annotation_target, unnecessary_question_mark

part of 'parent_home_cubit.dart';

// **************************************************************************
// FreezedGenerator
// **************************************************************************

// dart format off
T _$identity<T>(T value) => value;
/// @nodoc
mixin _$ParentHomeState {





@override
bool operator ==(Object other) {
  return identical(this, other) || (other.runtimeType == runtimeType&&other is ParentHomeState);
}


@override
int get hashCode => runtimeType.hashCode;

@override
String toString() {
  return 'ParentHomeState()';
}


}

/// @nodoc
class $ParentHomeStateCopyWith<$Res>  {
$ParentHomeStateCopyWith(ParentHomeState _, $Res Function(ParentHomeState) __);
}


/// Adds pattern-matching-related methods to [ParentHomeState].
extension ParentHomeStatePatterns on ParentHomeState {
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

@optionalTypeArgs TResult maybeMap<TResult extends Object?>({TResult Function( _Initial value)?  initial,TResult Function( ParentHomeLoading value)?  loading,TResult Function( ParentHomeLoaded value)?  loaded,TResult Function( ParentHomeError value)?  error,required TResult orElse(),}){
final _that = this;
switch (_that) {
case _Initial() when initial != null:
return initial(_that);case ParentHomeLoading() when loading != null:
return loading(_that);case ParentHomeLoaded() when loaded != null:
return loaded(_that);case ParentHomeError() when error != null:
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

@optionalTypeArgs TResult map<TResult extends Object?>({required TResult Function( _Initial value)  initial,required TResult Function( ParentHomeLoading value)  loading,required TResult Function( ParentHomeLoaded value)  loaded,required TResult Function( ParentHomeError value)  error,}){
final _that = this;
switch (_that) {
case _Initial():
return initial(_that);case ParentHomeLoading():
return loading(_that);case ParentHomeLoaded():
return loaded(_that);case ParentHomeError():
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

@optionalTypeArgs TResult? mapOrNull<TResult extends Object?>({TResult? Function( _Initial value)?  initial,TResult? Function( ParentHomeLoading value)?  loading,TResult? Function( ParentHomeLoaded value)?  loaded,TResult? Function( ParentHomeError value)?  error,}){
final _that = this;
switch (_that) {
case _Initial() when initial != null:
return initial(_that);case ParentHomeLoading() when loading != null:
return loading(_that);case ParentHomeLoaded() when loaded != null:
return loaded(_that);case ParentHomeError() when error != null:
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

@optionalTypeArgs TResult maybeWhen<TResult extends Object?>({TResult Function()?  initial,TResult Function()?  loading,TResult Function( ParentHomeOverviewViewModel overview)?  loaded,TResult Function( ApiErrorModel error)?  error,required TResult orElse(),}) {final _that = this;
switch (_that) {
case _Initial() when initial != null:
return initial();case ParentHomeLoading() when loading != null:
return loading();case ParentHomeLoaded() when loaded != null:
return loaded(_that.overview);case ParentHomeError() when error != null:
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

@optionalTypeArgs TResult when<TResult extends Object?>({required TResult Function()  initial,required TResult Function()  loading,required TResult Function( ParentHomeOverviewViewModel overview)  loaded,required TResult Function( ApiErrorModel error)  error,}) {final _that = this;
switch (_that) {
case _Initial():
return initial();case ParentHomeLoading():
return loading();case ParentHomeLoaded():
return loaded(_that.overview);case ParentHomeError():
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

@optionalTypeArgs TResult? whenOrNull<TResult extends Object?>({TResult? Function()?  initial,TResult? Function()?  loading,TResult? Function( ParentHomeOverviewViewModel overview)?  loaded,TResult? Function( ApiErrorModel error)?  error,}) {final _that = this;
switch (_that) {
case _Initial() when initial != null:
return initial();case ParentHomeLoading() when loading != null:
return loading();case ParentHomeLoaded() when loaded != null:
return loaded(_that.overview);case ParentHomeError() when error != null:
return error(_that.error);case _:
  return null;

}
}

}

/// @nodoc


class _Initial implements ParentHomeState {
  const _Initial();
  






@override
bool operator ==(Object other) {
  return identical(this, other) || (other.runtimeType == runtimeType&&other is _Initial);
}


@override
int get hashCode => runtimeType.hashCode;

@override
String toString() {
  return 'ParentHomeState.initial()';
}


}




/// @nodoc


class ParentHomeLoading implements ParentHomeState {
  const ParentHomeLoading();
  






@override
bool operator ==(Object other) {
  return identical(this, other) || (other.runtimeType == runtimeType&&other is ParentHomeLoading);
}


@override
int get hashCode => runtimeType.hashCode;

@override
String toString() {
  return 'ParentHomeState.loading()';
}


}




/// @nodoc


class ParentHomeLoaded implements ParentHomeState {
  const ParentHomeLoaded(this.overview);
  

 final  ParentHomeOverviewViewModel overview;

/// Create a copy of ParentHomeState
/// with the given fields replaced by the non-null parameter values.
@JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
$ParentHomeLoadedCopyWith<ParentHomeLoaded> get copyWith => _$ParentHomeLoadedCopyWithImpl<ParentHomeLoaded>(this, _$identity);



@override
bool operator ==(Object other) {
  return identical(this, other) || (other.runtimeType == runtimeType&&other is ParentHomeLoaded&&(identical(other.overview, overview) || other.overview == overview));
}


@override
int get hashCode => Object.hash(runtimeType,overview);

@override
String toString() {
  return 'ParentHomeState.loaded(overview: $overview)';
}


}

/// @nodoc
abstract mixin class $ParentHomeLoadedCopyWith<$Res> implements $ParentHomeStateCopyWith<$Res> {
  factory $ParentHomeLoadedCopyWith(ParentHomeLoaded value, $Res Function(ParentHomeLoaded) _then) = _$ParentHomeLoadedCopyWithImpl;
@useResult
$Res call({
 ParentHomeOverviewViewModel overview
});




}
/// @nodoc
class _$ParentHomeLoadedCopyWithImpl<$Res>
    implements $ParentHomeLoadedCopyWith<$Res> {
  _$ParentHomeLoadedCopyWithImpl(this._self, this._then);

  final ParentHomeLoaded _self;
  final $Res Function(ParentHomeLoaded) _then;

/// Create a copy of ParentHomeState
/// with the given fields replaced by the non-null parameter values.
@pragma('vm:prefer-inline') $Res call({Object? overview = null,}) {
  return _then(ParentHomeLoaded(
null == overview ? _self.overview : overview // ignore: cast_nullable_to_non_nullable
as ParentHomeOverviewViewModel,
  ));
}


}

/// @nodoc


class ParentHomeError implements ParentHomeState {
  const ParentHomeError(this.error);
  

 final  ApiErrorModel error;

/// Create a copy of ParentHomeState
/// with the given fields replaced by the non-null parameter values.
@JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
$ParentHomeErrorCopyWith<ParentHomeError> get copyWith => _$ParentHomeErrorCopyWithImpl<ParentHomeError>(this, _$identity);



@override
bool operator ==(Object other) {
  return identical(this, other) || (other.runtimeType == runtimeType&&other is ParentHomeError&&(identical(other.error, error) || other.error == error));
}


@override
int get hashCode => Object.hash(runtimeType,error);

@override
String toString() {
  return 'ParentHomeState.error(error: $error)';
}


}

/// @nodoc
abstract mixin class $ParentHomeErrorCopyWith<$Res> implements $ParentHomeStateCopyWith<$Res> {
  factory $ParentHomeErrorCopyWith(ParentHomeError value, $Res Function(ParentHomeError) _then) = _$ParentHomeErrorCopyWithImpl;
@useResult
$Res call({
 ApiErrorModel error
});




}
/// @nodoc
class _$ParentHomeErrorCopyWithImpl<$Res>
    implements $ParentHomeErrorCopyWith<$Res> {
  _$ParentHomeErrorCopyWithImpl(this._self, this._then);

  final ParentHomeError _self;
  final $Res Function(ParentHomeError) _then;

/// Create a copy of ParentHomeState
/// with the given fields replaced by the non-null parameter values.
@pragma('vm:prefer-inline') $Res call({Object? error = null,}) {
  return _then(ParentHomeError(
null == error ? _self.error : error // ignore: cast_nullable_to_non_nullable
as ApiErrorModel,
  ));
}


}

// dart format on
