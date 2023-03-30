import 'package:asbeza/model/item.dart';

import 'db_helper.dart';



class Service {
  Repository? _repository;

  Service() {
    _repository = Repository();
  }

  saveItem(Item item) async {
    return await _repository!.insertData('asbeza', item.toJson());
  }

  readItem() async {
    return await _repository!.readData('asbeza');
  }

  updateItem(Item item) async {
    return await _repository!.updateData('asbeza', item.toJson());
  }

  deleteItem(dispatchId) async {
    return await _repository!.deleteData('asbeza', dispatchId);
  }

  wipeDate() async {
    await _repository!.deleteAllData('asbeza');
  }
}