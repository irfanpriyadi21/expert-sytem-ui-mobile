import 'dart:async';
import 'dart:io';


import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:image_picker/image_picker.dart';
import 'package:nb_utils/nb_utils.dart';
import 'package:page_transition/page_transition.dart';
import 'package:provider/provider.dart';
import 'package:tugas_kp/Page/Profile/profile.dart';
import 'package:tugas_kp/Page/indexAdmin.dart';
import 'package:tugas_kp/Page/indexUser.dart';
import '../../Provider/base_url.dart';
import '../../Model/ModelUser.dart';
import '../../Model/string_http_exception.dart';
import '../../Provider/Auth/logout.dart';
import '../../Provider/Profile/profile.dart';
import '../../utils/alert.dart';
import '../../utils/navigatorKey.dart';
import '../../utils/widget/WAColors.dart';
import '../../utils/widget/WAWidgets.dart';
import '../Login.dart';
import '../widget/loading.dart';


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
  bool isLoading = false;
  ModelUser? user;
  File? image;
  int? role;

  Future pickImage() async {
    try {
      final image = await ImagePicker().pickImage(source: ImageSource.gallery);
      if(image == null) return;
      final imageTemp = File(image.path);
      setState(() => this.image = imageTemp);
    } on PlatformException catch(e) {
      print('Failed to pick image: $e');
    }
  }

  getData()async{
    setState(() {
      isLoading = true;
    });
    try{
      user = await Provider.of<ProfileData>(context, listen: false).getUser();
    }on StringHttpException catch(err){
      var errorMessage = err.toString();
      AlertFail(errorMessage);
    }catch(e, st){
      print(st);
      AlertFail("Something Went Wrong! $e");
    }
    setState(() {
      if(user == null){
        Logout();
        Navigator.push(
            NavigationService.navigatorKey.currentContext!,
            MaterialPageRoute(
                builder: (context) => const Login()
            )
        );
      }else{
        name.text = user!.results!.user!.name!;
        email.text = user!.results!.user!.email!;
        isLoading = false;
      }

    });
  }

  editProfile() async {
    setState(() {
      isLoading = true;
    });
    try {
      await Provider.of<ProfileData>(context, listen: false).editProf(
          name.value.text, email.value.text, image);
    } on StringHttpException catch (e) {
      var errorMessage = e.toString();
      AlertFail(errorMessage);
    } catch (error, s) {
      print(s);
      AlertFail("Edit Profile Gagal !! $error");
    }
    setState(() {
      isLoading = false;
      bool register = Provider
          .of<ProfileData>(context, listen: false)
          .editProfile!;
      if(register){
        AlertSucess("Berhasil Menyimpan Data !");
        Timer(Duration(seconds: 2), (){
          Navigator.pushReplacement(
              context,
              PageTransition(
                  type: PageTransitionType.fade,
                  child: role == 1
                        ?  IndextAdmin(1)
                        :  IndexUser(1)
              )
          );
        });
      }

    });
  }

  getPref() async {
    SharedPreferences preferences = await SharedPreferences.getInstance();
    setState(() {
      role = preferences.getInt("role");
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
                      isLoading
                      ? Loading()
                      : AppButton(
                        color: WAPrimaryColor,
                        width: context.width(),
                        child: Text('Simpan',
                            style: GoogleFonts.poppins(
                                textStyle: boldTextStyle(color: Colors.white)
                            ) ),
                        onTap: () {
                         editProfile();
                        },
                      ).cornerRadiusWithClipRRect(30).paddingOnly(left: context.width() * 0.1, right: context.width() * 0.1),
                    ],
                  ),
                ),
              ),
              Stack(
                alignment: AlignmentDirectional.bottomEnd,
                children: [
                  image == null
                  ? CircleAvatar(
                    radius: 60.0,
                    backgroundImage:user == null
                        ? NetworkImage('https://images.pexels.com/photos/220453/pexels-photo-220453.jpeg?auto=compress&cs=tinysrgb&dpr=1&w=500')
                        :  user!.results!.user!.profileImage == null
                        ? NetworkImage('https://images.pexels.com/photos/220453/pexels-photo-220453.jpeg?auto=compress&cs=tinysrgb&dpr=1&w=500')
                        : NetworkImage('${url2}${user!.results!.user!.profileDir}/${user!.results!.user!.profileImage}'),
                    backgroundColor: Colors.transparent,
                  )
                  : CircleAvatar(
                    backgroundColor: Colors.transparent,
                    radius: 60,
                    child: CircleAvatar(
                      radius: 60,
                      backgroundImage: Image.file(
                        image!,
                        fit: BoxFit.cover,
                      ).image,
                    ),
                  ),
                  Positioned(
                    bottom: 16,
                    child: GestureDetector(
                      onTap: (){
                        pickImage();
                      },
                      child: Container(
                        padding: EdgeInsets.all(6),
                        child: Icon(Icons.edit, color: Colors.white, size: 20),
                        decoration: BoxDecoration(color: WAAccentColor, shape: BoxShape.circle),
                      ),
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
