import "dart:developer";
import "dart:io";

///
/// [NetworkCheck] will check the Internet Availablity
///
class NetworkCheck {
  Future<bool> check() async {
    try {
      final result = await InternetAddress.lookup("google.com");
      if (result.isNotEmpty && result[0].rawAddress.isNotEmpty) {
        return true;
      }
    } on SocketException catch (_) {
      log("Internet_not connected");
      return false;
    }
    return false;
  }

  // dynamic checkInternet(Function func) {
  //   check().then((intenet) {
  //     if (intenet) {
  //       func(true);
  //     } else {
  //       func(false);
  //     }
  //   });
  // }
}
