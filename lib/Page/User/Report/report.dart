import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:nb_utils/nb_utils.dart';
import 'package:provider/provider.dart';
import 'package:tugas_kp/Model/ModelListDiagnosa.dart';
import 'package:tugas_kp/Page/User/Report/reportDetail.dart';
import 'package:tugas_kp/Provider/Diagnosa/diagnosa.dart';

import '../../../Model/string_http_exception.dart';
import '../../../utils/alert.dart';
import '../../widget/loading.dart';


class Report extends StatefulWidget {
  const Report({Key? key}) : super(key: key);

  @override
  State<Report> createState() => _ReportState();
}

class _ReportState extends State<Report> {
  List<ModelListDiagnosa> listDiagnosa = [];
  bool isLoading = false;
  int? role;
  int? userId;

  getData()async{
    setState(() {
      isLoading = true;
    });
    try{
      await Provider.of<DiagnosaApi>(context, listen: false).getListDiagnosa(
          role == 1
          ? ""
          : "?created_by=$userId");
    }on StringHttpException catch(err){
      var errorMessage = err.toString();
      AlertFail(errorMessage);
    }catch(e, st){
      print(st);
      AlertFail("Something Went Wrong! $e");
    }
    setState(() {
      listDiagnosa = Provider.of<DiagnosaApi>(context, listen: false).listDiagnosa;
      isLoading = false;
    });
  }

  getPref()async {
    SharedPreferences preferences = await SharedPreferences.getInstance();
    setState(() {
      role = preferences.getInt("role");
      userId = preferences.getInt("id");
      getData();
    });
  }

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    getPref();
  }

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Scaffold(
        extendBodyBehindAppBar: true,
        appBar: AppBar(
          backgroundColor: Colors.transparent,
          title: Text(
            'Report',
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
                child: SingleChildScrollView(
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      isLoading
                      ? Loading()
                      : ListView.builder(
                        shrinkWrap: true,
                        physics: ScrollPhysics(),
                        itemCount: listDiagnosa.length,
                        itemBuilder: ((BuildContext ctx, int index){
                          return GestureDetector(
                            onTap: (){
                              ReportDetail(listDiagnosa[index].diagnosaId!).launch(context);
                            },
                            child: Container(
                              padding: EdgeInsets.only(left: 16, right: 16, bottom: 10),
                              margin: EdgeInsets.only(bottom: 16, left: 16, right: 16),
                              decoration: boxDecorationRoundedWithShadow(16, backgroundColor: context.cardColor),
                              child: ListTile(
                                tileColor: index == 0
                                    ? Colors.green
                                    : index == 1
                                    ? Colors.orange
                                    : index == 2
                                    ? Colors.red
                                    : Colors.red,
                                enabled: true,
                                contentPadding: EdgeInsets.zero,
                                leading: Container(
                                  height: 50,
                                  width: 50,
                                  alignment: Alignment.center,
                                  decoration: boxDecorationWithRoundedCorners(
                                    boxShape: BoxShape.circle,
                                    backgroundColor: index == 0
                                        ? Colors.green.withOpacity(0.1)
                                        : index == 1
                                        ? Colors.orange.withOpacity(0.1)
                                        : index == 2
                                        ? Colors.red.withOpacity(0.1)
                                        : Colors.red.withOpacity(0.1),
                                  ),
                                  child: ImageIcon(
                                    AssetImage('assets/images/wa_ticket.png'),
                                    size: 24,
                                    color: index == 0
                                        ? Colors.green
                                        : index == 1
                                        ? Colors.orange
                                        : index == 2
                                        ? Colors.red
                                        : Colors.red,
                                  ),
                                ),
                                title: Column(
                                  crossAxisAlignment: CrossAxisAlignment.start,
                                  children: [
                                    Text(
                                      '${listDiagnosa[index].diagnosaId}',
                                      style: GoogleFonts.poppins(
                                          textStyle: boldTextStyle(color:Colors.black54, size: 14)
                                      ),
                                    ),
                                  ],
                                ),
                                subtitle: Text(
                                  '${listDiagnosa[index].createdAt}',
                                  style: GoogleFonts.poppins(
                                      textStyle: primaryTextStyle(color:Colors.black54, size: 14)
                                  ),
                                ),
                              ),
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
