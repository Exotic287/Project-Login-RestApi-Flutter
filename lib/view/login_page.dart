import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:http/http.dart' as http;
import 'dart:convert';
import 'package:dropdown_search/dropdown_search.dart';


class LoginPage extends StatefulWidget {
  // static String tag = 'login-page';
  LoginPage({Key key, this.title}) : super(key: key);

  final String title;
  @override
  _LoginPageState createState() => new _LoginPageState();
}

class _LoginPageState extends State<LoginPage> {
  final GlobalKey<FormState> _formKey = GlobalKey<FormState>();

  //variabel
  TextEditingController usernameController = TextEditingController();
  TextEditingController passwordController = TextEditingController();
  TextEditingController bagianController = TextEditingController();
  bool visible = false, _passwordVisible = true;
  var username1 = '';
  List<String> _bagian = [
    'mahasiswa',
    'dosen',
    'orang tua',
  ];


  @override
  void initState() {
    super.initState();
    _passwordVisible = false;
  }
  //Fungsi Validasi Login ke Data API
  Future<List> _login() async {
    final respon = await http.post(
        Uri.parse("https://rizalardianto.000webhostapp.com/loginn.php"), //untuk melihat usernya bisa buka https://rizalardianto.000webhostapp.com/read.php
        body: {
          "username": usernameController.text,
          "password": passwordController.text,
          "bagian": bagianController.text,
        });
    var dataUser = json.decode(respon.body);
    if (dataUser.length == 0) {
      setState(() {
        visible = true;
        pesan();
        visible = false;
      });
    } else {
      if (dataUser[0]['bagian'] == 'mahasiswa') {
        Navigator.of(context).pushNamedAndRemoveUntil(
            '/mahasiswa', (Route<dynamic> route) => false);
      } else if (dataUser[0]['bagian'] == 'dosen') {
        Navigator.of(context)
            .pushNamedAndRemoveUntil('/dosen', (Route<dynamic> route) => false);
      } else {
        Navigator.of(context).pushNamedAndRemoveUntil(
            '/orangTua', (Route<dynamic> route) => false);
      }
      setState(() {
        username1 = dataUser[0]['username'];
      });
    }
  }

  //method untuk menampilkan pesan ketika gagal Login
  void pesan() {
    showDialog(
        context: context,
        builder: (BuildContext context) {
          return AlertDialog(
            title: Text('Pesan'),
            content: Text('Gagal Login'),
            actions: <Widget>[
              RaisedButton(
                child: Icon(Icons.check),
                color: Colors.blue,
                textColor: Colors.white,
                onPressed: () => Navigator.of(context).pop(),
              ),
            ],
          );
        });
  }

  //Widget untuk logo Login
  final logo = Hero(
    tag: 'hero',
    child: Column(
      mainAxisAlignment: MainAxisAlignment.center,
      children: [
        Image.asset(
          'assets/Login.png',
          width: 400.0,
          height: 198.0,
          fit: BoxFit.cover,
        ),
      ],
    ),
  );


  //Widget untuk TextFormField Username
  Widget username() {
    return TextFormField(
      keyboardType: TextInputType.text,
      autofocus: false,
      controller: usernameController,
      decoration: InputDecoration(
        hintText: 'Username',
        hintStyle: const TextStyle(color: Colors.black),
        labelText: 'Masukan Username',
        labelStyle: const TextStyle(color: Colors.black),
        prefixIcon: const Icon(
          Icons.person,
          color: Colors.black,
        ),
        fillColor: Colors.cyan,
        focusedBorder: OutlineInputBorder(
            borderRadius: BorderRadius.circular(32.0),
            borderSide: const BorderSide(color: Colors.cyan)),
        enabledBorder: OutlineInputBorder(
            borderRadius: BorderRadius.circular(32.0),
            borderSide: const BorderSide(color: Colors.cyanAccent, width: 2.0)),
        // contentPadding: EdgeInsets.fromLTRB(left, top, right, bottom),
        contentPadding: EdgeInsets.fromLTRB(30.0, 10.0, 30.0, 10.0),
        border: OutlineInputBorder(borderRadius: BorderRadius.circular(32.0)),
      ),
    );
  }

