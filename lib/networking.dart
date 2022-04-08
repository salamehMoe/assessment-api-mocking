import 'dart:convert';

import 'package:flutter/cupertino.dart';
import 'package:http/http.dart' as http;
import 'package:login_mockup/home-page.dart';
import 'package:login_mockup/variables.dart';
class Networking{
  var client = http.Client();

  static void registerNewUser(String userEmail, String userName, String userPassword,BuildContext context) async {
    print('CLICKED $userEmail theUserName $userName theUserPass $userPassword');
    var url = Uri.parse('http://restapi.adequateshop.com/api/authaccount/registration');
    final theBody = json.encode({
      'name':userName,
      'email':userEmail,
      'password':userPassword,
    });
    Map<String,String> headers = {'Content-Type':'application/json','Authorization':'Bearer eyJ0eXAiOiJKV1QiLCJhbGciOiJIUzI1NiJ9'
    '.eyJpYXQiOjE2NDkyNDM0OTgsImlzcyI6Imh0dHBzOlwvXC93d3cuc2Vs'
    'YS5hZSIsImV4cCI6MTY0OTMyOTg5OCwianRpIjoiODg1NjE5YTgtZTEzNy00'
    'MTIxLTgxYTQtNzRjMDcwYzUyMGI5IiwidXNlcklkIjo2OTEsInJldm9jYWJs'
    'ZSI6dHJ1ZSwicmVmcmVzaGFibGUiOnRydWV9.7BSiZOWILDed7RAXLFscyp57'
    'LQi083BBh4HYBpBykzw'};

    var response = await http.post(url,body: theBody, headers: headers);
    var decodedResponse = jsonDecode(utf8.decode(response.bodyBytes));
    Variables.apiStatus= decodedResponse['code'];
    print('STATUS IN REGISTRATION ${response.statusCode}');
    if(response.statusCode == 200 || response.statusCode == 201){
      if(decodedResponse['code'] == 0){
        Navigator.pushNamed(context, HomePage.id);
      }


    }
  }

  static void logInUser(String userEmail, String userPassword,BuildContext context) async {
    print('CLICKED $userEmail theUserPass $userPassword');
    var url = Uri.parse('http://restapi.adequateshop.com/api/authaccount/login');
    final theBody = json.encode({
      'email':userEmail,
      'password':userPassword,
    });
    Map<String,String> headers = {'Content-Type':'application/json','Authorization':'Bearer eyJ0eXAiOiJKV1QiLCJhbGciOiJIUzI1NiJ9'
        '.eyJpYXQiOjE2NDkyNDM0OTgsImlzcyI6Imh0dHBzOlwvXC93d3cuc2Vs'
        'YS5hZSIsImV4cCI6MTY0OTMyOTg5OCwianRpIjoiODg1NjE5YTgtZTEzNy00'
        'MTIxLTgxYTQtNzRjMDcwYzUyMGI5IiwidXNlcklkIjo2OTEsInJldm9jYWJs'
        'ZSI6dHJ1ZSwicmVmcmVzaGFibGUiOnRydWV9.7BSiZOWILDed7RAXLFscyp57'
        'LQi083BBh4HYBpBykzw'};

    var response = await http.post(url,body: theBody, headers: headers);
    var decodedResponse = jsonDecode(utf8.decode(response.bodyBytes));
    Variables.apiStatus= decodedResponse['code'];
    print('STATUS IN LOGIN ${response.statusCode} THE MESSAGE ${decodedResponse['code']}');
    if(response.statusCode == 200 || response.statusCode == 201 ){
      if(decodedResponse['code'] == 0){
        Navigator.pushNamed(context, HomePage.id);
      }


    }
  }
}



