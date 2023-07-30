import 'dart:io';
import 'package:flutter/services.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'providers/theme.dart';
import 'providers/filtering_options.dart';
import 'providers/bottom_navbar.dart';
import 'providers/products.dart';
import 'providers/stage.dart';
import 'providers/auth.dart';
import 'providers/address_book.dart';
import 'providers/payment_method.dart';
import 'providers/wish_list.dart';
import '/providers/bag.dart';
import 'ios_main.dart';
import 'android_main.dart';

void main() {
  WidgetsFlutterBinding.ensureInitialized();
  SystemChrome.setPreferredOrientations(
    [DeviceOrientation.portraitUp, DeviceOrientation.portraitDown],
  );

  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MultiProvider(
      providers: [
        ChangeNotifierProvider(
          create: (context) => ThemeManager(),
        ),
        ChangeNotifierProvider(
          create: (context) => StageManger(),
        ),
        ChangeNotifierProvider(
          create: (context) => FilteringManger(),
        ),
        ChangeNotifierProvider(
          create: (context) => Auth(),
        ),
        ChangeNotifierProvider(
          create: (context) => AddressBook(),
        ),
        ChangeNotifierProvider(
          create: (context) => PaymentMethod(),
        ),
        ChangeNotifierProvider(
          create: (context) => WishList(),
        ),
        ChangeNotifierProvider(
          create: (context) => Bag(),
        ),
        ChangeNotifierProxyProvider<FilteringManger, Products>(
          create: (context) => Products('boys', '', 'newProduct', {}),
          update: (context, value, previous) => Products(
            value.gender,
            value.directory,
            value.sort,
            value.filterOutput,
          ),
        ),
        ChangeNotifierProvider(
          create: (context) => BottomNavBarManger(),
        )
      ],
      child: Platform.isIOS ? const IOSMain() : const AndroidMain(),
    );
  }
}




// MaterialApp(
//       title: 'Kids Zone',
//       theme: ThemeData(
//         // This is the theme of your application.
//         //
//         // Try running your application with "flutter run". You'll see the
//         // application has a blue toolbar. Then, without quitting the app, try
//         // changing the primarySwatch below to Colors.green and then invoke
//         // "hot reload" (press "r" in the console where you ran "flutter run",
//         // or simply save your changes to "hot reload" in a Flutter IDE).
//         // Notice that the counter didn't reset back to zero; the application
//         // is not restarted.
//         primarySwatch: Colors.blue,
//       ),
//       home: const MyHomePage(title: 'Flutter Demo Home Page'),
//     );