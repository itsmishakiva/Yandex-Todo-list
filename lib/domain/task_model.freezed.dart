// coverage:ignore-file
// GENERATED CODE - DO NOT MODIFY BY HAND
// ignore_for_file: type=lint
// ignore_for_file: unused_element, deprecated_member_use, deprecated_member_use_from_same_package, use_function_type_syntax_for_parameters, unnecessary_const, avoid_init_to_null, invalid_override_different_default_values_named, prefer_expression_function_bodies, annotate_overrides, invalid_annotation_target

part of 'task_model.dart';

// **************************************************************************
// FreezedGenerator
// **************************************************************************

T _$identity<T>(T value) => value;

final _privateConstructorUsedError = UnsupportedError(
    'It seems like you constructed your class using `MyClass._()`. This constructor is only meant to be used by freezed and you are not supposed to need it nor use it.\nPlease check the documentation here for more information: https://github.com/rrousselGit/freezed#custom-getters-and-methods');

TaskModel _$TaskModelFromJson(Map<String, dynamic> json) {
  return _TaskModel.fromJson(json);
}

/// @nodoc
mixin _$TaskModel {
  String get id => throw _privateConstructorUsedError;
  String get text => throw _privateConstructorUsedError;
  @JsonKey(name: 'created_at')
  int? get createdAt => throw _privateConstructorUsedError;
  @JsonKey(name: 'done', fromJson: MapperHelper.boolFromJson)
  bool get done => throw _privateConstructorUsedError;
  int? get deadline => throw _privateConstructorUsedError;
  @JsonKey(name: 'changed_at')
  int? get changedAt => throw _privateConstructorUsedError;
  String? get importance => throw _privateConstructorUsedError;
  @JsonKey(name: 'is_deleted', fromJson: MapperHelper.boolFromJson)
  bool get isDeleted => throw _privateConstructorUsedError;
  @JsonKey(name: 'last_updated_by')
  String? get deviceId => throw _privateConstructorUsedError;

  Map<String, dynamic> toJson() => throw _privateConstructorUsedError;
  @JsonKey(ignore: true)
  $TaskModelCopyWith<TaskModel> get copyWith =>
      throw _privateConstructorUsedError;
}

/// @nodoc
abstract class $TaskModelCopyWith<$Res> {
  factory $TaskModelCopyWith(TaskModel value, $Res Function(TaskModel) then) =
      _$TaskModelCopyWithImpl<$Res>;
  $Res call(
      {String id,
      String text,
      @JsonKey(name: 'created_at')
          int? createdAt,
      @JsonKey(name: 'done', fromJson: MapperHelper.boolFromJson)
          bool done,
      int? deadline,
      @JsonKey(name: 'changed_at')
          int? changedAt,
      String? importance,
      @JsonKey(name: 'is_deleted', fromJson: MapperHelper.boolFromJson)
          bool isDeleted,
      @JsonKey(name: 'last_updated_by')
          String? deviceId});
}

/// @nodoc
class _$TaskModelCopyWithImpl<$Res> implements $TaskModelCopyWith<$Res> {
  _$TaskModelCopyWithImpl(this._value, this._then);

  final TaskModel _value;
  // ignore: unused_field
  final $Res Function(TaskModel) _then;

  @override
  $Res call({
    Object? id = freezed,
    Object? text = freezed,
    Object? createdAt = freezed,
    Object? done = freezed,
    Object? deadline = freezed,
    Object? changedAt = freezed,
    Object? importance = freezed,
    Object? isDeleted = freezed,
    Object? deviceId = freezed,
  }) {
    return _then(_value.copyWith(
      id: id == freezed
          ? _value.id
          : id // ignore: cast_nullable_to_non_nullable
              as String,
      text: text == freezed
          ? _value.text
          : text // ignore: cast_nullable_to_non_nullable
              as String,
      createdAt: createdAt == freezed
          ? _value.createdAt
          : createdAt // ignore: cast_nullable_to_non_nullable
              as int?,
      done: done == freezed
          ? _value.done
          : done // ignore: cast_nullable_to_non_nullable
              as bool,
      deadline: deadline == freezed
          ? _value.deadline
          : deadline // ignore: cast_nullable_to_non_nullable
              as int?,
      changedAt: changedAt == freezed
          ? _value.changedAt
          : changedAt // ignore: cast_nullable_to_non_nullable
              as int?,
      importance: importance == freezed
          ? _value.importance
          : importance // ignore: cast_nullable_to_non_nullable
              as String?,
      isDeleted: isDeleted == freezed
          ? _value.isDeleted
          : isDeleted // ignore: cast_nullable_to_non_nullable
              as bool,
      deviceId: deviceId == freezed
          ? _value.deviceId
          : deviceId // ignore: cast_nullable_to_non_nullable
              as String?,
    ));
  }
}

