import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:selector/src/pages/HomeScreen.dart';

import 'package:selector/src/services/country_service.dart';
 
void main(){
  runApp( 
    MultiProvider(
      providers: [
        ChangeNotifierProvider(create: (_) => new CountryService())
      ],
      child: MyApp(),
    )
  );
}
 
class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Material App',
      debugShowCheckedModeBanner: false,
      home: HomeScreen(),
      theme: ThemeData.dark(),
    );
  }
}