import 'dart:async';

import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:nb_utils/nb_utils.dart';
import 'package:page_transition/page_transition.dart';
import 'package:provider/provider.dart';
import 'package:tugas_kp/Model/ModelGejala.dart';
import 'package:tugas_kp/Model/ModelKondisiUser.dart';
import 'package:tugas_kp/Page/User/Report/reportDetail.dart';
import 'package:tugas_kp/Page/indexUser.dart';
import 'package:tugas_kp/Page/widget/loading.dart';
import 'package:tugas_kp/Provider/Diagnosa/diagnosa.dart';

import '../../../Model/ModelValue.dart';
import '../../../Model/string_http_exception.dart';
import '../../../utils/alert.dart';
import '../../../utils/widget/WAColors.dart';


class Diagnosa extends StatefulWidget {
  const Diagnosa({Key? key}) : super(key: key);

  @override
  State<Diagnosa> createState() => _DiagnosaState();
}

class _DiagnosaState extends State<Diagnosa> {
  bool isLoading = false;
  bool isLoading2 = false;
  List<ModelKondisiUser> kondisiUser = [];
  List<ModelGejala> gejala = [];

  // List<String> gejala = [
  //   "Sering Merasa Sedih",
  //   "Sering kelelahan melakukan aktifitas ringan",
  //   "Kurang konsentrasi dalam belajar ",
  //   "Mudah merasa bosan",
  // ];

  List<ModelValue> val = [];

  getData()async{
    setState(() {
      isLoading = true;
    });
    try{
     await Provider.of<DiagnosaApi>(context, listen: false).getDiagnosa();
    }on StringHttpException catch(err){
      var errorMessage = err.toString();
      AlertFail(errorMessage);
    }catch(e, st){
      print(st);
      AlertFail("Something Went Wrong! $e");
    }
    setState(() {
      kondisiUser = Provider.of<DiagnosaApi>(context, listen: false).listKondisiUser;
      gejala = Provider.of<DiagnosaApi>(context, listen: false).listGejala;
      isLoading = false;
      List.generate(gejala.length, (index) {
        val.add(
          ModelValue(
            id: "",
            code: gejala[index].kodeGejala
          )
        );
      });
      print(val.length);
    });
  }

  postData()async{
    setState(() {
      isLoading2 = true;
    });
    try{
      await Provider.of<DiagnosaApi>(context, listen: false).postDiagnosa(val);
    }on StringHttpException catch(err){
      var errorMessage = err.toString();
      AlertFail(errorMessage);
    }catch(e, st){
      print(st);
      AlertFail("Something Went Wrong! $e");
    }
    setState(() {
      bool sucess = Provider.of<DiagnosaApi>(context, listen: false).statPostDiagnosa;
      String idDiagnosa = Provider.of<DiagnosaApi>(context, listen: false).idDiagnosa!;
      if(sucess){
        AlertSucess("Berhasil Menyimpan Data !");
        Timer(Duration(seconds: 2), (){
          Navigator.pushReplacement(
              context,
              PageTransition(
                  type: PageTransitionType.fade,
                  child: ReportDetail(idDiagnosa)
              )
          );
        });
      }
      isLoading2 = false;
    });
  }

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    getData();
  }
  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Scaffold(
        extendBodyBehindAppBar: true,
        appBar: AppBar(
          backgroundColor: Colors.transparent,
          title: Text(
            'Cek Gejala',
            style: GoogleFonts.poppins(
                textStyle: boldTextStyle(color: Colors.black, size: 20)
            ),
          ),
          leading: Container(
            margin: const EdgeInsets.all(8),
            decoration: boxDecorationWithRoundedCorners(
              backgroundColor: context.cardColor,
              borderRadius: BorderRadius.circular(12),
              border: Border.all(color: Colors.grey.withOpacity(0.2)),
            ),
            child: const Icon(Icons.arrow_back, color: black),
          ).onTap(() {
            finish(context);
          }),
          centerTitle: true,
          elevation: 0.0,
          // brightness: Brightness.dark,
        ),
        body: Container(
          height: context.height(),
          width: context.width(),
          decoration: const BoxDecoration(image: DecorationImage(image:
          AssetImage('assets/images/background.jpg'), fit: BoxFit.cover)),
          child: Stack(
            alignment: AlignmentDirectional.topCenter,
            children: [
              Container(
                padding: const EdgeInsets.only(right: 15, left: 15),
                child: SingleChildScrollView(
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      isLoading
                      ? const Loading()
                      : ListView.builder(
                        shrinkWrap: true,
                        itemCount: gejala.length,
                        physics: const ScrollPhysics(),
                        itemBuilder: ((BuildContext ctx, int? index){
                          return Container(
                            child: Column(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                Text('${index!+1}. ${gejala[index].gejala} ?',
                                  style: GoogleFonts.poppins(
                                      textStyle: secondaryTextStyle(size: 16, color: Colors.grey)
                                  ),
                                ),
                                ListView.builder(
                                    itemCount: kondisiUser.length,
                                    shrinkWrap: true,
                                    physics: NeverScrollableScrollPhysics(),
                                    itemBuilder: ((BuildContext context, int i){
                                      return  RadioListTile(
                                        title: Text(
                                          "${kondisiUser[i].kondisi}",
                                          style: GoogleFonts.poppins(
                                              textStyle: secondaryTextStyle(size: 14, color: Colors.grey)
                                          ),
                                        ),
                                        value:(i + 1).toString(),
                                        groupValue: val[index].id,
                                        onChanged: (value){
                                          setState(() {
                                            val[index] = ModelValue(
                                              id: value!.toString(),
                                              code: gejala[index].kodeGejala
                                            );
                                          });
                                        },
                                      );
                                    })
                                )
                              ],
                            ),
                          );
                        }),
                      ),
                      16.height,
                      isLoading2
                      ? Loading()
                      : AppButton(
                        color: WAPrimaryColor,
                        width: context.width(),
                        child: Text('Simpan',
                            style: GoogleFonts.poppins(
                                textStyle: boldTextStyle(color: Colors.white)
                            ) ),
                        onTap: () {
                          if (val.isEmpty) {
                            AlertFail("Pilih Diagnosa !");
                          } else {
                            postData();
                          }
                        },
                      ).cornerRadiusWithClipRRect(30).paddingOnly(left: context.width() * 0.1, right: context.width() * 0.1),
                    ],
                  ),
                ),
              ),
            ],
          ).paddingTop(60),
        ),
      ),
    );
  }
}


