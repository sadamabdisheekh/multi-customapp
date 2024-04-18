import 'package:multi/constants/app_constants.dart';
import 'package:shared_preferences/shared_preferences.dart';

import '../../models/user_model.dart';
import '../error/exception.dart';

abstract class LocalDataSource {
  UserModel getUserResponseModel();
  Future<bool> cacheUserResponse(UserModel userLoginResponseModel);
  Future<bool> clearUserProfile();
}

class LocalDataSourceImpl implements LocalDataSource {
  final SharedPreferences sharedPreferences;

  LocalDataSourceImpl({required this.sharedPreferences});

  @override
  UserModel getUserResponseModel() {
    final jsonString =
        sharedPreferences.getString(AppConstants.cachedUserResponseKey);
    if (jsonString != null) {
      return UserModel.fromJson(jsonString);
    } else {
      throw const DatabaseException('Not cached yet');
    }
  }

  @override
  Future<bool> cacheUserResponse(UserModel userLoginResponseModel) {
    return sharedPreferences.setString(
      AppConstants.cachedUserResponseKey,
      userLoginResponseModel.toJson(),
    );
  }

  @override
  Future<bool> clearUserProfile() {
    return sharedPreferences.remove(AppConstants.cachedUserResponseKey);
  }
}
