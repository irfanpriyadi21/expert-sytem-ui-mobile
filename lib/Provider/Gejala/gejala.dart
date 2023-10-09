import 'dart:convert';

import 'package:flutter/cupertino.dart';
import 'package:nb_utils/nb_utils.dart';
import 'package:http/http.dart' as http;
import '../../Model/ModelListGejala.dart';
import '../../Model/string_http_exception.dart';
import '../base_url.dart';

class GejalaApi with ChangeNotifier{
  List<ModelListGejala> gejala = [];
  bool? postGejala;
  bool? deleteGejala;

  Future<void> getListGejala()async{
    SharedPreferences prefs = await SharedPreferences.getInstance();
    String? token = prefs.getString("token")!;

    final url = UrlApi.getGejalaPenyakit;
    print(url);
    try{
      final response = await http.get(
        Uri.parse(url),
        headers: {
          'Authorization' : "Bearer $token"
        },
      );
      final responseData = json.decode(response.body);
      if(responseData['code'] == 200){
        Iterable dataGejala = responseData['results'];
        gejala = dataGejala.map((e) => ModelListGejala.fromJson(e)).toList();
      }else{
        throw StringHttpException("Terjadi Kesalahan");
      }
    }catch(e, st){
      print(st);
      throw e;
    }
  }

  Future<void> postGejalaPenyakit(String kodeGejala, gejala, id)async{
    SharedPreferences prefs = await SharedPreferences.getInstance();
    String? token = prefs.getString("token")!;

    final url = id == "0"
            ? UrlApi.postGejalaPenyakit
            : UrlApi.editGejalaPenyakit + id;
    print(url);
    try{
      final response = id == "0"
      ? await http.post(
          Uri.parse(url),
          headers: {
            'Authorization' : "Bearer $token"
          },
          body: {
            'kode_gejala': kodeGejala.toString(),
            'gejala': gejala.toString(),
          }
      )
      : await http.patch(
          Uri.parse(url),
          headers: {
            'Authorization' : "Bearer $token"
          },
          body: {
            'kode_gejala': kodeGejala.toString(),
            'gejala': gejala.toString(),
          }
      );
      final responseData = json.decode(response.body);
      if(responseData['code'] == 200){
        postGejala = true;
      }else{
        postGejala = false;
        String message = responseData['message'];
        throw StringHttpException(message);
      }
    }catch(e){
      rethrow;
    }
  }

  Future<void> deleteGejalaPenyakit(String id)async{
    SharedPreferences prefs = await SharedPreferences.getInstance();
    String? token = prefs.getString("token")!;

    final url = UrlApi.deleteGejalaPenyakit + id;
    try{
      final response = await http.delete(
        Uri.parse(url),
        headers: {
          'Authorization' : "Bearer $token"
        },
      );
      final responseData = json.decode(response.body);
      if(responseData['code'] == 200){
        deleteGejala = true;
      }else{
        deleteGejala = false;
        String message = responseData['message'];
        throw StringHttpException(message);
      }
    }catch(e){
      rethrow;
    }
  }
}