//ignore: depend_on_referenced_packages
import 'package:json_annotation/json_annotation.dart';

part 'responses.g.dart';

@JsonSerializable()
class BaseResponses {
  @JsonKey(name: 'status')
  int? status;
  @JsonKey(name: 'message')
  String? message;
}

@JsonSerializable()
class CustomerResponse {
  @JsonKey(name: 'id')
  String? id;
  @JsonKey(name: 'name')
  String? name;
  @JsonKey(name: 'numberOfNotifications')
  int? numberOfNotifications;

  CustomerResponse(this.id, this.name, this.numberOfNotifications);

  //fromJson
  factory CustomerResponse.fromJson(Map<String, dynamic> json) =>
      _$CustomerResponseFromJson(json);

  //toJson
  Map<String, dynamic> toJson() => _$CustomerResponseToJson(this);
}

@JsonSerializable()
class ContractResponse {
  @JsonKey(name: 'phone')
  String? phone;
  @JsonKey(name: 'link')
  String? link;
  @JsonKey(name: 'email')
  String? email;

  ContractResponse(this.phone, this.link, this.email);

  //fromJson
  factory ContractResponse.fromJson(Map<String, dynamic> json) =>
      _$ContractResponseFromJson(json);

  //toJson
  Map<String, dynamic> toJson() => _$ContractResponseToJson(this);
}

@JsonSerializable()
class AuthenticationResponse extends BaseResponses {
  @JsonKey(name: 'customer')
  CustomerResponse? customer;
  @JsonKey(name: 'contracts')
  ContractResponse? contracts;

  AuthenticationResponse(this.customer, this.contracts);

  //fromJson
  factory AuthenticationResponse.fromJson(Map<String, dynamic> json) =>
      _$AuthenticationResponseFromJson(json);

  //toJson
  Map<String, dynamic> toJson() => _$AuthenticationResponseToJson(this);
}

@JsonSerializable()
class ForgetPasswordResponse extends BaseResponses {
  @JsonKey(name: 'support')
  String? support;

  ForgetPasswordResponse(this.support);

  //toJson
  Map<String, dynamic> toJson() => _$ForgetPasswordResponseToJson(this);

  //fromJson
  factory ForgetPasswordResponse.fromJson(Map<String, dynamic> json) =>
      _$ForgetPasswordResponseFromJson(json);
}
