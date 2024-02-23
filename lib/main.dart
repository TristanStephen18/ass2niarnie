import 'package:assignment_2/providers/cart_provider.dart';
import 'package:assignment_2/providers/products_provider.dart';
import 'package:assignment_2/screens/view.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

void main(){
  runApp(Statemanagementapp());
}

class Statemanagementapp extends StatelessWidget {
  const Statemanagementapp({super.key});

  @override
  Widget build(BuildContext context) {
    return MultiProvider(
      providers: [
        ChangeNotifierProvider(create: (_)=>Product()),
        ChangeNotifierProvider(create: (_)=>Cart())
      ],
      child: MaterialApp(
        debugShowCheckedModeBanner: false,
        theme: ThemeData(
          useMaterial3: true
        ),
        home: Viewscreen(),
      ),
    );
  }
}