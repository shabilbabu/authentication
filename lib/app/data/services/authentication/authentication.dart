import 'dart:convert';
import 'dart:developer';

import '../api/api.dart';
import 'package:http/http.dart' as http;

class ApiServices extends Api{


  login({
    required String email, required String password,
  }) async {
    try{
      var response = await http.post(Uri.parse(uri + signIn),
      headers: <String, String>{
          'Content-Type': 'application/json; charset=UTF-8'
        },
        body: jsonEncode({"email" : email, "password" : password})
      );
      return response;
    } catch (e) {
      log(e.toString());
      return 'e';
    }
  }
  
  signUp({
    required String username,
    required String email,
    required String password
  }) async {
    try{
      var response = await http.post(Uri.parse(uri + signup),
      headers:  <String, String>{
        'Content-Type' : 'application/json; charset=UTF-8'
      },
      body: jsonEncode({"name" : username, "email" : email, "password" : password},),
      );
      return response;
    } catch (e) {
      return 'e';
    }
  }
}