String url = "https://sistem-pakar.dynastina.com/api";
String url2 = "https://sistem-pakar.dynastina.com/";

class UrlApi {
  static String photo = url2;
  static String login = "${url}/login";
  static String register = "${url}/regist";
  static String getGejala = "${url}/form";
  static String getUser = "${url}/profile";
  static String editProfile = "${url}/profile/update";

  static String postDiagnosa = "$url/form-process";
  static String listDiagnosa = "$url/form-diagnosis";
  static String resultDiagnosa = "$url/form-result/";

  static String getGejalaPenyakit = "$url/master-symptoms";
  static String postGejalaPenyakit = "$url/master-symptoms/store";
  static String getGejalaPenyakitById = "$url/master-symptoms/";
  static String deleteGejalaPenyakit = "$url/master-symptoms/destroy/";
  static String editGejalaPenyakit = "$url/master-symptoms/update/";

  static String getDepresi = "$url/master-depressions";
  static String postDepresi = "$url/master-depressions/store";
  static String getDepresiById = "$url/master-depressions/";
  static String deleteDepresi = "$url/master-depressions/destroy/";
  static String editDepresi = "$url/master-depressions/update/";
}