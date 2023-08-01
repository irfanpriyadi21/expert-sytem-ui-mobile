import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:nb_utils/nb_utils.dart';


class ReportDetail extends StatefulWidget {
  const ReportDetail({Key? key}) : super(key: key);

  @override
  State<ReportDetail> createState() => _ReportDetailState();
}

class _ReportDetailState extends State<ReportDetail> {
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
          brightness: Brightness.dark,
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
                          rows: [

                            DataRow(cells: [
                              DataCell(Text('1')),
                              DataCell(Text('G001 | P001')),
                              DataCell(Text('0.4')),
                            ]),
                            DataRow(cells: [
                              DataCell(Text('2')),
                              DataCell(Text('G002 | P001')),
                              DataCell(Text('0.2')),
                            ]),
                            DataRow(cells: [
                              DataCell(Text('3')),
                              DataCell(Text('G003 | P001')),
                              DataCell(Text('0.1')),
                            ]),
                            DataRow(cells: [
                              DataCell(Text('4')),
                              DataCell(Text('G004 | P001')),
                              DataCell(Text('0.2')),
                            ])
                          ]),
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
                                    rows: [

                                      DataRow(cells: [
                                        DataCell(Text('G001')),
                                        DataCell(Text('0.1')),
                                      ]),
                                      DataRow(cells: [
                                        DataCell(Text('G002')),
                                        DataCell(Text('0.6')),
                                      ]),
                                      DataRow(cells: [
                                        DataCell(Text('G003')),
                                        DataCell(Text('0.8')),
                                      ]),
                                      DataRow(cells: [
                                        DataCell(Text('G004')),
                                        DataCell(Text('0.1')),
                                      ])
                                    ])
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
                                    rows: [

                                      DataRow(cells: [
                                        DataCell(Text('0.4')),
                                      ]),
                                      DataRow(cells: [
                                        DataCell(Text('0.12')),
                                      ]),
                                      DataRow(cells: [
                                        DataCell(Text('0.8')),
                                      ]),
                                      DataRow(cells: [
                                        DataCell(Text('0.2')),
                                      ])
                                    ])
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
                          Text(': P001 | Gangguan Mood',
                              style: GoogleFonts.poppins(
                                  textStyle: boldTextStyle(size: 14, color: Colors.grey)
                              )
                          ),
                        ],
                      ),
                      Row(
                        children: [
                          Container(
                            width: 100,
                            child:  Text('Keakuratan',
                                style: GoogleFonts.poppins(
                                    textStyle: boldTextStyle(size: 14, color: Colors.grey)
                                )
                            ),
                          ),
                          Text(': 91.55 %',
                              style: GoogleFonts.poppins(
                                  textStyle: boldTextStyle(size: 14, color: Colors.grey)
                              )
                          ),
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
                            child: Text(': Ganggguan mood yang terjadi pada seseorang ini umumnya terjadi karena banyaknya tekanan yang menimpa dirinya dan cenderung terlarut dalam tekanan dapat meningkatkan resiko berkembangnya gangguan mood yang kemudian dapat berubah menjadi depresi terutama depresi mayor. Hal ini terbukti pada suatu penelitian yang menemukan bahwa dalam sekitar empat dari lima kasus, depresi mayor diawali oleh peristiwa kehidupan yang penuh tekanan.',
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
                              image: AssetImage(
                                  "assets/images/gangguanMood.jpg"),
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
