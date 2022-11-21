import 'package:flutter/cupertino.dart';
import 'package:hive_flutter/adapters.dart';
import 'package:pj1/models/catogories/catogories_model.dart';
import 'package:pj1/screens/category/expence_catogory_list.dart';
import 'package:pj1/screens/category/income_catogory_list.dart';

const category_db_name = 'catogery-database';

abstract class categorydbfuntions {
  Future<List<categorymodel>> getcategories();
  Future<void> insertcategory(categorymodel value);
  Future<void> deletecategory(String categoryid);
}

class categorydb implements categorydbfuntions {
  categorydb._internal();
  static categorydb instance = categorydb._internal();
  factory categorydb() {
    return instance;
  }
  ValueNotifier<List<categorymodel>> incomecatogorylist = ValueNotifier([]);
  ValueNotifier<List<categorymodel>> expencecatogorylist = ValueNotifier([]);
  @override
  @override
  Future<void> insertcategory(categorymodel value) async {
    final _categorydb = await Hive.openBox<categorymodel>(category_db_name);
    await _categorydb.put(value.id, value);
    refreshui();
  }

  @override
  Future<List<categorymodel>> getcategories() async {
    final _categorydb = await Hive.openBox<categorymodel>(category_db_name);
    return _categorydb.values.toList();
  }

  Future<void> refreshui() async {
    final _allcategories = await getcategories();
    incomecatogorylist.value.clear();
    expencecatogorylist.value.clear();
    await Future.forEach(
      _allcategories,
      (categorymodel category) {
        if (category.type == categorytype.income) {
          incomecatogorylist.value.add(category);
        } else {
          expencecatogorylist.value.add(category);
        }
      },
    );
    incomecatogorylist.notifyListeners();
    expencecatogorylist.notifyListeners();
  }

  @override
  Future<void> deletecategory(String categoryid) async {
    final _categorydb = await Hive.openBox<categorymodel>(category_db_name);
    await _categorydb.delete(categoryid);
    refreshui();
  }
}
