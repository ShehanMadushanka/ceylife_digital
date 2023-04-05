import 'package:meta/meta.dart';
import 'package:shared_preferences/shared_preferences.dart';

abstract class LocalDataSource {
  // Future<UserDetailsForSharedModel> getUserForUserDetails();
}

class LocalDataSourceImpl implements LocalDataSource {
  final SharedPreferences sharedPreferences;

  LocalDataSourceImpl({@required this.sharedPreferences});

/*@override
  Future<UserDetailsForSharedModel> getUserForUserDetails() async{
    final jsonString = sharedPreferences.getString(USER_DETAILS_FOR_USER);
    final response = await Future.value(UserDetailsForSharedModel.fromJson(json.decode(jsonString)));
    return response;
  }*/
}