  //Widget Untuk TextFormField Password
  Widget password() {
    return TextFormField(
      keyboardType: TextInputType.text,
      autofocus: false,
      obscureText: !_passwordVisible,
      controller: passwordController,
      decoration: InputDecoration(
        hintText: 'Password',
        hintStyle: const TextStyle(color: Colors.black),
        labelText: 'Masukan Password',
        labelStyle: const TextStyle(color: Colors.black),
        suffixIcon: IconButton(
          icon: Icon(
            _passwordVisible ? Icons.visibility : Icons.visibility_off,
            color: Theme.of(context).primaryColorDark,
          ),
          onPressed: () {
            setState(() {
              _passwordVisible = !_passwordVisible;
            });
          },
        ),
        prefixIcon: const Icon(
          Icons.lock_outline,
          color: Colors.black,
        ),
        fillColor: Colors.cyan,
        focusedBorder: OutlineInputBorder(
            borderRadius: BorderRadius.circular(32.0),
            borderSide: const BorderSide(color: Colors.cyan)),
        enabledBorder: OutlineInputBorder(
            borderRadius: BorderRadius.circular(32.0),
            borderSide: const BorderSide(color: Colors.cyanAccent, width: 2.0)),
        contentPadding: EdgeInsets.fromLTRB(20.0, 10.0, 20.0, 10.0),
        border: OutlineInputBorder(borderRadius: BorderRadius.circular(32.0)),
      ),
    );
  }

  // Widget untuk dropdownButton untuk FormField Bagian
  Widget bagian() {
    return FormField<String>(
      builder: (FormFieldState<String> state) {
        return Padding(
            padding: const EdgeInsets.all(4),
            child: DropdownSearch<String>(
              showClearButton: true,
              mode: Mode.MENU,
              showSelectedItems: true,
              items: _bagian,
              dropdownSearchDecoration: InputDecoration(
                hintText: 'Bagian',
                hintStyle: const TextStyle(color: Colors.black),
                labelText: 'Pilih Bagian',
                labelStyle: const TextStyle(color: Colors.black),
                prefixIcon: const Icon(
                  Icons.people,
                  color: Colors.black,
                ),
                fillColor: Colors.cyan,
                focusedBorder: OutlineInputBorder(
                    borderRadius: BorderRadius.circular(32.0),
                    borderSide: const BorderSide(color: Colors.cyan)),
                enabledBorder: OutlineInputBorder(
                    borderRadius: BorderRadius.circular(32.0),
                    borderSide:
                        const BorderSide(color: Colors.cyanAccent, width: 2.0)),
                contentPadding:
                    EdgeInsets.symmetric(horizontal: 20, vertical: 10),
                border: OutlineInputBorder(
                    borderRadius: BorderRadius.circular(32.0)),
              ),
              onChanged: (value) {
                print(value);
                bagianController.text = value;
              },
            ));
      },
    );
  }


  //Widget untuk Loading
  Widget loading() {
    return Visibility(
        maintainSize: true,
        maintainAnimation: true,
        maintainState: true,
        visible: visible,
        child: Container(child: CircularProgressIndicator()));
  }


  //Widget untuk Tombol LoginButton
  Widget loginButton() {
    return Padding(
      padding: EdgeInsets.symmetric(vertical: 16.0),
      child: Material(
        borderRadius: BorderRadius.circular(20.0),
        shadowColor: Colors.lightBlueAccent.shade100,
        elevation: 5.0,
        child: MaterialButton(
          minWidth: 200.0,
          height: 42.0,
          onPressed: () => _login(),
          color: Colors.lightBlueAccent,
          shape: RoundedRectangleBorder(
              borderRadius: new BorderRadius.circular(22.0)),
          child: Text(
            'Log In',
            style: TextStyle(
              color: Colors.white,
            ),
          ),
        ),
      ),
    );
  }

  // Widget untuk FlatButton Lupa Password
  Widget lupaPass() {
    return FlatButton(
      child: Text(
        'Lupa Password?',
        style: TextStyle(color: Colors.black54),
      ),
      onPressed: () {},
    );
  }

  // Widget untuk menusun widget" yang sudah dibuat diatas
  Widget isi() {
    return Form(
      key: _formKey,
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.center,
        children: <Widget>[
          logo,
          // SizedBox(height: 1.0),
          username(),
          SizedBox(
            height: 6.0,
          ),
          password(),
          SizedBox(height: 6.0),
          bagian(),
          SizedBox(height: 6.0),
          loading(),
          SizedBox(height: 6.0),
          loginButton(),
          lupaPass(),
        ],
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      body: Center(
        child: ListView(
          shrinkWrap: true,
          padding: EdgeInsets.all(10),
          children: <Widget>[isi()],
        ),
      ),
    );
  }
}
