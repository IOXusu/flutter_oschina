import 'package:http/http.dart' as http;

class NetUti {
  static Future<String> get(String url, Map<String, dynamic> params) async {
    if (url != null && params != null && params.isNotEmpty) {
      StringBuffer sb = StringBuffer('?');
      params.forEach((key, value) {
        sb.write('$key=$value&');
      });
      String paramStr = sb.toString().substring(0, sb.length - 1);
      url += paramStr;
    }
    http.Response response = await http.get(url);
    return response.body;
  }

  static Future<String> post(String url, Map<String, dynamic> params) async {
    http.Response response = await http.post(url, body: params);
    return response.body;
  }
}