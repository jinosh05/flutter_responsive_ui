/// Strict Pattern
/// Symbol ^ and $ in pattern is to make sure all the string value following the pattern
/// Regex will return false if any of the character not following the pattern, even if using hasMatch function
/// Example: Pattern : Email -> 'This is your email : test@gmail.com' will return `false`, but 'test@gmail.com' will return `true`
class RegexPattern {
  /// Username regex
  /// Requires minimum 3 character
  /// Allowing "_" and "." in middle of name
  static String username = r'^[a-zA-Z0-9][a-zA-Z0-9_.]+[a-zA-Z0-9]$';

  /// Email regex
  static String email =
      r'^[a-z0-9]+([-+._][a-z0-9]+){0,2}@.*?(\.(a(?:[cdefgilmnoqrstuwxz]|ero|(?:rp|si)a)|b(?:[abdefghijmnorstvwyz]iz)|c(?:[acdfghiklmnoruvxyz]|at|o(?:m|op))|d[ejkmoz]|e(?:[ceghrstu]|du)|f[ijkmor]|g(?:[abdefghilmnpqrstuwy]|ov)|h[kmnrtu]|i(?:[delmnoqrst]|n(?:fo|t))|j(?:[emop]|obs)|k[eghimnprwyz]|l[abcikrstuvy]|m(?:[acdeghklmnopqrstuvwxyz]|il|obi|useum)|n(?:[acefgilopruz]|ame|et)|o(?:m|rg)|p(?:[aefghklmnrstwy]|ro)|qa|r[eosuw]|s[abcdeghijklmnortuvyz]|t(?:[cdfghjklmnoprtvwz]|(?:rav)?el)|u[agkmsyz]|v[aceginu]|w[fs]|y[etu]|z[amw])\b){1,2}$';

  /// Phone Number regex
  /// Must started by either, "0", "+", "+XX <X between 2 to 4 digit>", "(+XX <X between 2 to 3 digit>)"
  /// Can add whitespace separating digit with "+" or "(+XX)"
  /// Example: 05555555555, +555 5555555555, (+123) 5555555555, (555) 5555555555, +5555 5555555555
  static String phone =
      r'^(0|\+|(\+[0-9]{2,4}|\(\+?[0-9]{2,4}\)) ?)([0-9]*|\d{2,4}-\d{2,4}(-\d{2,4})?)$';

  /// Currency regex
  static String currency =
      r'^(S?\$|\₩|Rp|\¥|\€|\₹|\₽|fr|R$|R)?[ ]?[-]?([0-9]{1,3}[,.]([0-9]{3}[,.])*[0-9]{3}|[0-9]+)([,.][0-9]{1,2})?( ?(USD?|AUD|NZD|CAD|CHF|GBP|CNY|EUR|JPY|IDR|MXN|NOK|KRW|TRY|INR|RUB|BRL|ZAR|SGD|MYR))?$';

  /// Numeric Only regex (No Whitespace & Symbols)
  static String numericOnly = r'^\d+$';

  /// Alphabet Only regex (No Whitespace & Symbols)
  static String alphabetOnly = r'^[a-zA-Z]+$';

  /// Alphabet & Numeric Only regex (No Whitespace & Symbols)
  static String alphaNumericOnly = r'^[a-zA-Z0-9]+$';

  /// Alphabet, Numeric, Symbol Only regex (No Whitespace & Symbols)
  static String alphaNumericSymbolOnly = r'^[a-zA-Z0-9!@#$%^&*()-_+=]+$';

  /// Password (Easy) Regex
  /// Allowing all character except 'whitespace'
  /// Minimum character: 8
  static String passwordEasy = r'^\S{8,}$';
}

class RegVal {
  /// Returns whether the pattern has a match in the string [input].
  static bool hasMatch(String? str, String pattern) =>
      str == null ? false : RegExp(pattern).hasMatch(str);
}
