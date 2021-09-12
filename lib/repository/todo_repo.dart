
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:konsolto_task/model/todo.dart';

abstract class TodoRepository {
  final firestoreInstance = FirebaseFirestore.instance;
  Future<void> addTask(Todo todo);
  Future<void> removeTask(String id);
  Future<List<Todo>> getAllTasks();
}

class TodoFunctions implements TodoRepository{

  @override
  Future<List<Todo>> getAllTasks() async{
    List<Todo> todoList = [];
      var todosFromFirebase = await firestoreInstance.collection("Todos").get();
      for (var doc in todosFromFirebase.docs) {
        todoList.add(Todo.fromFirestore(doc));
      }
      return todoList;
  }

  @override
  Future<void> addTask(Todo todo) async{
    await firestoreInstance.collection('Todos').add({
      'title':todo.title,
      'description':todo.description
    });
  }

  @override
  FirebaseFirestore get firestoreInstance =>  FirebaseFirestore.instance;

  @override
  Future<void> removeTask(String id) async{
    await firestoreInstance.collection('Todos').doc(id).delete();
  }
  
}