// GENERATED CODE - DO NOT MODIFY BY HAND
// coverage:ignore-file
// ignore_for_file: type=lint
// ignore_for_file: unused_element, deprecated_member_use, deprecated_member_use_from_same_package, use_function_type_syntax_for_parameters, unnecessary_const, avoid_init_to_null, invalid_override_different_default_values_named, prefer_expression_function_bodies, annotate_overrides, invalid_annotation_target, unnecessary_question_mark

part of 'sign_up_state.dart';

// **************************************************************************
// FreezedGenerator
// **************************************************************************

// dart format off
T _$identity<T>(T value) => value;
/// @nodoc
mixin _$SignUpState {

 bool get isProcessing; String get username; String get email; String get password; String get confirmPassword; bool get isPasswordVisible; bool get isConfirmPasswordVisible; bool get emailError; bool get usernameError; bool get passwordError; bool get confirmPasswordError; String? get usernameErrorMessage; String? get emailErrorMessage; String? get passwordErrorMessage; String? get confirmPasswordErrorMessage; Map<String, String>? get commonErrorMessage;
/// Create a copy of SignUpState
/// with the given fields replaced by the non-null parameter values.
@JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
$SignUpStateCopyWith<SignUpState> get copyWith => _$SignUpStateCopyWithImpl<SignUpState>(this as SignUpState, _$identity);



@override
bool operator ==(Object other) {
  return identical(this, other) || (other.runtimeType == runtimeType&&other is SignUpState&&(identical(other.isProcessing, isProcessing) || other.isProcessing == isProcessing)&&(identical(other.username, username) || other.username == username)&&(identical(other.email, email) || other.email == email)&&(identical(other.password, password) || other.password == password)&&(identical(other.confirmPassword, confirmPassword) || other.confirmPassword == confirmPassword)&&(identical(other.isPasswordVisible, isPasswordVisible) || other.isPasswordVisible == isPasswordVisible)&&(identical(other.isConfirmPasswordVisible, isConfirmPasswordVisible) || other.isConfirmPasswordVisible == isConfirmPasswordVisible)&&(identical(other.emailError, emailError) || other.emailError == emailError)&&(identical(other.usernameError, usernameError) || other.usernameError == usernameError)&&(identical(other.passwordError, passwordError) || other.passwordError == passwordError)&&(identical(other.confirmPasswordError, confirmPasswordError) || other.confirmPasswordError == confirmPasswordError)&&(identical(other.usernameErrorMessage, usernameErrorMessage) || other.usernameErrorMessage == usernameErrorMessage)&&(identical(other.emailErrorMessage, emailErrorMessage) || other.emailErrorMessage == emailErrorMessage)&&(identical(other.passwordErrorMessage, passwordErrorMessage) || other.passwordErrorMessage == passwordErrorMessage)&&(identical(other.confirmPasswordErrorMessage, confirmPasswordErrorMessage) || other.confirmPasswordErrorMessage == confirmPasswordErrorMessage)&&const DeepCollectionEquality().equals(other.commonErrorMessage, commonErrorMessage));
}


@override
int get hashCode => Object.hash(runtimeType,isProcessing,username,email,password,confirmPassword,isPasswordVisible,isConfirmPasswordVisible,emailError,usernameError,passwordError,confirmPasswordError,usernameErrorMessage,emailErrorMessage,passwordErrorMessage,confirmPasswordErrorMessage,const DeepCollectionEquality().hash(commonErrorMessage));

@override
String toString() {
  return 'SignUpState(isProcessing: $isProcessing, username: $username, email: $email, password: $password, confirmPassword: $confirmPassword, isPasswordVisible: $isPasswordVisible, isConfirmPasswordVisible: $isConfirmPasswordVisible, emailError: $emailError, usernameError: $usernameError, passwordError: $passwordError, confirmPasswordError: $confirmPasswordError, usernameErrorMessage: $usernameErrorMessage, emailErrorMessage: $emailErrorMessage, passwordErrorMessage: $passwordErrorMessage, confirmPasswordErrorMessage: $confirmPasswordErrorMessage, commonErrorMessage: $commonErrorMessage)';
}


}

