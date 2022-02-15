import 'dart:math';

import 'package:ciftci_destek_mobil/models/app_user.dart';
import 'package:ciftci_destek_mobil/models/firestore_db_services.dart';
import 'package:flutter/material.dart';
import 'package:ciftci_destek_mobil/screen/widgets/bezier_container.dart';
import 'package:ciftci_destek_mobil/screen/main_page.dart';
import 'package:ciftci_destek_mobil/models/firebase_my_auth.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:firebase_auth/firebase_auth.dart';

class LoginPage extends StatefulWidget {
  const LoginPage({Key? key}) : super(key: key);

  @override
  _LoginPageState createState() => _LoginPageState();
}

class _LoginPageState extends State<LoginPage> {
  FirebaseMyAuth firebaseMyAuth = FirebaseMyAuth();
  FirestoreDbServices firestoreDbServices = FirestoreDbServices();

  String? email;
  String? parola;
  var _formKey = GlobalKey<FormState>();
  @override
  Widget build(BuildContext context) {
    final height = MediaQuery.of(context).size.height;
    return Scaffold(
        body: Container(
      height: height,
      child: Stack(
        children: <Widget>[
          //Ekrandaki yamuk şekil çiziliyor
          Positioned(
              top: -height * .15,
              right: -MediaQuery.of(context).size.width * .4,
              child: const BezierContainer()),
          Container(
            padding: const EdgeInsets.symmetric(horizontal: 20),
            child: SingleChildScrollView(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.center,
                mainAxisAlignment: MainAxisAlignment.center,
                children: <Widget>[
                  SizedBox(height: height * .2),
                  _title(),
                  const SizedBox(height: 50),
                  _emailPasswordWidget(),
                  const SizedBox(height: 20),
                  _submitButton(),
                  _forgorPassword(),
                  _divider(),
                  _googleButton(),
                  SizedBox(height: height * .055),
                  //_createAccountLabel(),
                ],
              ),
            ),
          ),
          Positioned(top: 40, left: 0, child: _backButton()),
        ],
      ),
    ));
  }

  Widget _EMailText() {
    return Container(
      margin: const EdgeInsets.symmetric(vertical: 10),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: <Widget>[
          const Text(
            "Email",
            style: TextStyle(fontWeight: FontWeight.bold, fontSize: 15),
          ),
          const SizedBox(
            height: 10,
          ),
          TextFormField(
            onChanged: (alinanMail) {
              setState(() {});
              email = alinanMail;
            },
            //Mail Kontrolü
            validator: (alinanMail) {
              return alinanMail!.contains("@") ? null : "Mail Geçerli Değil";
            },
            obscureText: false,
            decoration: const InputDecoration(
                prefixIcon: Icon(Icons.subdirectory_arrow_right_sharp),
                border: InputBorder.none,
                fillColor: Color(0xfff3f3f4),
                filled: true),
          )
        ],
      ),
    );
  }

  Widget _PasswordText() {
    return Container(
      margin: const EdgeInsets.symmetric(vertical: 10),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: <Widget>[
          const Text(
            "Password",
            style: TextStyle(fontWeight: FontWeight.bold, fontSize: 15),
          ),
          const SizedBox(
            height: 10,
          ),
          TextFormField(
            onChanged: (alinanParola) {
              setState(() {});
              parola = alinanParola;
            },
            validator: (alinanParola) {
              return alinanParola!.length >= 4
                  ? null
                  : "Parola en az 4 karakter olmalıdır";
            },
            obscureText: true,
            decoration: const InputDecoration(
                prefixIcon: Icon(Icons.subdirectory_arrow_right_sharp),
                border: InputBorder.none,
                fillColor: Color(0xfff3f3f4),
                filled: true),
          )
        ],
      ),
    );
  }

  Widget _emailPasswordWidget() {
    return Column(
      children: <Widget>[
        Form(
            key: _formKey,
            child: Column(
              children: [_EMailText(), _PasswordText()],
            ))
      ],
    );
  }

  Widget _submitButton() {
    return GestureDetector(
      child: Container(
        width: MediaQuery.of(context).size.width,
        padding: const EdgeInsets.symmetric(vertical: 15),
        alignment: Alignment.center,
        decoration: BoxDecoration(
            borderRadius: const BorderRadius.all(Radius.circular(5)),
            boxShadow: <BoxShadow>[
              BoxShadow(
                  color: Colors.grey.shade200,
                  offset: const Offset(2, 4),
                  blurRadius: 5,
                  spreadRadius: 2)
            ],
            gradient: const LinearGradient(
                begin: Alignment.centerLeft,
                end: Alignment.centerRight,
                colors: [Color(0xff38A3A5), Color(0xff38A3A5)])),
        child: const Text(
          'Giriş',
          style: TextStyle(fontSize: 20, color: Colors.white),
        ),
      ),
      onTap: () {
        if (_formKey.currentState!.validate()) {
          Future<List<dynamic>> Sonuc = firebaseMyAuth.Login(email!, parola!);
          Sonuc.then((baglantiSonucu) {
            if (baglantiSonucu[0].runtimeType == UserCredential) {
              Fluttertoast.showToast(msg: "Giriş Başarılı");
              //GİRİŞ YAPAN KULLANICININ BİLGİLERİ
              UserCredential userCredential = baglantiSonucu[0];
              //Fluttertoast.showToast(msg: "${"Hoşgeldin"+userCredential.user!.email.toString()}");
              //userID ile YÖNLENDİRİLECEK
              Navigator.pushAndRemoveUntil(
                  context,
                  MaterialPageRoute(
                      builder: (BuildContext) => MainPaage(
                            userID: userCredential.user!.uid,
                          )),
                  (Route<dynamic> route) => false);
            } else {
              Fluttertoast.showToast(msg: baglantiSonucu[0]);
            }
          });
        }
      },
    );
  }



  Widget _backButton() {
    return InkWell(
      onTap: () {
        Navigator.pop(context);
      },
      child: Container(
        padding: const EdgeInsets.symmetric(horizontal: 10),
        child: Row(
          children: <Widget>[
            Container(
              padding: const EdgeInsets.only(left: 0, top: 10, bottom: 10),
              child: const Icon(Icons.keyboard_arrow_left, color: Colors.black),
            ),
            const Text('Geri',
                style: TextStyle(fontSize: 12, fontWeight: FontWeight.w500))
          ],
        ),
      ),
    );
  }

  Widget _title() {
    return const Text("Çiftçi Destek",
        style: TextStyle(
            fontSize: 30,
            fontWeight: FontWeight.w700,
            color: Color(0xff22577A)));
  }

  Widget _divider() {
    return Container(
      margin: EdgeInsets.symmetric(vertical: 10),
      child: Row(
        children: const <Widget>[
          SizedBox(
            width: 20,
          ),
          Expanded(
            child: Padding(
              padding: EdgeInsets.symmetric(horizontal: 10),
              child: Divider(
                thickness: 1,
              ),
            ),
          ),
          Text('Veya'),
          Expanded(
            child: Padding(
              padding: EdgeInsets.symmetric(horizontal: 10),
              child: Divider(
                thickness: 1,
              ),
            ),
          ),
          SizedBox(
            width: 20,
          ),
        ],
      ),
    );
  }

  Widget _googleButton() {
    return Container(
      height: 50,
      margin: const EdgeInsets.symmetric(vertical: 20),
      decoration: const BoxDecoration(
        borderRadius: BorderRadius.all(Radius.circular(10)),
      ),
      child: Row(
        children: <Widget>[
          Expanded(
            flex: 1,
            child: Container(
              decoration: BoxDecoration(
                color: Colors.white,
                borderRadius: BorderRadius.only(
                    bottomLeft: Radius.circular(5),
                    topLeft: Radius.circular(5)),
              ),
              alignment: Alignment.center,
              child: Text('G',
                  style: TextStyle(
                      color: Color(0xff22577A),
                      fontSize: 25,
                      fontWeight: FontWeight.w400)),
            ),
          ),
          Expanded(
            flex: 5,
            child: Container(
              decoration: BoxDecoration(
                border: Border.all(color: Color(0xff22577A), width: 2),
                color: Colors.white,
                borderRadius: BorderRadius.only(
                    bottomRight: Radius.circular(5),
                    topRight: Radius.circular(5)),
              ),
              alignment: Alignment.center,
              child: Text('Log in with Google',
                  style: TextStyle(
                      color: Colors.black,
                      fontSize: 18,
                      fontWeight: FontWeight.w400)),
            ),
          ),
        ],
      ),
    );
  }

  _forgorPassword() {
    return Container(
      padding: const EdgeInsets.symmetric(vertical: 10),
      alignment: Alignment.centerRight,
      child: const Text('Sifremi Unuttum ?',
          style: TextStyle(fontSize: 14, fontWeight: FontWeight.w500)),
    );
  }
}
