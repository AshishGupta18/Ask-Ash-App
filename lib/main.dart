import 'package:ask_ash/changemod/theme_model.dart';
import 'package:ask_ash/constant/constant.dart';
import 'package:ask_ash/screens/chat_screen.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return ChangeNotifierProvider(
      create: (_) => ThemeModel(),
      child: Consumer(
        builder: (context,ThemeModel themeNotifier , child )
      {
    return MaterialApp(
      title: 'CHATGPT',
      debugShowCheckedModeBanner: false,
      theme: themeNotifier.isDark ? ThemeData.dark() : ThemeData.light(),
      //   scaffoldBackgroundColor:scaffoldBackgroundColor ,
      //  appBarTheme: AppBarTheme(color: cardColor,)
      
      home: const ChatScreen(),
    );
      },
      )
      );
  }
}

