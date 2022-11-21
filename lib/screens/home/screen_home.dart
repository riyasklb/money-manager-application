import 'package:flutter/material.dart';
import 'package:flutter/src/widgets/container.dart';
import 'package:flutter/src/widgets/framework.dart';
import 'package:pj1/db/category/category_addpopup.dart';
import 'package:pj1/db/category/category_db.dart';
import 'package:pj1/models/catogories/catogories_model.dart';
import 'package:pj1/screens/add_transaction/screen_add_transation.dart';
import 'package:pj1/screens/home/widgets/bottum_navigation.dart';
import 'package:pj1/screens/trnsactions/screen_transaction.dart';

import '../category/screencatogory.dart';

class screenhome extends StatelessWidget {
  screenhome({super.key});
  static ValueNotifier<int> selectedindexnotifier = ValueNotifier(0);
  final _pages = [screentransaction(), screencatogories()];
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.grey[100],
      appBar: AppBar(
        title: Text('MONEY MANAGER'),
        centerTitle: true,
      ),
      bottomNavigationBar: const moneybottumnavigation(),
      body: SafeArea(
        child: ValueListenableBuilder(
          valueListenable: selectedindexnotifier,
          builder: (BuildContext context, int updatedindex, _) {
            return _pages[updatedindex];
          },
        ),
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: () {
          if (selectedindexnotifier.value == 0) {
            print('add transactions');
            Navigator.of(context).pushNamed(screenaddtransation.routename);
          } else {
            print('add catogories');
            showcategoryaddpopup(context);
            // final _sample = categorymodel(
            //   id: DateTime.now().millisecondsSinceEpoch.toString(),
            //   name: 'travel',
            //   type: categorytype.expence,
            // );
            // categorydb().insertcategory(_sample);
          }
        },
        child: Icon(Icons.add),
      ),
    );
  }
}
