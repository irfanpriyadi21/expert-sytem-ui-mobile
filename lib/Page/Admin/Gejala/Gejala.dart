import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:nb_utils/nb_utils.dart';
import 'package:provider/provider.dart';
import 'package:tugas_kp/Provider/Gejala/gejala.dart';
import '../../../Model/ModelListGejala.dart';
import '../../../Model/string_http_exception.dart';
import '../../../utils/alert.dart';
import '../../../utils/widget/WAColors.dart';
import '../../../utils/widget/WAWidgets.dart';
import '../../widget/loading.dart';


class Gejala extends StatefulWidget {
  const Gejala({Key? key}) : super(key: key);

  @override
  State<Gejala> createState() => _GejalaState();
}

class _GejalaState extends State<Gejala> {
  var kdGejala = TextEditingController();
  var nameGejala = TextEditingController();
  FocusNode kdF = FocusNode();
  FocusNode gejalaF = FocusNode();
  bool isLoading = false;
  bool isLoading2 = false;
  List<ModelListGejala> gejala = [];

  getData()async{
    setState(() {
      isLoading = true;
    });
    try{
      await Provider.of<GejalaApi>(context, listen: false).getListGejala();
    }on StringHttpException catch(err){
      var errorMessage = err.toString();
      AlertFail(errorMessage);
    }catch(e, st){
      print(st);
      AlertFail("Something Went Wrong! $e");
    }
    setState(() {
      gejala = Provider.of<GejalaApi>(context, listen: false).gejala;
      isLoading = false;
    });
  }

  deleteData(String id)async{
    setState(() {
      isLoading = true;
    });
    try{
      await Provider.of<GejalaApi>(context, listen: false).deleteGejalaPenyakit(id);
    }on StringHttpException catch(err){
      var errorMessage = err.toString();
      AlertFail(errorMessage);
    }catch(e, st){
      print(st);
      AlertFail("Something Went Wrong! $e");
    }
    setState(() {
      bool status = Provider.of<GejalaApi>(context, listen: false).deleteGejala!;
      if(status){
        Navigator.pop(context);
        AlertSucess("Data Berhasil Dihapus !");
        Future.delayed(const Duration(seconds: 2)).then((val) {
          Navigator.pop(context);
          getData();
        });
      }
      isLoading = false;
    });
  }

