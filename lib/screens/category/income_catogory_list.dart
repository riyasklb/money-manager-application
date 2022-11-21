import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/src/widgets/container.dart';
import 'package:flutter/src/widgets/framework.dart';

import '../../db/category/category_db.dart';
import '../../models/catogories/catogories_model.dart';

class incomecatogorylist extends StatelessWidget {
  const incomecatogorylist({super.key});

  @override
  Widget build(BuildContext context) {
    return ValueListenableBuilder(
        valueListenable: categorydb().incomecatogorylist,
        builder: (BuildContext ctx, List<categorymodel> newlist, Widget? _) {
          return ListView.separated(
            itemBuilder: (ctx, index) {
              final category = newlist[index];
              return Card(
                child: ListTile(
                  title: Text(category.name),
                  trailing: IconButton(
                    onPressed: () {
                      categorydb.instance.deletecategory(category.id);
                    },
                    icon: Icon(Icons.delete),
                  ),
                ),
              );
            },
            separatorBuilder: (ctx, index) {
              return SizedBox(
                height: 10,
              );
            },
            itemCount: newlist.length,
          );
        });
  }
}
