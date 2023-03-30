import 'package:equatable/equatable.dart';

abstract class AsbezaState extends Equatable {
    const AsbezaState();

      @override
      List<Object> get props => [];
}


class AsbezaInitialState extends AsbezaState {}

class AsbezaLoadingState extends AsbezaState {}

class AsbezaSuccessState extends AsbezaState {
  final List item;
  final List history;
  const AsbezaSuccessState({
    required this.item,
    required this.history,
  });
}

class AsbezaFailedState extends AsbezaState {}




// class AsbezaInitialState extends AsbezaState {
// }
// class AsbezaLoadingState extends AsbezaState {
//   @override
//   List<Object> get props => [];
// }
// class AsbezaSuccessState extends AsbezaState {
//   final List item;
//   final List history;
//   AsbezaSuccessState({required this.item, required this.history});
// //  AsbezaSuccessState(
// //    this.item, {required List history},
// //  );
//   @override
//   List<Object> get props => [];
// }
// class AsbezaFailState extends AsbezaState {
//   String message;
//   AsbezaFailState(this.message);
//   @override
//   List<Object> get props => [];
// }
