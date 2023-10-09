
import 'dart:convert';

import 'package:http/http.dart' as http;
import 'package:flutter/cupertino.dart';
import 'package:nb_utils/nb_utils.dart';
import 'package:tugas_kp/Provider/base_url.dart';

import '../../Model/ModelUser.dart';
import '../../Model/string_http_exception.dart';

class ProfileData with ChangeNotifier{
  bool editProfile = false;

  Future<ModelUser> getUser()async{
    SharedPreferences prefs = await SharedPreferences.getInstance();
    String? token = prefs.getString("token")!;

    final url = UrlApi.getUser;
    try{
      final response = await http.get(
        Uri.parse(url),
        headers: {
          'Authorization' : "Bearer $token",
        },
      );
      final responseData = json.decode(response.body);
      if(response.statusCode == 200){
        ModelUser user = ModelUser.fromJson(responseData);
        return user;
      }else{
        throw StringHttpException(responseData['message']);
      }
    }catch(e){
      rethrow;
    }
  }

  Future<void> editProf(fullname, email, file)async{
    SharedPreferences preferences = await SharedPreferences.getInstance();
    String? token = preferences.getString('token');
    String? username = preferences.getString('username');

    final url = UrlApi.editProfile;

    try{
      Map<String, String> headers = {"Authorization" : "Bearer $token"};
      final request = http.MultipartRequest("POST", Uri.parse(url));
      request.fields["username"] = username!;
      request.fields["name"] = fullname;
      request.fields["email"] = email;
      if(file != null){
        var pic = await http.MultipartFile.fromPath("avatar", file.path);
        request.files.add(pic);
      }
      request.headers.addAll(headers);

      var responsed = await request.send();
      var responseData = await responsed.stream.toBytes();
      var responseString = String.fromCharCodes(responseData);
      final responStatus = json.decode(responseString);
      int codePostFile = responStatus['code'];
      if(codePostFile == 200){
        editProfile = true;
      }else{
        editProfile = false;
      }
    }catch(e){
      rethrow;
    }
  }
}