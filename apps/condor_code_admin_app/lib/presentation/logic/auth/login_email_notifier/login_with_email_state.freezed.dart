// GENERATED CODE - DO NOT MODIFY BY HAND
// coverage:ignore-file
// ignore_for_file: type=lint
// ignore_for_file: unused_element, deprecated_member_use, deprecated_member_use_from_same_package, use_function_type_syntax_for_parameters, unnecessary_const, avoid_init_to_null, invalid_override_different_default_values_named, prefer_expression_function_bodies, annotate_overrides, invalid_annotation_target, unnecessary_question_mark

part of 'login_with_email_state.dart';

// **************************************************************************
// FreezedGenerator
// **************************************************************************

// dart format off
T _$identity<T>(T value) => value;
/// @nodoc
mixin _$LoginWithEmailState {

 bool get isProcessing; String get email; String get password; bool get isPasswordVisible; bool get emailError; bool get passwordError; String? get emailErrorMessage; String? get passwordErrorMessage;
/// Create a copy of LoginWithEmailState
/// with the given fields replaced by the non-null parameter values.
@JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
$LoginWithEmailStateCopyWith<LoginWithEmailState> get copyWith => _$LoginWithEmailStateCopyWithImpl<LoginWithEmailState>(this as LoginWithEmailState, _$identity);



@override
bool operator ==(Object other) {
  return identical(this, other) || (other.runtimeType == runtimeType&&other is LoginWithEmailState&&(identical(other.isProcessing, isProcessing) || other.isProcessing == isProcessing)&&(identical(other.email, email) || other.email == email)&&(identical(other.password, password) || other.password == password)&&(identical(other.isPasswordVisible, isPasswordVisible) || other.isPasswordVisible == isPasswordVisible)&&(identical(other.emailError, emailError) || other.emailError == emailError)&&(identical(other.passwordError, passwordError) || other.passwordError == passwordError)&&(identical(other.emailErrorMessage, emailErrorMessage) || other.emailErrorMessage == emailErrorMessage)&&(identical(other.passwordErrorMessage, passwordErrorMessage) || other.passwordErrorMessage == passwordErrorMessage));
}


@override
int get hashCode => Object.hash(runtimeType,isProcessing,email,password,isPasswordVisible,emailError,passwordError,emailErrorMessage,passwordErrorMessage);

@override
String toString() {
  return 'LoginWithEmailState(isProcessing: $isProcessing, email: $email, password: $password, isPasswordVisible: $isPasswordVisible, emailError: $emailError, passwordError: $passwordError, emailErrorMessage: $emailErrorMessage, passwordErrorMessage: $passwordErrorMessage)';
}


}

/// @nodoc
abstract mixin class $LoginWithEmailStateCopyWith<$Res>  {
  factory $LoginWithEmailStateCopyWith(LoginWithEmailState value, $Res Function(LoginWithEmailState) _then) = _$LoginWithEmailStateCopyWithImpl;
@useResult
$Res call({
 bool isProcessing, String email, String password, bool isPasswordVisible, bool emailError, bool passwordError, String? emailErrorMessage, String? passwordErrorMessage
});




}
/// @nodoc
class _$LoginWithEmailStateCopyWithImpl<$Res>
    implements $LoginWithEmailStateCopyWith<$Res> {
  _$LoginWithEmailStateCopyWithImpl(this._self, this._then);

  final LoginWithEmailState _self;
  final $Res Function(LoginWithEmailState) _then;

/// Create a copy of LoginWithEmailState
/// with the given fields replaced by the non-null parameter values.
@pragma('vm:prefer-inline') @override $Res call({Object? isProcessing = null,Object? email = null,Object? password = null,Object? isPasswordVisible = null,Object? emailError = null,Object? passwordError = null,Object? emailErrorMessage = freezed,Object? passwordErrorMessage = freezed,}) {
  return _then(_self.copyWith(
isProcessing: null == isProcessing ? _self.isProcessing : isProcessing // ignore: cast_nullable_to_non_nullable
as bool,email: null == email ? _self.email : email // ignore: cast_nullable_to_non_nullable
as String,password: null == password ? _self.password : password // ignore: cast_nullable_to_non_nullable
as String,isPasswordVisible: null == isPasswordVisible ? _self.isPasswordVisible : isPasswordVisible // ignore: cast_nullable_to_non_nullable
as bool,emailError: null == emailError ? _self.emailError : emailError // ignore: cast_nullable_to_non_nullable
as bool,passwordError: null == passwordError ? _self.passwordError : passwordError // ignore: cast_nullable_to_non_nullable
as bool,emailErrorMessage: freezed == emailErrorMessage ? _self.emailErrorMessage : emailErrorMessage // ignore: cast_nullable_to_non_nullable
as String?,passwordErrorMessage: freezed == passwordErrorMessage ? _self.passwordErrorMessage : passwordErrorMessage // ignore: cast_nullable_to_non_nullable
as String?,
  ));
}

}


