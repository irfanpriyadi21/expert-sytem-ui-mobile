import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:nb_utils/nb_utils.dart';
import '../../../utils/widget/WAColors.dart';
import '../../../utils/widget/WAWidgets.dart';


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
                                        Expanded(
                                          child: AppButton(
                                            color: WAPrimaryColor,
                                            width: context.width(),
                                            child: Text('Simpan',
                                                style: GoogleFonts.poppins(
                                                    textStyle: boldTextStyle(color: Colors.white)
                                                ) ),
                                            onTap: () {
                                              // if (widget.isEditProfile) {
                                              //   finish(context);
                                              // } else {
                                              //   WAAddCredentialScreen().launch(context);
                                              // }
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

                      ListView.builder(
                        shrinkWrap: true,
                        itemCount: 4,
                        itemBuilder: ((BuildContext ctx, int? index){
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
                                        'P00${(index! + 1)}',
                                        style: GoogleFonts.poppins(
                                            textStyle: primaryTextStyle(color:Colors.black54, size: 14)
                                        ),
                                      ),
                                      Text(
                                        index == 1
                                        ? 'Sering Merasa Sedih'
                                        : index == 2
                                          ? "Sering kelelahan melakukan aktifitas ringan"
                                          : index == 3
                                            ? "Kurang konsentrasi dalam belajar "
                                            : index == 4
                                              ? "Mudah merasa bosan"
                                              : "Sering Melamun",
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
                                        print("My account menu is selected.");
                                      }else if(value == 1){
                                        print("Settings menu is selected.");
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
