import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:nb_utils/nb_utils.dart';
import 'package:tugas_kp/Page/Profile/editProfile.dart';

class Profile extends StatefulWidget {
  const Profile({Key? key}) : super(key: key);

  @override
  State<Profile> createState() => _ProfileState();
}

class _ProfileState extends State<Profile> {
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
          brightness: Brightness.dark,
        ),
        body: Container(
          height: context.height(),
          width: context.width(),
          padding: EdgeInsets.only(top: 60),
          decoration: BoxDecoration(
            image: DecorationImage(image: AssetImage('assets/images/background.jpg'), fit: BoxFit.cover),
          ),
          child: SingleChildScrollView(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.center,
              children: [
              CircleAvatar(
                  radius: 40.0,
                  backgroundImage:
                  NetworkImage('https://images.pexels.com/photos/220453/pexels-photo-220453.jpeg?auto=compress&cs=tinysrgb&dpr=1&w=500'),
                  backgroundColor: Colors.transparent,
                ),
                16.height,
                Text('Irfan Priyadi Nurfauzi', style: GoogleFonts.poppins(
                  textStyle: boldTextStyle(color: Colors.grey)
                )),
                Text('irfanpnf@gmail.com', style: GoogleFonts.poppins(
                    textStyle: secondaryTextStyle(color: Colors.grey)
                )),
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
                      //
                    }),

              ],
            ).paddingAll(16),
          ),
        ),
      ),
    );
  }
}
