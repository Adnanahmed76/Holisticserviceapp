import 'package:flutter/material.dart';
import 'package:mynewearth/provider.dart';
import 'package:mynewearth/screens/offering_list_screen.dart';
import 'package:provider/provider.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MultiProvider(
      providers: [
        ChangeNotifierProvider(create: (_) => OfferingProvider()),
      ],
      child: MaterialApp(
        title: 'My New Earth',
        theme: ThemeData(
          primarySwatch: Colors.blue,
          useMaterial3: true,
        ),
        debugShowCheckedModeBanner: false,
        home: const OfferingListScreen(),
      ),
    );
  }
}

