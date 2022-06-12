import 'package:flutter/material.dart';
import 'view/login_page.dart';
import 'view/mahasiswa_page.dart';
import 'view/dosen_page.dart';
import 'view/orang_tua_page.dart';

void main() => runApp(MyApp());


class MyApp extends StatelessWidget {


  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      title: 'Login',
      home: LoginPage(),
      routes: <String, WidgetBuilder>{
        '/login': (BuildContext conntext) => new LoginPage(),
        '/mahasiswa': (BuildContext conntext) => new MahasiswaPage(),
        '/dosen': (BuildContext conntext) => new DosenPage(),
        '/orangTua': (BuildContext conntext) => new OrangTuaPage(),
      },
    );
  }
}
