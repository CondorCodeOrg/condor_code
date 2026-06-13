// GENERATED CODE - DO NOT MODIFY BY HAND
// coverage:ignore-file
// ignore_for_file: type=lint
// ignore_for_file: unused_element, deprecated_member_use, deprecated_member_use_from_same_package, use_function_type_syntax_for_parameters, unnecessary_const, avoid_init_to_null, invalid_override_different_default_values_named, prefer_expression_function_bodies, annotate_overrides, invalid_annotation_target, unnecessary_question_mark

part of 'courses_state.dart';

// **************************************************************************
// FreezedGenerator
// **************************************************************************

// dart format off
T _$identity<T>(T value) => value;
/// @nodoc
mixin _$CoursesState {

 List<Course> get courses; bool get isLoading; CourseOpenCommand? get openCommand;
/// Create a copy of CoursesState
/// with the given fields replaced by the non-null parameter values.
@JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
$CoursesStateCopyWith<CoursesState> get copyWith => _$CoursesStateCopyWithImpl<CoursesState>(this as CoursesState, _$identity);



@override
bool operator ==(Object other) {
  return identical(this, other) || (other.runtimeType == runtimeType&&other is CoursesState&&const DeepCollectionEquality().equals(other.courses, courses)&&(identical(other.isLoading, isLoading) || other.isLoading == isLoading)&&(identical(other.openCommand, openCommand) || other.openCommand == openCommand));
}


@override
int get hashCode => Object.hash(runtimeType,const DeepCollectionEquality().hash(courses),isLoading,openCommand);



}

/// @nodoc
abstract mixin class $CoursesStateCopyWith<$Res>  {
  factory $CoursesStateCopyWith(CoursesState value, $Res Function(CoursesState) _then) = _$CoursesStateCopyWithImpl;
@useResult
$Res call({
 List<Course> courses, bool isLoading, CourseOpenCommand? openCommand
});




}
/// @nodoc
class _$CoursesStateCopyWithImpl<$Res>
    implements $CoursesStateCopyWith<$Res> {
  _$CoursesStateCopyWithImpl(this._self, this._then);

  final CoursesState _self;
  final $Res Function(CoursesState) _then;

/// Create a copy of CoursesState
/// with the given fields replaced by the non-null parameter values.
@pragma('vm:prefer-inline') @override $Res call({Object? courses = null,Object? isLoading = null,Object? openCommand = freezed,}) {
  return _then(_self.copyWith(
courses: null == courses ? _self.courses : courses // ignore: cast_nullable_to_non_nullable
as List<Course>,isLoading: null == isLoading ? _self.isLoading : isLoading // ignore: cast_nullable_to_non_nullable
as bool,openCommand: freezed == openCommand ? _self.openCommand : openCommand // ignore: cast_nullable_to_non_nullable
as CourseOpenCommand?,
  ));
}

}


/// Adds pattern-matching-related methods to [CoursesState].
extension CoursesStatePatterns on CoursesState {
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

@optionalTypeArgs TResult maybeMap<TResult extends Object?>(TResult Function( _CoursesState value)?  $default,{required TResult orElse(),}){
final _that = this;
switch (_that) {
case _CoursesState() when $default != null:
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

@optionalTypeArgs TResult map<TResult extends Object?>(TResult Function( _CoursesState value)  $default,){
final _that = this;
switch (_that) {
case _CoursesState():
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

@optionalTypeArgs TResult? mapOrNull<TResult extends Object?>(TResult? Function( _CoursesState value)?  $default,){
final _that = this;
switch (_that) {
case _CoursesState() when $default != null:
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

@optionalTypeArgs TResult maybeWhen<TResult extends Object?>(TResult Function( List<Course> courses,  bool isLoading,  CourseOpenCommand? openCommand)?  $default,{required TResult orElse(),}) {final _that = this;
switch (_that) {
case _CoursesState() when $default != null:
return $default(_that.courses,_that.isLoading,_that.openCommand);case _:
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

@optionalTypeArgs TResult when<TResult extends Object?>(TResult Function( List<Course> courses,  bool isLoading,  CourseOpenCommand? openCommand)  $default,) {final _that = this;
switch (_that) {
case _CoursesState():
return $default(_that.courses,_that.isLoading,_that.openCommand);case _:
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

@optionalTypeArgs TResult? whenOrNull<TResult extends Object?>(TResult? Function( List<Course> courses,  bool isLoading,  CourseOpenCommand? openCommand)?  $default,) {final _that = this;
switch (_that) {
case _CoursesState() when $default != null:
return $default(_that.courses,_that.isLoading,_that.openCommand);case _:
  return null;

}
}

}

/// @nodoc


class _CoursesState implements CoursesState {
  const _CoursesState({final  List<Course> courses = const [], this.isLoading = false, this.openCommand}): _courses = courses;
  

 final  List<Course> _courses;
@override@JsonKey() List<Course> get courses {
  if (_courses is EqualUnmodifiableListView) return _courses;
  // ignore: implicit_dynamic_type
  return EqualUnmodifiableListView(_courses);
}

@override@JsonKey() final  bool isLoading;
@override final  CourseOpenCommand? openCommand;

/// Create a copy of CoursesState
/// with the given fields replaced by the non-null parameter values.
@override @JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
_$CoursesStateCopyWith<_CoursesState> get copyWith => __$CoursesStateCopyWithImpl<_CoursesState>(this, _$identity);



@override
bool operator ==(Object other) {
  return identical(this, other) || (other.runtimeType == runtimeType&&other is _CoursesState&&const DeepCollectionEquality().equals(other._courses, _courses)&&(identical(other.isLoading, isLoading) || other.isLoading == isLoading)&&(identical(other.openCommand, openCommand) || other.openCommand == openCommand));
}


@override
int get hashCode => Object.hash(runtimeType,const DeepCollectionEquality().hash(_courses),isLoading,openCommand);



}

/// @nodoc
abstract mixin class _$CoursesStateCopyWith<$Res> implements $CoursesStateCopyWith<$Res> {
  factory _$CoursesStateCopyWith(_CoursesState value, $Res Function(_CoursesState) _then) = __$CoursesStateCopyWithImpl;
@override @useResult
$Res call({
 List<Course> courses, bool isLoading, CourseOpenCommand? openCommand
});




}
/// @nodoc
class __$CoursesStateCopyWithImpl<$Res>
    implements _$CoursesStateCopyWith<$Res> {
  __$CoursesStateCopyWithImpl(this._self, this._then);

  final _CoursesState _self;
  final $Res Function(_CoursesState) _then;

/// Create a copy of CoursesState
/// with the given fields replaced by the non-null parameter values.
@override @pragma('vm:prefer-inline') $Res call({Object? courses = null,Object? isLoading = null,Object? openCommand = freezed,}) {
  return _then(_CoursesState(
courses: null == courses ? _self._courses : courses // ignore: cast_nullable_to_non_nullable
as List<Course>,isLoading: null == isLoading ? _self.isLoading : isLoading // ignore: cast_nullable_to_non_nullable
as bool,openCommand: freezed == openCommand ? _self.openCommand : openCommand // ignore: cast_nullable_to_non_nullable
as CourseOpenCommand?,
  ));
}


}

// dart format on
