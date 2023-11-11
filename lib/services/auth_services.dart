import "package:flutter_secure_storage/flutter_secure_storage.dart";
import "package:shared_preferences/shared_preferences.dart";

///
/// [AuthService] is a class used to Store and
///  Retrieve [SharedPreferences] datas
///  1) Declare the key for [SharedPreferences]
///  2) use get Method to fetch Stored datas
///  3) use the set Method to Store Datas
///
class AuthService {
  ///
  ///   KEYS OF SHARED PREFERENCE
  ///

  final String _firstOpen = "first_open";

  final String _userMail = "usermail";

  final String _userId = "user_id";

  final String _userName = "username";

  //
  //    INSTANCE OF SHARED PREFERENCE
  //
  Future<SharedPreferences> instance() async {
    final prefs = await SharedPreferences.getInstance();
    return prefs;
  }

  ///
  ///     GETTERS
  ///

  Future<bool> checkFirstOpen() async {
    final prefs = await instance();
    final first = prefs.getBool(_firstOpen) ?? true;
    // if (first) setFirstOpen();
    return first;
  }

  Future<String> getUserMail() async {
    final prefs = await instance();
    final value = prefs.getString(_userMail) ?? "";
    return value;
  }

  Future<String> getUserId() async {
    final name = await getUserName();
    final value = await _SecuredService().getUserId(_userId, username: name);
    // final prefs = await instance();
    // String? value = prefs.getString(_userId);
    return value;
  }

  Future<String> getUserName() async {
    final prefs = await instance();
    final value = prefs.getString(_userName);
    return value ?? "";
  }

  ///
  ///     SETTERS
  ///
  Future<void> setFirstOpen() async {
    final prefs = await instance();
    await prefs.setBool(_firstOpen, false);
  }

  Future<void> setUserMail(String value) async {
    final prefs = await instance();
    await prefs.setString(_userMail, value);
  }

  Future<void> setUserID(String value) async {
    final name = await getUserName();
    await _SecuredService().storeUserId(_userId, value, username: name);
    // final prefs = await instance();
    // prefs.setString(_userId, value);
  }

  Future<void> setUserName(String value) async {
    final prefs = await instance();
    await prefs.setString(_userName, value);
  }
}

///
///  [_SecuredService] is advanced version of [AuthService]
///  Use only limited datas which have to be Encrypted
///
class _SecuredService {
  ///
  /// Initialise [FlutterSecureStorage]
  ///
  final FlutterSecureStorage _storage = const FlutterSecureStorage();

  static const androidOptions = AndroidOptions(
    encryptedSharedPreferences: true,
    keyCipherAlgorithm:
        KeyCipherAlgorithm.RSA_ECB_OAEPwithSHA_256andMGF1Padding,
    storageCipherAlgorithm: StorageCipherAlgorithm.AES_GCM_NoPadding,
  );

  Future<void> storeUserId(
    String key,
    String value, {
    String username = "",
  }) async {
    await _storage.write(
      key: key,
      value: value,
      iOptions: IOSOptions(
        accountName:
            username.isEmpty ? AppleOptions.defaultAccountName : username,
      ),
      aOptions: androidOptions,
    );
  }

  Future<String> getUserId(String key, {String username = ""}) async {
    final name = await _storage.read(
      key: key,
      iOptions: IOSOptions(
        accountName:
            username.isEmpty ? AppleOptions.defaultAccountName : username,
      ),
      aOptions: androidOptions,
    );
    return name ?? "";
  }
}

// Future<String?> get() async {
//   final prefs = await instance();
//   String? value = prefs.getString();
//   return value;
// }

// void set(String value) async {
//   final prefs = await instance();
//   prefs.setString(a, value);
// }
