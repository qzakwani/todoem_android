part of 'task_list_bloc.dart';

abstract class TaskListState extends Equatable {
  const TaskListState();
  
  @override
  List<Object> get props => [];
}

class TaskListInitial extends TaskListState {}