/// @nodoc
abstract class _$$_TaskModelCopyWith<$Res> implements $TaskModelCopyWith<$Res> {
  factory _$$_TaskModelCopyWith(
          _$_TaskModel value, $Res Function(_$_TaskModel) then) =
      __$$_TaskModelCopyWithImpl<$Res>;
  @override
  $Res call(
      {String id,
      String text,
      @JsonKey(name: 'created_at')
          int? createdAt,
      @JsonKey(name: 'done', fromJson: MapperHelper.boolFromJson)
          bool done,
      int? deadline,
      @JsonKey(name: 'changed_at')
          int? changedAt,
      String? importance,
      @JsonKey(name: 'is_deleted', fromJson: MapperHelper.boolFromJson)
          bool isDeleted,
      @JsonKey(name: 'last_updated_by')
          String? deviceId});
}

/// @nodoc
class __$$_TaskModelCopyWithImpl<$Res> extends _$TaskModelCopyWithImpl<$Res>
    implements _$$_TaskModelCopyWith<$Res> {
  __$$_TaskModelCopyWithImpl(
      _$_TaskModel _value, $Res Function(_$_TaskModel) _then)
      : super(_value, (v) => _then(v as _$_TaskModel));

  @override
  _$_TaskModel get _value => super._value as _$_TaskModel;

  @override
  $Res call({
    Object? id = freezed,
    Object? text = freezed,
    Object? createdAt = freezed,
    Object? done = freezed,
    Object? deadline = freezed,
    Object? changedAt = freezed,
    Object? importance = freezed,
    Object? isDeleted = freezed,
    Object? deviceId = freezed,
  }) {
    return _then(_$_TaskModel(
      id: id == freezed
          ? _value.id
          : id // ignore: cast_nullable_to_non_nullable
              as String,
      text: text == freezed
          ? _value.text
          : text // ignore: cast_nullable_to_non_nullable
              as String,
      createdAt: createdAt == freezed
          ? _value.createdAt
          : createdAt // ignore: cast_nullable_to_non_nullable
              as int?,
      done: done == freezed
          ? _value.done
          : done // ignore: cast_nullable_to_non_nullable
              as bool,
      deadline: deadline == freezed
          ? _value.deadline
          : deadline // ignore: cast_nullable_to_non_nullable
              as int?,
      changedAt: changedAt == freezed
          ? _value.changedAt
          : changedAt // ignore: cast_nullable_to_non_nullable
              as int?,
      importance: importance == freezed
          ? _value.importance
          : importance // ignore: cast_nullable_to_non_nullable
              as String?,
      isDeleted: isDeleted == freezed
          ? _value.isDeleted
          : isDeleted // ignore: cast_nullable_to_non_nullable
              as bool,
      deviceId: deviceId == freezed
          ? _value.deviceId
          : deviceId // ignore: cast_nullable_to_non_nullable
              as String?,
    ));
  }
}

/// @nodoc
@JsonSerializable()
class _$_TaskModel implements _TaskModel {
  _$_TaskModel(
      {required this.id,
      required this.text,
      @JsonKey(name: 'created_at')
          this.createdAt,
      @JsonKey(name: 'done', fromJson: MapperHelper.boolFromJson)
          this.done = false,
      this.deadline,
      @JsonKey(name: 'changed_at')
          this.changedAt,
      this.importance = 'basic',
      @JsonKey(name: 'is_deleted', fromJson: MapperHelper.boolFromJson)
          this.isDeleted = false,
      @JsonKey(name: 'last_updated_by')
          this.deviceId});

