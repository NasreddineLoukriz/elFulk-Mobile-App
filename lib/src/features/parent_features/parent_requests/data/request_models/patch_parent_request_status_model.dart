import 'package:json_annotation/json_annotation.dart';

part 'patch_parent_request_status_model.g.dart';

@JsonSerializable(createFactory: false)
class PatchParentRequestStatusModel {
  const PatchParentRequestStatusModel({
    required this.status,
    required this.reviewNote,
  });

  final String status;
  @JsonKey(name: 'review_note')
  final String reviewNote;

  Map<String, dynamic> toJson() => _$PatchParentRequestStatusModelToJson(this);
}
