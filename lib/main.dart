import 'package:flutter/material.dart';
//import 'package:hive/hive.dart';
import 'package:pj1/models/catogories/catogories_model.dart';
import 'package:pj1/screens/add_transaction/screen_add_transation.dart';
import 'package:pj1/screens/home/screen_home.dart';
import 'package:hive_flutter/hive_flutter.dart';

import 'models/trandactions/transactions_ model.dart';

Future<void> main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Hive.initFlutter();

  if (!Hive.isAdapterRegistered(categorytypeAdapter().typeId)) {
    Hive.registerAdapter(categorytypeAdapter());
  }
  if (!Hive.isAdapterRegistered(categorymodelAdapter().typeId)) {
    Hive.registerAdapter(categorymodelAdapter());
  }
  if (!Hive.isAdapterRegistered(transactionmodelAdapter().typeId)) {
    Hive.registerAdapter(transactionmodelAdapter());
  }
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Flutter Demo',
      theme: ThemeData(),
      home: screenhome(),
      routes: {
        screenaddtransation.routename: (ctx) => screenaddtransation(),
      },
    );
  }
}
