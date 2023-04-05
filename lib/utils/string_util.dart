import 'package:ceylife_digital/error/messages.dart';
import 'package:ceylife_digital/utils/enums.dart';
import 'package:package_info/package_info.dart';

import 'app_images.dart';

class StringUtils {
  static String enumName(String enumToString) {
    List<String> paths = enumToString.split(".");
    return paths[paths.length - 1];
  }

  static void getApplicationVersion() async {
    PackageInfo packageInfo = await PackageInfo.fromPlatform();
    String versionName = packageInfo.version;
    String versionCode = packageInfo.buildNumber;

  }

  static String numberZeroPad(int number) {
    if (number.toString().length == 1)
      return "0$number";
    else
      return number.toString();
  }

  static String generateBranchAvailableTime(String openingHoursMonFri,
      String openingHoursSat, String openingHoursSun) {
    String value = "";
    if (openingHoursMonFri != null && openingHoursMonFri.isNotEmpty)
      value += ErrorMessages().mapAPIErrorCode(ErrorMessages.APP_BRANCH_LOCATOR_MTOF, '${_branchAvailableTimeSeparator(openingHoursMonFri)}\n');
    if (openingHoursSat != null && openingHoursSat.isNotEmpty)
      value += ErrorMessages().mapAPIErrorCode(ErrorMessages.APP_BRANCH_LOCATOR_SAT, '${_branchAvailableTimeSeparator(openingHoursSat)}\n');
    if (openingHoursSun != null && openingHoursSun.isNotEmpty)
      value += ErrorMessages().mapAPIErrorCode(ErrorMessages.APP_BRANCH_LOCATOR_SUN, '${_branchAvailableTimeSeparator(openingHoursSun)}');
    return value;
  }

  static String _branchAvailableTimeSeparator(String time) {
    List<String> timeSpan = time.split("-");
    return "${timeSpan[0].trim()} - ${timeSpan[1].trim()}";
  }

  static String mapProductCategoryToIcon(String categoryCode) {
    switch (categoryCode) {
      case 'LFI':
        return AppImages.lifeInsurance;
      case 'HTI':
        return AppImages.healthInsurance;
      case 'RTP':
        return AppImages.retirementPlanning;
      case 'ILP':
        return AppImages.investmentPlan;
    }
  }

  static PolicyStatus mapPolicyStatusEnum(String status) {
    if (status == 'ACTIVE')
      return PolicyStatus.ACTIVE;
    else if (status == 'LAPSED')
      return PolicyStatus.LAPSED;
    else if (status == 'PAIDUP')
      return PolicyStatus.PAIDUP;
    else if (status == 'PROPOSAL')
      return PolicyStatus.PROPOSAL;
    else if (status == 'MATURED')
      return PolicyStatus.MATURED;
    else
      return PolicyStatus.BUYONLINE;
  }
}
