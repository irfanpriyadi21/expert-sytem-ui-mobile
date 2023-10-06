import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:nb_utils/nb_utils.dart';
import 'package:provider/provider.dart';
import 'package:tugas_kp/Model/ModelGejala.dart';
import 'package:tugas_kp/Model/ModelKondisiUser.dart';
import 'package:tugas_kp/Page/widget/loading.dart';
import 'package:tugas_kp/Provider/Diagnosa/diagnosa.dart';

import '../../../Model/string_http_exception.dart';
import '../../../utils/alert.dart';


class Diagnosa extends StatefulWidget {
  const Diagnosa({Key? key}) : super(key: key);

  @override
  State<Diagnosa> createState() => _DiagnosaState();
}

class _DiagnosaState extends State<Diagnosa> {
  bool isLoading = false;
  List<ModelKondisiUser> kondisiUser = [];
  List<ModelGejala> gejala = [];

  // List<String> gejala = [
  //   "Sering Merasa Sedih",
  //   "Sering kelelahan melakukan aktifitas ringan",
  //   "Kurang konsentrasi dalam belajar ",
  //   "Mudah merasa bosan",
  // ];

  List<String> val = [];

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
        val.add('');
      });
      print(val.length);
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
                      ? Loading()
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
                                        groupValue: val[index],
                                        onChanged: (value){
                                          setState(() {
                                            val[index] = value!;
                                          });
                                        },
                                      );
                                    })
                                )
                              ],
                            ),
                          );
                        }),
                      )
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
