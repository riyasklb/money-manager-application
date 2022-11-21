import 'package:flutter/material.dart';
import 'package:flutter/src/widgets/container.dart';
import 'package:flutter/src/widgets/framework.dart';
import 'package:pj1/db/category/category_db.dart';
import 'package:pj1/screens/category/income_catogory_list.dart';
import 'package:pj1/screens/category/expence_catogory_list.dart';

class screencatogories extends StatefulWidget {
  const screencatogories({super.key});

  @override
  State<screencatogories> createState() => _screencatogoriesState();
}

class _screencatogoriesState extends State<screencatogories>
    with SingleTickerProviderStateMixin {
  late TabController _tabController;
  @override
  void initState() {
    _tabController = TabController(length: 2, vsync: this);
    categorydb().refreshui();

    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        TabBar(
            unselectedLabelColor: Colors.grey,
            labelColor: Colors.black,
            controller: _tabController,
            tabs: [
              Tab(
                text: 'INCOME',
              ),
              Tab(
                text: 'EXPENCE',
              )
            ]),
        Expanded(
          child: TabBarView(controller: _tabController, children: [
            incomecatogorylist(),
            expencecotogorylist(),
          ]),
        )
      ],
    );
  }
}
