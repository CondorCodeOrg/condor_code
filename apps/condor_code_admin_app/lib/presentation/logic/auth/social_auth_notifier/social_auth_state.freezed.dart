// GENERATED CODE - DO NOT MODIFY BY HAND
// coverage:ignore-file
// ignore_for_file: type=lint
// ignore_for_file: unused_element, deprecated_member_use, deprecated_member_use_from_same_package, use_function_type_syntax_for_parameters, unnecessary_const, avoid_init_to_null, invalid_override_different_default_values_named, prefer_expression_function_bodies, annotate_overrides, invalid_annotation_target, unnecessary_question_mark

part of 'social_auth_state.dart';

// **************************************************************************
// FreezedGenerator
// **************************************************************************

// dart format off
T _$identity<T>(T value) => value;
/// @nodoc
mixin _$SocialAuthState {

 bool get isSigningWithGoogle;//TODO: Implement Apple Sign In and anonymous sign in
 bool get isSigningWithApple; bool get isSigningAnonymously; String? get commonErrorMessage;
/// Create a copy of SocialAuthState
/// with the given fields replaced by the non-null parameter values.
@JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
$SocialAuthStateCopyWith<SocialAuthState> get copyWith => _$SocialAuthStateCopyWithImpl<SocialAuthState>(this as SocialAuthState, _$identity);



@override
bool operator ==(Object other) {
  return identical(this, other) || (other.runtimeType == runtimeType&&other is SocialAuthState&&(identical(other.isSigningWithGoogle, isSigningWithGoogle) || other.isSigningWithGoogle == isSigningWithGoogle)&&(identical(other.isSigningWithApple, isSigningWithApple) || other.isSigningWithApple == isSigningWithApple)&&(identical(other.isSigningAnonymously, isSigningAnonymously) || other.isSigningAnonymously == isSigningAnonymously)&&(identical(other.commonErrorMessage, commonErrorMessage) || other.commonErrorMessage == commonErrorMessage));
}


@override
int get hashCode => Object.hash(runtimeType,isSigningWithGoogle,isSigningWithApple,isSigningAnonymously,commonErrorMessage);

@override
String toString() {
  return 'SocialAuthState(isSigningWithGoogle: $isSigningWithGoogle, isSigningWithApple: $isSigningWithApple, isSigningAnonymously: $isSigningAnonymously, commonErrorMessage: $commonErrorMessage)';
}


}

/// @nodoc
abstract mixin class $SocialAuthStateCopyWith<$Res>  {
  factory $SocialAuthStateCopyWith(SocialAuthState value, $Res Function(SocialAuthState) _then) = _$SocialAuthStateCopyWithImpl;
@useResult
$Res call({
 bool isSigningWithGoogle, bool isSigningWithApple, bool isSigningAnonymously, String? commonErrorMessage
});




}
/// @nodoc
class _$SocialAuthStateCopyWithImpl<$Res>
    implements $SocialAuthStateCopyWith<$Res> {
  _$SocialAuthStateCopyWithImpl(this._self, this._then);

  final SocialAuthState _self;
  final $Res Function(SocialAuthState) _then;

/// Create a copy of SocialAuthState
/// with the given fields replaced by the non-null parameter values.
@pragma('vm:prefer-inline') @override $Res call({Object? isSigningWithGoogle = null,Object? isSigningWithApple = null,Object? isSigningAnonymously = null,Object? commonErrorMessage = freezed,}) {
  return _then(_self.copyWith(
isSigningWithGoogle: null == isSigningWithGoogle ? _self.isSigningWithGoogle : isSigningWithGoogle // ignore: cast_nullable_to_non_nullable
as bool,isSigningWithApple: null == isSigningWithApple ? _self.isSigningWithApple : isSigningWithApple // ignore: cast_nullable_to_non_nullable
as bool,isSigningAnonymously: null == isSigningAnonymously ? _self.isSigningAnonymously : isSigningAnonymously // ignore: cast_nullable_to_non_nullable
as bool,commonErrorMessage: freezed == commonErrorMessage ? _self.commonErrorMessage : commonErrorMessage // ignore: cast_nullable_to_non_nullable
as String?,
  ));
}

}


