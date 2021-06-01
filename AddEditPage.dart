import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'package:finalyearproject_goaltracc/main.dart';
import 'package:finalyearproject_goaltracc/pickers.dart';
import 'package:finalyearproject_goaltracc/HelperUtils.dart';
import 'package:finalyearproject_goaltracc/homepage.dart';

class AddEditPage extends StatefulWidget {
  final List list;
  final int index;
  AddEditPage({this.list,this.index});
  @override
  _AddEditPageState createState() => _AddEditPageState();
}

class _AddEditPageState extends State<AddEditPage> {

  TextEditingController goal = TextEditingController();
  TextEditingController description = TextEditingController();
  TextEditingController tasks = TextEditingController();
  String deadLine1;
  

  bool editMode = false;
  var _categories = ['Days', 'Weeks', 'Months', 'Years'];
	final double  _minimumPadding = 5.0;

	var _currentItemSelected = '';




  addUpdateData(){
    if(editMode){
      var url = 'http://192.168.1.68/php-mysql-flutter-crud/edit.php';
      http.post(url,body: {
        'id' : widget.list[widget.index]['id'],
        'goalname' : goal.text,
        'descriptiondetails' : description.text,
        'date' : deadLine1,
        'tasks' : tasks.text,
      });
    }else{
      var url = 'http://192.168.1.68/php-mysql-flutter-crud/add.php';
      http.post(url,body: {
        'goalname' : goal.text,
        'descriptiondetails' : description.text,
        'date' : deadLine1,
        'tasks' : tasks.text,
      });
    }

  }


  @override
  void initState() {
    _currentItemSelected = _categories[0];
    super.initState();
    if(widget.index != null){
      editMode = true;
      goal.text = widget.list[widget.index]['goalname'];
      description.text = widget.list[widget.index]['descriptiondetails'];
      deadLine1 = widget.list[widget.index]['date'];
      tasks.text = widget.list[widget.index]['tasks'];
    }

  }


  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: Text(editMode ? 'Update Your Goals' :'Add A New Goal'),
      backgroundColor: Colors.redAccent,
      ),
      body: ListView(
        children: <Widget>[

          Padding(
            padding: const EdgeInsets.all(8.0),
            child: TextField(
              controller: goal,
              decoration: InputDecoration(
                  hintText: 'Goal Name',
                  border: OutlineInputBorder(
                    borderRadius: BorderRadius.circular(10.0),
                  ),
                ),
            ),
          ),
          Padding(
            padding: const EdgeInsets.all(8.0),
            child: TextField(
              minLines: 5,
              maxLines: 5,
              keyboardType: TextInputType.multiline,
              controller: description,
              decoration: InputDecoration(
                    hintText: 'Goal Description',
                    border: OutlineInputBorder(
                      borderRadius: BorderRadius.all(Radius.circular(10.0)),
                    ),
                  ),
            ),
          ),
          Padding(
            padding: const EdgeInsets.all(8.0),
            child: TextField(
              controller: tasks,
              minLines: 5,
              maxLines: 5,
              decoration: InputDecoration(
                    hintText: 'Add Multiple Tasks for achieving the goal.',
                    border: OutlineInputBorder(
                      borderRadius: BorderRadius.all(Radius.circular(10.0)),
                    ),
                  ),
            ),
          ),
          
          Padding(
            padding: const EdgeInsets.all(8.0),
            
            child:Theme(
                  data: Theme.of(context).copyWith(
                      primaryColor: Colors.purple,
                      accentColor: Colors.yellow),
                  child: Builder(
                    builder: (context) => OutlineButton(
                      child: Text(editMode ? 'Update Deadline' :'Add Deadline',
                      //   goal.deadLine == null
                      //       ? 'ADD DEADLINE'
                      //       : 'EDIT DEADLINE',
                        style: TextStyle(
                          color: Colors.blue,
                          fontWeight: FontWeight.w500,
                        ),
                      ),
                      onPressed: () {
                        createNewDeadline(context);
                      },
                      shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(5.0),
                      ),
                      borderSide: BorderSide(color: Colors.red),
                      highlightedBorderColor: Colors.yellow,
                      splashColor: Colors.yellow,
                    ),
                  ),
                ),
          ),
          
          
          
          Padding(padding: EdgeInsets.all(8),
            child: RaisedButton(
              color: Colors.redAccent,
              onPressed: (){
                setState(() {
                  addUpdateData();
                });
                Navigator.push(context, MaterialPageRoute(builder: (context) => MyHomePage(),),);
                debugPrint('Clicked RaisedButton Button');
              },
              child: Text(editMode ? 'Update Goal' :'Add Goal',style: TextStyle(color: Colors.white),),
            ),
          ),
        ],
      ),
    );
  }
  void createNewDeadline(context) async {
    DateTime dueDate = await pickDate(context);
    if (dueDate == null) return;

    TimeOfDay dueTime = await pickTime(context);
    if (dueTime == null) return;

    DateTime deadLine = DateTime(
        dueDate.year, dueDate.month, dueDate.day, dueTime.hour, dueTime.minute);
    
    
    showSnackBar(context, 'Deadline set for ${getFormattedDate(deadLine)}!');
    deadLine1= deadLine.toString();

    setState(() {
      
    });
  }
}
