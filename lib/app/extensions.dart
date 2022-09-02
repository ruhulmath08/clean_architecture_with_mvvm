//extensions on String
import 'package:clean_architecture_with_mvvm/app/constant.dart';

extension NonNullString on String? {
  String orEmpty() {
    if (this == null) {
      return Constant.empty;
    } else {
      return this!;
    }
  }
}

//extensions on int
extension NonNullInteger on int? {
  int orZero() {
    if (this == null) {
      return Constant.zero;
    } else {
      return this!;
    }
  }
}
