// GENERATED CODE - DO NOT MODIFY BY HAND
// coverage:ignore-file
// ignore_for_file: type=lint
// ignore_for_file: unused_element, deprecated_member_use, deprecated_member_use_from_same_package, use_function_type_syntax_for_parameters, unnecessary_const, avoid_init_to_null, invalid_override_different_default_values_named, prefer_expression_function_bodies, annotate_overrides, invalid_annotation_target, unnecessary_question_mark

part of 'course_state.dart';

// **************************************************************************
// FreezedGenerator
// **************************************************************************

// dart format off
T _$identity<T>(T value) => value;
/// @nodoc
mixin _$CourseState {

 List<LessonItem> get lessons; Lesson? get selectedLesson; bool get isTasksExist; bool get isLessonsLoading; bool get isLessonDetailsLoading;
/// Create a copy of CourseState
/// with the given fields replaced by the non-null parameter values.
@JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
$CourseStateCopyWith<CourseState> get copyWith => _$CourseStateCopyWithImpl<CourseState>(this as CourseState, _$identity);



@override
bool operator ==(Object other) {
  return identical(this, other) || (other.runtimeType == runtimeType&&other is CourseState&&const DeepCollectionEquality().equals(other.lessons, lessons)&&(identical(other.selectedLesson, selectedLesson) || other.selectedLesson == selectedLesson)&&(identical(other.isTasksExist, isTasksExist) || other.isTasksExist == isTasksExist)&&(identical(other.isLessonsLoading, isLessonsLoading) || other.isLessonsLoading == isLessonsLoading)&&(identical(other.isLessonDetailsLoading, isLessonDetailsLoading) || other.isLessonDetailsLoading == isLessonDetailsLoading));
}


@override
int get hashCode => Object.hash(runtimeType,const DeepCollectionEquality().hash(lessons),selectedLesson,isTasksExist,isLessonsLoading,isLessonDetailsLoading);

@override
String toString() {
  return 'CourseState(lessons: $lessons, selectedLesson: $selectedLesson, isTasksExist: $isTasksExist, isLessonsLoading: $isLessonsLoading, isLessonDetailsLoading: $isLessonDetailsLoading)';
}


}

/// @nodoc
abstract mixin class $CourseStateCopyWith<$Res>  {
  factory $CourseStateCopyWith(CourseState value, $Res Function(CourseState) _then) = _$CourseStateCopyWithImpl;
@useResult
$Res call({
 List<LessonItem> lessons, Lesson? selectedLesson, bool isTasksExist, bool isLessonsLoading, bool isLessonDetailsLoading
});




}
/// @nodoc
class _$CourseStateCopyWithImpl<$Res>
    implements $CourseStateCopyWith<$Res> {
  _$CourseStateCopyWithImpl(this._self, this._then);

  final CourseState _self;
  final $Res Function(CourseState) _then;

/// Create a copy of CourseState
/// with the given fields replaced by the non-null parameter values.
@pragma('vm:prefer-inline') @override $Res call({Object? lessons = null,Object? selectedLesson = freezed,Object? isTasksExist = null,Object? isLessonsLoading = null,Object? isLessonDetailsLoading = null,}) {
  return _then(_self.copyWith(
lessons: null == lessons ? _self.lessons : lessons // ignore: cast_nullable_to_non_nullable
as List<LessonItem>,selectedLesson: freezed == selectedLesson ? _self.selectedLesson : selectedLesson // ignore: cast_nullable_to_non_nullable
as Lesson?,isTasksExist: null == isTasksExist ? _self.isTasksExist : isTasksExist // ignore: cast_nullable_to_non_nullable
as bool,isLessonsLoading: null == isLessonsLoading ? _self.isLessonsLoading : isLessonsLoading // ignore: cast_nullable_to_non_nullable
as bool,isLessonDetailsLoading: null == isLessonDetailsLoading ? _self.isLessonDetailsLoading : isLessonDetailsLoading // ignore: cast_nullable_to_non_nullable
as bool,
  ));
}

}


