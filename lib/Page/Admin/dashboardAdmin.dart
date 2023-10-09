import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:nb_utils/nb_utils.dart';
import 'package:intl/intl.dart';
import 'package:provider/provider.dart';
import 'package:tugas_kp/Page/Admin/Depresi/Depresi.dart';
import 'package:tugas_kp/Page/Admin/Gejala/Gejala.dart';

import '../../Model/ModelListDiagnosa.dart';
import '../../Model/ModelUser.dart';
import '../../Model/string_http_exception.dart';
import '../../Provider/Auth/logout.dart';
import '../../Provider/Diagnosa/diagnosa.dart';
import '../../Provider/Profile/profile.dart';
import '../../Provider/base_url.dart';
import '../../utils/alert.dart';
import '../../utils/navigatorKey.dart';
import '../Login.dart';
import '../User/Report/report.dart';
import '../User/Report/reportDetail.dart';
import '../widget/loading.dart';


class DashboardAdmin extends StatefulWidget {
  const DashboardAdmin({Key? key}) : super(key: key);

  @override
  State<DashboardAdmin> createState() => _DashboardAdminState();
}

class _DashboardAdminState extends State<DashboardAdmin> {
  bool isLoading = false;
  ModelUser? user;
  List<ModelListDiagnosa> listDiagnosa = [];
  bool isLoading2 = false;
  int? role;
  int? userId;

  getDataHistory()async{
    setState(() {
      isLoading2 = true;
    });
    try{
      await Provider.of<DiagnosaApi>(context, listen: false).getListDiagnosa(
          role == 1
              ? ""
              : "?created_by=$userId");
    }on StringHttpException catch(err){
      var errorMessage = err.toString();
      AlertFail(errorMessage);
    }catch(e, st){
      print(st);
      AlertFail("Something Went Wrong! $e");
    }
    setState(() {
      listDiagnosa = Provider.of<DiagnosaApi>(context, listen: false).listDiagnosa;
      isLoading2 = false;
    });
  }

