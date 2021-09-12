import 'dart:async';

import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';
import 'package:konsolto_task/model/todo.dart';
import 'package:konsolto_task/repository/todo_repo.dart';

part 'todo_event.dart';
part 'todo_state.dart';

class TodoBloc extends Bloc<TodoEvent, TodoState> {
  final TodoRepository todoRepository;

  TodoBloc(this.todoRepository) : super(TodoInitial());

  @override
  Stream<TodoState> mapEventToState(
    TodoEvent event,
  ) async* {
    // TODO: implement mapEventToState
    yield TodoInitial();
    if(event is GetTodos)
      {
        try {
          final List<Todo> allTodos = await todoRepository.getAllTasks();
          yield TodosState(allTodos);
        } catch (e) {
          yield TodoError(e.toString());
        }
      }
    else if(event is PostTodo)
      {
        try {
          await todoRepository.addTask(event.todo);
        } catch (e) {
          yield TodoError(e.toString());
        }
      }
    else if(event is DeleteTodo)
      {
        try {
          await todoRepository.removeTask(event.id);
        } catch (e) {
          yield TodoError(e.toString());
        }
      }
  }
}
