import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';

class DosenPage extends StatefulWidget {
  @override
  _DosenPageState createState() => new _DosenPageState();
}

class _DosenPageState extends State<DosenPage> {
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
        title: Text("Dosen"),
      ),
        body: SafeArea(
      child: new Container(
          color: Colors.white,
          child: Center(
            child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: <Widget>[
                  Text('Dosen'),
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