/// @nodoc
abstract mixin class $SignUpStateCopyWith<$Res>  {
  factory $SignUpStateCopyWith(SignUpState value, $Res Function(SignUpState) _then) = _$SignUpStateCopyWithImpl;
@useResult
$Res call({
 bool isProcessing, String username, String email, String password, String confirmPassword, bool isPasswordVisible, bool isConfirmPasswordVisible, bool emailError, bool usernameError, bool passwordError, bool confirmPasswordError, String? usernameErrorMessage, String? emailErrorMessage, String? passwordErrorMessage, String? confirmPasswordErrorMessage, Map<String, String>? commonErrorMessage
});




}
/// @nodoc
class _$SignUpStateCopyWithImpl<$Res>
    implements $SignUpStateCopyWith<$Res> {
  _$SignUpStateCopyWithImpl(this._self, this._then);

  final SignUpState _self;
  final $Res Function(SignUpState) _then;

/// Create a copy of SignUpState
/// with the given fields replaced by the non-null parameter values.
@pragma('vm:prefer-inline') @override $Res call({Object? isProcessing = null,Object? username = null,Object? email = null,Object? password = null,Object? confirmPassword = null,Object? isPasswordVisible = null,Object? isConfirmPasswordVisible = null,Object? emailError = null,Object? usernameError = null,Object? passwordError = null,Object? confirmPasswordError = null,Object? usernameErrorMessage = freezed,Object? emailErrorMessage = freezed,Object? passwordErrorMessage = freezed,Object? confirmPasswordErrorMessage = freezed,Object? commonErrorMessage = freezed,}) {
  return _then(_self.copyWith(
isProcessing: null == isProcessing ? _self.isProcessing : isProcessing // ignore: cast_nullable_to_non_nullable
as bool,username: null == username ? _self.username : username // ignore: cast_nullable_to_non_nullable
as String,email: null == email ? _self.email : email // ignore: cast_nullable_to_non_nullable
as String,password: null == password ? _self.password : password // ignore: cast_nullable_to_non_nullable
as String,confirmPassword: null == confirmPassword ? _self.confirmPassword : confirmPassword // ignore: cast_nullable_to_non_nullable
as String,isPasswordVisible: null == isPasswordVisible ? _self.isPasswordVisible : isPasswordVisible // ignore: cast_nullable_to_non_nullable
as bool,isConfirmPasswordVisible: null == isConfirmPasswordVisible ? _self.isConfirmPasswordVisible : isConfirmPasswordVisible // ignore: cast_nullable_to_non_nullable
as bool,emailError: null == emailError ? _self.emailError : emailError // ignore: cast_nullable_to_non_nullable
as bool,usernameError: null == usernameError ? _self.usernameError : usernameError // ignore: cast_nullable_to_non_nullable
as bool,passwordError: null == passwordError ? _self.passwordError : passwordError // ignore: cast_nullable_to_non_nullable
as bool,confirmPasswordError: null == confirmPasswordError ? _self.confirmPasswordError : confirmPasswordError // ignore: cast_nullable_to_non_nullable
as bool,usernameErrorMessage: freezed == usernameErrorMessage ? _self.usernameErrorMessage : usernameErrorMessage // ignore: cast_nullable_to_non_nullable
as String?,emailErrorMessage: freezed == emailErrorMessage ? _self.emailErrorMessage : emailErrorMessage // ignore: cast_nullable_to_non_nullable
as String?,passwordErrorMessage: freezed == passwordErrorMessage ? _self.passwordErrorMessage : passwordErrorMessage // ignore: cast_nullable_to_non_nullable
as String?,confirmPasswordErrorMessage: freezed == confirmPasswordErrorMessage ? _self.confirmPasswordErrorMessage : confirmPasswordErrorMessage // ignore: cast_nullable_to_non_nullable
as String?,commonErrorMessage: freezed == commonErrorMessage ? _self.commonErrorMessage : commonErrorMessage // ignore: cast_nullable_to_non_nullable
as Map<String, String>?,
  ));
}

}


