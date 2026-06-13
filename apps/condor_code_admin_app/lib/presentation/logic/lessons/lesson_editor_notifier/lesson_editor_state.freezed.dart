// GENERATED CODE - DO NOT MODIFY BY HAND
// coverage:ignore-file
// ignore_for_file: type=lint
// ignore_for_file: unused_element, deprecated_member_use, deprecated_member_use_from_same_package, use_function_type_syntax_for_parameters, unnecessary_const, avoid_init_to_null, invalid_override_different_default_values_named, prefer_expression_function_bodies, annotate_overrides, invalid_annotation_target, unnecessary_question_mark

part of 'lesson_editor_state.dart';

// **************************************************************************
// FreezedGenerator
// **************************************************************************

// dart format off
T _$identity<T>(T value) => value;
/// @nodoc
mixin _$LessonEditorState {

 Lesson? get lesson; List<Task> get tasks; List<Question> get questions; bool get isLoading; bool get isSaving; String? get errorMessage;
/// Create a copy of LessonEditorState
/// with the given fields replaced by the non-null parameter values.
@JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
$LessonEditorStateCopyWith<LessonEditorState> get copyWith => _$LessonEditorStateCopyWithImpl<LessonEditorState>(this as LessonEditorState, _$identity);



@override
bool operator ==(Object other) {
  return identical(this, other) || (other.runtimeType == runtimeType&&other is LessonEditorState&&(identical(other.lesson, lesson) || other.lesson == lesson)&&const DeepCollectionEquality().equals(other.tasks, tasks)&&const DeepCollectionEquality().equals(other.questions, questions)&&(identical(other.isLoading, isLoading) || other.isLoading == isLoading)&&(identical(other.isSaving, isSaving) || other.isSaving == isSaving)&&(identical(other.errorMessage, errorMessage) || other.errorMessage == errorMessage));
}


@override
int get hashCode => Object.hash(runtimeType,lesson,const DeepCollectionEquality().hash(tasks),const DeepCollectionEquality().hash(questions),isLoading,isSaving,errorMessage);

@override
String toString() {
  return 'LessonEditorState(lesson: $lesson, tasks: $tasks, questions: $questions, isLoading: $isLoading, isSaving: $isSaving, errorMessage: $errorMessage)';
}


}

/// @nodoc
abstract mixin class $LessonEditorStateCopyWith<$Res>  {
  factory $LessonEditorStateCopyWith(LessonEditorState value, $Res Function(LessonEditorState) _then) = _$LessonEditorStateCopyWithImpl;
@useResult
$Res call({
 Lesson? lesson, List<Task> tasks, List<Question> questions, bool isLoading, bool isSaving, String? errorMessage
});




}
/// @nodoc
class _$LessonEditorStateCopyWithImpl<$Res>
    implements $LessonEditorStateCopyWith<$Res> {
  _$LessonEditorStateCopyWithImpl(this._self, this._then);

  final LessonEditorState _self;
  final $Res Function(LessonEditorState) _then;

/// Create a copy of LessonEditorState
/// with the given fields replaced by the non-null parameter values.
@pragma('vm:prefer-inline') @override $Res call({Object? lesson = freezed,Object? tasks = null,Object? questions = null,Object? isLoading = null,Object? isSaving = null,Object? errorMessage = freezed,}) {
  return _then(_self.copyWith(
lesson: freezed == lesson ? _self.lesson : lesson // ignore: cast_nullable_to_non_nullable
as Lesson?,tasks: null == tasks ? _self.tasks : tasks // ignore: cast_nullable_to_non_nullable
as List<Task>,questions: null == questions ? _self.questions : questions // ignore: cast_nullable_to_non_nullable
as List<Question>,isLoading: null == isLoading ? _self.isLoading : isLoading // ignore: cast_nullable_to_non_nullable
as bool,isSaving: null == isSaving ? _self.isSaving : isSaving // ignore: cast_nullable_to_non_nullable
as bool,errorMessage: freezed == errorMessage ? _self.errorMessage : errorMessage // ignore: cast_nullable_to_non_nullable
as String?,
  ));
}

}


