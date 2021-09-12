part of 'todo_bloc.dart';

abstract class TodoState extends Equatable {
  const TodoState();
}

class TodoInitial extends TodoState {
  @override
  List<Object> get props => [];
}

class TodosState extends TodoState{

  final List<Todo> todos;
  const TodosState(this.todos);

  @override
  // TODO: implement props
  List<Object?> get props => throw UnimplementedError();
}

class TodoError extends TodoState {
  final String message;

  const TodoError(this.message);

  @override
  // TODO: implement props
  List<Object> get props => [message];
}


