import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:konsolto_task/bloc/todo_bloc.dart';
import 'package:konsolto_task/model/todo.dart';
import 'package:konsolto_task/ui/todo_screen.dart';

import 'constants.dart';

class CustomDialog extends StatefulWidget {
  const CustomDialog({Key? key}) : super(key: key);

  @override
  _CustomDialogState createState() => _CustomDialogState();
}

class _CustomDialogState extends State<CustomDialog> {

  final titleController = TextEditingController();
  final descriptionController = TextEditingController();

  @override
  Widget build(BuildContext context) {
    return Dialog(
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(Constants.padding),
      ),
      elevation: 0,
      backgroundColor: Colors.transparent,
      child: Stack(
        children: <Widget>[
          Container(
            padding: const EdgeInsets.only(left: Constants.padding,top: Constants.avatarRadius
                + Constants.padding, right: Constants.padding,bottom: Constants.padding
            ),
            margin: const EdgeInsets.only(top: Constants.avatarRadius),
            decoration: BoxDecoration(
                shape: BoxShape.rectangle,
                color: Colors.white,
                borderRadius: BorderRadius.circular(Constants.padding),
                boxShadow: const [
                   BoxShadow(color: Colors.black,offset:  Offset(0,10),
                      blurRadius: 10
                  ),
                ]
            ),
            child: Column(
              mainAxisSize: MainAxisSize.min,
              children: [
                Flexible(
                  child: Padding(
                    padding: const EdgeInsets.all(10.0),
                    child: TextField(
                      controller: titleController,
                      decoration: const InputDecoration(
                          border: InputBorder.none,
                          labelText: 'Title',
                          hintText: 'title of the task...'
                      ),
                      keyboardType: TextInputType.text,
                    ),
                  ),
                ),
                Flexible(
                  child: Padding(
                    padding: const EdgeInsets.all(10.0),
                    child: TextField(
                      controller: descriptionController,
                      decoration: const InputDecoration(
                          border: InputBorder.none,
                          labelText: 'Description',
                          hintText: 'description of the task...'
                      ),
                      keyboardType: TextInputType.text,
                    ),
                  ),
                ),
                Row(
                  mainAxisAlignment: MainAxisAlignment.end,
                  children: [
                    Container(
                      margin: const EdgeInsets.all(10),
                      height: 50.0,
                      child: RaisedButton(
                        shape: RoundedRectangleBorder(
                            borderRadius: BorderRadius.circular(18.0),
                            side: const BorderSide(color:  Color.fromRGBO(0, 160, 227, 1))),
                        onPressed: () {
                          Todo todo= Todo(titleController.text,descriptionController.text);
                          if(titleController.text.isEmpty||descriptionController.text.isEmpty)
                            {
                              Fluttertoast.showToast(
                                  msg: "Please fill all fields",
                                  toastLength: Toast.LENGTH_SHORT,
                                  gravity: ToastGravity.CENTER,
                              );
                            }
                          else
                            {
                              final todoBloc = BlocProvider.of<TodoBloc>(context);
                              todoBloc.add(PostTodo(todo));
                              Navigator.of(context).pushAndRemoveUntil(MaterialPageRoute(builder: (context) =>
                              const TodoScreen()), (Route<dynamic> route) => false);
                            }
                        },
                        padding:const  EdgeInsets.all(10.0),
                        color: Constants.primaryColor,
                        textColor: Constants.secColor,
                        child: const Text("Add",
                            style: TextStyle(fontSize: 15)),
                      ),
                    ),
                    Container(
                      margin: const EdgeInsets.all(10),
                      height: 50.0,
                      child: RaisedButton(
                        shape: RoundedRectangleBorder(
                            borderRadius: BorderRadius.circular(18.0),
                            side: const BorderSide(color:  Color.fromRGBO(0, 160, 227, 1))),
                        onPressed: () {
                          Navigator.of(context).pop();
                        },
                        padding:const  EdgeInsets.all(10.0),
                        color: Colors.white,
                        textColor: const Color.fromRGBO(0, 160, 227, 1),
                        child: const Text("Cancel",
                            style:  TextStyle(fontSize: 15)),
                      ),
                    ),

                  ],
                )
              ],
            ),

          ),// bottom part
          Positioned(
            left: Constants.padding,
            right: Constants.padding,
            child: CircleAvatar(
              backgroundColor: Colors.transparent,
              radius: Constants.avatarRadius,
              child: ClipRRect(
                  borderRadius: const BorderRadius.all(Radius.circular(Constants.avatarRadius)),
                  child: Image.asset("assets/can-task.jpg")
              ),
            ),
          ),// top part
        ],
      ),
    );
  }
}
