import 'dart:convert';

import 'package:flutter/cupertino.dart';
import 'package:nb_utils/nb_utils.dart';
import 'package:tugas_kp/Model/ModelGejala.dart';
import '../../Model/ModelKondisiUser.dart';
import '../../Model/string_http_exception.dart';
import '../base_url.dart';
import 'package:http/http.dart' as http;

class DiagnosaApi with ChangeNotifier{
  List<ModelGejala> listGejala = [];
  List<ModelKondisiUser> listKondisiUser = [];

  Future<void> getDiagnosa()async{
    SharedPreferences prefs = await SharedPreferences.getInstance();
    String? token = prefs.getString("token")!;

    final url = UrlApi.getGejala;
    try{
      final response = await http.get(
        Uri.parse(url),
        headers: {
          'Authorization' : "Bearer $token"
        },
      );
      final responseData = json.decode(response.body);
      if(responseData['code'] == 200){
        Iterable dataGejala = responseData['results']['gejala'];
        Iterable dataKondisiUser = responseData['results']['kondisi_user'];
        listGejala = dataGejala.map((e) => ModelGejala.fromJson(e)).toList();
        listKondisiUser = dataKondisiUser.map((e) => ModelKondisiUser.fromJson(e)).toList();
      }else{
        throw StringHttpException("Terjadi Kesalahan");
      }
    }catch(e, st){
      print(st);
      throw e;
    }

  }
}