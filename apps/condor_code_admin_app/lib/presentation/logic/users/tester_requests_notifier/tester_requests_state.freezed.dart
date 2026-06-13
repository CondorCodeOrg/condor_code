// GENERATED CODE - DO NOT MODIFY BY HAND
// coverage:ignore-file
// ignore_for_file: type=lint
// ignore_for_file: unused_element, deprecated_member_use, deprecated_member_use_from_same_package, use_function_type_syntax_for_parameters, unnecessary_const, avoid_init_to_null, invalid_override_different_default_values_named, prefer_expression_function_bodies, annotate_overrides, invalid_annotation_target, unnecessary_question_mark

part of 'tester_requests_state.dart';

// **************************************************************************
// FreezedGenerator
// **************************************************************************

// dart format off
T _$identity<T>(T value) => value;
/// @nodoc
mixin _$TesterRequestsState {

 bool get isLoading; bool get isProcessing; List<TesterAccessRequest> get requests; String? get errorMessage;
/// Create a copy of TesterRequestsState
/// with the given fields replaced by the non-null parameter values.
@JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
$TesterRequestsStateCopyWith<TesterRequestsState> get copyWith => _$TesterRequestsStateCopyWithImpl<TesterRequestsState>(this as TesterRequestsState, _$identity);



@override
bool operator ==(Object other) {
  return identical(this, other) || (other.runtimeType == runtimeType&&other is TesterRequestsState&&(identical(other.isLoading, isLoading) || other.isLoading == isLoading)&&(identical(other.isProcessing, isProcessing) || other.isProcessing == isProcessing)&&const DeepCollectionEquality().equals(other.requests, requests)&&(identical(other.errorMessage, errorMessage) || other.errorMessage == errorMessage));
}


@override
int get hashCode => Object.hash(runtimeType,isLoading,isProcessing,const DeepCollectionEquality().hash(requests),errorMessage);

@override
String toString() {
  return 'TesterRequestsState(isLoading: $isLoading, isProcessing: $isProcessing, requests: $requests, errorMessage: $errorMessage)';
}


}

/// @nodoc
abstract mixin class $TesterRequestsStateCopyWith<$Res>  {
  factory $TesterRequestsStateCopyWith(TesterRequestsState value, $Res Function(TesterRequestsState) _then) = _$TesterRequestsStateCopyWithImpl;
@useResult
$Res call({
 bool isLoading, bool isProcessing, List<TesterAccessRequest> requests, String? errorMessage
});




}
/// @nodoc
class _$TesterRequestsStateCopyWithImpl<$Res>
    implements $TesterRequestsStateCopyWith<$Res> {
  _$TesterRequestsStateCopyWithImpl(this._self, this._then);

  final TesterRequestsState _self;
  final $Res Function(TesterRequestsState) _then;

/// Create a copy of TesterRequestsState
/// with the given fields replaced by the non-null parameter values.
@pragma('vm:prefer-inline') @override $Res call({Object? isLoading = null,Object? isProcessing = null,Object? requests = null,Object? errorMessage = freezed,}) {
  return _then(_self.copyWith(
isLoading: null == isLoading ? _self.isLoading : isLoading // ignore: cast_nullable_to_non_nullable
as bool,isProcessing: null == isProcessing ? _self.isProcessing : isProcessing // ignore: cast_nullable_to_non_nullable
as bool,requests: null == requests ? _self.requests : requests // ignore: cast_nullable_to_non_nullable
as List<TesterAccessRequest>,errorMessage: freezed == errorMessage ? _self.errorMessage : errorMessage // ignore: cast_nullable_to_non_nullable
as String?,
  ));
}

}


