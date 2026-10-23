import 'package:freezed_annotation/freezed_annotation.dart';

part 'register_request_model.g.dart';

/// جسم طلب إنشاء حساب جديد.
@JsonSerializable()
class RegisterRequestModel {
  RegisterRequestModel({
    required this.name,
    required this.email,
    required this.password,
  });

  factory RegisterRequestModel.fromJson(Map<String, dynamic> json) =>
      _$RegisterRequestModelFromJson(json);

  final String name;
  final String email;
  final String password;

  Map<String, dynamic> toJson() => _$RegisterRequestModelToJson(this);
}
