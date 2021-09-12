import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:konsolto_task/bloc/todo_bloc.dart';
import 'package:konsolto_task/model/todo.dart';
import 'package:konsolto_task/repository/todo_repo.dart';
import 'package:konsolto_task/utils/constants.dart';
import 'package:konsolto_task/utils/color_loader.dart';
import 'package:konsolto_task/utils/custom_dialog.dart';
import 'package:konsolto_task/utils/no_tasks.dart';
import 'package:konsolto_task/utils/task_card.dart';
import 'package:konsolto_task/utils/text_with_border.dart';
import 'package:intl/intl.dart';


class TodoScreen extends StatefulWidget {

  const TodoScreen({Key? key}) : super(key: key);

  @override
  _TodoScreenState createState() => _TodoScreenState();
}

class _TodoScreenState extends State<TodoScreen> {

  static final DateTime now = DateTime.now();
  static final DateFormat dateformatter = DateFormat('yyyy-MM-dd');
  static final DateFormat dayformatter=DateFormat('EEEE');
  final String dateformatted = dateformatter.format(now);
  final String dayformatted = dayformatter.format(now);

  @override
  Widget build(BuildContext context) {
    return MultiBlocProvider(
      providers: [
        BlocProvider <TodoBloc>(
          create: (context) => TodoBloc(TodoFunctions()),
        ),
      ],
      child: Scaffold(
        body: Container(
          width: MediaQuery.of(context).size.width,
          height: MediaQuery.of(context).size.height,
          child: Stack(
            children: [
              Container(
                width: MediaQuery.of(context).size.width,
                height: MediaQuery.of(context).size.height/4,
                decoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(10),
                  color: Constants.primaryColor
                ),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children:  [
                    TextWithBorder(text: dateformatted ,borderColor: Constants.sideColor),
                    TextWithBorder(text: dayformatted ,borderColor: Constants.sideColor)
                  ],
                ) ,
              ),
              Positioned(
                top:115,
                left:30.0,
                right: 30.0,
                child: Container(
                  decoration: BoxDecoration(
                      borderRadius: BorderRadius.circular(25),
                      color: Constants.secColor
                  ),
                  height: MediaQuery.of(context).size.height,
                  width: MediaQuery.of(context).size.width,
                  child: BlocProvider<TodoBloc>(
                    create:  (BuildContext context) => TodoBloc(TodoFunctions()),
                    child: const TasksComponent(),
                  ),
                ),
              )
            ],
          ),
        ),
        floatingActionButton: Padding(
          padding: const EdgeInsets.all(8.0),
          child: FloatingActionButton(
            backgroundColor: Constants.primaryColor,
            foregroundColor: Constants.secColor,
            onPressed: ()async{
              showDialog(context: context,
                  builder: (BuildContext context){
                    return BlocProvider<TodoBloc>(
                      create:  (BuildContext context) => TodoBloc(TodoFunctions()),
                      child: const CustomDialog(),
                    );
                  }
              );
            },
            child: const Icon(Icons.add),
          ),
        ),
        floatingActionButtonLocation: FloatingActionButtonLocation.centerDocked ,
      ),
    );
  }
}


class TasksComponent extends StatefulWidget {
  const TasksComponent({Key? key}) : super(key: key);

  @override
  _TasksComponentState createState() => _TasksComponentState();
}

class _TasksComponentState extends State<TasksComponent> {

  getTasksFromDb(){
    final todoBloc = BlocProvider.of<TodoBloc>(context);
    todoBloc.add(GetTodos());
  }

  @override
  void initState() {
    // TODO: implement initState
    getTasksFromDb();
    super.initState();
  }
  @override
  Widget build(BuildContext context) {
    return BlocListener<TodoBloc,TodoState>(
      listener:(context,state){
      },
      child: BlocBuilder<TodoBloc, TodoState>(
          bloc: BlocProvider.of<TodoBloc>(context),
          builder: (BuildContext context, TodoState state) {
            if (state is TodoInitial) {
              return const ColorLoader();
            }
            else if (state is TodosState) {
              return state.todos.isEmpty ? const NoTasks() : viewTasks(state.todos);
            }else{
              return Container();
            }
          }
      ),
    );
  }

  Widget viewTasks(List<Todo> todos){
    return ListView.builder(
          physics: const ScrollPhysics(),
          shrinkWrap: true,
          itemCount: todos.length,
          itemBuilder: (BuildContext context,int index){
            final item = todos[index].id;
            return Dismissible(
              key: Key(item),
              onDismissed: (direction){
                final todoBloc = BlocProvider.of<TodoBloc>(context);
                todoBloc.add(DeleteTodo(item));
                Navigator.of(context).pushAndRemoveUntil(MaterialPageRoute(builder: (context) =>
                const TodoScreen()), (Route<dynamic> route) => false);
              },
              child: Padding(
                padding: const EdgeInsets.all(8.0),
                child: TaskCard(title:todos[index].title,description:todos[index].description),
              ),
            );
        });
  }
}
