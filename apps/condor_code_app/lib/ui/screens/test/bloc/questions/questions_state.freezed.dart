// GENERATED CODE - DO NOT MODIFY BY HAND
// coverage:ignore-file
// ignore_for_file: type=lint
// ignore_for_file: unused_element, deprecated_member_use, deprecated_member_use_from_same_package, use_function_type_syntax_for_parameters, unnecessary_const, avoid_init_to_null, invalid_override_different_default_values_named, prefer_expression_function_bodies, annotate_overrides, invalid_annotation_target, unnecessary_question_mark

part of 'questions_state.dart';

// **************************************************************************
// FreezedGenerator
// **************************************************************************

// dart format off
T _$identity<T>(T value) => value;
/// @nodoc
mixin _$QuestionsState {

 int get correctCounter; int get incorrectCounter; List<Question> get questions; List<Question> get incorrectQuestions; int get currentQuestionPosition; int get answerNumber; int get heartCounter; bool get isWorkOnMistakesActive; bool get isButtonEnabled;
/// Create a copy of QuestionsState
/// with the given fields replaced by the non-null parameter values.
@JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
$QuestionsStateCopyWith<QuestionsState> get copyWith => _$QuestionsStateCopyWithImpl<QuestionsState>(this as QuestionsState, _$identity);



@override
bool operator ==(Object other) {
  return identical(this, other) || (other.runtimeType == runtimeType&&other is QuestionsState&&(identical(other.correctCounter, correctCounter) || other.correctCounter == correctCounter)&&(identical(other.incorrectCounter, incorrectCounter) || other.incorrectCounter == incorrectCounter)&&const DeepCollectionEquality().equals(other.questions, questions)&&const DeepCollectionEquality().equals(other.incorrectQuestions, incorrectQuestions)&&(identical(other.currentQuestionPosition, currentQuestionPosition) || other.currentQuestionPosition == currentQuestionPosition)&&(identical(other.answerNumber, answerNumber) || other.answerNumber == answerNumber)&&(identical(other.heartCounter, heartCounter) || other.heartCounter == heartCounter)&&(identical(other.isWorkOnMistakesActive, isWorkOnMistakesActive) || other.isWorkOnMistakesActive == isWorkOnMistakesActive)&&(identical(other.isButtonEnabled, isButtonEnabled) || other.isButtonEnabled == isButtonEnabled));
}


@override
int get hashCode => Object.hash(runtimeType,correctCounter,incorrectCounter,const DeepCollectionEquality().hash(questions),const DeepCollectionEquality().hash(incorrectQuestions),currentQuestionPosition,answerNumber,heartCounter,isWorkOnMistakesActive,isButtonEnabled);

@override
String toString() {
  return 'QuestionsState(correctCounter: $correctCounter, incorrectCounter: $incorrectCounter, questions: $questions, incorrectQuestions: $incorrectQuestions, currentQuestionPosition: $currentQuestionPosition, answerNumber: $answerNumber, heartCounter: $heartCounter, isWorkOnMistakesActive: $isWorkOnMistakesActive, isButtonEnabled: $isButtonEnabled)';
}


}

/// @nodoc
abstract mixin class $QuestionsStateCopyWith<$Res>  {
  factory $QuestionsStateCopyWith(QuestionsState value, $Res Function(QuestionsState) _then) = _$QuestionsStateCopyWithImpl;
@useResult
$Res call({
 int correctCounter, int incorrectCounter, List<Question> questions, List<Question> incorrectQuestions, int currentQuestionPosition, int answerNumber, int heartCounter, bool isWorkOnMistakesActive, bool isButtonEnabled
});




}
/// @nodoc
class _$QuestionsStateCopyWithImpl<$Res>
    implements $QuestionsStateCopyWith<$Res> {
  _$QuestionsStateCopyWithImpl(this._self, this._then);

  final QuestionsState _self;
  final $Res Function(QuestionsState) _then;

/// Create a copy of QuestionsState
/// with the given fields replaced by the non-null parameter values.
@pragma('vm:prefer-inline') @override $Res call({Object? correctCounter = null,Object? incorrectCounter = null,Object? questions = null,Object? incorrectQuestions = null,Object? currentQuestionPosition = null,Object? answerNumber = null,Object? heartCounter = null,Object? isWorkOnMistakesActive = null,Object? isButtonEnabled = null,}) {
  return _then(_self.copyWith(
correctCounter: null == correctCounter ? _self.correctCounter : correctCounter // ignore: cast_nullable_to_non_nullable
as int,incorrectCounter: null == incorrectCounter ? _self.incorrectCounter : incorrectCounter // ignore: cast_nullable_to_non_nullable
as int,questions: null == questions ? _self.questions : questions // ignore: cast_nullable_to_non_nullable
as List<Question>,incorrectQuestions: null == incorrectQuestions ? _self.incorrectQuestions : incorrectQuestions // ignore: cast_nullable_to_non_nullable
as List<Question>,currentQuestionPosition: null == currentQuestionPosition ? _self.currentQuestionPosition : currentQuestionPosition // ignore: cast_nullable_to_non_nullable
as int,answerNumber: null == answerNumber ? _self.answerNumber : answerNumber // ignore: cast_nullable_to_non_nullable
as int,heartCounter: null == heartCounter ? _self.heartCounter : heartCounter // ignore: cast_nullable_to_non_nullable
as int,isWorkOnMistakesActive: null == isWorkOnMistakesActive ? _self.isWorkOnMistakesActive : isWorkOnMistakesActive // ignore: cast_nullable_to_non_nullable
as bool,isButtonEnabled: null == isButtonEnabled ? _self.isButtonEnabled : isButtonEnabled // ignore: cast_nullable_to_non_nullable
as bool,
  ));
}

}


