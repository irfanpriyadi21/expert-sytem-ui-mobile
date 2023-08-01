import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:nb_utils/nb_utils.dart';
import 'package:intl/intl.dart';
import 'package:tugas_kp/Page/Admin/Gejala/Gejala.dart';


class DashboardAdmin extends StatefulWidget {
  const DashboardAdmin({Key? key}) : super(key: key);

  @override
  State<DashboardAdmin> createState() => _DashboardAdminState();
}

class _DashboardAdminState extends State<DashboardAdmin> {
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
                            child: Row(
                              children: [
                                CircleAvatar(
                                  radius: 25.0,
                                  backgroundImage:
                                  NetworkImage('https://images.pexels.com/photos/220453/pexels-photo-220453.jpeg?auto=compress&cs=tinysrgb&dpr=1&w=500'),
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
                                        'Administrator !',
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
                            ),
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
                        GestureDetector(
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
                                child: ImageIcon(AssetImage('assets/images/wa_ticket.png'), size: 30, color:Color(0xFF26C884)),
                              ),
                              8.height,
                              Text(
                                'Tambah Admin',
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
              Column(
                children: [
                  Container(
                    padding: EdgeInsets.only(left: 16, right: 16, bottom: 10),
                    margin: EdgeInsets.only(bottom: 16, left: 16, right: 16),
                    decoration: boxDecorationRoundedWithShadow(16, backgroundColor: context.cardColor),
                    child: ListTile(
                      tileColor: Colors.green,
                      enabled: true,
                      contentPadding: EdgeInsets.zero,
                      leading: Container(
                        height: 50,
                        width: 50,
                        alignment: Alignment.center,
                        decoration: boxDecorationWithRoundedCorners(
                          boxShape: BoxShape.circle,
                          backgroundColor: Colors.green.withOpacity(0.1),
                        ),
                        child: ImageIcon(
                          AssetImage('assets/images/wa_ticket.png'),
                          size: 24,
                          color: Colors.green,
                        ),
                      ),
                      title: RichTextWidget(
                        list: [
                          TextSpan(
                            text: 'Administrator menambahkan',
                            style: GoogleFonts.poppins(
                              textStyle: primaryTextStyle(color: Colors.black54, size: 14)
                            ),
                          ),
                          TextSpan(
                            text: '\t Gejala',
                            style: GoogleFonts.poppins(
                              textStyle: boldTextStyle(size: 14, color: black)
                            ),
                          ),
                        ],
                      ),
                      subtitle: Text(
                        '20 November 2023',
                        style: GoogleFonts.poppins(
                          textStyle: primaryTextStyle(color:Colors.black54, size: 14)
                        ),
                      ),
                    ),
                  ),
                  Container(
                    padding: EdgeInsets.only(left: 16, right: 16, bottom: 10),
                    margin: EdgeInsets.only(bottom: 16, left: 16, right: 16),
                    decoration: boxDecorationRoundedWithShadow(16, backgroundColor: context.cardColor),
                    child: ListTile(
                      tileColor: Colors.orange,
                      enabled: true,
                      contentPadding: EdgeInsets.zero,
                      leading: Container(
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
                      title: RichTextWidget(
                        overflow:TextOverflow.clip,
                        list: [
                          TextSpan(
                            text: 'Administrator menambahkan',
                            style: GoogleFonts.poppins(
                              textStyle: primaryTextStyle(color: Colors.black54, size: 14)
                            ),
                          ),
                          TextSpan(
                            text: '\t account admin ',
                            style: GoogleFonts.poppins(
                              textStyle: boldTextStyle(size: 14, color:black)
                            ),
                          ),
                        ],
                      ),
                      subtitle: Text(
                        '19 November 2023',
                        style: GoogleFonts.poppins(
                          textStyle: primaryTextStyle(color:Colors.black54, size: 14)
                        ),
                      ),
                    ),
                  )
                ],
              )
            ],
          ),
        )
      )
    );
  }
}
