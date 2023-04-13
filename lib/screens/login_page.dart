import 'dart:convert';

import 'package:admin_app/screens/nab_bar/home_page.dart';
import 'package:admin_app/widget/custom_widget.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:http/http.dart' as http;

class LogIn extends StatefulWidget {
  const LogIn({Key? key}) : super(key: key);

  @override
  State<LogIn> createState() => _LogInState();
}
final GlobalKey<FormState> _formKey = GlobalKey<FormState>();
TextEditingController emailControler = TextEditingController();
TextEditingController passwordControler = TextEditingController();

class _LogInState extends State<LogIn> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Container(
        margin: EdgeInsets.symmetric(horizontal: 20),
        child: Form(
          key:_formKey,
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Center(
                  child: Padding(
                    padding: const EdgeInsets.all(8.0),
                    child: Text(
                "Log In",
                style: myStyle(25, Colors.blue, FontWeight.bold),
              ),
                  )),
              TextFormField(
                controller: emailControler,
                style: GoogleFonts.roboto(),
                decoration: InputDecoration(
                  hintText: "example@gmail.com",
                  labelText: 'Enter your email',
                  hintStyle: GoogleFonts.roboto(),
                  prefixIcon: Icon(Icons.mail),
                  border: OutlineInputBorder(),
                  enabledBorder: OutlineInputBorder(),
                ),
                validator: (value) {
                  if (value!.isEmpty) {
                    return 'Please enter your email';
                  }
                  if (!RegExp(r"^[a-zA-Z0-9.]+@[a-zA-Z0-9]+\.[a-zA-Z]+").hasMatch(value)) {
                    return 'Please enter a valid email';
                  }
                  return null;
                },
              ),
              SizedBox(
                height: 20,
              ),
              TextFormField(
                controller: passwordControler,
                obscureText: true,
                style: GoogleFonts.roboto(),
                decoration: InputDecoration(
                  hintText: "************",
                  labelText: 'Enter your password',
                  prefixIcon: Icon(Icons.key_outlined),
                  border: OutlineInputBorder(),
                  enabledBorder: OutlineInputBorder(),
                ),
                validator: (value) {
                  if (value!.isEmpty) {
                    return 'Please enter your password';
                  }
                  if (value.length < 8) {
                    return 'Password must be at least 8 characters';
                  }
                  return null;
                },
              ),
              SizedBox(
                height: 20,
              ),
              ElevatedButton(
                  onPressed: () {
                    if (_formKey.currentState!.validate()) {
                      // The form is valid, do something here
                      getLogin();
                      passwordControler.clear();
                    }

                  },
                  child: Text("Log In",style: myStyle(16,Colors.white,FontWeight.bold),))
            ],
          ),
        ),
      ),
    );
  }

  getLogin() async {
    try {
      String url = "${baseUrl}sign-in";
      var map = Map<String, dynamic>();
      map["email"] = emailControler.text.toString();
      map["password"] = passwordControler.text.toString();
      var response = await http.post(Uri.parse(url));
      var data = jsonDecode(response.body);
      Navigator.of(context).push(MaterialPageRoute(builder: (_) => HomePage()));
    } catch (e) {
      print("somethings is wrong ");
    }
  }
}
