import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:internet_connection_checker/internet_connection_checker.dart';
import 'package:news_app/Screens/Home.dart';
import 'package:news_app/blocs/observer.dart';
import 'package:news_app/Screens/news-detalies.dart';
import 'package:news_app/theme/AppTheme.dart';

bool isConnectdet = false;
void main() {
  WidgetsFlutterBinding.ensureInitialized();
  Bloc.observer = MyBlocObserver();
  final connectionChecker = InternetConnectionChecker();
  final subscription = connectionChecker.onStatusChange.listen(
    (InternetConnectionStatus status) {
      if (status == InternetConnectionStatus.connected) {
        print('Data connection is available.');
        isConnectdet = true;
      } else {
        print('You\'re disconnected from the internet.');
        isConnectdet = false;
      }
    },
  );
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
        theme: AppTheme.lightTheme,
        themeMode: ThemeMode.light,
        debugShowCheckedModeBanner: false,
        initialRoute: HomePage.routeName,
        routes: {
          HomePage.routeName: (context) => HomePage(),
          NewsDetails.routeName: (context) => NewsDetails(),
        });
  }
}
