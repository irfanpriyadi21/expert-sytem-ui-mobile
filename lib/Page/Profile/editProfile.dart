import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:nb_utils/nb_utils.dart';

import '../../utils/widget/WAColors.dart';
import '../../utils/widget/WAWidgets.dart';


class EditProfile extends StatefulWidget {
  const EditProfile({Key? key}) : super(key: key);

  @override
  State<EditProfile> createState() => _EditProfileState();
}

class _EditProfileState extends State<EditProfile> {
  var name = TextEditingController();
  var email = TextEditingController();
  FocusNode nameF = FocusNode();
  FocusNode emailF = FocusNode();


  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Scaffold(
        extendBodyBehindAppBar: true,
        appBar: AppBar(
          backgroundColor: Colors.transparent,
          title: Text(
            'Edit Profile',
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
                margin: EdgeInsets.only(top: 80),
                padding: EdgeInsets.only(top: 50, left: 16, right: 16, bottom: 16),
                width: context.width(),
                height: context.height(),
                decoration: boxDecorationWithShadow(backgroundColor: context.cardColor, borderRadius: BorderRadius.only(topLeft: Radius.circular(30), topRight: Radius.circular(30))),
                child: SingleChildScrollView(
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      16.height,
                      Container(
                        padding: EdgeInsets.all(16),
                        decoration: BoxDecoration(borderRadius: BorderRadius.circular(16), border: Border.all(color: Colors.grey.withOpacity(0.2), width: 0.5)),
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Text('Full Name',
                                style: GoogleFonts.poppins(
                                  textStyle: boldTextStyle(size: 14)
                                )
                            ),
                            8.height,
                            AppTextField(
                              decoration: waInputDecoration(
                                hint: 'Enter your full name here',
                              ),
                              textFieldType: TextFieldType.NAME,
                              keyboardType: TextInputType.name,
                              controller: name,
                              focus: nameF,
                            ),
                            16.height,
                            Text('Email',
                                style: GoogleFonts.poppins(
                                  textStyle: boldTextStyle(size: 14)
                                )
                            ),
                            8.height,
                            AppTextField(
                              decoration: waInputDecoration(
                                hint: 'Enter your email here',
                              ),
                              textFieldType: TextFieldType.PHONE,
                              keyboardType: TextInputType.phone,
                              controller: email,
                              focus: emailF,
                            ),
                          ],
                        ),
                      ),
                      16.height,
                      AppButton(
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
                      ).cornerRadiusWithClipRRect(30).paddingOnly(left: context.width() * 0.1, right: context.width() * 0.1),
                    ],
                  ),
                ),
              ),
              Stack(
                alignment: AlignmentDirectional.bottomEnd,
                children: [
                  Container(
                    margin: EdgeInsets.only(right: 8),
                    height: 110,
                    width: 110,
                    decoration: BoxDecoration(color: WAPrimaryColor, shape: BoxShape.circle),
                    child: Icon(Icons.person, color: white, size: 60),
                  ),
                  Positioned(
                    bottom: 16,
                    child: Container(
                      padding: EdgeInsets.all(6),
                      child: Icon(Icons.edit, color: Colors.white, size: 20),
                      decoration: BoxDecoration(color: WAAccentColor, shape: BoxShape.circle),
                    ),
                  ),
                ],
              ),
            ],
          ).paddingTop(60),
        ),
      ),
    );
  }
}
