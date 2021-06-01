import 'dart:convert';
import 'package:dynamic_theme/dynamic_theme.dart';
import 'package:flutter/material.dart';
import 'package:finalyearproject_goaltracc/register.dart';
import 'package:finalyearproject_goaltracc/homepage.dart';
import 'package:finalyearproject_goaltracc/ThemeUtils.dart';
import 'package:finalyearproject_goaltracc/HelperUtils.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:http/http.dart' as http;



void main() {
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  
  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      title: 'Goal Tracc Application',
      theme: ThemeData(
        primarySwatch: Colors.blue,
        visualDensity: VisualDensity.adaptivePlatformDensity,
      ),
      home: Login(),
    );
  }
}

class Login extends StatefulWidget {
  final List list1;
  final int index1;
  Login({this.list1,this.index1});
  @override
  _LoginState createState() => _LoginState();
}

class _LoginState extends State<Login> {
  
  
  bool _isObscure = true;
  TextEditingController user = TextEditingController();
  TextEditingController pass = TextEditingController();

  Future login() async {
    var url = "http://192.168.1.68/login_register/login.php";
    var response = await http.post(url, body: {
      "username": user.text,
      "password": pass.text,
    });
    var data = json.decode(response.body);
    if (data == "Success") {
     Fluttertoast.showToast(
        msg: "The user have been loggen in successfully.",
        toastLength: Toast.LENGTH_SHORT,
        gravity: ToastGravity.CENTER,
        timeInSecForIosWeb: 1,
        backgroundColor: Colors.red,
        textColor: Colors.white,
        fontSize: 16.0
    );
      Navigator.push(context, MaterialPageRoute(builder: (context)=>MyHomePage(),),);
    } else {
    Fluttertoast.showToast(
        msg: "The username or password you typed is incorrect. Please enter the username or password again",
        toastLength: Toast.LENGTH_SHORT,
        gravity: ToastGravity.CENTER,
        timeInSecForIosWeb: 1,
        backgroundColor: Colors.red,
        textColor: Colors.white,
        fontSize: 16.0
    );
      
    }
  }


Widget build(BuildContext context) {
    
  
    double width=MediaQuery.of(context).size.width;
    double height=MediaQuery.of(context).size.height;
    return Scaffold(
      appBar: AppBar(
        elevation: 0,
        backgroundColor: Colors.black,
        

      ),
      body: Container(
        color: Colors.black,
        height: height,
        width: width,
        child: SingleChildScrollView(
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Container(
                padding: EdgeInsets.all(30.0),
              ),

              Padding(
                padding: const EdgeInsets.all(3.0),
                child: Row(

                  mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                  children: [
                    Text('Login', style: TextStyle(fontSize: 28.0,fontWeight: FontWeight.bold, color: Colors.red),),
                  ],
                ),
              ),
              SizedBox(height: 30.0,),
              TextField(
                controller: user,
                decoration: InputDecoration(
                  hintText: 'Username',
                  suffixIcon: Icon(Icons.email),
                  border: OutlineInputBorder(
                    borderRadius: BorderRadius.circular(10.0),
                  ),
                ),
              ),
              SizedBox(height: 20.0,),
              TextField(
                controller: pass,
                obscureText: _isObscure,
                decoration: InputDecoration(
                    hintText: 'Password',
                    border: OutlineInputBorder(
                        borderRadius: BorderRadius.circular(10.0),
                      ),
                    suffixIcon: IconButton(
                        icon: Icon(
                            _isObscure ? Icons.visibility : Icons.visibility_off),
                        onPressed: () {
                          setState(() {
                            _isObscure = !_isObscure;
                          });
                        })),
              ),
              SizedBox(height: 30.0,),
              Padding(
                padding: const EdgeInsets.all(10.0),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.start,
                  children: [
                    Container(
                      padding:EdgeInsets.all(70.0),
                    ),
                    RaisedButton(
                      child: Text('LOGIN'),
                      color: Colors.red,
                      onPressed: (){
                          login();

                      },
                    ),
                  ],
                ),
              ),
              SizedBox(height:5.0),
              GestureDetector(
                onTap: (){
                  Navigator.push(context, MaterialPageRoute(builder: (context)=>Register()));
                },
                child: Text.rich(
                  TextSpan(
                      text: 'Don\'t have an account',
                      children: [
                        TextSpan(
                          text: 'SIGNUP',
                          style: TextStyle(
                              color: Color(0xffEE7B23)
                          ),
                        ),
                      ]
                  ),
                ),
              ),


            ],
          ),
        ),
      ),
    );
  }
 void toggleBrightness() {
    DynamicTheme.of(context).setBrightness(
      getInvertTheme(context),
    );
  } 
}