/// Adds pattern-matching-related methods to [QuestionsState].
extension QuestionsStatePatterns on QuestionsState {
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

@optionalTypeArgs TResult maybeMap<TResult extends Object?>(TResult Function( _QuestionsState value)?  $default,{required TResult orElse(),}){
final _that = this;
switch (_that) {
case _QuestionsState() when $default != null:
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

@optionalTypeArgs TResult map<TResult extends Object?>(TResult Function( _QuestionsState value)  $default,){
final _that = this;
switch (_that) {
case _QuestionsState():
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

@optionalTypeArgs TResult? mapOrNull<TResult extends Object?>(TResult? Function( _QuestionsState value)?  $default,){
final _that = this;
switch (_that) {
case _QuestionsState() when $default != null:
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

@optionalTypeArgs TResult maybeWhen<TResult extends Object?>(TResult Function( int correctCounter,  int incorrectCounter,  List<Question> questions,  List<Question> incorrectQuestions,  int currentQuestionPosition,  int answerNumber,  int heartCounter,  bool isWorkOnMistakesActive,  bool isButtonEnabled)?  $default,{required TResult orElse(),}) {final _that = this;
switch (_that) {
case _QuestionsState() when $default != null:
return $default(_that.correctCounter,_that.incorrectCounter,_that.questions,_that.incorrectQuestions,_that.currentQuestionPosition,_that.answerNumber,_that.heartCounter,_that.isWorkOnMistakesActive,_that.isButtonEnabled);case _:
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

@optionalTypeArgs TResult when<TResult extends Object?>(TResult Function( int correctCounter,  int incorrectCounter,  List<Question> questions,  List<Question> incorrectQuestions,  int currentQuestionPosition,  int answerNumber,  int heartCounter,  bool isWorkOnMistakesActive,  bool isButtonEnabled)  $default,) {final _that = this;
switch (_that) {
case _QuestionsState():
return $default(_that.correctCounter,_that.incorrectCounter,_that.questions,_that.incorrectQuestions,_that.currentQuestionPosition,_that.answerNumber,_that.heartCounter,_that.isWorkOnMistakesActive,_that.isButtonEnabled);case _:
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

@optionalTypeArgs TResult? whenOrNull<TResult extends Object?>(TResult? Function( int correctCounter,  int incorrectCounter,  List<Question> questions,  List<Question> incorrectQuestions,  int currentQuestionPosition,  int answerNumber,  int heartCounter,  bool isWorkOnMistakesActive,  bool isButtonEnabled)?  $default,) {final _that = this;
switch (_that) {
case _QuestionsState() when $default != null:
return $default(_that.correctCounter,_that.incorrectCounter,_that.questions,_that.incorrectQuestions,_that.currentQuestionPosition,_that.answerNumber,_that.heartCounter,_that.isWorkOnMistakesActive,_that.isButtonEnabled);case _:
  return null;

}
}

}

/// @nodoc


class _QuestionsState extends QuestionsState {
  const _QuestionsState({this.correctCounter = 0, this.incorrectCounter = 0, final  List<Question> questions = const [], final  List<Question> incorrectQuestions = const [], this.currentQuestionPosition = 0, this.answerNumber = 0, this.heartCounter = 5, this.isWorkOnMistakesActive = false, this.isButtonEnabled = false}): _questions = questions,_incorrectQuestions = incorrectQuestions,super._();
  

@override@JsonKey() final  int correctCounter;
@override@JsonKey() final  int incorrectCounter;
 final  List<Question> _questions;
@override@JsonKey() List<Question> get questions {
  if (_questions is EqualUnmodifiableListView) return _questions;
  // ignore: implicit_dynamic_type
  return EqualUnmodifiableListView(_questions);
}

 final  List<Question> _incorrectQuestions;
@override@JsonKey() List<Question> get incorrectQuestions {
  if (_incorrectQuestions is EqualUnmodifiableListView) return _incorrectQuestions;
  // ignore: implicit_dynamic_type
  return EqualUnmodifiableListView(_incorrectQuestions);
}

@override@JsonKey() final  int currentQuestionPosition;
@override@JsonKey() final  int answerNumber;
@override@JsonKey() final  int heartCounter;
@override@JsonKey() final  bool isWorkOnMistakesActive;
@override@JsonKey() final  bool isButtonEnabled;

/// Create a copy of QuestionsState
/// with the given fields replaced by the non-null parameter values.
@override @JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
_$QuestionsStateCopyWith<_QuestionsState> get copyWith => __$QuestionsStateCopyWithImpl<_QuestionsState>(this, _$identity);



@override
bool operator ==(Object other) {
  return identical(this, other) || (other.runtimeType == runtimeType&&other is _QuestionsState&&(identical(other.correctCounter, correctCounter) || other.correctCounter == correctCounter)&&(identical(other.incorrectCounter, incorrectCounter) || other.incorrectCounter == incorrectCounter)&&const DeepCollectionEquality().equals(other._questions, _questions)&&const DeepCollectionEquality().equals(other._incorrectQuestions, _incorrectQuestions)&&(identical(other.currentQuestionPosition, currentQuestionPosition) || other.currentQuestionPosition == currentQuestionPosition)&&(identical(other.answerNumber, answerNumber) || other.answerNumber == answerNumber)&&(identical(other.heartCounter, heartCounter) || other.heartCounter == heartCounter)&&(identical(other.isWorkOnMistakesActive, isWorkOnMistakesActive) || other.isWorkOnMistakesActive == isWorkOnMistakesActive)&&(identical(other.isButtonEnabled, isButtonEnabled) || other.isButtonEnabled == isButtonEnabled));
}


@override
int get hashCode => Object.hash(runtimeType,correctCounter,incorrectCounter,const DeepCollectionEquality().hash(_questions),const DeepCollectionEquality().hash(_incorrectQuestions),currentQuestionPosition,answerNumber,heartCounter,isWorkOnMistakesActive,isButtonEnabled);

@override
String toString() {
  return 'QuestionsState(correctCounter: $correctCounter, incorrectCounter: $incorrectCounter, questions: $questions, incorrectQuestions: $incorrectQuestions, currentQuestionPosition: $currentQuestionPosition, answerNumber: $answerNumber, heartCounter: $heartCounter, isWorkOnMistakesActive: $isWorkOnMistakesActive, isButtonEnabled: $isButtonEnabled)';
}


}

/// @nodoc
abstract mixin class _$QuestionsStateCopyWith<$Res> implements $QuestionsStateCopyWith<$Res> {
  factory _$QuestionsStateCopyWith(_QuestionsState value, $Res Function(_QuestionsState) _then) = __$QuestionsStateCopyWithImpl;
@override @useResult
$Res call({
 int correctCounter, int incorrectCounter, List<Question> questions, List<Question> incorrectQuestions, int currentQuestionPosition, int answerNumber, int heartCounter, bool isWorkOnMistakesActive, bool isButtonEnabled
});




}
/// @nodoc
class __$QuestionsStateCopyWithImpl<$Res>
    implements _$QuestionsStateCopyWith<$Res> {
  __$QuestionsStateCopyWithImpl(this._self, this._then);

  final _QuestionsState _self;
  final $Res Function(_QuestionsState) _then;

/// Create a copy of QuestionsState
/// with the given fields replaced by the non-null parameter values.
@override @pragma('vm:prefer-inline') $Res call({Object? correctCounter = null,Object? incorrectCounter = null,Object? questions = null,Object? incorrectQuestions = null,Object? currentQuestionPosition = null,Object? answerNumber = null,Object? heartCounter = null,Object? isWorkOnMistakesActive = null,Object? isButtonEnabled = null,}) {
  return _then(_QuestionsState(
correctCounter: null == correctCounter ? _self.correctCounter : correctCounter // ignore: cast_nullable_to_non_nullable
as int,incorrectCounter: null == incorrectCounter ? _self.incorrectCounter : incorrectCounter // ignore: cast_nullable_to_non_nullable
as int,questions: null == questions ? _self._questions : questions // ignore: cast_nullable_to_non_nullable
as List<Question>,incorrectQuestions: null == incorrectQuestions ? _self._incorrectQuestions : incorrectQuestions // ignore: cast_nullable_to_non_nullable
as List<Question>,currentQuestionPosition: null == currentQuestionPosition ? _self.currentQuestionPosition : currentQuestionPosition // ignore: cast_nullable_to_non_nullable
as int,answerNumber: null == answerNumber ? _self.answerNumber : answerNumber // ignore: cast_nullable_to_non_nullable
as int,heartCounter: null == heartCounter ? _self.heartCounter : heartCounter // ignore: cast_nullable_to_non_nullable
as int,isWorkOnMistakesActive: null == isWorkOnMistakesActive ? _self.isWorkOnMistakesActive : isWorkOnMistakesActive // ignore: cast_nullable_to_non_nullable
as bool,isButtonEnabled: null == isButtonEnabled ? _self.isButtonEnabled : isButtonEnabled // ignore: cast_nullable_to_non_nullable
as bool,
  ));
}


}

// dart format on
