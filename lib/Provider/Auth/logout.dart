import 'package:nb_utils/nb_utils.dart';

Future<void>Logout()async{
  SharedPreferences prefs = await SharedPreferences.getInstance();
  await prefs.remove('loginStatus');
  await prefs.remove('token');
  await prefs.remove('id');
  await prefs.remove('name');
  await prefs.remove('email');
}