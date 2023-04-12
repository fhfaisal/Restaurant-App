import 'dart:convert';

import 'package:admin_app/screens/nab_bar/home_page.dart';
import 'package:admin_app/widget/custom_widget.dart';
import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;

class LogIn extends StatefulWidget {
  const LogIn({Key? key}) : super(key: key);

  @override
  State<LogIn> createState() => _LogInState();
}
TextEditingController emailControler=TextEditingController();
TextEditingController passwordControler=TextEditingController();

class _LogInState extends State<LogIn> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Container(
        margin: EdgeInsets.symmetric(horizontal: 20),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Center(child: Text("Log In",style: myStyle(25,Colors.blue,FontWeight.bold),)),
            TextFormField(
              controller: emailControler ,
              decoration: InputDecoration(
                hintText: "Enter Your Email"
              ),
            ),
            TextFormField(
              controller: passwordControler ,
              decoration: InputDecoration(
                hintText: "Enter Your Password"
              ),
            ),
            SizedBox(height: 20,),
            ElevatedButton(onPressed: (){
              getLogin();
            }, child: Text("Log In"))
          ],
        ),
      ),
    );
  }



  getLogin() async{
    try{
      String url="${baseUrl}sign-in";
      var map=Map<String,dynamic>();
      map["email"]=emailControler.text.toString();
      map["password"]=passwordControler.text.toString();
      var response=await http.post(Uri.parse(url));
      var data=jsonDecode(response.body);
      Navigator.of(context).push(MaterialPageRoute(builder: (_)=>HomePage()));
    }catch(e){
      print("somethings is wrong ");
    }
  }
}
