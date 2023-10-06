import 'dart:async';

import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:nb_utils/nb_utils.dart';
import 'package:page_transition/page_transition.dart';
import 'package:provider/provider.dart';
import 'package:tugas_kp/Page/Login.dart';
import 'package:tugas_kp/Page/widget/loading.dart';

import '../Model/string_http_exception.dart';
import '../Provider/Auth/auth.dart';
import '../utils/alert.dart';
import '../utils/widget/WAColors.dart';
import '../utils/widget/WAWidgets.dart';


class Register extends StatefulWidget {
  const Register({Key? key}) : super(key: key);

  @override
  State<Register> createState() => _RegisterState();
}

class _RegisterState extends State<Register> {
  TextEditingController email = new TextEditingController();
  TextEditingController name = new TextEditingController();
  TextEditingController password = new TextEditingController();
  FocusNode fullNameFocusNode = FocusNode();
  FocusNode emailFocusNode = FocusNode();
  FocusNode passWordFocusNode = FocusNode();
  bool isLoading = false;

  register() async {
    setState(() {
      isLoading = true;
    });
    try {
      await Provider.of<Auth>(context, listen: false).register(
          name.value.text,
          email.value.text,
          password.value.text,
      );
    } on StringHttpException catch (e) {
      var errorMessage = e.toString();
      AlertFail(errorMessage);
    } catch (error, s) {
      AlertFail("Register Gagal !! $error");
    }
    setState(() {
      isLoading = false;
      bool register = Provider
          .of<Auth>(context, listen: false)
          .regis!;
      if(register){
        AlertSucess("Berhasil Menyimpan Data !");
        Timer(Duration(seconds: 2), (){
          Navigator.pushReplacement(
              context,
              PageTransition(
                  type: PageTransitionType.fade,
                  child: const Login()
              )
          );
        });
      }

    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Container(
        width: context.width(),
        height: context.height(),
        decoration: BoxDecoration(
          image: DecorationImage(image: AssetImage('assets/images/background.jpg')),
        ),
        child: SingleChildScrollView(
          child: Column(
            children: [
              50.height,
              Text("Register New Account", style: GoogleFonts.poppins(
                textStyle: boldTextStyle(size: 20, color: black)
              )),
              Container(
                margin: EdgeInsets.all(16),
                child: Stack(
                  alignment: Alignment.topCenter,
                  children: <Widget>[
                    Container(
                      width: context.width(),
                      padding: EdgeInsets.only(left: 16, right: 16, bottom: 16),
                      margin: EdgeInsets.only(top: 55.0),
                      decoration: boxDecorationWithShadow(borderRadius: BorderRadius.circular(30), backgroundColor: context.cardColor),
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: <Widget>[
                          Container(
                            child: Column(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                50.height,
                                Text("Full Name", style: GoogleFonts.poppins(
                                  textStyle: boldTextStyle(size: 14)
                                )),
                                8.height,
                                AppTextField(
                                  decoration: waInputDecoration(hint: 'Enter your full name here', prefixIcon: Icons.person_outline_outlined),
                                  textFieldType: TextFieldType.NAME,
                                  keyboardType: TextInputType.name,
                                  controller: name,
                                  focus: fullNameFocusNode,
                                  nextFocus: emailFocusNode,
                                ),
                                16.height,
                                Text("Email", style: GoogleFonts.poppins(
                                  textStyle: boldTextStyle(size: 14)
                                )),
                                8.height,
                                AppTextField(
                                  decoration: waInputDecoration(hint: 'Enter your email here', prefixIcon: Icons.email_outlined),
                                  textFieldType: TextFieldType.EMAIL,
                                  keyboardType: TextInputType.emailAddress,
                                  controller: email,
                                  focus: emailFocusNode,
                                  nextFocus: passWordFocusNode,
                                ),
                                16.height,
                                Text("Password", style: GoogleFonts.poppins(
                                  textStyle: boldTextStyle(size: 14)
                                )),
                                8.height,
                                AppTextField(
                                  decoration: waInputDecoration(hint: 'Enter your password here', prefixIcon: Icons.lock_outline),
                                  suffixIconColor: WAPrimaryColor,
                                  textFieldType: TextFieldType.PASSWORD,
                                  isPassword: true,
                                  keyboardType: TextInputType.visiblePassword,
                                  controller: password,
                                  focus: passWordFocusNode,
                                ),
                                30.height,
                                isLoading
                                ? Loading()
                                : AppButton(
                                    text: "Register Account",
                                    color: WAPrimaryColor,
                                    textColor: Colors.white,
                                    shapeBorder: RoundedRectangleBorder(borderRadius: BorderRadius.circular(30)),
                                    width: context.width(),
                                    onTap: () {
                                      if(email.value.text.isEmpty || name.value.text.isEmpty || password.value.text.isEmpty){
                                        AlertFail("Lengkapi Data !");
                                      }else{
                                        register();
                                      }
                                    }).paddingOnly(left: context.width() * 0.1, right: context.width() * 0.1),
                                30.height,
                                Row(
                                  mainAxisSize: MainAxisSize.min,
                                  crossAxisAlignment: CrossAxisAlignment.center,
                                  mainAxisAlignment: MainAxisAlignment.center,
                                  children: [
                                    Text('Already have an account?', style: GoogleFonts.poppins(
                                      textStyle: primaryTextStyle(color: Colors.grey)
                                    )),
                                    4.width,
                                    Text('Log In here', style: GoogleFonts.poppins(
                                      textStyle: boldTextStyle(color: black)
                                    )),
                                  ],
                                ).onTap(() {
                                  finish(context);
                                }).center(),
                              ],
                            ),
                          )
                        ],
                      ),
                    ),
                    Container(
                      alignment: Alignment.center,
                      height: 100,
                      width: 100,
                      decoration: boxDecorationRoundedWithShadow(30, backgroundColor: context.cardColor),
                      child: Image.asset(
                        'assets/images/logo.png',
                        height: 60,
                        width: 60,
                        fit: BoxFit.cover,
                      ),
                    )
                  ],
                ),
              ),
              SizedBox(height: 16),
            ],
          ),
        ),
      ),
    );
  }
}
