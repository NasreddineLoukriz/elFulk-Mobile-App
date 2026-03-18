// GENERATED CODE - DO NOT MODIFY BY HAND
// coverage:ignore-file
// ignore_for_file: type=lint
// ignore_for_file: unused_element, deprecated_member_use, deprecated_member_use_from_same_package, use_function_type_syntax_for_parameters, unnecessary_const, avoid_init_to_null, invalid_override_different_default_values_named, prefer_expression_function_bodies, annotate_overrides, invalid_annotation_target, unnecessary_question_mark

part of 'architecture_cubit.dart';

// **************************************************************************
// FreezedGenerator
// **************************************************************************

// dart format off
T _$identity<T>(T value) => value;
/// @nodoc
mixin _$ArchitectureState {





@override
bool operator ==(Object other) {
  return identical(this, other) || (other.runtimeType == runtimeType&&other is ArchitectureState);
}


@override
int get hashCode => runtimeType.hashCode;

@override
String toString() {
  return 'ArchitectureState()';
}


}

/// @nodoc
class $ArchitectureStateCopyWith<$Res>  {
$ArchitectureStateCopyWith(ArchitectureState _, $Res Function(ArchitectureState) __);
}


/// Adds pattern-matching-related methods to [ArchitectureState].
extension ArchitectureStatePatterns on ArchitectureState {
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

@optionalTypeArgs TResult maybeMap<TResult extends Object?>({TResult Function( _Initial value)?  initial,TResult Function( ArchitectureLoading value)?  loading,TResult Function( ArchitectureLoaded value)?  loaded,TResult Function( ArchitectureError value)?  error,required TResult orElse(),}){
final _that = this;
switch (_that) {
case _Initial() when initial != null:
return initial(_that);case ArchitectureLoading() when loading != null:
return loading(_that);case ArchitectureLoaded() when loaded != null:
return loaded(_that);case ArchitectureError() when error != null:
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

@optionalTypeArgs TResult map<TResult extends Object?>({required TResult Function( _Initial value)  initial,required TResult Function( ArchitectureLoading value)  loading,required TResult Function( ArchitectureLoaded value)  loaded,required TResult Function( ArchitectureError value)  error,}){
final _that = this;
switch (_that) {
case _Initial():
return initial(_that);case ArchitectureLoading():
return loading(_that);case ArchitectureLoaded():
return loaded(_that);case ArchitectureError():
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

@optionalTypeArgs TResult? mapOrNull<TResult extends Object?>({TResult? Function( _Initial value)?  initial,TResult? Function( ArchitectureLoading value)?  loading,TResult? Function( ArchitectureLoaded value)?  loaded,TResult? Function( ArchitectureError value)?  error,}){
final _that = this;
switch (_that) {
case _Initial() when initial != null:
return initial(_that);case ArchitectureLoading() when loading != null:
return loading(_that);case ArchitectureLoaded() when loaded != null:
return loaded(_that);case ArchitectureError() when error != null:
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

@optionalTypeArgs TResult maybeWhen<TResult extends Object?>({TResult Function()?  initial,TResult Function()?  loading,TResult Function( ArchitectureOverviewViewModel overview)?  loaded,TResult Function( String message)?  error,required TResult orElse(),}) {final _that = this;
switch (_that) {
case _Initial() when initial != null:
return initial();case ArchitectureLoading() when loading != null:
return loading();case ArchitectureLoaded() when loaded != null:
return loaded(_that.overview);case ArchitectureError() when error != null:
return error(_that.message);case _:
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

@optionalTypeArgs TResult when<TResult extends Object?>({required TResult Function()  initial,required TResult Function()  loading,required TResult Function( ArchitectureOverviewViewModel overview)  loaded,required TResult Function( String message)  error,}) {final _that = this;
switch (_that) {
case _Initial():
return initial();case ArchitectureLoading():
return loading();case ArchitectureLoaded():
return loaded(_that.overview);case ArchitectureError():
return error(_that.message);case _:
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

@optionalTypeArgs TResult? whenOrNull<TResult extends Object?>({TResult? Function()?  initial,TResult? Function()?  loading,TResult? Function( ArchitectureOverviewViewModel overview)?  loaded,TResult? Function( String message)?  error,}) {final _that = this;
switch (_that) {
case _Initial() when initial != null:
return initial();case ArchitectureLoading() when loading != null:
return loading();case ArchitectureLoaded() when loaded != null:
return loaded(_that.overview);case ArchitectureError() when error != null:
return error(_that.message);case _:
  return null;

}
}

}

/// @nodoc


class _Initial implements ArchitectureState {
  const _Initial();
  






@override
bool operator ==(Object other) {
  return identical(this, other) || (other.runtimeType == runtimeType&&other is _Initial);
}


@override
int get hashCode => runtimeType.hashCode;

@override
String toString() {
  return 'ArchitectureState.initial()';
}


}




/// @nodoc


class ArchitectureLoading implements ArchitectureState {
  const ArchitectureLoading();
  






@override
bool operator ==(Object other) {
  return identical(this, other) || (other.runtimeType == runtimeType&&other is ArchitectureLoading);
}


@override
int get hashCode => runtimeType.hashCode;

@override
String toString() {
  return 'ArchitectureState.loading()';
}


}




/// @nodoc


class ArchitectureLoaded implements ArchitectureState {
  const ArchitectureLoaded(this.overview);
  

 final  ArchitectureOverviewViewModel overview;

/// Create a copy of ArchitectureState
/// with the given fields replaced by the non-null parameter values.
@JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
$ArchitectureLoadedCopyWith<ArchitectureLoaded> get copyWith => _$ArchitectureLoadedCopyWithImpl<ArchitectureLoaded>(this, _$identity);



@override
bool operator ==(Object other) {
  return identical(this, other) || (other.runtimeType == runtimeType&&other is ArchitectureLoaded&&(identical(other.overview, overview) || other.overview == overview));
}


@override
int get hashCode => Object.hash(runtimeType,overview);

@override
String toString() {
  return 'ArchitectureState.loaded(overview: $overview)';
}


}

/// @nodoc
abstract mixin class $ArchitectureLoadedCopyWith<$Res> implements $ArchitectureStateCopyWith<$Res> {
  factory $ArchitectureLoadedCopyWith(ArchitectureLoaded value, $Res Function(ArchitectureLoaded) _then) = _$ArchitectureLoadedCopyWithImpl;
@useResult
$Res call({
 ArchitectureOverviewViewModel overview
});




}
/// @nodoc
class _$ArchitectureLoadedCopyWithImpl<$Res>
    implements $ArchitectureLoadedCopyWith<$Res> {
  _$ArchitectureLoadedCopyWithImpl(this._self, this._then);

  final ArchitectureLoaded _self;
  final $Res Function(ArchitectureLoaded) _then;

/// Create a copy of ArchitectureState
/// with the given fields replaced by the non-null parameter values.
@pragma('vm:prefer-inline') $Res call({Object? overview = null,}) {
  return _then(ArchitectureLoaded(
null == overview ? _self.overview : overview // ignore: cast_nullable_to_non_nullable
as ArchitectureOverviewViewModel,
  ));
}


}

/// @nodoc


class ArchitectureError implements ArchitectureState {
  const ArchitectureError(this.message);
  

 final  String message;

/// Create a copy of ArchitectureState
/// with the given fields replaced by the non-null parameter values.
@JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
$ArchitectureErrorCopyWith<ArchitectureError> get copyWith => _$ArchitectureErrorCopyWithImpl<ArchitectureError>(this, _$identity);



@override
bool operator ==(Object other) {
  return identical(this, other) || (other.runtimeType == runtimeType&&other is ArchitectureError&&(identical(other.message, message) || other.message == message));
}


@override
int get hashCode => Object.hash(runtimeType,message);

@override
String toString() {
  return 'ArchitectureState.error(message: $message)';
}


}

/// @nodoc
abstract mixin class $ArchitectureErrorCopyWith<$Res> implements $ArchitectureStateCopyWith<$Res> {
  factory $ArchitectureErrorCopyWith(ArchitectureError value, $Res Function(ArchitectureError) _then) = _$ArchitectureErrorCopyWithImpl;
@useResult
$Res call({
 String message
});




}
/// @nodoc
class _$ArchitectureErrorCopyWithImpl<$Res>
    implements $ArchitectureErrorCopyWith<$Res> {
  _$ArchitectureErrorCopyWithImpl(this._self, this._then);

  final ArchitectureError _self;
  final $Res Function(ArchitectureError) _then;

/// Create a copy of ArchitectureState
/// with the given fields replaced by the non-null parameter values.
@pragma('vm:prefer-inline') $Res call({Object? message = null,}) {
  return _then(ArchitectureError(
null == message ? _self.message : message // ignore: cast_nullable_to_non_nullable
as String,
  ));
}


}

// dart format on
