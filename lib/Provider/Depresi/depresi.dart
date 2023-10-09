import 'dart:convert';
import 'package:flutter/cupertino.dart';
import 'package:nb_utils/nb_utils.dart';
import 'package:tugas_kp/Model/ModelListDepresi.dart';
import 'package:http/http.dart' as http;
import '../../Model/string_http_exception.dart';
import '../base_url.dart';

class DepresiApi with ChangeNotifier{
  List<ModelListDepresi> depresi = [];
  bool postDepresi = false;
  bool deleteDepresi = false;

  Future<void> getListDepresi()async{
    SharedPreferences prefs = await SharedPreferences.getInstance();
    String? token = prefs.getString("token")!;

    final url = UrlApi.getDepresi;
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
        Iterable dataDepresi = responseData['results'];
        depresi = dataDepresi.map((e) => ModelListDepresi.fromJson(e)).toList();
      }else{
        throw StringHttpException("Terjadi Kesalahan");
      }
    }catch(e, st){
      print(st);
      throw e;
    }
  }

  Future<void> postDataDepresi(String kodeDepresi, depresi, id)async{
    SharedPreferences prefs = await SharedPreferences.getInstance();
    String? token = prefs.getString("token")!;

    final url = id == "0"
        ? UrlApi.postDepresi
        : UrlApi.editDepresi + id;
    print(url);
    try{
      final response = id == "0"
          ? await http.post(
          Uri.parse(url),
          headers: {
            'Authorization' : "Bearer $token"
          },
          body: {
            'kode_depresi': kodeDepresi.toString(),
            'depresi': depresi.toString(),
          }
      )
          : await http.patch(
          Uri.parse(url),
          headers: {
            'Authorization' : "Bearer $token"
          },
          body: {
            'kode_depresi': kodeDepresi.toString(),
            'depresi': depresi.toString(),
          }
      );
      final responseData = json.decode(response.body);
      if(responseData['code'] == 200){
        postDepresi = true;
      }else{
        postDepresi = false;
        String message = responseData['message'];
        throw StringHttpException(message);
      }
    }catch(e){
      rethrow;
    }
  }

  Future<void> deleteDataDepresi(String id)async{
    SharedPreferences prefs = await SharedPreferences.getInstance();
    String? token = prefs.getString("token")!;

    final url = UrlApi.deleteDepresi + id;
    try{
      final response = await http.delete(
        Uri.parse(url),
        headers: {
          'Authorization' : "Bearer $token"
        },
      );
      final responseData = json.decode(response.body);
      if(responseData['code'] == 200){
        deleteDepresi = true;
      }else{
        deleteDepresi = false;
        String message = responseData['message'];
        throw StringHttpException(message);
      }
    }catch(e){
      rethrow;
    }
  }

}