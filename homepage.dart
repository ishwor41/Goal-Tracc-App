import 'dart:convert';
import 'package:dynamic_theme/dynamic_theme.dart';
import 'package:flutter/material.dart';
import 'package:finalyearproject_goaltracc/register.dart';
import 'package:finalyearproject_goaltracc/ThemeUtils.dart';
import 'package:finalyearproject_goaltracc/AddEditPage.dart';
import 'package:finalyearproject_goaltracc/SendFeedBack.dart';
import 'package:finalyearproject_goaltracc/main.dart';
import 'package:http/http.dart' as http;

class MyHomePage extends StatefulWidget {
  @override
  _MyHomePageState createState() => _MyHomePageState();
}

class _MyHomePageState extends State<MyHomePage> {


  Future getData()async{
    var url = 'http://192.168.1.68/php-mysql-flutter-crud/read.php';
    var response = await http.get(url);
    return json.decode(response.body);
  }


  @override
  void initState() {
    super.initState();

  }

  @override
  Widget build(BuildContext context) {
    // bool isDarkTheme = isThemeCurrentlyDark(context);
    // Icon actionIcon = isDarkTheme ? Icon(Icons.wb_sunny) : Icon(Icons.person_add);
    // String toolTip = isDarkTheme ? 'BURN YOUR EYES' : 'SAVE YOUR EYES';
    return Scaffold(
      appBar: AppBar(
        title: Text('Goal Tracc Application'),
        backgroundColor: Colors.redAccent,
        // actions: <Widget>[
        //   IconButton(
        //     icon: actionIcon,
        //     tooltip: toolTip,
        //     onPressed: toggleBrightness,
        //   ),
        // ],
      ),
      floatingActionButton: FloatingActionButton(
        child: Icon(Icons.add),
        backgroundColor: Colors.redAccent,
        onPressed: (){
          Navigator.push(context, MaterialPageRoute(builder: (context) => AddEditPage(),),);
          debugPrint('Clicked FloatingActionButton Button');
        },
      ),
      body: FutureBuilder(
        future: getData(),
        builder: (context,snapshot){
          if(snapshot.hasError) print(snapshot.error);
          return snapshot.hasData
              ? ListView.builder(
              itemCount: snapshot.data.length,
              itemBuilder: (context,index){
                List list = snapshot.data;
                return ListTile(
                  leading: GestureDetector(child: Icon(Icons.edit),
                    onTap: (){
                      Navigator.push(context, MaterialPageRoute(builder: (context) => AddEditPage(list: list,index: index,),),);
                    debugPrint('Edit Clicked');
                  },),
                  title: Text(list[index]['goalname']),
                  subtitle: Text(list[index]['tasks']),
                  
                  trailing: GestureDetector(child: Icon(Icons.delete),
                    onTap: (){
                      setState(() {
                        var url = 'http://192.168.1.68/php-mysql-flutter-crud/delete.php';
                        http.post(url,body: {
                          'id' : list[index]['id'],
                        });
                      });
                      debugPrint('delete Clicked');
                    },),
                );
              }
          )
              : CircularProgressIndicator();
        },
      ),
      drawer: Drawer(
        child: ListView(
          padding: EdgeInsets.zero,
          children: <Widget>[
            DrawerHeader(
              child: Row(
                    children: <Widget>[
                      Icon(Icons.person_rounded,
                           size:30,
                      ),
                      Container(
                        padding: EdgeInsets.all(5),
                      ),
                      

                      Text("nfjksdsnk",
                        style: TextStyle(
                            fontSize: 16.0,
                            ),
                          ),
                    ]
                   ),

              decoration: BoxDecoration(
                color: Colors.redAccent,
              ),
            ),
            ListTile(
              title:  Row(
                    children: <Widget>[
                      Icon(Icons.home,
                           size:30,
                      ),
                      Container(
                        padding: EdgeInsets.all(5),
                      ),

                      Text("Home",
                        style: TextStyle(
                            fontSize: 16.0,
                            ),
                          ),
                    ]
                   ),
              onTap: () {
                // Navigator.push(context, MaterialPageRoute(builder: (context)=>Home()));
              },
            ),
            ListTile(
              title:  Row(
                    children: <Widget>[
                      Icon(Icons.add_circle_outline,
                           size:30,
                      ),
                      Container(
                        padding: EdgeInsets.all(5),
                      ),

                      Text("Add Goals",
                        style: TextStyle(
                            fontSize: 16.0,
                            ),
                          ),
                    ]
                   ),
              onTap: () {
                Navigator.push(context, MaterialPageRoute(builder: (context)=>AddEditPage()));
              },
            ),
            ListTile(
              title:  Row(
                    children: <Widget>[
                      Icon(Icons.feedback_rounded,
                           size:30,
                      ),
                      Container(
                        padding: EdgeInsets.all(5),
                      ),

                      Text("Send Feedback",
                        style: TextStyle(
                            fontSize: 16.0,
                            ),
                          ),
                    ]
                   ),
              onTap: () {
                Navigator.push(context, MaterialPageRoute(builder: (context)=>SendFeedBack()));
              },
            ),
            ListTile(
              title:  Row(
                    children: <Widget>[
                      Icon(Icons.logout,
                           size:30,
                      ),
                      Container(
                        padding: EdgeInsets.all(5),
                      ),

                      Text("Log Out",
                        style: TextStyle(
                            fontSize: 16.0,
                            ),
                          ),
                    ]
                   ),
              onTap: () {
                Navigator.push(context, MaterialPageRoute(builder: (context)=>Login()));
              },
            ),
          ],
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
