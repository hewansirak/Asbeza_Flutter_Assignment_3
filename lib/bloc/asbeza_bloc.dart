import 'dart:developer';
import 'dart:math';

import 'package:asbeza/bloc/asbeza_state.dart';
import 'package:asbeza/model/item.dart';
import 'package:bloc/bloc.dart';

import '../service/apiservice.dart';
import '../service/service.dart';
import 'asbeza_event.dart';

class AsbezaBloc extends Bloc<AsbezaEvent, AsbezaState> {
  final _apiServiceProvider = ApiServiceProvider();
  final _service = Service();

  List history = [];
  List historyLoad = [];


  AsbezaBloc() : super(AsbezaInitialState()) {
    on<AsbezaFetchEvent>((event, emit) async {
      emit(AsbezaLoadingState());
      try {
        final activity = await _apiServiceProvider.fetchActivity();
        await _service.readItem().then((val) => {
              history = val,
            });
        historyLoad = Item.historyList(history);

        emit(AsbezaSuccessState(item: activity!, history: historyLoad));
      } catch (e) {
        print(e);
        emit(AsbezaFailedState());
      }
    });
    on<HistoryEvent>((event, emit) => {
    
  //  {history.add(event.data)});
  
    if (!historyLoad.contains(event.data))
            {
              historyLoad.add(event.data),
              event.data.itemAdded = 1,
              _service.saveItem(event.data),
            }
        });

      on<QunatityIncEvent>((event, emit) => {
          historyLoad[event.data].quantity++,
          _service.updateItem(
            historyLoad[event.data],
          )
        });
      on<QunatityDecEvent>((event, emit) => {
          if (historyLoad[event.data].quantity <= 1)
            {
              historyLoad[event.data].itemAdded = 0,
              _service.deleteItem(historyLoad[event.data].id),
              historyLoad.removeAt(event.data),
            }
          else
            {
              historyLoad[event.data].quantity--,
              _service.updateItem(
                historyLoad[event.data],
              )
            },
        });
      on<ItemRemoveEvent>((event, emit) => {
          historyLoad[event.data].itemAdded = 0,
          historyLoad[event.data].quantity = 1,
          _service.deleteItem(historyLoad[event.data].id),
          historyLoad.removeAt(event.data),
        });
  }
}
