// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'task_model.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

_$_TaskModel _$$_TaskModelFromJson(Map<String, dynamic> json) => _$_TaskModel(
      id: json['id'] as String,
      text: json['text'] as String,
      createdAt: json['created_at'] as int?,
      done: json['done'] == null
          ? false
          : MapperHelper.boolFromJson(json['done']),
      deadline: json['deadline'] as int?,
      changedAt: json['changed_at'] as int?,
      importance: json['importance'] as String? ?? 'basic',
      isDeleted: json['is_deleted'] == null
          ? false
          : MapperHelper.boolFromJson(json['is_deleted']),
      deviceId: json['last_updated_by'] as String?,
    );

Map<String, dynamic> _$$_TaskModelToJson(_$_TaskModel instance) =>
    <String, dynamic>{
      'id': instance.id,
      'text': instance.text,
      'created_at': instance.createdAt,
      'done': instance.done,
      'deadline': instance.deadline,
      'changed_at': instance.changedAt,
      'importance': instance.importance,
      'is_deleted': instance.isDeleted,
      'last_updated_by': instance.deviceId,
    };