  getPref()async {
    SharedPreferences preferences = await SharedPreferences.getInstance();
    setState(() {
      role = preferences.getInt("role");
      userId = preferences.getInt("id");
      getDataHistory();
    });
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
      }
      isLoading = false;
    });
  }

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    getPref();
    getData();
  }


  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Container(
          width: context.width(),
          height: context.height(),
          decoration: BoxDecoration(
            image: DecorationImage(image: AssetImage('assets/images/background.jpg'), fit: BoxFit.cover),
          ),
        child: SingleChildScrollView(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Padding(
                padding: EdgeInsets.only(
                    top: 60, left: 15
                ),
                child: Text(
                  'Diagnosa Depresi',
                  style: GoogleFonts.poppins(
                      textStyle: TextStyle(
                          color: Colors.grey,
                          fontWeight: FontWeight.bold,
                          fontSize: 20)
                  ),
                ),
              ),
              Container(
                  padding:
                  const EdgeInsets.symmetric(horizontal: 20, vertical: 40),
                  margin: EdgeInsets.only(top: 20, bottom: 20, right: 15, left: 15),
                  decoration: BoxDecoration(
                    color: Color(0xFF6C56F9),
                    borderRadius: BorderRadius.circular(20),
                    boxShadow: const [
                      BoxShadow(
                        blurRadius: 60,
                        spreadRadius: 4,
                        color: Color(0x1A000000),
                      ),
                    ],
                    // image: const DecorationImage(
                    //     alignment: Alignment.centerRight,
                    //     image: AssetImage('assets/images/illustration.png'),
                    //     opacity: 0.03,
                    //     fit: BoxFit.contain)
                  ),
                  child: Column(
                    children: [
                      Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          Expanded(
                              child: isLoading
                                  ? const Loading()
                                  : user == null
                                  ? Container()
                                  : Row(
                                children: [
                                  CircleAvatar(
                                    radius: 25.0,
                                    backgroundImage:
                                    user!.results!.user!.profileImage == null
                                        ?  NetworkImage('https://images.pexels.com/photos/220453/pexels-photo-220453.jpeg?auto=compress&cs=tinysrgb&dpr=1&w=500')
                                        :  NetworkImage('${url2}${user!.results!.user!.profileDir}/${user!.results!.user!.profileImage}'),

                                    backgroundColor: Colors.transparent,
                                  ),
                                  SizedBox(width: 10),
                                  Expanded(
                                    child: Column(
                                      crossAxisAlignment: CrossAxisAlignment.start,
                                      children: [
                                        Text(
                                          'Welcome,',
                                          style: GoogleFonts.poppins(
                                              textStyle: TextStyle(
                                                  color: Colors.white,
                                                  fontSize: 14)
                                          ),
                                        ),
                                        Text(
                                          '${user!.results!.user!.name} !',
                                          style: GoogleFonts.poppins(
                                              textStyle: TextStyle(
                                                  color: Colors.white,
                                                  fontWeight: FontWeight.bold,
                                                  fontSize: 14)
                                          ),
                                        )
                                      ],
                                    ),
                                  )
                                ],
                              )
                          ),
                          Text(
                            '${DateFormat('MMM d, yyyy').format(DateTime.now())}',
                            style: GoogleFonts.poppins(
                                textStyle: TextStyle(
                                    color: Colors.white,
                                    fontSize: 12)
                            ),
                          ),

                        ],
                      )
                    ],
                  )
              ),
              Padding(
                padding: EdgeInsets.only(
                    top: 20, left: 15
                ),
                child: Text(
                  'Menu',
                  style: GoogleFonts.poppins(
                      textStyle: TextStyle(
                          color: Colors.grey,
                          fontWeight: FontWeight.bold,
                          fontSize: 18)
                  ),
                ),
              ),
              Center(
                child: SingleChildScrollView(
                    scrollDirection: Axis.horizontal,
                    child: Wrap(
                      direction: Axis.horizontal,
                      spacing: 16,
                      children: [
                        GestureDetector(
                          onTap: (){
                            Depresi().launch(context);
                          },
                          child: Column(
                            mainAxisAlignment: MainAxisAlignment.center,
                            children: [
                              Container(
                                width: 80,
                                height: 80,
                                alignment: Alignment.center,
                                decoration: boxDecorationRoundedWithShadow(
                                  16,
                                  backgroundColor: context.cardColor,
                                  shadowColor: Colors.grey.withOpacity(0.2),
                                ),
                                child: ImageIcon(AssetImage('assets/images/wa_ticket.png'), size: 30, color: Color(0xFF6C56F9)),
                              ),
                              8.height,
                              Text(
                                'Master Diagnosa',
                                style: GoogleFonts.poppins(
                                    textStyle:  secondaryTextStyle(
                                      size: 14,
                                      color: Colors.grey,
                                    )
                                ),
                                textAlign: TextAlign.center,
                                maxLines: 1,
                              ),
                            ],
                          ),
                        ),
                        GestureDetector(
                          onTap: (){
                            Gejala().launch(context);
                          },
                          child: Column(
                            mainAxisAlignment: MainAxisAlignment.center,
                            children: [
                              Container(
                                width: 80,
                                height: 80,
                                alignment: Alignment.center,
                                decoration: boxDecorationRoundedWithShadow(
                                  16,
                                  backgroundColor: context.cardColor,
                                  shadowColor: Colors.grey.withOpacity(0.2),
                                ),
                                child: ImageIcon(AssetImage('assets/images/wa_ticket.png'), size: 30, color:Color(0xFFFF7426)),
                              ),
                              8.height,
                              Text(
                                'Master Gejala',
                                style: GoogleFonts.poppins(
                                    textStyle:  secondaryTextStyle(
                                      size: 14,
                                      color: Colors.grey,
                                    )
                                ),
                                textAlign: TextAlign.center,
                                maxLines: 1,
                              ),
                            ],
                          ),
                        ),
                        GestureDetector(
                          onTap: (){
                            Report().launch(context);
                          },
                          child: Column(
                            mainAxisAlignment: MainAxisAlignment.center,
                            children: [
                              Container(
                                width: 80,
                                height: 80,
                                alignment: Alignment.center,
                                decoration: boxDecorationRoundedWithShadow(
                                  16,
                                  backgroundColor: context.cardColor,
                                  shadowColor: Colors.grey.withOpacity(0.2),
                                ),
                                child: ImageIcon(AssetImage('assets/images/wa_ticket.png'), size: 30, color:Colors.red),
                              ),
                              8.height,
                              Text(
                                'Laporan',
                                style: GoogleFonts.poppins(
                                    textStyle:  secondaryTextStyle(
                                      size: 14,
                                      color: Colors.grey,
                                    )
                                ),
                                textAlign: TextAlign.center,
                                maxLines: 1,
                              ),
                            ],
                          ),
                        ),

                      ],
                    ).paddingAll(16)
                ),
              ),
              Padding(
                padding: EdgeInsets.only(
                    top: 20, left: 15
                ),
                child: Text(
                  'History Terakhir',
                  style: GoogleFonts.poppins(
                      textStyle: TextStyle(
                          color: Colors.grey,
                          fontWeight: FontWeight.bold,
                          fontSize: 18)
                  ),
                ),
              ),
              SizedBox(height: 20),
              isLoading2
                  ? Loading()
                  : ListView.builder(
                shrinkWrap: true,
                physics: ScrollPhysics(),
                itemCount: listDiagnosa.isEmpty
                    ? 0
                    : listDiagnosa.length <= 5
                    ? listDiagnosa.length
                    : 5,
                itemBuilder: ((BuildContext ctx, int index){
                  return GestureDetector(
                    onTap: (){
                      ReportDetail(listDiagnosa[index].diagnosaId!).launch(context);
                    },
                    child: Container(
                      padding: const EdgeInsets.only(left: 16, right: 16, bottom: 10),
                      margin: const EdgeInsets.only(bottom: 16, left: 16, right: 16),
                      decoration: boxDecorationRoundedWithShadow(16, backgroundColor: context.cardColor),
                      child: ListTile(
                        tileColor: index == 0
                            ? Colors.green
                            : index == 1
                            ? Colors.orange
                            : index == 2
                            ? Colors.red
                            : Colors.red,
                        enabled: true,
                        contentPadding: EdgeInsets.zero,
                        leading: Container(
                          height: 50,
                          width: 50,
                          alignment: Alignment.center,
                          decoration: boxDecorationWithRoundedCorners(
                            boxShape: BoxShape.circle,
                            backgroundColor: index == 0
                                ? Colors.green.withOpacity(0.1)
                                : index == 1
                                ? Colors.orange.withOpacity(0.1)
                                : index == 2
                                ? Colors.red.withOpacity(0.1)
                                : Colors.red.withOpacity(0.1),
                          ),
                          child: ImageIcon(
                            AssetImage('assets/images/wa_ticket.png'),
                            size: 24,
                            color: index == 0
                                ? Colors.green
                                : index == 1
                                ? Colors.orange
                                : index == 2
                                ? Colors.red
                                : Colors.red,
                          ),
                        ),
                        title: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Text(
                              '${listDiagnosa[index].diagnosaId}',
                              style: GoogleFonts.poppins(
                                  textStyle: boldTextStyle(color:Colors.black54, size: 14)
                              ),
                            ),
                          ],
                        ),
                        subtitle: Text(
                          '${listDiagnosa[index].createdAt}',
                          style: GoogleFonts.poppins(
                              textStyle: primaryTextStyle(color:Colors.black54, size: 14)
                          ),
                        ),
                      ),
                    ),
                  );
                }),
              )
            ],
          ),
        )
      )
    );
  }
}
