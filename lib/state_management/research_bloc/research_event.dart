// ignore_for_file: public_member_api_docs, sort_constructors_first
part of 'task_bloc.dart';

import 'package:thesis_eul/models/research_details.dart';

abstract class ResearchEvent extends Equatable {
  const ResearchEvent();

  @override
  List<Object> get props => [];
}

class AddResearch extends ResearchEvent {
  final ResearchDetails research;
  const AddResearch({
    required this.research,
  });

  @override
  List<Object> get props => [research];
}

class UpdateResearch extends ResearchEvent {
  final ResearchDetails research;
  const UpdateResearch({
    required this.research,
  });

  @override
  List<Object> get props => [research];
}

class DeleteResearch extends ResearchEvent {
  final ResearchDetails research;
  const DeleteResearch({
    required this.research,
  });

  @override
  List<Object> get props => [research];
}

// class RemoveTask extends ResearchEvent {
//   final Task task;
//   const RemoveTask({
//     required this.task,
//   });

//   @override
//   List<Object> get props => [task];
// }

class TaskFavorite extends ResearchEvent {
  final Task task;
  const TaskFavorite({
    required this.task,
  });

  @override
  List<Object> get props => [task];
}

class ResearchDetails extends ResearchEvent {
  final ResearchDetails oldRes;
  final ResearchDetails newRes;
  ResearchDetails({
    required this.oldRes,
    required this.newRes,
  });

  @override
  List<Object> get props => [oldRes, newRes];
}

class RestoreResearch extends ResearchEvent {
  final ResearchDetails research;
  RestoreResearch({
    required this.research,
  });

  @override
  List<Object> get props => [research];
}
 class AddAuthor extends ResearchEvent{
    final ResearchDetails research;
    AddAuthor({required this.research});

    @override
    List<Object> get props => [research];
 }
