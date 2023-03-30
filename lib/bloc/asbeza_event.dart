import 'package:asbeza/model/item.dart';
import 'package:equatable/equatable.dart';

//class AsbezaEvent extends Equatable {
//  @override
//  List<Object?> get props => throw UnimplementedError();
//}

//class GetDataButtonPressed extends AsbezaEvent {
  
abstract class AsbezaEvent extends Equatable {
  const AsbezaEvent();

  @override
  List<Object> get props => [];
}

class AsbezaFetchEvent extends AsbezaEvent {
  const AsbezaFetchEvent();
  
  
  @override
  List<Object> get props => [];
}

class HistoryEvent extends AsbezaEvent {
  final Item item;
  const HistoryEvent({required this.item});

  @override
  List<Object> get props => [];

  get data => item;
}


class QunatityIncEvent extends AsbezaEvent {
  final int index;
  QunatityIncEvent(
    this.index,
  );

  @override
  List<Object> get props => [];

  get data => index;
}

class QunatityDecEvent extends AsbezaEvent {
  final int index;
  QunatityDecEvent(
    this.index,
  );

  @override
  List<Object> get props => [];

  get data => index;
}

class ItemRemoveEvent extends AsbezaEvent {
  final int index;
  ItemRemoveEvent(
    this.index,
  );

  @override
  List<Object> get props => [];

  get data => index;
}