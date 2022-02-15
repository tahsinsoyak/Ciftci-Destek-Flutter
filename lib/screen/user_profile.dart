import 'package:ciftci_destek_mobil/models/app_user.dart';
import 'package:ciftci_destek_mobil/screen/login_page.dart';
import 'package:flutter/material.dart';
import 'package:ciftci_destek_mobil/themes/main_colors.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:fluttertoast/fluttertoast.dart';

class UserProfile extends StatefulWidget {
  AppUser? appUser;
  UserProfile({this.appUser, Key? key}) : super(key: key);

  @override
  State<UserProfile> createState() => _UserProfileState();
}

class _UserProfileState extends State<UserProfile> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      resizeToAvoidBottomInset: false,
      appBar: AppBar(
        backgroundColor: Colors.white,
        foregroundColor: MainColors.Blue2,
        elevation: 0,
        centerTitle: true,
        title: const Text(
          "Profil Detayları",
        ),
        actions: [
          IconButton(
              onPressed: () async {}, icon: const Icon(Icons.info_outline))
        ],
      ),
      body: profileView(),
    );
  }

  Widget profileView() {
    return Column(
      children: <Widget>[
        Padding(
          padding: const EdgeInsets.fromLTRB(0, 30, 0, 50),
          child: Stack(
            children: <Widget>[
              CircleAvatar(
                backgroundColor: MainColors.Blue1,
                radius: 70,
                child: Text(
                  widget.appUser!.adSoyad![0].toUpperCase(),
                  style: TextStyle(fontSize: 50, color: MainColors.Green1),
                ),
              ),
            ],
          ),
        ),
        ///////////////////////
        Expanded(
            child: Container(
          decoration: const BoxDecoration(
            borderRadius: BorderRadius.only(
                topLeft: Radius.circular(30), topRight: Radius.circular(30)),
            gradient: LinearGradient(
              begin: Alignment.topRight,
              end: Alignment.bottomLeft,
              ///////
              colors: [MainColors.Blue1, MainColors.Blue2],
            ),
          ),
          child: Padding(
            padding: EdgeInsets.fromLTRB(20, 30, 20, 10),
            child: Column(
              children: <Widget>[
                Padding(
                  padding: const EdgeInsets.fromLTRB(0, 0, 0, 15),
                  child: TextFormField(
                    initialValue: widget.appUser!.adSoyad,
                    readOnly: true,
                    style: TextStyle(fontSize: 20, color: MainColors.Green1),
                    decoration: InputDecoration(
                      border: OutlineInputBorder(
                        borderSide: const BorderSide(
                          color: Colors.red,
                        ),
                        borderRadius: BorderRadius.circular(20.0),
                      ),
                    ),
                  ),
                ),
                Padding(
                    padding: const EdgeInsets.fromLTRB(0, 0, 0, 15),
                    child: TextFormField(
                      style: TextStyle(fontSize: 20, color: MainColors.Green1),
                      initialValue: widget.appUser!.eMail,
                      decoration: InputDecoration(
                        border: OutlineInputBorder(
                          borderSide: const BorderSide(
                            color: Colors.red, //this has no effect
                          ),
                          borderRadius: BorderRadius.circular(20.0),
                        ),
                      ),
                    )),
                const SizedBox(
                  height: 10,
                ),
                Row(
                  children: [
                    Text(
                      "Kullanıcı Türü:",
                      style: TextStyle(fontSize: 20),
                    ),
                    Text(
                      uzmanMi(),
                      style: TextStyle(fontSize: 20, color: MainColors.Green1),
                    )
                  ],
                ),
                const SizedBox(
                  height: 10,
                ),
                Row(
                  children: [
                    Text(
                      "Mail Doğrulaması:",
                      style: TextStyle(fontSize: 20),
                    ),
                    eMailDogrulamasiDurumu(),
                  ],
                ),
                //E MAİL DOĞRULAMA MESAJI GÖNDERİM ALANI
                eMailDogrulamaMesajiGonder(),
                //BUTTONLAR
                const SizedBox(
                  height: 30,
                ),
                Row(
                  children: [
                    Expanded(
                      child: Align(
                        child: ElevatedButton(
                          child: Text(
                            "Çıkış Yap",
                            style: TextStyle(fontSize: 17),
                          ),
                          onPressed: () async {
                            await FirebaseAuth.instance.signOut();
                            Navigator.pushAndRemoveUntil(
                                context,
                                MaterialPageRoute(
                                    builder: (BuildContext) => LoginPage()),
                                (Route<dynamic> route) => false);
                            Fluttertoast.showToast(msg: "Çıkış Yapıldı");
                          },
                          style: ElevatedButton.styleFrom(
                              primary: Colors.red,
                              fixedSize: const Size(150, 60),
                              shape: RoundedRectangleBorder(
                                  borderRadius: BorderRadius.circular(30))),
                        ),
                      ),
                    ),
                    Expanded(
                      child: Align(
                        child: ElevatedButton(
                          child: Text("Kaydet", style: TextStyle(fontSize: 18)),
                          onPressed: () {},
                          style: ElevatedButton.styleFrom(
                              primary: MainColors.Green2,
                              fixedSize: const Size(150, 60),
                              shape: RoundedRectangleBorder(
                                  borderRadius: BorderRadius.circular(30))),
                        ),
                      ),
                    )
                  ],
                )
              ],
            ),
          ),
        ))
      ],
    );
  }

  String uzmanMi() {
    if (widget.appUser!.uzmanMi == true) {
      return " Uzman";
    } else {
      return " Çictçi";
    }
  }

  eMailDogrulamasiDurumu() {
    User? user = FirebaseAuth.instance.currentUser;

    if (user!.emailVerified == true) {
      return Text(
        " Doğrulandı",
        style: TextStyle(fontSize: 20, color: MainColors.Green1),
      );
    } else {
      return Text(
        "Doğrulanmadı",
        style: TextStyle(fontSize: 20, color: Colors.red),
      );
      ;
    }
  }

  EmailDogrulama() async {
    User? user = FirebaseAuth.instance.currentUser;
    print(user!.email.toString());

    if (user != null && !user.emailVerified) {
      await user.sendEmailVerification();
      Fluttertoast.showToast(msg: "e mail doğrulaması gonderildi");
      print("e mail doğrulaması gonderildi");
    }
  }

  Widget eMailDogrulamaMesajiGonder() {
    User? user = FirebaseAuth.instance.currentUser;
    print(user!.email.toString());

    if (user != null && !user.emailVerified) {
      return TextButton(
        child: Text("E Mail Doğrulama mesajı için tıklayın..."),
        onPressed: () => EmailDogrulama(),
      );
    }else
  { return Text("E Mailizi doğruladığınız için teşekkürler");}
  }
}
