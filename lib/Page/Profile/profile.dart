import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:nb_utils/nb_utils.dart';
import 'package:provider/provider.dart';
import 'package:tugas_kp/Page/Login.dart';
import 'package:tugas_kp/Page/Profile/editProfile.dart';
import 'package:tugas_kp/Provider/Auth/logout.dart';

import '../../Model/ModelUser.dart';
import '../../Model/string_http_exception.dart';
import '../../Provider/Profile/profile.dart';
import '../../Provider/base_url.dart';
import '../../utils/alert.dart';
import '../../utils/navigatorKey.dart';
import '../widget/loading.dart';

class Profile extends StatefulWidget {
  const Profile({Key? key}) : super(key: key);

  @override
  State<Profile> createState() => _ProfileState();
}

class _ProfileState extends State<Profile> {
  bool isLoading = false;
  ModelUser? user;
  // String? name;
  // String? email;
  //
  // getPref() async {
  //   SharedPreferences preferences = await SharedPreferences.getInstance();
  //   setState(() {
  //     email = preferences.getString('email')?? "";
  //     name = preferences.getString('name')?? "";
  //   });
  // }
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
      }
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
          title: Text('My Profile', style: GoogleFonts.poppins(
            textStyle: boldTextStyle(color: Colors.grey, size: 20)
          )),
          centerTitle: true,
          automaticallyImplyLeading: false,
          elevation: 0.0,
          // brightness: Brightness.dark,
        ),
        body: Container(
          height: context.height(),
          width: context.width(),
          padding: EdgeInsets.only(top: 60),
          decoration: BoxDecoration(
            image: DecorationImage(image: AssetImage('assets/images/background.jpg'), fit: BoxFit.cover),
          ),
          child: SingleChildScrollView(
            child:
            isLoading
                ? Loading()
                : user == null
                ? Container()
                :Column(
              crossAxisAlignment: CrossAxisAlignment.center,
              children: [
                CircleAvatar(
                  radius: 30.0,
                  backgroundImage:
                  user!.results!.user!.profileImage == null
                      ?  NetworkImage('https://images.pexels.com/photos/220453/pexels-photo-220453.jpeg?auto=compress&cs=tinysrgb&dpr=1&w=500')
                      :  NetworkImage('${url2}${user!.results!.user!.profileDir}/${user!.results!.user!.profileImage}'),

                  backgroundColor: Colors.transparent,
                ),
                16.height,
                Text(
                  '${user!.results!.user!.name} !',
                  style: GoogleFonts.poppins(
                      textStyle: TextStyle(
                          color: Colors.grey,
                          fontWeight: FontWeight.bold,
                          fontSize: 14)
                  ),
                ),
                Text(
                  '${user!.results!.user!.email} !',
                  style: GoogleFonts.poppins(
                      textStyle: TextStyle(
                          color: Colors.grey,
                          fontSize: 14)
                  ),
                ),
                30.height,
                SettingItemWidget(
                    title: 'Edit Profile',
                    titleTextStyle: GoogleFonts.poppins(
                        textStyle: boldTextStyle(color: Colors.grey)
                    ),
                    decoration: boxDecorationRoundedWithShadow(12, backgroundColor: context.cardColor),
                    trailing: Icon(Icons.arrow_right, color: grey.withOpacity(0.5)),
                    onTap: () {
                      EditProfile().launch(context);
                    }),

                16.height,
                SettingItemWidget(
                    title: 'Logout',
                    titleTextStyle: GoogleFonts.poppins(
                        textStyle: boldTextStyle(color: Colors.grey)
                    ),
                    decoration: boxDecorationRoundedWithShadow(12, backgroundColor: context.cardColor),
                    trailing: Icon(Icons.power_settings_new, color: Colors.red),
                    onTap: () {
                      Logout();
                      Login().launch(context);
                    }),

              ],
            ).paddingAll(16),
          ),
        ),
      ),
    );
  }
}
