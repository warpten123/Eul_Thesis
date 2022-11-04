part of 'research_bloc.dart';

class ResearchState extends Equatable {
  final List<ResearchDetails> pendingTasks;
  final List<ResearchDetails> removedTasks;
  final List<ResearchDetails> completedTasks;
  final List<ResearchDetails> favoriteTasks;
  const ResearchState({
    this.pendingTasks = const <ResearchDetails>[],
    this.removedTasks = const <ResearchDetails>[],
    this.completedTasks = const <ResearchDetails>[],
    this.favoriteTasks = const <ResearchDetails>[],
  });
  @override
  List<Object> get props =>
      [pendingTasks, removedTasks, completedTasks, favoriteTasks];

  Map<String, dynamic> toMap() {
    return <String, dynamic>{
      'pendingTasks': pendingTasks.map((x) => x.toMap()).toList(),
      'favoriteTasks': favoriteTasks.map((x) => x.toMap()).toList(),
      'completedTasks': completedTasks.map((x) => x.toMap()).toList(),
      'removedTasks': removedTasks.map((x) => x.toMap()).toList(),
    };
  }

  factory TaskState.fromMap(Map<String, dynamic> map) {
    return TaskState(
      pendingTasks:
          List<Task>.from((map['pendingTasks']?.map((x) => Task.fromMap(x)))),
      removedTasks:
          List<Task>.from((map['removedTasks']?.map((x) => Task.fromMap(x)))),
      completedTasks:
          List<Task>.from((map['completedTasks']?.map((x) => Task.fromMap(x)))),
      favoriteTasks:
          List<Task>.from((map['favoriteTasks']?.map((x) => Task.fromMap(x)))),
    );
  }
}