/// Adds pattern-matching-related methods to [LoginWithEmailState].
extension LoginWithEmailStatePatterns on LoginWithEmailState {
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

@optionalTypeArgs TResult maybeMap<TResult extends Object?>(TResult Function( _LoginWithEmailState value)?  $default,{required TResult orElse(),}){
final _that = this;
switch (_that) {
case _LoginWithEmailState() when $default != null:
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

@optionalTypeArgs TResult map<TResult extends Object?>(TResult Function( _LoginWithEmailState value)  $default,){
final _that = this;
switch (_that) {
case _LoginWithEmailState():
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

@optionalTypeArgs TResult? mapOrNull<TResult extends Object?>(TResult? Function( _LoginWithEmailState value)?  $default,){
final _that = this;
switch (_that) {
case _LoginWithEmailState() when $default != null:
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

@optionalTypeArgs TResult maybeWhen<TResult extends Object?>(TResult Function( bool isProcessing,  String email,  String password,  bool isPasswordVisible,  bool emailError,  bool passwordError,  String? emailErrorMessage,  String? passwordErrorMessage)?  $default,{required TResult orElse(),}) {final _that = this;
switch (_that) {
case _LoginWithEmailState() when $default != null:
return $default(_that.isProcessing,_that.email,_that.password,_that.isPasswordVisible,_that.emailError,_that.passwordError,_that.emailErrorMessage,_that.passwordErrorMessage);case _:
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

@optionalTypeArgs TResult when<TResult extends Object?>(TResult Function( bool isProcessing,  String email,  String password,  bool isPasswordVisible,  bool emailError,  bool passwordError,  String? emailErrorMessage,  String? passwordErrorMessage)  $default,) {final _that = this;
switch (_that) {
case _LoginWithEmailState():
return $default(_that.isProcessing,_that.email,_that.password,_that.isPasswordVisible,_that.emailError,_that.passwordError,_that.emailErrorMessage,_that.passwordErrorMessage);}
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

@optionalTypeArgs TResult? whenOrNull<TResult extends Object?>(TResult? Function( bool isProcessing,  String email,  String password,  bool isPasswordVisible,  bool emailError,  bool passwordError,  String? emailErrorMessage,  String? passwordErrorMessage)?  $default,) {final _that = this;
switch (_that) {
case _LoginWithEmailState() when $default != null:
return $default(_that.isProcessing,_that.email,_that.password,_that.isPasswordVisible,_that.emailError,_that.passwordError,_that.emailErrorMessage,_that.passwordErrorMessage);case _:
  return null;

}
}

}

/// @nodoc


class _LoginWithEmailState extends LoginWithEmailState {
  const _LoginWithEmailState({this.isProcessing = false, this.email = '', this.password = '', this.isPasswordVisible = false, this.emailError = false, this.passwordError = false, this.emailErrorMessage, this.passwordErrorMessage}): super._();
  

@override@JsonKey() final  bool isProcessing;
@override@JsonKey() final  String email;
@override@JsonKey() final  String password;
@override@JsonKey() final  bool isPasswordVisible;
@override@JsonKey() final  bool emailError;
@override@JsonKey() final  bool passwordError;
@override final  String? emailErrorMessage;
@override final  String? passwordErrorMessage;

/// Create a copy of LoginWithEmailState
/// with the given fields replaced by the non-null parameter values.
@override @JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
_$LoginWithEmailStateCopyWith<_LoginWithEmailState> get copyWith => __$LoginWithEmailStateCopyWithImpl<_LoginWithEmailState>(this, _$identity);



@override
bool operator ==(Object other) {
  return identical(this, other) || (other.runtimeType == runtimeType&&other is _LoginWithEmailState&&(identical(other.isProcessing, isProcessing) || other.isProcessing == isProcessing)&&(identical(other.email, email) || other.email == email)&&(identical(other.password, password) || other.password == password)&&(identical(other.isPasswordVisible, isPasswordVisible) || other.isPasswordVisible == isPasswordVisible)&&(identical(other.emailError, emailError) || other.emailError == emailError)&&(identical(other.passwordError, passwordError) || other.passwordError == passwordError)&&(identical(other.emailErrorMessage, emailErrorMessage) || other.emailErrorMessage == emailErrorMessage)&&(identical(other.passwordErrorMessage, passwordErrorMessage) || other.passwordErrorMessage == passwordErrorMessage));
}


@override
int get hashCode => Object.hash(runtimeType,isProcessing,email,password,isPasswordVisible,emailError,passwordError,emailErrorMessage,passwordErrorMessage);

@override
String toString() {
  return 'LoginWithEmailState(isProcessing: $isProcessing, email: $email, password: $password, isPasswordVisible: $isPasswordVisible, emailError: $emailError, passwordError: $passwordError, emailErrorMessage: $emailErrorMessage, passwordErrorMessage: $passwordErrorMessage)';
}


}

/// @nodoc
abstract mixin class _$LoginWithEmailStateCopyWith<$Res> implements $LoginWithEmailStateCopyWith<$Res> {
  factory _$LoginWithEmailStateCopyWith(_LoginWithEmailState value, $Res Function(_LoginWithEmailState) _then) = __$LoginWithEmailStateCopyWithImpl;
@override @useResult
$Res call({
 bool isProcessing, String email, String password, bool isPasswordVisible, bool emailError, bool passwordError, String? emailErrorMessage, String? passwordErrorMessage
});




}
/// @nodoc
class __$LoginWithEmailStateCopyWithImpl<$Res>
    implements _$LoginWithEmailStateCopyWith<$Res> {
  __$LoginWithEmailStateCopyWithImpl(this._self, this._then);

  final _LoginWithEmailState _self;
  final $Res Function(_LoginWithEmailState) _then;

/// Create a copy of LoginWithEmailState
/// with the given fields replaced by the non-null parameter values.
@override @pragma('vm:prefer-inline') $Res call({Object? isProcessing = null,Object? email = null,Object? password = null,Object? isPasswordVisible = null,Object? emailError = null,Object? passwordError = null,Object? emailErrorMessage = freezed,Object? passwordErrorMessage = freezed,}) {
  return _then(_LoginWithEmailState(
isProcessing: null == isProcessing ? _self.isProcessing : isProcessing // ignore: cast_nullable_to_non_nullable
as bool,email: null == email ? _self.email : email // ignore: cast_nullable_to_non_nullable
as String,password: null == password ? _self.password : password // ignore: cast_nullable_to_non_nullable
as String,isPasswordVisible: null == isPasswordVisible ? _self.isPasswordVisible : isPasswordVisible // ignore: cast_nullable_to_non_nullable
as bool,emailError: null == emailError ? _self.emailError : emailError // ignore: cast_nullable_to_non_nullable
as bool,passwordError: null == passwordError ? _self.passwordError : passwordError // ignore: cast_nullable_to_non_nullable
as bool,emailErrorMessage: freezed == emailErrorMessage ? _self.emailErrorMessage : emailErrorMessage // ignore: cast_nullable_to_non_nullable
as String?,passwordErrorMessage: freezed == passwordErrorMessage ? _self.passwordErrorMessage : passwordErrorMessage // ignore: cast_nullable_to_non_nullable
as String?,
  ));
}


}

// dart format on
