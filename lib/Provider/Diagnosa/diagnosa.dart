import 'dart:convert';

import 'package:flutter/cupertino.dart';
import 'package:nb_utils/nb_utils.dart';
import 'package:tugas_kp/Model/ModelGejala.dart';
import 'package:tugas_kp/Model/ModelListDiagnosa.dart';
import '../../Model/ModelKondisiUser.dart';
import '../../Model/ModelResultDiagnosa.dart';
import '../../Model/ModelValue.dart';
import '../../Model/string_http_exception.dart';
import '../base_url.dart';
import 'package:http/http.dart' as http;

class DiagnosaApi with ChangeNotifier{
  List<ModelGejala> listGejala = [];
  List<ModelKondisiUser> listKondisiUser = [];
  List<ModelListDiagnosa> listDiagnosa = [];
  List? gejalaByUser;
  List? cf;
  bool statPostDiagnosa = false;
  String? idDiagnosa;

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

  Future<void> postDiagnosa(List<ModelValue> val)async{
    SharedPreferences prefs = await SharedPreferences.getInstance();
    String? token = prefs.getString("token")!;

    final url = UrlApi.postDiagnosa;

    Map<String, dynamic> dataMap = Map();
    List.generate(val.length, (index){
      dataMap.putIfAbsent("kondisi[${val[index].code}]", () => val[index].id);
    });

    try{
      final response = await http.post(
          Uri.parse(url),
          headers: {
            'Authorization' : "Bearer $token"
          },
          body: dataMap
      );
      final responseData = json.decode(response.body);
      print(responseData);

      int code = responseData['code'];
      if(code == 200){
        idDiagnosa = responseData['results']['diagnose']['diagnosa_id'];
        statPostDiagnosa = true;
      }else{
        statPostDiagnosa = false;
        throw StringHttpException(responseData['message']);
      }
    }catch(e){
      rethrow;
    }

  }

  Future<ModelResultDiagnosa> getResult(String id)async{
    SharedPreferences prefs = await SharedPreferences.getInstance();
    String? token = prefs.getString("token")!;

    final url = UrlApi.resultDiagnosa + "$id";
    print(url);
    try{
      final response = await http.get(
        Uri.parse(url),
        headers: {
          'Authorization' : "Bearer $token",
        },
      );
      final responseData = json.decode(response.body);
      if(response.statusCode == 200){
        gejalaByUser = responseData['results']['gejala_by_user'];
        cf = responseData['results']['cf_kombinasi']['cf'];
        ModelResultDiagnosa user = ModelResultDiagnosa.fromJson(responseData);
        return user;
      }else{
        throw StringHttpException(responseData['message']);
      }
    }catch(e){
      rethrow;
    }
  }

  Future<void> getListDiagnosa(String filter)async{
    SharedPreferences prefs = await SharedPreferences.getInstance();
    String? token = prefs.getString("token")!;

    final url = UrlApi.listDiagnosa + filter;
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
        Iterable dataDiagnosa = responseData['results'];
        listDiagnosa = dataDiagnosa.map((e) => ModelListDiagnosa.fromJson(e)).toList();
      }else{
        throw StringHttpException("Terjadi Kesalahan");
      }
    }catch(e, st){
      print(st);
      throw e;
    }
  }
}