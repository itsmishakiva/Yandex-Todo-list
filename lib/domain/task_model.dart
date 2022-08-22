import 'package:freezed_annotation/freezed_annotation.dart';

part 'task_model.freezed.dart';

part 'task_model.g.dart';

@freezed
class TaskModel with _$TaskModel {
  factory TaskModel({
    required String id,
    required String text,
    @JsonKey(name: 'created_at') int? createdAt,
    @JsonKey(name: 'done', fromJson: MapperHelper.boolFromJson)
    @Default(false)
        bool done,
    int? deadline,
    @JsonKey(name: 'changed_at') int? changedAt,
    @Default('basic') String? importance,
    @JsonKey(name: 'is_deleted', fromJson: MapperHelper.boolFromJson)
    @Default(false)
        bool isDeleted,
    @JsonKey(name: 'last_updated_by') String? deviceId,
  }) = _TaskModel;

  factory TaskModel.fromJson(Map<String, dynamic> json) =>
      _$TaskModelFromJson(json);
}

class MapperHelper {
  static bool boolFromJson(dynamic input) {
    if (input == 0) return false;
    if (input == false || input == true) return input;
    return true;
  }
}
