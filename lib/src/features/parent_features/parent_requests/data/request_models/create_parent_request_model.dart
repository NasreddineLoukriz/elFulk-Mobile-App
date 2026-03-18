import 'package:json_annotation/json_annotation.dart';

part 'create_parent_request_model.g.dart';

@JsonSerializable(createFactory: false)
class CreateParentRequestModel {
  const CreateParentRequestModel({
    required this.childName,
    required this.requestType,
    required this.note,
  });

  @JsonKey(name: 'child_name')
  final String childName;
  @JsonKey(name: 'request_type')
  final String requestType;
  final String note;

  Map<String, dynamic> toJson() => _$CreateParentRequestModelToJson(this);
}
