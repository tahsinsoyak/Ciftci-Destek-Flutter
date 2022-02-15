import 'package:ciftci_destek_mobil/models/app_user.dart';
import 'package:ciftci_destek_mobil/screen/user_profile.dart';
import 'package:flutter/material.dart';
import 'package:ciftci_destek_mobil/screen/sign_up_page.dart';
import 'package:ciftci_destek_mobil/screen/login_page.dart';
import 'package:ciftci_destek_mobil/themes/main_colors.dart';

class WelcomePage extends StatefulWidget {
  const WelcomePage({Key? key}) : super(key: key);

  @override
  _WelcomePageState createState() => _WelcomePageState();
}

class _WelcomePageState extends State<WelcomePage> {
  @override
  Widget build(BuildContext context) {
    double ekranBoyutu = MediaQuery.of(context).size.height;
    return Scaffold(
      body: SingleChildScrollView(
        child: Container(
          padding: const EdgeInsets.symmetric(horizontal: 20),
          height: MediaQuery.of(context).size.height,
          decoration: const BoxDecoration(
              gradient: LinearGradient(
                  begin: Alignment.topCenter,
                  end: Alignment.bottomCenter,
                  colors: [MainColors.Green2, MainColors.Green1])),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.center,
            mainAxisAlignment: MainAxisAlignment.center,
            children: <Widget>[
              SizedBox(
                height: ekranBoyutu / 7,
              ),
              _title(),
              const SizedBox(
                height: 80,
              ),
              //KAYIT OL
              _submitButton(),
              const SizedBox(
                height: 20,
              ),
              //GİRİŞ YAP
              _signUpButton(),
              SizedBox(
                height: ekranBoyutu / 5,
              ),
              GestureDetector(
                child:const Text(
                  "FTT Yapımıdır",
                  style: TextStyle(color: MainColors.Blue2),
                ),
                onTap: () {
                  Navigator.push(
                      context,
                      MaterialPageRoute(
                          builder: (BuildContext) => UserProfile(
                                appUser: AppUser(
                                    Parola: "sad",
                                    eMail: "deneme@deneme.com",
                                    userID: "Furkan Ayyıldız"),
                              )));
                },
              )
            ],
          ),
        ),
      ),
    );
  }

  Widget _submitButton() {
    return InkWell(
      onTap: () {
        Navigator.push(
            context, MaterialPageRoute(builder: (context) => LoginPage()));
      },
      child: Container(
        width: MediaQuery.of(context).size.width,
        padding: const EdgeInsets.symmetric(vertical: 13),
        alignment: Alignment.center,
        decoration: BoxDecoration(
            borderRadius: const BorderRadius.all(Radius.circular(5)),
            boxShadow: <BoxShadow>[
              BoxShadow(
                  color: const Color(0xff38A3A5).withAlpha(100),
                  offset: const Offset(2, 4),
                  blurRadius: 8,
                  spreadRadius: 2)
            ],
            color: Colors.white),
        child: const Text(
          'Giriş Yap',
          style: TextStyle(fontSize: 20, color: Color(0xff38A3A5)),
        ),
      ),
    );
  }

  Widget _signUpButton() {
    return InkWell(
      onTap: () {
        Navigator.push(
            context, MaterialPageRoute(builder: (context) => SignUpPage()));
      },
      child: Container(
        width: MediaQuery.of(context).size.width,
        padding: const EdgeInsets.symmetric(vertical: 13),
        alignment: Alignment.center,
        decoration: BoxDecoration(
          borderRadius: const BorderRadius.all(Radius.circular(5)),
          border: Border.all(color: Colors.white, width: 2),
        ),
        child: const Text(
          'Kayıt Ol',
          style: TextStyle(fontSize: 20, color: Colors.white),
        ),
      ),
    );
  }

  Widget _title() {
    return Column(
      children: [
        Container(
          child: Image.asset(
            "lib/assets/leaf3.png",
            color: Colors.green,
          ),
          height: 90,
        ),
        const SizedBox(
          height: 10,
        ),
        const Text("Çiftçi Destek",
            style: TextStyle(
                fontSize: 30,
                fontWeight: FontWeight.w700,
                color: Color(0xff22577A)))
      ],
    );
  }
}
