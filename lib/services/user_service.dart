import 'package:api_integration_demo/constants/api_constants.dart';
import 'package:api_integration_demo/models/users_data_model.dart';
import 'package:http/http.dart' as http;

class UserService {
  /// get method to get user data
  Future<List<UsersData>> getUserData() async {
    try {
      final response = await http.get(Uri.parse(ApiConstants.apiEndUrl));
      if (response.statusCode == 200) {
        return usersDataFromJson(response.body);
      }
      return [];
    } catch (e) {
      throw Exception("Failed to fetch data..");
    }
  }
}