/// Adds pattern-matching-related methods to [TesterRequestsState].
extension TesterRequestsStatePatterns on TesterRequestsState {
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

@optionalTypeArgs TResult maybeMap<TResult extends Object?>(TResult Function( _TesterRequestsState value)?  $default,{required TResult orElse(),}){
final _that = this;
switch (_that) {
case _TesterRequestsState() when $default != null:
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

@optionalTypeArgs TResult map<TResult extends Object?>(TResult Function( _TesterRequestsState value)  $default,){
final _that = this;
switch (_that) {
case _TesterRequestsState():
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

@optionalTypeArgs TResult? mapOrNull<TResult extends Object?>(TResult? Function( _TesterRequestsState value)?  $default,){
final _that = this;
switch (_that) {
case _TesterRequestsState() when $default != null:
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

@optionalTypeArgs TResult maybeWhen<TResult extends Object?>(TResult Function( bool isLoading,  bool isProcessing,  List<TesterAccessRequest> requests,  String? errorMessage)?  $default,{required TResult orElse(),}) {final _that = this;
switch (_that) {
case _TesterRequestsState() when $default != null:
return $default(_that.isLoading,_that.isProcessing,_that.requests,_that.errorMessage);case _:
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

@optionalTypeArgs TResult when<TResult extends Object?>(TResult Function( bool isLoading,  bool isProcessing,  List<TesterAccessRequest> requests,  String? errorMessage)  $default,) {final _that = this;
switch (_that) {
case _TesterRequestsState():
return $default(_that.isLoading,_that.isProcessing,_that.requests,_that.errorMessage);}
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

@optionalTypeArgs TResult? whenOrNull<TResult extends Object?>(TResult? Function( bool isLoading,  bool isProcessing,  List<TesterAccessRequest> requests,  String? errorMessage)?  $default,) {final _that = this;
switch (_that) {
case _TesterRequestsState() when $default != null:
return $default(_that.isLoading,_that.isProcessing,_that.requests,_that.errorMessage);case _:
  return null;

}
}

}

/// @nodoc


class _TesterRequestsState implements TesterRequestsState {
  const _TesterRequestsState({this.isLoading = false, this.isProcessing = false, final  List<TesterAccessRequest> requests = const <TesterAccessRequest>[], this.errorMessage}): _requests = requests;
  

@override@JsonKey() final  bool isLoading;
@override@JsonKey() final  bool isProcessing;
 final  List<TesterAccessRequest> _requests;
@override@JsonKey() List<TesterAccessRequest> get requests {
  if (_requests is EqualUnmodifiableListView) return _requests;
  // ignore: implicit_dynamic_type
  return EqualUnmodifiableListView(_requests);
}

@override final  String? errorMessage;

/// Create a copy of TesterRequestsState
/// with the given fields replaced by the non-null parameter values.
@override @JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
_$TesterRequestsStateCopyWith<_TesterRequestsState> get copyWith => __$TesterRequestsStateCopyWithImpl<_TesterRequestsState>(this, _$identity);



@override
bool operator ==(Object other) {
  return identical(this, other) || (other.runtimeType == runtimeType&&other is _TesterRequestsState&&(identical(other.isLoading, isLoading) || other.isLoading == isLoading)&&(identical(other.isProcessing, isProcessing) || other.isProcessing == isProcessing)&&const DeepCollectionEquality().equals(other._requests, _requests)&&(identical(other.errorMessage, errorMessage) || other.errorMessage == errorMessage));
}


@override
int get hashCode => Object.hash(runtimeType,isLoading,isProcessing,const DeepCollectionEquality().hash(_requests),errorMessage);

@override
String toString() {
  return 'TesterRequestsState(isLoading: $isLoading, isProcessing: $isProcessing, requests: $requests, errorMessage: $errorMessage)';
}


}

/// @nodoc
abstract mixin class _$TesterRequestsStateCopyWith<$Res> implements $TesterRequestsStateCopyWith<$Res> {
  factory _$TesterRequestsStateCopyWith(_TesterRequestsState value, $Res Function(_TesterRequestsState) _then) = __$TesterRequestsStateCopyWithImpl;
@override @useResult
$Res call({
 bool isLoading, bool isProcessing, List<TesterAccessRequest> requests, String? errorMessage
});




}
/// @nodoc
class __$TesterRequestsStateCopyWithImpl<$Res>
    implements _$TesterRequestsStateCopyWith<$Res> {
  __$TesterRequestsStateCopyWithImpl(this._self, this._then);

  final _TesterRequestsState _self;
  final $Res Function(_TesterRequestsState) _then;

/// Create a copy of TesterRequestsState
/// with the given fields replaced by the non-null parameter values.
@override @pragma('vm:prefer-inline') $Res call({Object? isLoading = null,Object? isProcessing = null,Object? requests = null,Object? errorMessage = freezed,}) {
  return _then(_TesterRequestsState(
isLoading: null == isLoading ? _self.isLoading : isLoading // ignore: cast_nullable_to_non_nullable
as bool,isProcessing: null == isProcessing ? _self.isProcessing : isProcessing // ignore: cast_nullable_to_non_nullable
as bool,requests: null == requests ? _self._requests : requests // ignore: cast_nullable_to_non_nullable
as List<TesterAccessRequest>,errorMessage: freezed == errorMessage ? _self.errorMessage : errorMessage // ignore: cast_nullable_to_non_nullable
as String?,
  ));
}


}

// dart format on
