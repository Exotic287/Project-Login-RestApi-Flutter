import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';

class OrangTuaPage extends StatefulWidget {
  @override
  _OrangTuaPageState createState() => new _OrangTuaPageState();
}

class _OrangTuaPageState extends State<OrangTuaPage> {
  @override
  void initState() {
    super.initState();
  }

  _logOut() async {
    final prefs = await SharedPreferences.getInstance();
    prefs.setBool('login', false);
    Navigator.of(context)
        .pushNamedAndRemoveUntil('/login', (Route<dynamic> route) => false);
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("Orang Tua"),
      ),
        body: SafeArea(
      child: new Container(
          color: Colors.white,
          child: Center(
            child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: <Widget>[
                  Text('Orang Tua'),
                  RaisedButton(
                    onPressed: () => _logOut(),
                    color: Colors.white,
                    child: const Text('Logout',
                        style: TextStyle(fontSize: 18)),
                  )
                ]
            ),
            
            
          )),
    ));
  }
}