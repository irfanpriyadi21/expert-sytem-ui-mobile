import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:nb_utils/nb_utils.dart';


class Diagnosa extends StatefulWidget {
  const Diagnosa({Key? key}) : super(key: key);

  @override
  State<Diagnosa> createState() => _DiagnosaState();
}

class _DiagnosaState extends State<Diagnosa> {
  List<String> gejala = [
    "Sering Merasa Sedih",
    "Sering kelelahan melakukan aktifitas ringan",
    "Kurang konsentrasi dalam belajar ",
    "Mudah merasa bosan",
  ];
  List<String>? val = [
    "",
    "",
    "",
    ""
  ];
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
                      ListView.builder(
                        shrinkWrap: true,
                        itemCount: gejala.length,
                        physics: ScrollPhysics(),
                        itemBuilder: ((BuildContext ctx, int? index){
                          return Container(
                            child: Column(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                Text('${index!+1}. ${gejala[index!]} ?',
                                    style: GoogleFonts.poppins(
                                        textStyle: secondaryTextStyle(size: 16, color: Colors.grey)
                                    ),
                                ),
                                RadioListTile(
                                  title: Text("Tidak Tahu",
                                    style: GoogleFonts.poppins(
                                        textStyle: secondaryTextStyle(size: 14, color: Colors.grey)
                                    ),
                                  ),
                                  value: "tidaktahu",
                                  groupValue: val![index],
                                  onChanged: (value){
                                    setState(() {
                                      val!.add(value!);
                                    });
                                  },
                                ),
                                RadioListTile(
                                  title: Text("Tidak Yakin",
                                    style: GoogleFonts.poppins(
                                        textStyle: secondaryTextStyle(size: 14, color: Colors.grey)
                                    ),
                                  ),
                                  value: "tidakyakin",
                                  groupValue: val![index],
                                  onChanged: (value){
                                    setState(() {
                                      val!.add(value!);
                                    });
                                  },
                                ),
                                RadioListTile(
                                  title: Text("Mungkin",
                                    style: GoogleFonts.poppins(
                                        textStyle: secondaryTextStyle(size: 14, color: Colors.grey)
                                    ),
                                  ),
                                  value: "mungkin",
                                  groupValue: val![index],
                                  onChanged: (value){
                                    setState(() {
                                      val!.add(value!);
                                    });
                                  },
                                ),
                                RadioListTile(
                                  title: Text("Kemungkinan Besar",
                                    style: GoogleFonts.poppins(
                                        textStyle: secondaryTextStyle(size: 14, color: Colors.grey)
                                    ),
                                  ),
                                  value: "kemungkinanbesar",
                                  groupValue: val![index],
                                  onChanged: (value){
                                    setState(() {
                                      val!.add(value!);
                                    });
                                  },
                                ),
                                RadioListTile(
                                  title: Text("Hampir Pasti",
                                    style: GoogleFonts.poppins(
                                        textStyle: secondaryTextStyle(size: 14, color: Colors.grey)
                                    ),
                                  ),
                                  value: "hampirPasti",
                                  groupValue: val![index],
                                  onChanged: (value){
                                    setState(() {
                                      val!.add(value!);
                                    });
                                  },
                                ),
                                RadioListTile(
                                  title: Text("Pasti",
                                    style: GoogleFonts.poppins(
                                        textStyle: secondaryTextStyle(size: 14, color: Colors.grey)
                                    ),
                                  ),
                                  value: "pasti",
                                  groupValue: val![index],
                                  onChanged: (value){
                                    setState(() {
                                      val!.add(value!);
                                    });
                                  },
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
