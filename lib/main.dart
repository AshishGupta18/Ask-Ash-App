
import 'package:ask_ash/constant/constant.dart';
import 'package:ask_ash/providers/chats_provider.dart';
import 'package:ask_ash/providers/models_providers.dart';
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
   
    return MultiProvider
    (providers: [
      ChangeNotifierProvider(create: (_) => ModelsProvider(),

      ),
        ChangeNotifierProvider(create: (_) => ChatProvider(),

      ),
   
    ],
      child: MaterialApp(
        title: 'ASK ASH',
        debugShowCheckedModeBanner: false,
        theme: ThemeData(
            scaffoldBackgroundColor:scaffoldBackgroundColor ,
         appBarTheme: AppBarTheme(color: cardColor,)
        
        ),
        home: const ChatScreen(),
      ),
    );
      }
  }


