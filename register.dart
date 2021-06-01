import 'dart:convert';
import 'dart:async';
import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'package:finalyearproject_goaltracc/homepage.dart';
import 'package:finalyearproject_goaltracc/main.dart';
import 'package:finalyearproject_goaltracc/HelperUtils.dart';
import 'package:fluttertoast/fluttertoast.dart';


class Register extends StatefulWidget {
  @override
  _RegisterState createState() => _RegisterState();
}

class _RegisterState extends State<Register> {
  bool _isObscure = true;
  TextEditingController user = TextEditingController();
  TextEditingController pass = TextEditingController();

  Future register() async {
    var url = "http://192.168.1.68/login_register/register.php";
    var response = await http.post(url, body: {
      "username": user.text,
      "password": pass.text,
    });
    var data = json.decode(response.body);
    if (data == "Error") {
      Fluttertoast.showToast(
        msg: "The user have been already registered.",
        toastLength: Toast.LENGTH_SHORT,
        gravity: ToastGravity.CENTER,
        timeInSecForIosWeb: 1,
        backgroundColor: Colors.red,
        textColor: Colors.white,
        fontSize: 16.0
    );
    } else {
      Fluttertoast.showToast(
        msg: "The user have been registered successfully.",
        toastLength: Toast.LENGTH_SHORT,
        gravity: ToastGravity.CENTER,
        timeInSecForIosWeb: 1,
        backgroundColor: Colors.red,
        textColor: Colors.white,
        fontSize: 16.0
    );
      Navigator.push(context, MaterialPageRoute(builder: (context)=>MyHomePage(),),);
    }
  }

  @override
  Widget build(BuildContext context) {

    double width=MediaQuery.of(context).size.width;
    double height=MediaQuery.of(context).size.height;
    return Scaffold(
      appBar: AppBar(
        elevation: 0,
        backgroundColor: Colors.pinkAccent[100],
        
      ),
      body: Container(
        color: Colors.pinkAccent[100],
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
                    Text('REGISTER NOW', style: TextStyle(fontSize: 28.0,fontWeight: FontWeight.bold, color: Colors.red),),
                  ],
                ),
              ),
              SizedBox(height: 30.0,),
              TextField(
                controller: user,
                decoration: InputDecoration(
                  hintText: 'Username',
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
              
              SizedBox(height: 30.0,),
              Padding(
                padding: const EdgeInsets.fromLTRB(20.0,20.0,0.0,0.0),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.start,
                  children: [
                    Container(
                      padding:EdgeInsets.all(65.0),
                    ),
                    RaisedButton(
                      child: Text('REGISTER'),
                      color: Colors.red,
                      onPressed: (){
                        register();
                      },
                    ),
                  ],
                ),
              ),
              SizedBox(height:20.0),



            ],
          ),
        ),
      ),
    );
  }
}
