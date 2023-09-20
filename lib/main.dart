import 'package:flutter/material.dart';
import 'package:hive/hive.dart';
import 'package:imc_flutter/pages/home.dart';
import 'package:path_provider/path_provider.dart' as path_provider;

void main() async{
  WidgetsFlutterBinding.ensureInitialized();
  var documentDirectory = await path_provider.getApplicationDocumentsDirectory();

  Hive.init(documentDirectory.path);

  runApp(
      MaterialApp(
        title: 'DIO',
        debugShowCheckedModeBanner: false,
        routes: {
          '/home_page': (BuildContext context) => const Home(),

        },
        initialRoute: '/home_page',
      ));
}


