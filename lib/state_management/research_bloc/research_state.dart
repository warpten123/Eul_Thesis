// part of 'research_bloc.dart';

// class ResearchState extends Equatable {
//   final List<ResearchDetails> pendingResearch;
//   final List<ResearchDetails> removedResearch;
//   final List<ResearchDetails> completedResearch;
//   final List<ResearchDetails> favoriteResearch;
//   const ResearchState({
//     this.pendingResearch = const <ResearchDetails>[],
//     this.removedResearch = const <ResearchDetails>[],
//     this.completedResearch = const <ResearchDetails>[],
//     this.favoriteResearch = const <ResearchDetails>[],
//   });
//   @override
//   List<Object> get props =>
//       [pendingResearch, removedResearch, completedResearch, favoriteResearch];

//   Map<String, dynamic> toMap() {
//     return <String, dynamic>{
//       'pendingResearch': pendingResearch.map((x) => x.toMap()).toList(),
//       'removedResearch': removedResearch.map((x) => x.toMap()).toList(),
//       'completedResearch': completedResearch.map((x) => x.toMap()).toList(),
//       'favoriteResearch': favoriteResearch.map((x) => x.toMap()).toList(),
//     };
//   }

//   factory ResearchState.fromMap(Map<String, dynamic> map) {
//     return ResearchState(
//       pendingTasks:
//           List<Task>.from((map['pendingTasks']?.map((x) => ResearchDetails.fromMap(x)))),
//       removedTasks:
//           List<Task>.from((map['removedTasks']?.map((x) => Task.fromMap(x)))),
//       completedTasks:
//           List<Task>.from((map['completedTasks']?.map((x) => Task.fromMap(x)))),
//       favoriteTasks:
//           List<Task>.from((map['favoriteTasks']?.map((x) => Task.fromMap(x)))),
//     );
//   }
// }