/// Adds pattern-matching-related methods to [SocialAuthState].
extension SocialAuthStatePatterns on SocialAuthState {
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

@optionalTypeArgs TResult maybeMap<TResult extends Object?>(TResult Function( _SocialAuthState value)?  $default,{required TResult orElse(),}){
final _that = this;
switch (_that) {
case _SocialAuthState() when $default != null:
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

@optionalTypeArgs TResult map<TResult extends Object?>(TResult Function( _SocialAuthState value)  $default,){
final _that = this;
switch (_that) {
case _SocialAuthState():
return $default(_that);}
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

@optionalTypeArgs TResult? mapOrNull<TResult extends Object?>(TResult? Function( _SocialAuthState value)?  $default,){
final _that = this;
switch (_that) {
case _SocialAuthState() when $default != null:
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

@optionalTypeArgs TResult maybeWhen<TResult extends Object?>(TResult Function( bool isSigningWithGoogle,  bool isSigningWithApple,  bool isSigningAnonymously,  String? commonErrorMessage)?  $default,{required TResult orElse(),}) {final _that = this;
switch (_that) {
case _SocialAuthState() when $default != null:
return $default(_that.isSigningWithGoogle,_that.isSigningWithApple,_that.isSigningAnonymously,_that.commonErrorMessage);case _:
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

@optionalTypeArgs TResult when<TResult extends Object?>(TResult Function( bool isSigningWithGoogle,  bool isSigningWithApple,  bool isSigningAnonymously,  String? commonErrorMessage)  $default,) {final _that = this;
switch (_that) {
case _SocialAuthState():
return $default(_that.isSigningWithGoogle,_that.isSigningWithApple,_that.isSigningAnonymously,_that.commonErrorMessage);}
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

@optionalTypeArgs TResult? whenOrNull<TResult extends Object?>(TResult? Function( bool isSigningWithGoogle,  bool isSigningWithApple,  bool isSigningAnonymously,  String? commonErrorMessage)?  $default,) {final _that = this;
switch (_that) {
case _SocialAuthState() when $default != null:
return $default(_that.isSigningWithGoogle,_that.isSigningWithApple,_that.isSigningAnonymously,_that.commonErrorMessage);case _:
  return null;

}
}

}

/// @nodoc


class _SocialAuthState extends SocialAuthState {
  const _SocialAuthState({this.isSigningWithGoogle = false, this.isSigningWithApple = false, this.isSigningAnonymously = false, this.commonErrorMessage}): super._();
  

@override@JsonKey() final  bool isSigningWithGoogle;
//TODO: Implement Apple Sign In and anonymous sign in
@override@JsonKey() final  bool isSigningWithApple;
@override@JsonKey() final  bool isSigningAnonymously;
@override final  String? commonErrorMessage;

/// Create a copy of SocialAuthState
/// with the given fields replaced by the non-null parameter values.
@override @JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
_$SocialAuthStateCopyWith<_SocialAuthState> get copyWith => __$SocialAuthStateCopyWithImpl<_SocialAuthState>(this, _$identity);



@override
bool operator ==(Object other) {
  return identical(this, other) || (other.runtimeType == runtimeType&&other is _SocialAuthState&&(identical(other.isSigningWithGoogle, isSigningWithGoogle) || other.isSigningWithGoogle == isSigningWithGoogle)&&(identical(other.isSigningWithApple, isSigningWithApple) || other.isSigningWithApple == isSigningWithApple)&&(identical(other.isSigningAnonymously, isSigningAnonymously) || other.isSigningAnonymously == isSigningAnonymously)&&(identical(other.commonErrorMessage, commonErrorMessage) || other.commonErrorMessage == commonErrorMessage));
}


@override
int get hashCode => Object.hash(runtimeType,isSigningWithGoogle,isSigningWithApple,isSigningAnonymously,commonErrorMessage);

@override
String toString() {
  return 'SocialAuthState(isSigningWithGoogle: $isSigningWithGoogle, isSigningWithApple: $isSigningWithApple, isSigningAnonymously: $isSigningAnonymously, commonErrorMessage: $commonErrorMessage)';
}


}

/// @nodoc
abstract mixin class _$SocialAuthStateCopyWith<$Res> implements $SocialAuthStateCopyWith<$Res> {
  factory _$SocialAuthStateCopyWith(_SocialAuthState value, $Res Function(_SocialAuthState) _then) = __$SocialAuthStateCopyWithImpl;
@override @useResult
$Res call({
 bool isSigningWithGoogle, bool isSigningWithApple, bool isSigningAnonymously, String? commonErrorMessage
});




}
/// @nodoc
class __$SocialAuthStateCopyWithImpl<$Res>
    implements _$SocialAuthStateCopyWith<$Res> {
  __$SocialAuthStateCopyWithImpl(this._self, this._then);

  final _SocialAuthState _self;
  final $Res Function(_SocialAuthState) _then;

/// Create a copy of SocialAuthState
/// with the given fields replaced by the non-null parameter values.
@override @pragma('vm:prefer-inline') $Res call({Object? isSigningWithGoogle = null,Object? isSigningWithApple = null,Object? isSigningAnonymously = null,Object? commonErrorMessage = freezed,}) {
  return _then(_SocialAuthState(
isSigningWithGoogle: null == isSigningWithGoogle ? _self.isSigningWithGoogle : isSigningWithGoogle // ignore: cast_nullable_to_non_nullable
as bool,isSigningWithApple: null == isSigningWithApple ? _self.isSigningWithApple : isSigningWithApple // ignore: cast_nullable_to_non_nullable
as bool,isSigningAnonymously: null == isSigningAnonymously ? _self.isSigningAnonymously : isSigningAnonymously // ignore: cast_nullable_to_non_nullable
as bool,commonErrorMessage: freezed == commonErrorMessage ? _self.commonErrorMessage : commonErrorMessage // ignore: cast_nullable_to_non_nullable
as String?,
  ));
}


}

// dart format on
