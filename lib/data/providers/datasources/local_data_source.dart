import 'package:multi/constants/app_constants.dart';
import 'package:shared_preferences/shared_preferences.dart';

import '../../models/customer_model.dart';
import '../error/exception.dart';

abstract class LocalDataSource {
  CustomerModel getUserResponseModel();
  Future<bool> cacheUserResponse(CustomerModel userLoginResponseModel);
  Future<bool> clearUserProfile();
}

class LocalDataSourceImpl implements LocalDataSource {
  final SharedPreferences sharedPreferences;

  LocalDataSourceImpl({required this.sharedPreferences});

  @override
  CustomerModel getUserResponseModel() {
    final jsonString =
        sharedPreferences.getString(AppConstants.cachedUserResponseKey);
    if (jsonString != null) {
      return CustomerModel.fromJson(jsonString);
    } else {
      throw const DatabaseException('Not cached yet');
    }
  }

  @override
  Future<bool> cacheUserResponse(CustomerModel userLoginResponseModel) {
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
