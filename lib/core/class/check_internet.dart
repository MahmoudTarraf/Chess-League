import 'dart:io';

checkInternet() async {
  try {
    final result = await InternetAddress.lookup("google.com");
    if (result.isNotEmpty && result[0].rawAddress.isNotEmpty) {
      return true;
    }
  } on WebSocketException catch (_) {
    return false;
  }
}
