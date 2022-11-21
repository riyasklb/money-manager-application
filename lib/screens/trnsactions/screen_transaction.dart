import 'package:flutter/material.dart';
import 'package:flutter/src/widgets/container.dart';
import 'package:flutter/src/widgets/framework.dart';
import 'package:flutter_slidable/flutter_slidable.dart';
import 'package:intl/intl.dart';
import 'package:pj1/db/category/category_db.dart';
import 'package:pj1/db/transactions/transaction_db.dart';
import 'package:pj1/models/catogories/catogories_model.dart';

import '../../models/trandactions/transactions_ model.dart';

class screentransaction extends StatelessWidget {
  const screentransaction({super.key});

  @override
  Widget build(BuildContext context) {
    transactiondb.instance.refresh();
    categorydb.instance.refreshui();
    return ValueListenableBuilder(
        valueListenable: transactiondb.instance.transactionlistnofier,
        builder: (BuildContext ctx, List<transactionmodel> newList, Widget? _) {
          return ListView.separated(
              padding: EdgeInsets.all(8),
              // ignore: non_constant_identifier_names
              itemBuilder: (ctx, index) {
                final _value = newList[index];
                return Slidable(
                  key: Key(_value.id!),
                  startActionPane: ActionPane(
                    motion: ScrollMotion(),
                    children: [
                      SlidableAction(
                        onPressed: (ctx) {
                          transactiondb.instance.deletetransaction(_value.id!);
                        },
                        icon: Icons.delete,
                        foregroundColor: Color.fromARGB(255, 226, 55, 55),
                      )
                    ],
                  ),
                  child: Card(
                    child: ListTile(
                      title: Text('Rs ${_value.amount}'),
                      leading: CircleAvatar(
                        radius: 39,
                        child: Text(
                          parsedate(_value.date),
                          textAlign: TextAlign.center,
                        ),
                        backgroundColor: _value.type == categorytype.income
                            ? Colors.blue
                            : Colors.green,
                      ),
                      subtitle: Text(_value.category.name),
                    ),
                  ),
                );
              },
              separatorBuilder: (ctx, index) {
                return const SizedBox(
                  height: 5,
                );
              },
              itemCount: newList.length);
        });
  }

  String parsedate(DateTime date) {
    final _date = DateFormat.MMMd().format(date);
    final _splitedate = _date.split(' ');
    return '${_splitedate.last}\n${_splitedate.first}';
  }
}
