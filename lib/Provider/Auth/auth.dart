import 'dart:convert';
import 'package:flutter/cupertino.dart';
import 'package:http/http.dart' as http;
import 'package:nb_utils/nb_utils.dart';
import '../../Model/string_http_exception.dart';
import '../base_url.dart';

class Auth with ChangeNotifier{
  bool login = false;
  bool regis = false;
  int? role;

  Future<void> authenticate(String username, password)async {
    final url = UrlApi.login;
    print(url);
    try {
      final response = await http.post(
          Uri.parse(url),
          body: {
            'email': username.toString(),
            'password': password.toString(),
          }
      );
      final responseData = json.decode(response.body);
      if(responseData['code'] == 200){
        login = true;
        var result = responseData['results'];
        String token = result['token']['value'];
        int id = result['user']['id'];
        role = result['user']['role_id'];
        String name = result['user']['name'];
        String email = result['user']['email'];
        String username = result['user']['username'];

        String loginStatus = 'success';
        sharedPref(token, loginStatus, id, name, email, username);
      }else{
        login = false;
        String message = responseData['message'];
        throw StringHttpException(message);
      }
    } catch (e, st) {
      print(st);
      rethrow;
    }
  }

  Future<void> register(String name, String email, String password)async{
    final url = UrlApi.register;
    try {
      final response = await http.post(
          Uri.parse(url),
          body: {
            'name' : name,
            'email': email,
            'password': password,
            'password_confirmation' : password
          }
      );
      final responseData = json.decode(response.body);
      if(responseData['code'] == 200){
        regis = true;
      }else{
        regis = false;
      }
    }catch(e){
      rethrow;
    }
  }

  sharedPref(String token, status, id, name, email, username)async{
    SharedPreferences prefs = await SharedPreferences.getInstance();
    prefs.setString("token", token);
    prefs.setString("loginStatus", status);
    prefs.setInt("id", id);
    prefs.setInt("role", role!);
    prefs.setString("name", name);
    prefs.setString("email", email);
    prefs.setString("username", username);
  }
}