/// Adds pattern-matching-related methods to [LessonEditorState].
extension LessonEditorStatePatterns on LessonEditorState {
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

@optionalTypeArgs TResult maybeMap<TResult extends Object?>(TResult Function( _LessonEditorState value)?  $default,{required TResult orElse(),}){
final _that = this;
switch (_that) {
case _LessonEditorState() when $default != null:
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

@optionalTypeArgs TResult map<TResult extends Object?>(TResult Function( _LessonEditorState value)  $default,){
final _that = this;
switch (_that) {
case _LessonEditorState():
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

@optionalTypeArgs TResult? mapOrNull<TResult extends Object?>(TResult? Function( _LessonEditorState value)?  $default,){
final _that = this;
switch (_that) {
case _LessonEditorState() when $default != null:
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

@optionalTypeArgs TResult maybeWhen<TResult extends Object?>(TResult Function( Lesson? lesson,  List<Task> tasks,  List<Question> questions,  bool isLoading,  bool isSaving,  String? errorMessage)?  $default,{required TResult orElse(),}) {final _that = this;
switch (_that) {
case _LessonEditorState() when $default != null:
return $default(_that.lesson,_that.tasks,_that.questions,_that.isLoading,_that.isSaving,_that.errorMessage);case _:
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

@optionalTypeArgs TResult when<TResult extends Object?>(TResult Function( Lesson? lesson,  List<Task> tasks,  List<Question> questions,  bool isLoading,  bool isSaving,  String? errorMessage)  $default,) {final _that = this;
switch (_that) {
case _LessonEditorState():
return $default(_that.lesson,_that.tasks,_that.questions,_that.isLoading,_that.isSaving,_that.errorMessage);}
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

@optionalTypeArgs TResult? whenOrNull<TResult extends Object?>(TResult? Function( Lesson? lesson,  List<Task> tasks,  List<Question> questions,  bool isLoading,  bool isSaving,  String? errorMessage)?  $default,) {final _that = this;
switch (_that) {
case _LessonEditorState() when $default != null:
return $default(_that.lesson,_that.tasks,_that.questions,_that.isLoading,_that.isSaving,_that.errorMessage);case _:
  return null;

}
}

}

/// @nodoc


class _LessonEditorState extends LessonEditorState {
  const _LessonEditorState({this.lesson, final  List<Task> tasks = const <Task>[], final  List<Question> questions = const <Question>[], this.isLoading = false, this.isSaving = false, this.errorMessage}): _tasks = tasks,_questions = questions,super._();
  

@override final  Lesson? lesson;
 final  List<Task> _tasks;
@override@JsonKey() List<Task> get tasks {
  if (_tasks is EqualUnmodifiableListView) return _tasks;
  // ignore: implicit_dynamic_type
  return EqualUnmodifiableListView(_tasks);
}

 final  List<Question> _questions;
@override@JsonKey() List<Question> get questions {
  if (_questions is EqualUnmodifiableListView) return _questions;
  // ignore: implicit_dynamic_type
  return EqualUnmodifiableListView(_questions);
}

@override@JsonKey() final  bool isLoading;
@override@JsonKey() final  bool isSaving;
@override final  String? errorMessage;

/// Create a copy of LessonEditorState
/// with the given fields replaced by the non-null parameter values.
@override @JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
_$LessonEditorStateCopyWith<_LessonEditorState> get copyWith => __$LessonEditorStateCopyWithImpl<_LessonEditorState>(this, _$identity);



@override
bool operator ==(Object other) {
  return identical(this, other) || (other.runtimeType == runtimeType&&other is _LessonEditorState&&(identical(other.lesson, lesson) || other.lesson == lesson)&&const DeepCollectionEquality().equals(other._tasks, _tasks)&&const DeepCollectionEquality().equals(other._questions, _questions)&&(identical(other.isLoading, isLoading) || other.isLoading == isLoading)&&(identical(other.isSaving, isSaving) || other.isSaving == isSaving)&&(identical(other.errorMessage, errorMessage) || other.errorMessage == errorMessage));
}


@override
int get hashCode => Object.hash(runtimeType,lesson,const DeepCollectionEquality().hash(_tasks),const DeepCollectionEquality().hash(_questions),isLoading,isSaving,errorMessage);

@override
String toString() {
  return 'LessonEditorState(lesson: $lesson, tasks: $tasks, questions: $questions, isLoading: $isLoading, isSaving: $isSaving, errorMessage: $errorMessage)';
}


}

/// @nodoc
abstract mixin class _$LessonEditorStateCopyWith<$Res> implements $LessonEditorStateCopyWith<$Res> {
  factory _$LessonEditorStateCopyWith(_LessonEditorState value, $Res Function(_LessonEditorState) _then) = __$LessonEditorStateCopyWithImpl;
@override @useResult
$Res call({
 Lesson? lesson, List<Task> tasks, List<Question> questions, bool isLoading, bool isSaving, String? errorMessage
});




}
/// @nodoc
class __$LessonEditorStateCopyWithImpl<$Res>
    implements _$LessonEditorStateCopyWith<$Res> {
  __$LessonEditorStateCopyWithImpl(this._self, this._then);

  final _LessonEditorState _self;
  final $Res Function(_LessonEditorState) _then;

/// Create a copy of LessonEditorState
/// with the given fields replaced by the non-null parameter values.
@override @pragma('vm:prefer-inline') $Res call({Object? lesson = freezed,Object? tasks = null,Object? questions = null,Object? isLoading = null,Object? isSaving = null,Object? errorMessage = freezed,}) {
  return _then(_LessonEditorState(
lesson: freezed == lesson ? _self.lesson : lesson // ignore: cast_nullable_to_non_nullable
as Lesson?,tasks: null == tasks ? _self._tasks : tasks // ignore: cast_nullable_to_non_nullable
as List<Task>,questions: null == questions ? _self._questions : questions // ignore: cast_nullable_to_non_nullable
as List<Question>,isLoading: null == isLoading ? _self.isLoading : isLoading // ignore: cast_nullable_to_non_nullable
as bool,isSaving: null == isSaving ? _self.isSaving : isSaving // ignore: cast_nullable_to_non_nullable
as bool,errorMessage: freezed == errorMessage ? _self.errorMessage : errorMessage // ignore: cast_nullable_to_non_nullable
as String?,
  ));
}


}

// dart format on
