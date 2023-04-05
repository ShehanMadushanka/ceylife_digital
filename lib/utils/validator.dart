import 'package:ceylife_digital/features/data/models/common/configuration_data.dart';
import 'package:string_validator/string_validator.dart';

class Validator {
  static bool validateNIC(String nic) {
    String nic_part1, nic_part2;
    int length = nic.length;
    bool retVal = false;
    try {
      if (length == 10) {
        try {
          nic_part1 = nic.substring(length - 1, length);
          nic_part2 = nic.substring(0, length - 1);

          double.parse(nic_part2);
          if (nic_part1 == "v" ||
              nic_part1 == "V" ||
              nic_part1 == "x" ||
              nic_part1 == "X") {
            retVal = validateDayOfTheYear(nic);
          }
        } on FormatException catch (e) {
          retVal = false;
        }
      } else if (length == 12) {
        try {
          double.parse(nic);
          retVal = validateDayOfTheYear(nic);
        } on FormatException catch (e) {
          retVal = false;
        }
      }
    } on Exception catch (e) {
      retVal = false;
    }

    return retVal;
  }

  static bool validateDayOfTheYear(String nic) {
    bool ret = false;
    int sex = 0;
    if (nic.length == 10) {
      sex = int.parse(nic.substring(2, 5));
    } else if (nic.length == 12) {
      sex = int.parse(nic.substring(4, 7));
    }

    if ((sex > 0 && sex <= 366) || sex > 500 && sex <= 866) {
      ret = true;
    } else {
      ret = false;
    }
    return ret;
  }

  static bool validateEmail(String email) {
    return RegExp(
        r"^[a-zA-Z0-9.a-zA-Z0-9.!#$%&'*+-/=?^_`{|}~]+@[a-zA-Z0-9]+\.[a-zA-Z]+")
        .hasMatch(email);
  }

  static bool validateEnglishCharacters(String text) {
    return RegExp(r"^[a-zA-Z0-9.a-zA-Z0-9.!#$%&@'*+-/=?^_`{|}();:~<>]+").hasMatch(text);
  }

  static bool validatePassword(String password, PasswordPolicy passwordPolicy) {
    if (password.length < passwordPolicy.minLength)
      return false;
    else if (password.length > passwordPolicy.maxLength)
      return false;
    else if (!_isLowercaseValidated(password, passwordPolicy.minLowerChars))
      return false;
    else if (!_isUppercaseValidated(password, passwordPolicy.minUpperChars))
      return false;
    else if (!_isNumericValidated(password, passwordPolicy.minNumChars))
      return false;
    else {
      List<String> _specialChar = password
          .replaceAll(RegExp('[A-Z]'), "")
          .replaceAll(RegExp('[a-z]'), "")
          .replaceAll(RegExp('[0-9]'), "")
          .split("");

      if ((passwordPolicy.minSpecialChars == 0 &&
          passwordPolicy.specialChars.split('').length > 0) ||
          (passwordPolicy.minSpecialChars == 0 && _specialChar.length > 0) ||
          _specialChar.length < passwordPolicy.minSpecialChars) {
        return false;
      } else {
        bool _success;

        if (passwordPolicy.specialChars.isNotEmpty) {
          List _givenCharacters = passwordPolicy.specialChars.split("");
          _specialChar.forEach((char) {
            if (!_givenCharacters.contains(char)) {
              _success = false;
              return;
            }

            _success = true;
          });

          return _success;
        } else {
          return true;
        }
      }
    }
  }

  static bool _isUppercaseValidated(String word, int count) {
    int matches = 0;
    word.replaceAll(RegExp(r'[^\w\s]+'),'').replaceAll(RegExp('[0-9]'), '').split('').forEach((element) {
      if (isUppercase(element)) matches++;
    });

    if(count == 0 && matches>0)
      return true;

    return !(count == 0 && matches > 0) && matches >= count;
  }

  static bool _isLowercaseValidated(String word, int count) {
    int matches = 0;
    word.replaceAll(RegExp(r'[^\w\s]+'),'').replaceAll(RegExp('[0-9]'), '').split('').forEach((element) {
      if (isLowercase(element)) matches++;
    });

    if(count == 0 && matches>0)
      return true;

    return !(count == 0 && matches > 0) && matches >= count;
  }

  static bool _isNumericValidated(String word, int count) {
    int matches = 0;
    word.split('').forEach((element) {
      if (isNumeric(element)) matches++;
    });

    if(count == 0 && matches>0)
      return true;

    return !(count == 0 && matches > 0) && matches >= count;
  }
}