  postData(String id)async{
    setState(() {
      isLoading2 = true;
    });
    try{
      await Provider.of<GejalaApi>(context, listen: false).postGejalaPenyakit(
          kdGejala.text, nameGejala.text, id);
    }on StringHttpException catch(err){
      var errorMessage = err.toString();
      AlertFail(errorMessage);
    }catch(e, st){
      print(st);
      AlertFail("Something Went Wrong! $e");
    }
    setState(() {
      bool status = Provider.of<GejalaApi>(context, listen: false).postGejala!;
      if(status){
        Navigator.pop(context);
        AlertSucess("Data Berhasil Disimpan !");
        Future.delayed(const Duration(seconds: 2)).then((val) {
          Navigator.pop(context);
          getData();
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
  
  dialog(String id){
    showModalBottomSheet(
        context: context,
        isScrollControlled: true,
        shape: const RoundedRectangleBorder(
          borderRadius: BorderRadius.vertical(
            top: Radius.circular(20.0),
          ),
        ),
        builder: (context) {
          return Padding(
            padding: MediaQuery.of(context).viewInsets,
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              mainAxisSize: MainAxisSize.min,
              children: <Widget>[
                Container(
                  padding: const EdgeInsets.only(right: 15, left: 15, top: 10, bottom: 10),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Center(
                        child: Text('Input Gejala',
                          style: GoogleFonts.poppins(
                              textStyle: boldTextStyle(color: Colors.grey)
                          ),
                        ),
                      ),
                      20.height,
                      Text('Kode Gejala',
                          style: GoogleFonts.poppins(
                              textStyle: boldTextStyle(size: 14, color: Colors.grey)
                          )
                      ),
                      8.height,
                      AppTextField(
                        decoration: waInputDecoration(
                          hint: 'Enter Kode Gejala',
                        ),
                        textFieldType: TextFieldType.NAME,
                        keyboardType: TextInputType.name,
                        controller: kdGejala,
                        focus: kdF,
                      ),
                      16.height,
                      Text('Nama Gejala',
                          style: GoogleFonts.poppins(
                              textStyle: boldTextStyle(size: 14, color: Colors.grey)
                          )
                      ),
                      8.height,
                      AppTextField(
                        decoration: waInputDecoration(
                          hint: 'Enter Gejala',
                        ),
                        textFieldType: TextFieldType.PHONE,
                        keyboardType: TextInputType.phone,
                        controller: nameGejala,
                        focus: gejalaF,
                      ),
                      40.height,
                      Row(
                        children: [
                          Expanded(
                            child: AppButton(
                              color: Colors.grey,
                              width: context.width(),
                              child: Text('Cancel',
                                  style: GoogleFonts.poppins(
                                      textStyle: boldTextStyle(color: Colors.white)
                                  ) ),
                              onTap: () {
                                Navigator.pop(context);
                              },
                            ).cornerRadiusWithClipRRect(10).paddingOnly(left: context.width() * 0.1, right: context.width() * 0.1),
                          ),
                          const SizedBox(width: 10),
                          isLoading
                          ? Loading()
                          : Expanded(
                            child: AppButton(
                              color: WAPrimaryColor,
                              width: context.width(),
                              child: Text('Simpan',
                                  style: GoogleFonts.poppins(
                                      textStyle: boldTextStyle(color: Colors.white)
                                  ) ),
                              onTap: () {
                                if (kdGejala.text.isEmpty || nameGejala.text.isEmpty) {
                                  AlertFail("Lengkapi Data !!");
                                } else {
                                  postData(id);
                                }
                              },
                            ).cornerRadiusWithClipRRect(10).paddingOnly(left: context.width() * 0.1, right: context.width() * 0.1),
                          )
                        ],
                      )
                    ],
                  ),
                )

              ],
            ),
          );
        });
  }

  dialogDelete(String name, id) {
    return showDialog(
        context: context,
        builder: (BuildContext context) {
          return AlertDialog(
            title: Text(
                'Delete $name ?',
                style: GoogleFonts.poppins(
                  textStyle: TextStyle(
                      fontSize: 16,
                      color: Colors.black
                  ),
                )
            ),
            actions: <Widget>[
              TextButton(
                child: Text(
                    'Cancel',
                    style: GoogleFonts.poppins(
                      textStyle: TextStyle(
                          fontSize: 16,
                          fontWeight: FontWeight.bold,
                          color: Colors.red
                      ),
                    )
                ),
                onPressed: () {
                  Navigator.of(context).pop(false);
                },
              ),
              TextButton(
                child: Text(
                    'Ok',
                    style: GoogleFonts.poppins(
                      textStyle: TextStyle(
                          fontSize: 16,
                          fontWeight: FontWeight.bold,
                          color: Colors.blue
                      ),
                    )
                ),
                onPressed:(){
                  deleteData(id.toString());
                },
              ),
            ],
          );
        });
  }

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Scaffold(
        extendBodyBehindAppBar: true,
        appBar: AppBar(
          backgroundColor: Colors.transparent,
          title: Text(
            'Gejala',
            style: GoogleFonts.poppins(
                textStyle: boldTextStyle(color: Colors.black, size: 20)
            ),
          ),
          leading: Container(
            margin: EdgeInsets.all(8),
            decoration: boxDecorationWithRoundedCorners(
              backgroundColor: context.cardColor,
              borderRadius: BorderRadius.circular(12),
              border: Border.all(color: Colors.grey.withOpacity(0.2)),
            ),
            child: Icon(Icons.arrow_back, color: black),
          ).onTap(() {
            finish(context);
          }),
          actions: [
            Padding(
              padding: EdgeInsets.only(right: 20),
              child: GestureDetector(
                child: const CircleAvatar(
                  radius: 20,
                  backgroundColor: Colors.white,
                  child: Icon(
                    Icons.add,
                    color: black,
                    size: 30,
                  ),
                ),
                onTap: (){
                  dialog("0");
                  kdGejala.clear();
                  nameGejala.clear();
                },
              ),
            )

          ],
          centerTitle: true,
          elevation: 0.0,
          // brightness: Brightness.dark,
        ),
        body: Container(
          height: context.height(),
          width: context.width(),
          decoration: BoxDecoration(image: DecorationImage(image:
          AssetImage('assets/images/background.jpg'), fit: BoxFit.cover)),
          child: Stack(
            alignment: AlignmentDirectional.topCenter,
            children: [
              Container(
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
                        physics: ScrollPhysics(),
                        itemBuilder: ((BuildContext ctx, int index){
                          return  Container(
                            padding: EdgeInsets.only(left: 16, right: 16, bottom: 10, top: 10),
                            margin: EdgeInsets.only(bottom: 16, left: 16, right: 16),
                            decoration: boxDecorationRoundedWithShadow(16, backgroundColor: context.cardColor),
                            child:  Row(
                              crossAxisAlignment: CrossAxisAlignment.center,
                              mainAxisAlignment: MainAxisAlignment.start,
                              children: [
                                Container(
                                  height: 50,
                                  width: 50,
                                  alignment: Alignment.center,
                                  decoration: boxDecorationWithRoundedCorners(
                                    boxShape: BoxShape.circle,
                                    backgroundColor: Colors.orange.withOpacity(0.1),
                                  ),
                                  child: ImageIcon(
                                    AssetImage('assets/images/wa_ticket.png'),
                                    size: 24,
                                    color: Colors.orange,
                                  ),
                                ),
                                10.width,
                                Expanded(
                                  child: Column(
                                    crossAxisAlignment: CrossAxisAlignment.start,
                                    children: [
                                      Text(
                                        '${gejala[index].kodeGejala}',
                                        style: GoogleFonts.poppins(
                                            textStyle: primaryTextStyle(color:Colors.black54, size: 14)
                                        ),
                                      ),
                                      Text(
                                        '${gejala[index].gejala}',
                                        style: GoogleFonts.poppins(
                                            textStyle: primaryTextStyle(color:Colors.black54, size: 14)
                                        ),
                                      )
                                    ],
                                  ),
                                ),
                                PopupMenuButton(
                                  // add icon, by default "3 dot" icon
                                  // icon: Icon(Icons.book)
                                    itemBuilder: (context){
                                      return [
                                        PopupMenuItem<int>(
                                          value: 0,
                                          child: Text(
                                            "Edit",
                                            style: GoogleFonts.poppins(
                                                textStyle: secondaryTextStyle(color: Colors.blue, size: 14)
                                            ),
                                          ),
                                        ),

                                        PopupMenuItem<int>(
                                          value: 1,
                                          child: Text(
                                            "Delete",
                                            style: GoogleFonts.poppins(
                                                textStyle: secondaryTextStyle(color: Colors.red, size: 14)
                                            ),
                                          ),
                                        ),
                                      ];
                                    },
                                    onSelected:(value){
                                      if(value == 0){
                                        dialog(gejala[index].id.toString());
                                         kdGejala.text = gejala[index].kodeGejala!;
                                         nameGejala.text = gejala[index].gejala!;
                                      }else if(value == 1){
                                        dialogDelete(gejala[index].kodeGejala!, gejala[index].id!);
                                      }
                                    }
                                ),
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
