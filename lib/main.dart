import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:nb_utils/nb_utils.dart';
import 'package:tugas_kp/Page/Login.dart';
import 'package:tugas_kp/Provider/Auth/auth.dart';
import 'package:tugas_kp/Provider/Depresi/depresi.dart';
import 'package:tugas_kp/Provider/Diagnosa/diagnosa.dart';
import 'package:tugas_kp/Provider/Profile/profile.dart';
import 'package:tugas_kp/Provider/app_provider.dart';
import 'package:tugas_kp/utils/navigatorKey.dart';
import 'package:tugas_kp/utils/widget/WAColors.dart';
import 'package:tugas_kp/utils/widget/WAWidgets.dart';
import 'package:provider/provider.dart';

import 'Provider/Gejala/gejala.dart';

void main() {
  runApp(
    MultiProvider(
      providers:[
       ChangeNotifierProvider(
         create:(_) => AppProvider(),
       )
    ],
      child:  const MyApp(),
    )
  );
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MultiProvider(
        providers:[
          ChangeNotifierProvider.value(
            value: Auth(),
          ),
          ChangeNotifierProvider.value(
            value: DiagnosaApi(),
          ),
          ChangeNotifierProvider.value(
            value: ProfileData(),
          ),
          ChangeNotifierProvider.value(
            value: DepresiApi(),
          ),
          ChangeNotifierProvider.value(
            value: GejalaApi(),
          )
        ],
        child: Consumer<AppProvider>(
          builder: (context, value, child){
            return MaterialApp(
              title: 'Sistem Pakar',
              navigatorKey: NavigationService.navigatorKey,
              debugShowCheckedModeBanner: false,
              theme: ThemeData(
                primarySwatch: Colors.blue,
              ),
              home: const Login(),
            );
          },
        ),
    );
  }
}
