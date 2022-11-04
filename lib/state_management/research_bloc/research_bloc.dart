// import 'package:equatable/equatable.dart';
// import 'package:flutter/cupertino.dart';
// import 'package:hydrated_bloc/hydrated_bloc.dart';

// part 'research_event.dart';
// part 'research_state.dart';

// class ResearchBloc extends HydratedBloc<ResearchEvent, ResearchState> {
//   ResearchBloc() : super(const ResearchState()) {
//     on<AddResearch>(_onAddResearch);
//     on<UpdateResearch>(_onUpdateTask);
//     on<DeleteResearch>(_onDeleteTask);
//     // on<>(_onRemoveToBin);
//     // on<R>(_MarkFavorite);
//     // on<EdgeInsetsGeometry>(_onEditTask);
//     on<RestoreResearch>(_onRestoreTask);
//     on<AddAuthor>(_addAuthor);
//   }
//   void _onAddResearch(AddResearch event, Emitter<ResearchState> emit) {
//     final state = this.state;
//     emit(ResearchState(
//       pendingTasks: List.from(state.pendingTasks)..add(event.task),
//       removedTasks: state.removedTasks,
//       completedTasks: state.completedTasks,
//       favoriteTasks: state.favoriteTasks,
//     ));
//   }

//   void _onUpdateTask(UpdateTask event, Emitter<TaskState> emit) {
//     final state = this.state;
//     final task = event.task;

//     List<Task> pendingTasks = state.pendingTasks;
//     List<Task> completedTasks = state.completedTasks;
//     task.isDone == false
//         ? {
//             pendingTasks = List.from(pendingTasks)..remove(task),
//             completedTasks = List.from(completedTasks)
//               ..insert(0, task.copyWith(isDone: true))
//           }
//         : {
//             completedTasks = List.from(completedTasks)..remove(task),
//             pendingTasks = List.from(pendingTasks)
//               ..insert(0, task.copyWith(isDone: false))
//           };
//     emit(TaskState(
//         pendingTasks: pendingTasks,
//         removedTasks: state.removedTasks,
//         completedTasks: completedTasks,
//         favoriteTasks: state.favoriteTasks));
//   }

//   void _onDeleteTask(DeleteTask event, Emitter<TaskState> emit) {
//     final state = this.state;
//     emit(TaskState(
//         pendingTasks: state.pendingTasks,
//         removedTasks: List.from(state.removedTasks)..remove(event.task)));
//   }

//   void _onRemoveToBin(RemoveTask event, Emitter<TaskState> emit) {
//     final state = this.state;
//     emit(TaskState(
//         pendingTasks: List.from(state.pendingTasks)..remove(event.task),
//         completedTasks: List.from(state.completedTasks)..remove(event.task),
//         favoriteTasks: List.from(state.favoriteTasks)..remove(event.task),
//         removedTasks: List.from(state.removedTasks)
//           ..add(event.task.copyWith(isDeleted: true))));
//   }

//   void _MarkFavorite(TaskFavorite event, Emitter<TaskState> emit) {
//     final state = this.state;
//     List<Task> pendingTasks = state.pendingTasks;
//     List<Task> completedTasks = state.completedTasks;
//     List<Task> favoriteTasks = state.favoriteTasks;
//     if (event.task.isDone == false) {
//       // if task is not yet complete
//       if (event.task.isFavorite == false) {
//         //and task is not yet favorite
//         var taskIndex = pendingTasks.indexOf(event.task);
//         pendingTasks = List.from(pendingTasks)
//           ..remove(event.task)
//           ..insert(taskIndex, event.task.copyWith(isFavorite: true));
//         favoriteTasks.insert(0, event.task.copyWith(isFavorite: true));
//       } else {
//         //if task is already favorite,
//         var taskIndex = pendingTasks.indexOf(event.task);
//         pendingTasks = List.from(pendingTasks)
//           ..remove(event.task)
//           ..insert(taskIndex, event.task.copyWith(isFavorite: false));
//         favoriteTasks.remove(event.task);
//       }
//     } else {
//       if (event.task.isFavorite == false) {
//         //and task is not yet favorite
//         var taskIndex = completedTasks.indexOf(event.task);
//         completedTasks = List.from(completedTasks)
//           ..remove(event.task)
//           ..insert(taskIndex, event.task.copyWith(isFavorite: true));
//         favoriteTasks.insert(0, event.task.copyWith(isFavorite: true));
//       } else {
//         //if task is already favorite,
//         var taskIndex = completedTasks.indexOf(event.task);
//         completedTasks = List.from(completedTasks)
//           ..remove(event.task)
//           ..insert(taskIndex, event.task.copyWith(isFavorite: false));
//         favoriteTasks.remove(event.task);
//       }
//     }
//     emit(TaskState(
//         pendingTasks: pendingTasks,
//         removedTasks: state.removedTasks,
//         completedTasks: completedTasks,
//         favoriteTasks: favoriteTasks));
//   }

//   void _onEditTask(EditTask event, Emitter<TaskState> emit) {
//     final state = this.state;
//     List<Task> favoriteTasks = state.favoriteTasks;
//     if (event.oldTask.isFavorite == true) {
//       favoriteTasks
//         ..remove(event.oldTask)
//         ..insert(0, event.newTask);
//     }
//     emit(TaskState(
//         pendingTasks: List.from(state.pendingTasks)
//           ..remove(event.oldTask)
//           ..insert(0, event.newTask),
//         completedTasks: state.completedTasks..remove(event.oldTask),
//         favoriteTasks: favoriteTasks,
//         removedTasks: state.removedTasks));
//   }

//   void _onRestoreTask(RestoreTask event, Emitter<TaskState> emit) {
//     final state = this.state;
//     emit(TaskState(
//         removedTasks: List.from(state.removedTasks)..remove(event.task),
//         pendingTasks: List.from(state.pendingTasks)
//           ..insert(
//               0,
//               event.task.copyWith(
//                   isDeleted: false, isDone: false, isFavorite: false))));
//   }

//   @override
//   TaskState? fromJson(Map<String, dynamic> json) {
//     return TaskState.fromMap(json);
//   }

//   @override
//   Map<String, dynamic>? toJson(TaskState state) {
//     return state.toMap();
//   }
// }
