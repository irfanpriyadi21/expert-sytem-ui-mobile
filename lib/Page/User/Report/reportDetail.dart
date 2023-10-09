import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:nb_utils/nb_utils.dart';
import 'package:provider/provider.dart';
import 'package:tugas_kp/Model/ModelResultDiagnosa.dart';

import '../../../Model/string_http_exception.dart';
import '../../../Provider/Diagnosa/diagnosa.dart';
import '../../../utils/alert.dart';
import '../../widget/loading.dart';


class ReportDetail extends StatefulWidget {
  final String id;
  const ReportDetail(this.id, {Key? key}) : super(key: key);

  @override
  State<ReportDetail> createState() => _ReportDetailState();
}

class _ReportDetailState extends State<ReportDetail> {
  bool isLoading = false;
  ModelResultDiagnosa? diagnosa;
  List? gejalaByUser;
  List? cf;


  getData()async{
    setState(() {
      isLoading = true;
    });
    try{
      diagnosa = await Provider.of<DiagnosaApi>(context, listen: false).getResult(widget.id);
    }on StringHttpException catch(err){
      var errorMessage = err.toString();
      AlertFail(errorMessage);
    }catch(e, st){
      print(st);
      AlertFail("Something Went Wrong! $e");
    }
    setState(() {
      gejalaByUser = Provider.of<DiagnosaApi>(context, listen: false).gejalaByUser;
      cf = Provider.of<DiagnosaApi>(context, listen: false).cf;
      isLoading = false;
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
            'Report Detail',
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
          decoration: BoxDecoration(image: DecorationImage(image:
          AssetImage('assets/images/background.jpg'), fit: BoxFit.cover)),
          child: Stack(
            alignment: AlignmentDirectional.topCenter,
            children: [
               isLoading
                ? Loading()
                : diagnosa == null
                  ? Container()
                  : Container(
                 padding: EdgeInsets.only(right: 15, left: 15),
                 child: SingleChildScrollView(
                   child: Column(
                     crossAxisAlignment: CrossAxisAlignment.start,
                     mainAxisAlignment: MainAxisAlignment.center,
                     children: [
                       40.height,
                       Text('Pakar',
                           style: GoogleFonts.poppins(
                               textStyle: boldTextStyle(size: 14, color: Colors.grey)
                           )
                       ),
                       DataTable(
                         decoration: BoxDecoration(
                           borderRadius: BorderRadius.circular(5),
                           border: Border.all(
                             color: Colors.grey,
                           ),
                         ),
                         dividerThickness: 0,
                         border: TableBorder(
                           borderRadius: BorderRadius.circular(5),
                         ),
                         columns: [
                           DataColumn(
                             label: Text('No'),
                           ),
                           DataColumn(
                             label: Text('Gejala'),
                           ),
                           DataColumn(
                             label: Text('Nilai(MB-MD)'),
                           ),
                         ],
                         rows: diagnosa!.results!.pakar!.map((e){
                           var index = diagnosa!.results!.pakar!.indexOf(e) + 1;
                           double rd = double.parse((e.mb! - e.md!).toStringAsFixed(2));
                           return DataRow(cells: [
                             DataCell(Text('$index')),
                             DataCell(Text('${e.kodeGejala} | ${e.kodeDepresi}')),
                             DataCell(Text('$rd')),
                           ]);
                         }).toList(),
                       ),
                       20.height,
                       Row(
                         children: [
                           Expanded(
                             child: Column(
                               children: [
                                 Text('User',
                                     style: GoogleFonts.poppins(
                                         textStyle: boldTextStyle(size: 14, color: Colors.grey)
                                     )
                                 ),
                                 DataTable(
                                     decoration: BoxDecoration(
                                       borderRadius: BorderRadius.circular(5),
                                       border: Border.all(
                                         color: Colors.grey,
                                       ),
                                     ),
                                     dividerThickness: 0,
                                     border: TableBorder(
                                       borderRadius: BorderRadius.circular(5),
                                     ),
                                     columns: [
                                       DataColumn(
                                         label: Text('Gejala'),
                                       ),
                                       DataColumn(
                                         label: Text('Nilai'),
                                       ),
                                     ],
                                    rows: gejalaByUser!.map((e){
                                      print(gejalaByUser);
                                      print(widget.id);
                                     return DataRow(cells: [
                                       DataCell(Text("${e[0]}")),
                                       DataCell(Text('${e[1]}')),
                                     ]);
                                   }).toList(),
                                 )
                               ],
                             ),
                           ),
                           Expanded(
                             child: Column(
                               children: [
                                 Text('Hasil',
                                     style: GoogleFonts.poppins(
                                         textStyle: boldTextStyle(size: 14, color: Colors.grey)
                                     )
                                 ),
                                 DataTable(
                                     decoration: BoxDecoration(
                                       borderRadius: BorderRadius.circular(5),
                                       border: Border.all(
                                         color: Colors.grey,
                                       ),
                                     ),
                                     dividerThickness: 0,
                                     border: TableBorder(
                                       borderRadius: BorderRadius.circular(5),
                                     ),
                                     columns: [
                                       DataColumn(
                                         label: Text('Nilai'),
                                       ),
                                     ],
                                     rows: cf!.map((e){
                                       double data = double.parse((e).toStringAsFixed(2));
                                       return  DataRow(cells: [

                                         DataCell(Text('$data')),
                                       ]);
                                     }).toList()
                                 )
                               ],
                             ),
                           )
                         ],
                       ),
                       20.height,
                       Row(
                         children: [
                           Container(
                             width: 100,
                             child:  Text('Hasil',
                                 style: GoogleFonts.poppins(
                                     textStyle: boldTextStyle(size: 14, color: Colors.grey)
                                 )
                             ),
                           ),
                          Expanded(
                            child:  Text(': ${diagnosa!.results!.artikel![0].kodeDepresi} | ${diagnosa!.results!.artikel![0].title}',
                                style: GoogleFonts.poppins(
                                    textStyle: boldTextStyle(size: 14, color: Colors.grey)
                                )
                            ),
                          )
                         ],
                       ),
                       Row(
                         crossAxisAlignment: CrossAxisAlignment.start,
                         children: [
                           Container(
                             width: 100,
                             child:  Text('Keterangan',
                                 style: GoogleFonts.poppins(
                                     textStyle: boldTextStyle(size: 14, color: Colors.grey)
                                 )
                             ),
                           ),
                           Expanded(
                             child: Text(': ${diagnosa!.results!.artikel![0].content}',
                                 style: GoogleFonts.poppins(
                                     textStyle: secondaryTextStyle(size: 14, color: Colors.grey)
                                 )
                             ),
                           )
                         ],
                       ),
                       10.height,
                       Center(
                         child: Container(
                           height: 100.0,
                           width: 150,
                           decoration: BoxDecoration(
                             image: DecorationImage(
                               image: NetworkImage("${diagnosa!.results!.artikel![0].image}"),
                               fit: BoxFit.fill,
                             ),
                           ),
                         ),
                       ),
                       40.height





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
