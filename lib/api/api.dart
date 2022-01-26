import 'dart:convert';
import 'package:http/http.dart' as http;


class CallApi {
  var baseurl = 'https://api.comick.fun/chapter?order=hot';
  var token;

  getMangas(apiUrl) async {
    var fullUrl = Uri.parse(baseurl + apiUrl);
    return await http.get(
      fullUrl,
    );
  }

  

  _setHeaders() => {
        'Content-type': 'application/json',
        'Accept': 'application/json',
        'Authorization': 'Bearer $token'
      };

  // _getToken() async {
  //   SharedPreferences localStorage = await SharedPreferences.getInstance();
  //   var token = localStorage.getString('token');
  //   return '?token=$token';
  }

