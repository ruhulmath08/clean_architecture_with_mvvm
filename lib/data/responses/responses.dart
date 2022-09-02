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

  //from json
  factory CustomerResponse.fromJson(Map<String, dynamic> json) =>
      _$CustomerResponseFromJson(json);

  //to json
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

  //from json
  factory ContractResponse.fromJson(Map<String, dynamic> json) =>
      _$ContractResponseFromJson(json);

  //to json
  Map<String, dynamic> toJson() => _$ContractResponseToJson(this);
}

@JsonSerializable()
class AuthenticationResponse extends BaseResponses {
  @JsonKey(name: 'customer')
  CustomerResponse? customer;
  @JsonKey(name: 'contracts')
  ContractResponse? contracts;

  AuthenticationResponse(this.customer, this.contracts);

  //from json
  factory AuthenticationResponse.fromJson(Map<String, dynamic> json) =>
      _$AuthenticationResponseFromJson(json);

  //to json
  Map<String, dynamic> toJson() => _$AuthenticationResponseToJson(this);
}
