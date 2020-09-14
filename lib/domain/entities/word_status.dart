import 'package:flutter/foundation.dart';

enum WordStatus {
  unused,
  success,
  mistake,
}

extension WordStatusExtension on WordStatus {
  String get statusString {
    switch (this) {
      case WordStatus.unused:
        return 'unused';
        break;
      case WordStatus.success:
        return 'success';
        break;
      case WordStatus.mistake:
        return 'mistake';
        break;
    }
  }
}

WordStatus wordStatusfromString({@required String wordStatusToString}) {
  if (wordStatusToString == 'success') {
    return WordStatus.success;
  } else if (wordStatusToString == 'mistake') {
    return WordStatus.mistake;
  } else {
    return WordStatus.unused;
  }
}
