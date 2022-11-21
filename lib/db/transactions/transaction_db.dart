import 'dart:ffi';

import 'package:flutter/cupertino.dart';
import 'package:hive_flutter/adapters.dart';

//import '../../models/catogories/catogories_model.dart';
import '../../models/trandactions/transactions_ model.dart';

const transactiondbname = 'transaction-db';

abstract class transactiondbfuntions {
  Future<void> addtransaction(transactionmodel obj);
  Future<List<transactionmodel>> getalltransactions();
  Future<void> deletetransaction(String id);
}

class transactiondb implements transactiondbfuntions {
  transactiondb._internal();
  static transactiondb instance = transactiondb._internal();
  factory transactiondb() {
    return instance;
  }
  ValueNotifier<List<transactionmodel>> transactionlistnofier =
      ValueNotifier([]);

  @override
  Future<void> addtransaction(transactionmodel obj) async {
    final _db = await Hive.openBox<transactionmodel>(transactiondbname);
    await _db.put(obj.id, obj);
  }

  Future<void> refresh() async {
    final _list = await getalltransactions();
    _list.sort((first, second) => first.date.compareTo(second.date));
    transactionlistnofier.value.clear();
    transactionlistnofier.value.addAll(_list);
    transactionlistnofier.notifyListeners();
  }

  @override
  Future<List<transactionmodel>> getalltransactions() async {
    final _db = await Hive.openBox<transactionmodel>(transactiondbname);
    return _db.values.toList();
  }

  @override
  Future<void> deletetransaction(String id) async {
    final _db = await Hive.openBox<transactionmodel>(transactiondbname);
    await _db.delete(id);
    refresh();
  }
}
