import 'package:flutter/material.dart';

class TaskCard extends StatelessWidget {
  final String? title;
  final String? description;

  const TaskCard({Key? key,this.title,this.description}) : super(key: key);


  @override
  Widget build(BuildContext context) {
    return Card(
      shape:RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(15.0),
      ),
      elevation: 3.0,
      child: ListTile(
        title: Text(title!),
        subtitle: Text(description!),
      )
    );
  }
}
