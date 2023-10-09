import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:nb_utils/nb_utils.dart';
import 'package:provider/provider.dart';
import 'package:tugas_kp/Page/Admin/dashboardAdmin.dart';
import 'package:tugas_kp/Page/User/dashboardUser.dart';
import 'package:tugas_kp/Page/indexAdmin.dart';
import 'package:tugas_kp/Page/indexUser.dart';
import 'package:tugas_kp/Page/widget/loading.dart';
import 'package:tugas_kp/utils/alert.dart';

import '../Model/string_http_exception.dart';
import '../Provider/Auth/auth.dart';
import '../utils/widget/WAColors.dart';
import '../utils/widget/WAWidgets.dart';
import 'Register.dart';

class Login extends StatefulWidget {
  const Login({Key? key}) : super(key: key);

  @override
  State<Login> createState() => _LoginState();
}

enum LoginStatus{notSignIn, signIn}

class _LoginState extends State<Login> {
  final navigatorKey = GlobalKey<NavigatorState>();
  var emailController = TextEditingController();
  var passwordController = TextEditingController();
  LoginStatus _loginStatus = LoginStatus.notSignIn;
  FocusNode emailFocusNode = FocusNode();
  FocusNode passWordFocusNode = FocusNode();
  bool isLoading = false;
  int? role;

  getPref() async {
    SharedPreferences preferences = await SharedPreferences.getInstance();
    setState(() {
      String status = preferences.getString('loginStatus')?? "";
      role = preferences.getInt('role');
      _loginStatus = status == 'success'
          ? LoginStatus.signIn
          : LoginStatus.notSignIn;
    });
  }

  login() async {
    setState(() {
      isLoading = true;
    });
    try {
      await Provider.of<Auth>(context, listen: false).authenticate(
          emailController.value.text,
          passwordController.value.text);
    } on StringHttpException catch (e) {
      var errorMessage = e.toString();
      AlertFail(errorMessage);
      setState(() {
        isLoading = false;
      });
    } catch (error, s) {
      print(s);
      AlertFail("Login Gagal !!");
      setState(() {
        isLoading = false;
      });
    }
    setState(() {
      isLoading = false;
      bool login = Provider
          .of<Auth>(context, listen: false)
          .login!;
      role = Provider
          .of<Auth>(context, listen: false)
          .role!;
      if (login == true) {
        _loginStatus = LoginStatus.signIn;
      }
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
    switch (_loginStatus) {
      case LoginStatus.notSignIn :
        return Scaffold(
          body: Container(
            width: context.width(),
            height: context.height(),
            decoration: BoxDecoration(image: DecorationImage(
                image: AssetImage('assets/images/background.jpg'),
                fit: BoxFit.cover)),
            child: SingleChildScrollView(
              child: Column(
                children: <Widget>[
                  70.height,
                  Text("Diagnosa Depresi \n Mahasiswa Semester Akhir",
                      textAlign: TextAlign.center,
                      style: GoogleFonts.poppins(
                          textStyle: boldTextStyle(size: 20, color: black)
                      )),
                  Container(
                    margin: EdgeInsets.all(16),
                    child: Stack(
                      alignment: Alignment.topCenter,
                      children: <Widget>[
                        Container(
                          width: context.width(),
                          padding: const EdgeInsets.only(
                              left: 16, right: 16, bottom: 16),
                          margin: const EdgeInsets.only(top: 55.0),
                          decoration: boxDecorationWithShadow(
                              borderRadius: BorderRadius.circular(30),
                              backgroundColor: context.cardColor),
                          child: Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: <Widget>[
                              Container(
                                child: Column(
                                  crossAxisAlignment: CrossAxisAlignment.start,
                                  children: [
                                    SizedBox(
                                      height: 50,
                                    ),
                                    Text("Email",
                                        style: GoogleFonts.poppins(
                                            textStyle: boldTextStyle(size: 14)
                                        )),
                                    8.height,
                                    AppTextField(
                                      decoration: waInputDecoration(
                                          hint: 'Enter your email here',
                                          prefixIcon: Icons.email_outlined),
                                      textFieldType: TextFieldType.EMAIL,
                                      keyboardType: TextInputType.emailAddress,
                                      controller: emailController,
                                      focus: emailFocusNode,
                                      nextFocus: passWordFocusNode,
                                    ),
                                    16.height,
                                    Text("Password", style: GoogleFonts.poppins(
                                        textStyle: boldTextStyle(size: 14)
                                    )),
                                    8.height,
                                    AppTextField(
                                      decoration: waInputDecoration(
                                          hint: 'Enter your password here',
                                          prefixIcon: Icons.lock_outline),
                                      suffixIconColor: WAPrimaryColor,
                                      textFieldType: TextFieldType.PASSWORD,
                                      isPassword: true,
                                      keyboardType: TextInputType
                                          .visiblePassword,
                                      controller: passwordController,
                                      focus: passWordFocusNode,
                                    ),
                                    30.height,
                                    isLoading
                                    ? Loading()
                                    : AppButton(
                                        text: "Log In",
                                        textStyle: GoogleFonts.poppins(
                                            color: Colors.white
                                        ),
                                        color: WAPrimaryColor,
                                        textColor: Colors.white,
                                        shapeBorder: RoundedRectangleBorder(
                                            borderRadius: BorderRadius.circular(
                                                30)),
                                        width: context.width(),
                                        onTap: () {
                                          if (emailController.value.text
                                              .isEmpty ||
                                              passwordController.value.text
                                                  .isEmpty) {
                                            AlertFail(
                                                "Lengkapi Username Password !!");
                                          } else {
                                            login();
                                            // if (emailController.value.text ==
                                            //     "admin" &&
                                            //     passwordController.value.text ==
                                            //         "admin") {
                                            //   IndextAdmin().launch(context);
                                            // } else
                                            // if (emailController.value.text ==
                                            //     "peserta" &&
                                            //     passwordController.value.text ==
                                            //         "peserta") {
                                            //   IndexUser(0).launch(context);
                                            // } else {
                                            //   AlertFail(
                                            //       "Username Password Salah !!");
                                            // }
                                          }
                                        }).paddingOnly(
                                        left: context.width() * 0.1,
                                        right: context.width() * 0.1),
                                    30.height,
                                    Row(
                                      mainAxisSize: MainAxisSize.min,
                                      crossAxisAlignment: CrossAxisAlignment
                                          .center,
                                      mainAxisAlignment: MainAxisAlignment
                                          .center,
                                      children: [
                                        Text('Don\'t have an account?',
                                            style: GoogleFonts.poppins(
                                                textStyle: primaryTextStyle(
                                                    color: Colors.grey)
                                            )),
                                        4.width,
                                        Text('Register here',
                                            style: GoogleFonts.poppins(
                                                textStyle: boldTextStyle(
                                                    color: black)
                                            )),
                                      ],
                                    ).onTap(() {
                                      Register().launch(context);
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
                          decoration: boxDecorationRoundedWithShadow(
                              30, backgroundColor: context.cardColor),
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
                  16.height,
                ],
              ),
            ),
          ),
        );
      case LoginStatus.signIn :
        return role == 1
              ? IndextAdmin(0)
              : IndexUser(0);
        break;
    }
  }
}
