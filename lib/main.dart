import 'package:flutter/material.dart';
import 'package:firebase_core/firebase_core.dart'; // Firebase Core 추가
import 'package:portfolio/homepage.dart';
import 'package:portfolio/profile_detail_page.dart';
import 'package:portfolio/project_detail.dart';
import 'package:portfolio/project_list_page.dart';
import 'package:portfolio/upload.dart';

import 'firebase_options.dart';

void main() async { // async 추가

  // Firebase SDK 초기화
  await Firebase.initializeApp(
    options: DefaultFirebaseOptions.currentPlatform,
  );

  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return  MaterialApp(
      title: 'My Portfolio',
      theme: ThemeData(
        scaffoldBackgroundColor: Colors.white,
        colorScheme: ColorScheme.fromSwatch(
          primarySwatch: Colors.grey,
          accentColor: Colors.black,
        ),
        primaryColor: Colors.black,
        visualDensity: VisualDensity.adaptivePlatformDensity,
      ),
      routes: {
        '/': (context) => HomePage(),
        '/projectList': (context) => ProjectListPage(),
        '/projectDetail': (context) => ProjectDetailPage(),
        '/profileDetail': (context) => ProfileDetailPage(),
        '/upload': (context) => UploadPage(),
      },
    );
  }
}