/// Adds pattern-matching-related methods to [SignUpState].
extension SignUpStatePatterns on SignUpState {
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

@optionalTypeArgs TResult maybeMap<TResult extends Object?>(TResult Function( _SignUpState value)?  $default,{required TResult orElse(),}){
final _that = this;
switch (_that) {
case _SignUpState() when $default != null:
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

@optionalTypeArgs TResult map<TResult extends Object?>(TResult Function( _SignUpState value)  $default,){
final _that = this;
switch (_that) {
case _SignUpState():
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

@optionalTypeArgs TResult? mapOrNull<TResult extends Object?>(TResult? Function( _SignUpState value)?  $default,){
final _that = this;
switch (_that) {
case _SignUpState() when $default != null:
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

@optionalTypeArgs TResult maybeWhen<TResult extends Object?>(TResult Function( bool isProcessing,  String username,  String email,  String password,  String confirmPassword,  bool isPasswordVisible,  bool isConfirmPasswordVisible,  bool emailError,  bool usernameError,  bool passwordError,  bool confirmPasswordError,  String? usernameErrorMessage,  String? emailErrorMessage,  String? passwordErrorMessage,  String? confirmPasswordErrorMessage,  Map<String, String>? commonErrorMessage)?  $default,{required TResult orElse(),}) {final _that = this;
switch (_that) {
case _SignUpState() when $default != null:
return $default(_that.isProcessing,_that.username,_that.email,_that.password,_that.confirmPassword,_that.isPasswordVisible,_that.isConfirmPasswordVisible,_that.emailError,_that.usernameError,_that.passwordError,_that.confirmPasswordError,_that.usernameErrorMessage,_that.emailErrorMessage,_that.passwordErrorMessage,_that.confirmPasswordErrorMessage,_that.commonErrorMessage);case _:
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

@optionalTypeArgs TResult when<TResult extends Object?>(TResult Function( bool isProcessing,  String username,  String email,  String password,  String confirmPassword,  bool isPasswordVisible,  bool isConfirmPasswordVisible,  bool emailError,  bool usernameError,  bool passwordError,  bool confirmPasswordError,  String? usernameErrorMessage,  String? emailErrorMessage,  String? passwordErrorMessage,  String? confirmPasswordErrorMessage,  Map<String, String>? commonErrorMessage)  $default,) {final _that = this;
switch (_that) {
case _SignUpState():
return $default(_that.isProcessing,_that.username,_that.email,_that.password,_that.confirmPassword,_that.isPasswordVisible,_that.isConfirmPasswordVisible,_that.emailError,_that.usernameError,_that.passwordError,_that.confirmPasswordError,_that.usernameErrorMessage,_that.emailErrorMessage,_that.passwordErrorMessage,_that.confirmPasswordErrorMessage,_that.commonErrorMessage);}
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

@optionalTypeArgs TResult? whenOrNull<TResult extends Object?>(TResult? Function( bool isProcessing,  String username,  String email,  String password,  String confirmPassword,  bool isPasswordVisible,  bool isConfirmPasswordVisible,  bool emailError,  bool usernameError,  bool passwordError,  bool confirmPasswordError,  String? usernameErrorMessage,  String? emailErrorMessage,  String? passwordErrorMessage,  String? confirmPasswordErrorMessage,  Map<String, String>? commonErrorMessage)?  $default,) {final _that = this;
switch (_that) {
case _SignUpState() when $default != null:
return $default(_that.isProcessing,_that.username,_that.email,_that.password,_that.confirmPassword,_that.isPasswordVisible,_that.isConfirmPasswordVisible,_that.emailError,_that.usernameError,_that.passwordError,_that.confirmPasswordError,_that.usernameErrorMessage,_that.emailErrorMessage,_that.passwordErrorMessage,_that.confirmPasswordErrorMessage,_that.commonErrorMessage);case _:
  return null;

}
}

}

/// @nodoc


class _SignUpState extends SignUpState {
  const _SignUpState({this.isProcessing = false, this.username = '', this.email = '', this.password = '', this.confirmPassword = '', this.isPasswordVisible = false, this.isConfirmPasswordVisible = false, this.emailError = false, this.usernameError = false, this.passwordError = false, this.confirmPasswordError = false, this.usernameErrorMessage, this.emailErrorMessage, this.passwordErrorMessage, this.confirmPasswordErrorMessage, final  Map<String, String>? commonErrorMessage}): _commonErrorMessage = commonErrorMessage,super._();
  

@override@JsonKey() final  bool isProcessing;
@override@JsonKey() final  String username;
@override@JsonKey() final  String email;
@override@JsonKey() final  String password;
@override@JsonKey() final  String confirmPassword;
@override@JsonKey() final  bool isPasswordVisible;
@override@JsonKey() final  bool isConfirmPasswordVisible;
@override@JsonKey() final  bool emailError;
@override@JsonKey() final  bool usernameError;
@override@JsonKey() final  bool passwordError;
@override@JsonKey() final  bool confirmPasswordError;
@override final  String? usernameErrorMessage;
@override final  String? emailErrorMessage;
@override final  String? passwordErrorMessage;
@override final  String? confirmPasswordErrorMessage;
 final  Map<String, String>? _commonErrorMessage;
@override Map<String, String>? get commonErrorMessage {
  final value = _commonErrorMessage;
  if (value == null) return null;
  if (_commonErrorMessage is EqualUnmodifiableMapView) return _commonErrorMessage;
  // ignore: implicit_dynamic_type
  return EqualUnmodifiableMapView(value);
}


/// Create a copy of SignUpState
/// with the given fields replaced by the non-null parameter values.
@override @JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
_$SignUpStateCopyWith<_SignUpState> get copyWith => __$SignUpStateCopyWithImpl<_SignUpState>(this, _$identity);



@override
bool operator ==(Object other) {
  return identical(this, other) || (other.runtimeType == runtimeType&&other is _SignUpState&&(identical(other.isProcessing, isProcessing) || other.isProcessing == isProcessing)&&(identical(other.username, username) || other.username == username)&&(identical(other.email, email) || other.email == email)&&(identical(other.password, password) || other.password == password)&&(identical(other.confirmPassword, confirmPassword) || other.confirmPassword == confirmPassword)&&(identical(other.isPasswordVisible, isPasswordVisible) || other.isPasswordVisible == isPasswordVisible)&&(identical(other.isConfirmPasswordVisible, isConfirmPasswordVisible) || other.isConfirmPasswordVisible == isConfirmPasswordVisible)&&(identical(other.emailError, emailError) || other.emailError == emailError)&&(identical(other.usernameError, usernameError) || other.usernameError == usernameError)&&(identical(other.passwordError, passwordError) || other.passwordError == passwordError)&&(identical(other.confirmPasswordError, confirmPasswordError) || other.confirmPasswordError == confirmPasswordError)&&(identical(other.usernameErrorMessage, usernameErrorMessage) || other.usernameErrorMessage == usernameErrorMessage)&&(identical(other.emailErrorMessage, emailErrorMessage) || other.emailErrorMessage == emailErrorMessage)&&(identical(other.passwordErrorMessage, passwordErrorMessage) || other.passwordErrorMessage == passwordErrorMessage)&&(identical(other.confirmPasswordErrorMessage, confirmPasswordErrorMessage) || other.confirmPasswordErrorMessage == confirmPasswordErrorMessage)&&const DeepCollectionEquality().equals(other._commonErrorMessage, _commonErrorMessage));
}


@override
int get hashCode => Object.hash(runtimeType,isProcessing,username,email,password,confirmPassword,isPasswordVisible,isConfirmPasswordVisible,emailError,usernameError,passwordError,confirmPasswordError,usernameErrorMessage,emailErrorMessage,passwordErrorMessage,confirmPasswordErrorMessage,const DeepCollectionEquality().hash(_commonErrorMessage));

@override
String toString() {
  return 'SignUpState(isProcessing: $isProcessing, username: $username, email: $email, password: $password, confirmPassword: $confirmPassword, isPasswordVisible: $isPasswordVisible, isConfirmPasswordVisible: $isConfirmPasswordVisible, emailError: $emailError, usernameError: $usernameError, passwordError: $passwordError, confirmPasswordError: $confirmPasswordError, usernameErrorMessage: $usernameErrorMessage, emailErrorMessage: $emailErrorMessage, passwordErrorMessage: $passwordErrorMessage, confirmPasswordErrorMessage: $confirmPasswordErrorMessage, commonErrorMessage: $commonErrorMessage)';
}


}

/// @nodoc
abstract mixin class _$SignUpStateCopyWith<$Res> implements $SignUpStateCopyWith<$Res> {
  factory _$SignUpStateCopyWith(_SignUpState value, $Res Function(_SignUpState) _then) = __$SignUpStateCopyWithImpl;
@override @useResult
$Res call({
 bool isProcessing, String username, String email, String password, String confirmPassword, bool isPasswordVisible, bool isConfirmPasswordVisible, bool emailError, bool usernameError, bool passwordError, bool confirmPasswordError, String? usernameErrorMessage, String? emailErrorMessage, String? passwordErrorMessage, String? confirmPasswordErrorMessage, Map<String, String>? commonErrorMessage
});




}
/// @nodoc
class __$SignUpStateCopyWithImpl<$Res>
    implements _$SignUpStateCopyWith<$Res> {
  __$SignUpStateCopyWithImpl(this._self, this._then);

  final _SignUpState _self;
  final $Res Function(_SignUpState) _then;

/// Create a copy of SignUpState
/// with the given fields replaced by the non-null parameter values.
@override @pragma('vm:prefer-inline') $Res call({Object? isProcessing = null,Object? username = null,Object? email = null,Object? password = null,Object? confirmPassword = null,Object? isPasswordVisible = null,Object? isConfirmPasswordVisible = null,Object? emailError = null,Object? usernameError = null,Object? passwordError = null,Object? confirmPasswordError = null,Object? usernameErrorMessage = freezed,Object? emailErrorMessage = freezed,Object? passwordErrorMessage = freezed,Object? confirmPasswordErrorMessage = freezed,Object? commonErrorMessage = freezed,}) {
  return _then(_SignUpState(
isProcessing: null == isProcessing ? _self.isProcessing : isProcessing // ignore: cast_nullable_to_non_nullable
as bool,username: null == username ? _self.username : username // ignore: cast_nullable_to_non_nullable
as String,email: null == email ? _self.email : email // ignore: cast_nullable_to_non_nullable
as String,password: null == password ? _self.password : password // ignore: cast_nullable_to_non_nullable
as String,confirmPassword: null == confirmPassword ? _self.confirmPassword : confirmPassword // ignore: cast_nullable_to_non_nullable
as String,isPasswordVisible: null == isPasswordVisible ? _self.isPasswordVisible : isPasswordVisible // ignore: cast_nullable_to_non_nullable
as bool,isConfirmPasswordVisible: null == isConfirmPasswordVisible ? _self.isConfirmPasswordVisible : isConfirmPasswordVisible // ignore: cast_nullable_to_non_nullable
as bool,emailError: null == emailError ? _self.emailError : emailError // ignore: cast_nullable_to_non_nullable
as bool,usernameError: null == usernameError ? _self.usernameError : usernameError // ignore: cast_nullable_to_non_nullable
as bool,passwordError: null == passwordError ? _self.passwordError : passwordError // ignore: cast_nullable_to_non_nullable
as bool,confirmPasswordError: null == confirmPasswordError ? _self.confirmPasswordError : confirmPasswordError // ignore: cast_nullable_to_non_nullable
as bool,usernameErrorMessage: freezed == usernameErrorMessage ? _self.usernameErrorMessage : usernameErrorMessage // ignore: cast_nullable_to_non_nullable
as String?,emailErrorMessage: freezed == emailErrorMessage ? _self.emailErrorMessage : emailErrorMessage // ignore: cast_nullable_to_non_nullable
as String?,passwordErrorMessage: freezed == passwordErrorMessage ? _self.passwordErrorMessage : passwordErrorMessage // ignore: cast_nullable_to_non_nullable
as String?,confirmPasswordErrorMessage: freezed == confirmPasswordErrorMessage ? _self.confirmPasswordErrorMessage : confirmPasswordErrorMessage // ignore: cast_nullable_to_non_nullable
as String?,commonErrorMessage: freezed == commonErrorMessage ? _self._commonErrorMessage : commonErrorMessage // ignore: cast_nullable_to_non_nullable
as Map<String, String>?,
  ));
}


}

// dart format on