  factory _$_TaskModel.fromJson(Map<String, dynamic> json) =>
      _$$_TaskModelFromJson(json);

  @override
  final String id;
  @override
  final String text;
  @override
  @JsonKey(name: 'created_at')
  final int? createdAt;
  @override
  @JsonKey(name: 'done', fromJson: MapperHelper.boolFromJson)
  final bool done;
  @override
  final int? deadline;
  @override
  @JsonKey(name: 'changed_at')
  final int? changedAt;
  @override
  @JsonKey()
  final String? importance;
  @override
  @JsonKey(name: 'is_deleted', fromJson: MapperHelper.boolFromJson)
  final bool isDeleted;
  @override
  @JsonKey(name: 'last_updated_by')
  final String? deviceId;

  @override
  String toString() {
    return 'TaskModel(id: $id, text: $text, createdAt: $createdAt, done: $done, deadline: $deadline, changedAt: $changedAt, importance: $importance, isDeleted: $isDeleted, deviceId: $deviceId)';
  }

  @override
  bool operator ==(dynamic other) {
    return identical(this, other) ||
        (other.runtimeType == runtimeType &&
            other is _$_TaskModel &&
            const DeepCollectionEquality().equals(other.id, id) &&
            const DeepCollectionEquality().equals(other.text, text) &&
            const DeepCollectionEquality().equals(other.createdAt, createdAt) &&
            const DeepCollectionEquality().equals(other.done, done) &&
            const DeepCollectionEquality().equals(other.deadline, deadline) &&
            const DeepCollectionEquality().equals(other.changedAt, changedAt) &&
            const DeepCollectionEquality()
                .equals(other.importance, importance) &&
            const DeepCollectionEquality().equals(other.isDeleted, isDeleted) &&
            const DeepCollectionEquality().equals(other.deviceId, deviceId));
  }

  @JsonKey(ignore: true)
  @override
  int get hashCode => Object.hash(
      runtimeType,
      const DeepCollectionEquality().hash(id),
      const DeepCollectionEquality().hash(text),
      const DeepCollectionEquality().hash(createdAt),
      const DeepCollectionEquality().hash(done),
      const DeepCollectionEquality().hash(deadline),
      const DeepCollectionEquality().hash(changedAt),
      const DeepCollectionEquality().hash(importance),
      const DeepCollectionEquality().hash(isDeleted),
      const DeepCollectionEquality().hash(deviceId));

  @JsonKey(ignore: true)
  @override
  _$$_TaskModelCopyWith<_$_TaskModel> get copyWith =>
      __$$_TaskModelCopyWithImpl<_$_TaskModel>(this, _$identity);

  @override
  Map<String, dynamic> toJson() {
    return _$$_TaskModelToJson(
      this,
    );
  }
}

abstract class _TaskModel implements TaskModel {
  factory _TaskModel(
      {required final String id,
      required final String text,
      @JsonKey(name: 'created_at')
          final int? createdAt,
      @JsonKey(name: 'done', fromJson: MapperHelper.boolFromJson)
          final bool done,
      final int? deadline,
      @JsonKey(name: 'changed_at')
          final int? changedAt,
      final String? importance,
      @JsonKey(name: 'is_deleted', fromJson: MapperHelper.boolFromJson)
          final bool isDeleted,
      @JsonKey(name: 'last_updated_by')
          final String? deviceId}) = _$_TaskModel;

  factory _TaskModel.fromJson(Map<String, dynamic> json) =
      _$_TaskModel.fromJson;

  @override
  String get id;
  @override
  String get text;
  @override
  @JsonKey(name: 'created_at')
  int? get createdAt;
  @override
  @JsonKey(name: 'done', fromJson: MapperHelper.boolFromJson)
  bool get done;
  @override
  int? get deadline;
  @override
  @JsonKey(name: 'changed_at')
  int? get changedAt;
  @override
  String? get importance;
  @override
  @JsonKey(name: 'is_deleted', fromJson: MapperHelper.boolFromJson)
  bool get isDeleted;
  @override
  @JsonKey(name: 'last_updated_by')
  String? get deviceId;
  @override
  @JsonKey(ignore: true)
  _$$_TaskModelCopyWith<_$_TaskModel> get copyWith =>
      throw _privateConstructorUsedError;
}
