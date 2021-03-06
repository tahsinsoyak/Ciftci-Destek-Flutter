import 'package:ciftci_destek_mobil/models/app_user.dart';
import 'package:flutter/material.dart';
import 'package:ciftci_destek_mobil/screen/widgets/bezier_container.dart';
import 'package:ciftci_destek_mobil/screen/login_page.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:ciftci_destek_mobil/themes/main_colors.dart';
import 'package:ciftci_destek_mobil/models/firebase_my_auth.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:ciftci_destek_mobil/models/firestore_db_services.dart';
import 'package:firebase_auth/firebase_auth.dart';

class SignUpPage extends StatefulWidget {
  const SignUpPage({Key? key}) : super(key: key);

  @override
  _SignUpPageState createState() => _SignUpPageState();
}

class _SignUpPageState extends State<SignUpPage> {
  FirebaseMyAuth firebaseMyAuth = FirebaseMyAuth();
  AppUser SignupUser = AppUser();

  var _formKey = GlobalKey<FormState>();
  @override
  Widget build(BuildContext context) {
    final height = MediaQuery.of(context).size.height;
    return Scaffold(
      body: Container(
        height: height,
        child: Stack(
          children: <Widget>[
            Positioned(
              top: -MediaQuery.of(context).size.height * .15,
              right: -MediaQuery.of(context).size.width * .4,
              child: const BezierContainer(),
            ),
            Container(
              padding: const EdgeInsets.symmetric(horizontal: 20),
              child: SingleChildScrollView(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.center,
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: <Widget>[
                    SizedBox(height: height * .2),
                    _title(),
                    const SizedBox(
                      height: 50,
                    ),
                    _inputWidget(),
                    const SizedBox(
                      height: 20,
                    ),
                    _submitButton(),
                    SizedBox(height: height * .10),
                    _loginAccountLabel(),
                  ],
                ),
              ),
            ),
            Positioned(top: 40, left: 0, child: _backButton()),
          ],
        ),
      ),
    );
  }

  Widget _inputWidget() {
    return Column(
      children: <Widget>[
        Form(
            key: _formKey,
            child: Column(
              children: [
                _NameText(),
                _EMailText(),
                _PasswordText(),
                _UzmanMi()
              ],
            ))
      ],
    );
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
              SignupUser.eMail = alinanMail;
            },
            //Mail Kontrol??
            validator: (alinanMail) {
              return alinanMail!.contains("@") ? null : "Mail Ge??erli De??il";
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
              SignupUser.parola = alinanParola;
            },
            validator: (alinanParola) {
              return alinanParola!.length >= 6
                  ? null
                  : "Parola en az 6 karakter olmal??d??r";
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

  Widget _NameText() {
    return Container(
      margin: const EdgeInsets.symmetric(vertical: 10),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: <Widget>[
          const Text(
            "??sim Soyisim",
            style: TextStyle(fontWeight: FontWeight.bold, fontSize: 15),
          ),
          const SizedBox(
            height: 10,
          ),
          TextFormField(
            onChanged: (isim) {
              setState(() {});
              SignupUser.adSoyad = isim;
            },
            validator: (isim) {
              return isim!.length >= 1 ? null : "L??tfen ??sim Giriniz";
            },
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

  Widget _UzmanMi() {
    return SwitchListTile(
        title: Text(
          "Uzman M??s??n ?",
          style: TextStyle(fontWeight: FontWeight.bold, fontSize: 15),
        ),
        subtitle:
            Text("Uzman olarak kay??t olanlar, onay almak i??in beklemelidir."),
        value: SignupUser.uzmanMi!,
        onChanged: (value) {
          setState(() {
            SignupUser.uzmanMi = value;
          });
        });
    //Text("Uzman M??s??n ?",style: TextStyle(fontWeight: FontWeight.bold, fontSize: 15),),
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
                colors: [MainColors.Blue2, MainColors.Blue1])),
        child: const Text(
          'Kay??t Ol',
          style: TextStyle(fontSize: 20, color: Colors.white),
        ),
      ),
      onTap: () {
        if (_formKey.currentState!.validate()) {
          firebaseMyAuth.SignUp(SignupUser.eMail!, SignupUser.parola!)
              .then((baglantiSonucu) {
            if (baglantiSonucu.runtimeType == UserCredential) {
              Fluttertoast.showToast(msg: "Kay??t Ba??ar??l??");
              //Ana Sayfaya Y??nlendirme
              Navigator.push(context,
                  MaterialPageRoute(builder: (context) => LoginPage()));
              //User nesnesi olu??turma
              UserCredential userCredential = baglantiSonucu;
              //Appuser t??r??ndeki nesneye userID atama ve kullan??c?? bilgilerinin katdetme
              SignupUser.userID = userCredential.user!.uid;
              kullaniciyiKaydet(SignupUser);
            } else {
              Fluttertoast.showToast(msg: baglantiSonucu);
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
        padding: EdgeInsets.symmetric(horizontal: 10),
        child: Row(
          children: <Widget>[
            Container(
              padding: EdgeInsets.only(left: 0, top: 10, bottom: 10),
              child: Icon(Icons.keyboard_arrow_left, color: Colors.black),
            ),
            Text('Back',
                style: TextStyle(fontSize: 12, fontWeight: FontWeight.w500))
          ],
        ),
      ),
    );
  }

  Widget _loginAccountLabel() {
    return InkWell(
      onTap: () {
        Navigator.push(
            context, MaterialPageRoute(builder: (context) => LoginPage()));
      },
      child: Container(
        margin: EdgeInsets.symmetric(vertical: 20),
        padding: EdgeInsets.all(15),
        alignment: Alignment.bottomCenter,
        child: Row(
          mainAxisAlignment: MainAxisAlignment.center,
          children: <Widget>[
            Text(
              'Already have an account ?',
              style: TextStyle(fontSize: 13, fontWeight: FontWeight.w600),
            ),
            SizedBox(
              width: 10,
            ),
            Text(
              'Login',
              style: TextStyle(
                  color: Color(0xfff79c4f),
                  fontSize: 13,
                  fontWeight: FontWeight.w600),
            ),
          ],
        ),
      ),
    );
  }

  Widget _title() {
    return const Text("??ift??i Destek",
        style: TextStyle(
            fontSize: 30,
            fontWeight: FontWeight.w700,
            color: Color(0xff22577A)));
  }

  void kullaniciyiKaydet(AppUser SignUpUser) async {
    FirestoreDbServices firestoreDbServices = FirestoreDbServices();
    await firestoreDbServices.saveUser(SignUpUser);

    if (SignupUser.uzmanMi == true) {
      await firestoreDbServices.uzmanKaydet(SignupUser);
    }
  }
}
