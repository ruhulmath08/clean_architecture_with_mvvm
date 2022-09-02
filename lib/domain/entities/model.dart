import 'package:clean_architecture_with_mvvm/data/responses/responses.dart';

class SliderObject {
  String title;
  String subTitle;
  String image;

  SliderObject(this.title, this.subTitle, this.image);
}

class Customer {
  String id;
  String name;
  int numberOfNotifications;

  Customer(this.id, this.name, this.numberOfNotifications);
}

class Contracts {
  String phone;
  String link;
  String email;

  Contracts(this.phone, this.link, this.email);
}

class Authentication {
  Customer? customer;
  Contracts? contracts;

  Authentication(this.customer, this.contracts);
}

class DeviceInfo {
  DeviceInfo(this.name, this.identifier, this.version);

  String name;
  String identifier;
  String version;
}
