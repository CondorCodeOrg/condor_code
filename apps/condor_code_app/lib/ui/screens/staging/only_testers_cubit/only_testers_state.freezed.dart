// GENERATED CODE - DO NOT MODIFY BY HAND
// coverage:ignore-file
// ignore_for_file: type=lint
// ignore_for_file: unused_element, deprecated_member_use, deprecated_member_use_from_same_package, use_function_type_syntax_for_parameters, unnecessary_const, avoid_init_to_null, invalid_override_different_default_values_named, prefer_expression_function_bodies, annotate_overrides, invalid_annotation_target, unnecessary_question_mark

part of 'only_testers_state.dart';

// **************************************************************************
// FreezedGenerator
// **************************************************************************

// dart format off
T _$identity<T>(T value) => value;
/// @nodoc
mixin _$OnlyTestersState {

 bool get isLoading; bool get isSubmitting; TesterAccessRequest? get myRequest;
/// Create a copy of OnlyTestersState
/// with the given fields replaced by the non-null parameter values.
@JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
$OnlyTestersStateCopyWith<OnlyTestersState> get copyWith => _$OnlyTestersStateCopyWithImpl<OnlyTestersState>(this as OnlyTestersState, _$identity);



@override
bool operator ==(Object other) {
  return identical(this, other) || (other.runtimeType == runtimeType&&other is OnlyTestersState&&(identical(other.isLoading, isLoading) || other.isLoading == isLoading)&&(identical(other.isSubmitting, isSubmitting) || other.isSubmitting == isSubmitting)&&(identical(other.myRequest, myRequest) || other.myRequest == myRequest));
}


@override
int get hashCode => Object.hash(runtimeType,isLoading,isSubmitting,myRequest);

@override
String toString() {
  return 'OnlyTestersState(isLoading: $isLoading, isSubmitting: $isSubmitting, myRequest: $myRequest)';
}


}

/// @nodoc
abstract mixin class $OnlyTestersStateCopyWith<$Res>  {
  factory $OnlyTestersStateCopyWith(OnlyTestersState value, $Res Function(OnlyTestersState) _then) = _$OnlyTestersStateCopyWithImpl;
@useResult
$Res call({
 bool isLoading, bool isSubmitting, TesterAccessRequest? myRequest
});




}
/// @nodoc
class _$OnlyTestersStateCopyWithImpl<$Res>
    implements $OnlyTestersStateCopyWith<$Res> {
  _$OnlyTestersStateCopyWithImpl(this._self, this._then);

  final OnlyTestersState _self;
  final $Res Function(OnlyTestersState) _then;

/// Create a copy of OnlyTestersState
/// with the given fields replaced by the non-null parameter values.
@pragma('vm:prefer-inline') @override $Res call({Object? isLoading = null,Object? isSubmitting = null,Object? myRequest = freezed,}) {
  return _then(_self.copyWith(
isLoading: null == isLoading ? _self.isLoading : isLoading // ignore: cast_nullable_to_non_nullable
as bool,isSubmitting: null == isSubmitting ? _self.isSubmitting : isSubmitting // ignore: cast_nullable_to_non_nullable
as bool,myRequest: freezed == myRequest ? _self.myRequest : myRequest // ignore: cast_nullable_to_non_nullable
as TesterAccessRequest?,
  ));
}

}


