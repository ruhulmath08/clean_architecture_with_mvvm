//to convert the response into a non nullable object (model)
import 'package:clean_architecture_with_mvvm/app/constant.dart';
import 'package:clean_architecture_with_mvvm/app/extensions.dart';
import 'package:clean_architecture_with_mvvm/data/responses/responses.dart';
import 'package:clean_architecture_with_mvvm/domain/entities/model.dart';

extension CustomerResponseMapper on CustomerResponse? {
  Customer toDomain() {
    return Customer(
      this?.id?.orEmpty() ?? Constant.empty,
      this?.name?.orEmpty() ?? Constant.empty,
      this?.numberOfNotifications?.orZero() ?? Constant.zero,
    );
  }
}

extension ContractResponseMapper on ContractResponse? {
  Contracts toDomain() {
    return Contracts(
      this?.phone?.orEmpty() ?? Constant.empty,
      this?.link?.orEmpty() ?? Constant.empty,
      this?.email?.orEmpty() ?? Constant.empty,
    );
  }
}

extension AuthenticationMapper on AuthenticationResponse? {
  Authentication toDomain() {
    return Authentication(
      this?.customer.toDomain(),
      this?.contracts.toDomain(),
    );
  }
}

extension ForgetPasswordMapper on ForgetPasswordResponse? {
  String toDomain() {
    return this?.support?.orEmpty() ?? Constant.empty;
  }
}
