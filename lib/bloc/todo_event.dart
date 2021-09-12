part of 'todo_bloc.dart';

abstract class TodoEvent extends Equatable {
  const TodoEvent();
}

class GetTodos extends TodoEvent{
  @override
  // TODO: implement props
  List<Object?> get props => throw UnimplementedError();
}

class PostTodo extends TodoEvent{
  final Todo todo;
  const PostTodo(this.todo);
  @override
  // TODO: implement props
  List<Object?> get props => throw UnimplementedError();
}

class DeleteTodo extends TodoEvent{
  final String id;
  const DeleteTodo(this.id);
  @override
  // TODO: implement props
  List<Object?> get props => throw UnimplementedError();
}
