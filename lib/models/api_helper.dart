import 'dart:convert';
import 'package:http/http.dart' as http;
import 'user_info.dart';

class ApiHelper {
  final String baseUrl = 'https://655e8107879575426b4398a4.mockapi.io/api/usersinfo';

  Future<List<UserInfo>> getAllUsers() async {
    final response = await http.get(Uri.parse(baseUrl));

    if (response.statusCode == 200) {
      List<dynamic> data = json.decode(response.body);

      List<UserInfo> users = data.map((json) {
        return UserInfo.fromMap(json);
      }).toList();

      return users;
    } else {
      throw Exception('Failed to load users');
    }
  }


  Future<int> createUser(UserInfo user) async {
    final response = await http.post(
      Uri.parse(baseUrl),
      headers: {'Content-Type': 'application/json'},
      body: jsonEncode(user.toMap()),
    );

    if (response.statusCode == 201) {
      return json.decode(response.body)['id'];
    } else {
      throw Exception('Failed to create user');
    }
  }

  Future<int?> updateUser(UserInfo user,String? id) async {
    print("UPDATING "+ id.toString());
    print(user.toString());
    user.id = id;
    print(user.toString());
    final response = await http.put(
      Uri.parse('$baseUrl/${id}'),
      headers: {'Content-Type': 'application/json'},

      body: jsonEncode(user.toMap()),
    );

    if (response.statusCode == 200) {
      return jsonDecode(response.body);
    } else {
      throw Exception('Failed to update user '+ response.statusCode.toString());
    }
  }
  Future<String?> deleteUser(String? id) async {
    final response = await http.delete(Uri.parse('$baseUrl/$id'));

    if (response.statusCode == 200) {
      return id;
    } else {
      throw Exception('Failed to delete user');
    }
  }
}