/// Adds pattern-matching-related methods to [CourseState].
extension CourseStatePatterns on CourseState {
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

@optionalTypeArgs TResult maybeMap<TResult extends Object?>(TResult Function( _CourseState value)?  $default,{required TResult orElse(),}){
final _that = this;
switch (_that) {
case _CourseState() when $default != null:
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

@optionalTypeArgs TResult map<TResult extends Object?>(TResult Function( _CourseState value)  $default,){
final _that = this;
switch (_that) {
case _CourseState():
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

@optionalTypeArgs TResult? mapOrNull<TResult extends Object?>(TResult? Function( _CourseState value)?  $default,){
final _that = this;
switch (_that) {
case _CourseState() when $default != null:
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

@optionalTypeArgs TResult maybeWhen<TResult extends Object?>(TResult Function( List<LessonItem> lessons,  Lesson? selectedLesson,  bool isTasksExist,  bool isLessonsLoading,  bool isLessonDetailsLoading)?  $default,{required TResult orElse(),}) {final _that = this;
switch (_that) {
case _CourseState() when $default != null:
return $default(_that.lessons,_that.selectedLesson,_that.isTasksExist,_that.isLessonsLoading,_that.isLessonDetailsLoading);case _:
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

@optionalTypeArgs TResult when<TResult extends Object?>(TResult Function( List<LessonItem> lessons,  Lesson? selectedLesson,  bool isTasksExist,  bool isLessonsLoading,  bool isLessonDetailsLoading)  $default,) {final _that = this;
switch (_that) {
case _CourseState():
return $default(_that.lessons,_that.selectedLesson,_that.isTasksExist,_that.isLessonsLoading,_that.isLessonDetailsLoading);case _:
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

@optionalTypeArgs TResult? whenOrNull<TResult extends Object?>(TResult? Function( List<LessonItem> lessons,  Lesson? selectedLesson,  bool isTasksExist,  bool isLessonsLoading,  bool isLessonDetailsLoading)?  $default,) {final _that = this;
switch (_that) {
case _CourseState() when $default != null:
return $default(_that.lessons,_that.selectedLesson,_that.isTasksExist,_that.isLessonsLoading,_that.isLessonDetailsLoading);case _:
  return null;

}
}

}

/// @nodoc


class _CourseState implements CourseState {
  const _CourseState({final  List<LessonItem> lessons = const [], this.selectedLesson, this.isTasksExist = false, this.isLessonsLoading = false, this.isLessonDetailsLoading = false}): _lessons = lessons;
  

 final  List<LessonItem> _lessons;
@override@JsonKey() List<LessonItem> get lessons {
  if (_lessons is EqualUnmodifiableListView) return _lessons;
  // ignore: implicit_dynamic_type
  return EqualUnmodifiableListView(_lessons);
}

@override final  Lesson? selectedLesson;
@override@JsonKey() final  bool isTasksExist;
@override@JsonKey() final  bool isLessonsLoading;
@override@JsonKey() final  bool isLessonDetailsLoading;

/// Create a copy of CourseState
/// with the given fields replaced by the non-null parameter values.
@override @JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
_$CourseStateCopyWith<_CourseState> get copyWith => __$CourseStateCopyWithImpl<_CourseState>(this, _$identity);



@override
bool operator ==(Object other) {
  return identical(this, other) || (other.runtimeType == runtimeType&&other is _CourseState&&const DeepCollectionEquality().equals(other._lessons, _lessons)&&(identical(other.selectedLesson, selectedLesson) || other.selectedLesson == selectedLesson)&&(identical(other.isTasksExist, isTasksExist) || other.isTasksExist == isTasksExist)&&(identical(other.isLessonsLoading, isLessonsLoading) || other.isLessonsLoading == isLessonsLoading)&&(identical(other.isLessonDetailsLoading, isLessonDetailsLoading) || other.isLessonDetailsLoading == isLessonDetailsLoading));
}


@override
int get hashCode => Object.hash(runtimeType,const DeepCollectionEquality().hash(_lessons),selectedLesson,isTasksExist,isLessonsLoading,isLessonDetailsLoading);

@override
String toString() {
  return 'CourseState(lessons: $lessons, selectedLesson: $selectedLesson, isTasksExist: $isTasksExist, isLessonsLoading: $isLessonsLoading, isLessonDetailsLoading: $isLessonDetailsLoading)';
}


}

/// @nodoc
abstract mixin class _$CourseStateCopyWith<$Res> implements $CourseStateCopyWith<$Res> {
  factory _$CourseStateCopyWith(_CourseState value, $Res Function(_CourseState) _then) = __$CourseStateCopyWithImpl;
@override @useResult
$Res call({
 List<LessonItem> lessons, Lesson? selectedLesson, bool isTasksExist, bool isLessonsLoading, bool isLessonDetailsLoading
});




}
/// @nodoc
class __$CourseStateCopyWithImpl<$Res>
    implements _$CourseStateCopyWith<$Res> {
  __$CourseStateCopyWithImpl(this._self, this._then);

  final _CourseState _self;
  final $Res Function(_CourseState) _then;

/// Create a copy of CourseState
/// with the given fields replaced by the non-null parameter values.
@override @pragma('vm:prefer-inline') $Res call({Object? lessons = null,Object? selectedLesson = freezed,Object? isTasksExist = null,Object? isLessonsLoading = null,Object? isLessonDetailsLoading = null,}) {
  return _then(_CourseState(
lessons: null == lessons ? _self._lessons : lessons // ignore: cast_nullable_to_non_nullable
as List<LessonItem>,selectedLesson: freezed == selectedLesson ? _self.selectedLesson : selectedLesson // ignore: cast_nullable_to_non_nullable
as Lesson?,isTasksExist: null == isTasksExist ? _self.isTasksExist : isTasksExist // ignore: cast_nullable_to_non_nullable
as bool,isLessonsLoading: null == isLessonsLoading ? _self.isLessonsLoading : isLessonsLoading // ignore: cast_nullable_to_non_nullable
as bool,isLessonDetailsLoading: null == isLessonDetailsLoading ? _self.isLessonDetailsLoading : isLessonDetailsLoading // ignore: cast_nullable_to_non_nullable
as bool,
  ));
}


}

// dart format on