/// Adds pattern-matching-related methods to [OnlyTestersState].
extension OnlyTestersStatePatterns on OnlyTestersState {
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

@optionalTypeArgs TResult maybeMap<TResult extends Object?>(TResult Function( _OnlyTestersState value)?  $default,{required TResult orElse(),}){
final _that = this;
switch (_that) {
case _OnlyTestersState() when $default != null:
return $default(_that);case _:
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

@optionalTypeArgs TResult map<TResult extends Object?>(TResult Function( _OnlyTestersState value)  $default,){
final _that = this;
switch (_that) {
case _OnlyTestersState():
return $default(_that);case _:
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

@optionalTypeArgs TResult? mapOrNull<TResult extends Object?>(TResult? Function( _OnlyTestersState value)?  $default,){
final _that = this;
switch (_that) {
case _OnlyTestersState() when $default != null:
return $default(_that);case _:
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

@optionalTypeArgs TResult maybeWhen<TResult extends Object?>(TResult Function( bool isLoading,  bool isSubmitting,  TesterAccessRequest? myRequest)?  $default,{required TResult orElse(),}) {final _that = this;
switch (_that) {
case _OnlyTestersState() when $default != null:
return $default(_that.isLoading,_that.isSubmitting,_that.myRequest);case _:
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

@optionalTypeArgs TResult when<TResult extends Object?>(TResult Function( bool isLoading,  bool isSubmitting,  TesterAccessRequest? myRequest)  $default,) {final _that = this;
switch (_that) {
case _OnlyTestersState():
return $default(_that.isLoading,_that.isSubmitting,_that.myRequest);case _:
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

@optionalTypeArgs TResult? whenOrNull<TResult extends Object?>(TResult? Function( bool isLoading,  bool isSubmitting,  TesterAccessRequest? myRequest)?  $default,) {final _that = this;
switch (_that) {
case _OnlyTestersState() when $default != null:
return $default(_that.isLoading,_that.isSubmitting,_that.myRequest);case _:
  return null;

}
}

}

/// @nodoc


class _OnlyTestersState extends OnlyTestersState {
  const _OnlyTestersState({this.isLoading = false, this.isSubmitting = false, this.myRequest}): super._();
  

@override@JsonKey() final  bool isLoading;
@override@JsonKey() final  bool isSubmitting;
@override final  TesterAccessRequest? myRequest;

/// Create a copy of OnlyTestersState
/// with the given fields replaced by the non-null parameter values.
@override @JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
_$OnlyTestersStateCopyWith<_OnlyTestersState> get copyWith => __$OnlyTestersStateCopyWithImpl<_OnlyTestersState>(this, _$identity);



@override
bool operator ==(Object other) {
  return identical(this, other) || (other.runtimeType == runtimeType&&other is _OnlyTestersState&&(identical(other.isLoading, isLoading) || other.isLoading == isLoading)&&(identical(other.isSubmitting, isSubmitting) || other.isSubmitting == isSubmitting)&&(identical(other.myRequest, myRequest) || other.myRequest == myRequest));
}


@override
int get hashCode => Object.hash(runtimeType,isLoading,isSubmitting,myRequest);

@override
String toString() {
  return 'OnlyTestersState(isLoading: $isLoading, isSubmitting: $isSubmitting, myRequest: $myRequest)';
}


}

/// @nodoc
abstract mixin class _$OnlyTestersStateCopyWith<$Res> implements $OnlyTestersStateCopyWith<$Res> {
  factory _$OnlyTestersStateCopyWith(_OnlyTestersState value, $Res Function(_OnlyTestersState) _then) = __$OnlyTestersStateCopyWithImpl;
@override @useResult
$Res call({
 bool isLoading, bool isSubmitting, TesterAccessRequest? myRequest
});




}
/// @nodoc
class __$OnlyTestersStateCopyWithImpl<$Res>
    implements _$OnlyTestersStateCopyWith<$Res> {
  __$OnlyTestersStateCopyWithImpl(this._self, this._then);

  final _OnlyTestersState _self;
  final $Res Function(_OnlyTestersState) _then;

/// Create a copy of OnlyTestersState
/// with the given fields replaced by the non-null parameter values.
@override @pragma('vm:prefer-inline') $Res call({Object? isLoading = null,Object? isSubmitting = null,Object? myRequest = freezed,}) {
  return _then(_OnlyTestersState(
isLoading: null == isLoading ? _self.isLoading : isLoading // ignore: cast_nullable_to_non_nullable
as bool,isSubmitting: null == isSubmitting ? _self.isSubmitting : isSubmitting // ignore: cast_nullable_to_non_nullable
as bool,myRequest: freezed == myRequest ? _self.myRequest : myRequest // ignore: cast_nullable_to_non_nullable
as TesterAccessRequest?,
  ));
}


}

// dart format on
