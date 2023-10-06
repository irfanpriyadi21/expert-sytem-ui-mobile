import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:nb_utils/nb_utils.dart';
import 'package:tugas_kp/Page/User/Report/reportDetail.dart';


class Report extends StatefulWidget {
  const Report({Key? key}) : super(key: key);

  @override
  State<Report> createState() => _ReportState();
}

class _ReportState extends State<Report> {
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

                      ListView.builder(
                        shrinkWrap: true,
                        itemCount: 4,
                        itemBuilder: ((BuildContext ctx, int? index){
                          return GestureDetector(
                            onTap: (){
                              ReportDetail().launch(context);
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
                                title: RichTextWidget(
                                  list: [
                                    TextSpan(
                                      text: 'Irfan di diagnosa',
                                      style: GoogleFonts.poppins(
                                          textStyle: primaryTextStyle(color: Colors.black54, size: 14)
                                      ),
                                    ),
                                    TextSpan(
                                      text: index == 0
                                          ? '\t Gangguan Mood'
                                          : index == 1
                                          ? '\t Depresi Ringan'
                                          : index == 2
                                          ? '\t Depresi Sedang'
                                          : '\t Depresi Berat',
                                      style: GoogleFonts.poppins(
                                          textStyle: boldTextStyle(size: 14, color: black)
                                      ),
                                    ),
                                  ],
                                ),
                                subtitle: Text(
                                  '20 November 2023',
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
