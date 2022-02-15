import 'package:ciftci_destek_mobil/models/app_user.dart';
import 'package:ciftci_destek_mobil/models/firestore_db_services.dart';
import 'package:ciftci_destek_mobil/screen/calc_page.dart';
import 'package:ciftci_destek_mobil/screen/conversion_page.dart';
import 'package:ciftci_destek_mobil/screen/gubre_fiyatlari.dart';
import 'package:ciftci_destek_mobil/screen/hava_durumu.dart';
import 'package:ciftci_destek_mobil/screen/listeleme.dart';
import 'package:ciftci_destek_mobil/screen/user_profile.dart';
import 'package:ciftci_destek_mobil/screen/uzmana_sor.dart';
import 'package:ciftci_destek_mobil/themes/main_colors.dart';
import 'package:flutter/material.dart';
import 'package:flutter/scheduler.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:firebase_auth/firebase_auth.dart';

class MainPaage extends StatefulWidget {
  AppUser? appUser;
  final String? userID;
  User? user = FirebaseAuth.instance.currentUser;

  MainPaage({this.appUser , this.userID, Key? key}) : super(key: key);

  @override
  _MainPaageState createState() => _MainPaageState();
}

class _MainPaageState extends State<MainPaage> {
  @override
  void initState() {
    super.initState();
    if(widget.appUser==null ){
          KullaniciVerileriGetir();
    }
    else{

    }

    //UYARI GÖSTERİLMİYOR
    SchedulerBinding.instance!
        .addPostFrameCallback((_) => EmailDogrulamaUyarisi());
  }

  @override
  Widget build(BuildContext context) {
    final screenSize = MediaQuery.of(context).size;
    return Scaffold(
        appBar: AppBar(
          backgroundColor: Colors.white,
          foregroundColor: MainColors.Blue2,
          elevation: 0,
          centerTitle: true,
          title: const Text(
            "Çiftçi Destek",
          ),
          actions: [
            IconButton(
                onPressed: () {
                  Navigator.push(
                      context,
                      MaterialPageRoute(
                          builder: (BuildContext) => UserProfile(
                                appUser: widget.appUser,
                              )));
                },
                icon: const Icon(Icons.account_circle_outlined))
          ],
        ),
        body: SafeArea(
          child: Stack(
            children: <Widget>[
              CustomScrollView(
                slivers: <Widget>[
                  SliverToBoxAdapter(
                    child: Padding(
                      padding: const EdgeInsets.all(26.0),
                      child: Column(
                        mainAxisSize: MainAxisSize.min,
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: <Widget>[
                          Material(
                            elevation: 5.0,
                            borderRadius:
                                const BorderRadius.all(Radius.circular(30)),
                            child: TextField(
                              controller:
                                  TextEditingController(text: 'Search...'),
                              cursorColor: Theme.of(context).primaryColor,
                              style: const TextStyle(
                                  color: Colors.black, fontSize: 18),
                              decoration: const InputDecoration(
                                  suffixIcon: Material(
                                    elevation: 2.0,
                                    borderRadius:
                                        BorderRadius.all(Radius.circular(30)),
                                    child: Icon(Icons.search),
                                  ),
                                  border: InputBorder.none,
                                  contentPadding: EdgeInsets.symmetric(
                                      horizontal: 25, vertical: 13)),
                            ),
                          ),
                        ],
                      ),
                    ),
                  ),
                  SliverPadding(
                    padding: const EdgeInsets.all(26.0),
                    sliver: SliverGrid.count(
                      crossAxisCount: 2,
                      mainAxisSpacing: 20,
                      crossAxisSpacing: 20,
                      children: <Widget>[
                        GestureDetector(
                          child: cards(
                            "lib/assets/shovel.png",
                            'Toprak Analizi',
                          ),
                          onTap: () {
                            Navigator.push(
                                context,
                                MaterialPageRoute(
                                    builder: (context) => Listeleme(appUser: widget.appUser,)));
                          },
                        ),
                        GestureDetector(
                          child: cards(
                            "lib/assets/weather.png",
                            'Hava Durumu',
                          ),
                          onTap: () {
                            Navigator.push(
                                context,
                                MaterialPageRoute(
                                    builder: (context) => Home()));
                          },
                        ),
                        GestureDetector(
                          child:
                              cards("lib/assets/calculator.png", 'Gelir/Gider'),
                          onTap: () {
                            Navigator.push(
                              context,
                              MaterialPageRoute(
                                builder: (context) => CalcApp()
                              ),
                            );
                          },
                        ),
                        GestureDetector(
                          child: cards(
                            "lib/assets/messages.png",
                            'Uzmana Sor',
                          ),
                          onTap: () {
                            Navigator.push(
                                context,
                                MaterialPageRoute(
                                    builder: (context) => UzmanaSor(
                                          appUser: widget.appUser,
                                        )));
                          },
                        ),
                        cards("lib/assets/fertilizer.png", 'Hal Fiyatları'),
                        GestureDetector(
                          child: cards(
                            "lib/assets/logo.png",
                            'Döviz Kuru',
                          ),
                          onTap: () {
                            Navigator.push(
                                context,
                                MaterialPageRoute(
                                    builder: (context) =>
                                        const ConversionPage()));
                          },
                        ),
                      ],
                    ),
                  ),
                ],
              ),
            ],
          ),
        ));
  }

  Widget cards(
    pictureAsset,
    title,
  ) {
    return Container(
      height: 200,
      width: 200,
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(30),
        boxShadow: const [
          BoxShadow(
            color: Colors.grey,
            blurRadius: 6.0,
          ),
        ],
        color: Colors.white,
      ),
      child: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: <Widget>[
            Image.asset(
              pictureAsset,
              width: 90,
              height: 90,
            ),
            const SizedBox(
              height: 5,
            ),
            Text(title,
                style:
                    const TextStyle(fontWeight: FontWeight.bold, fontSize: 18)),
            // Container(
            //   padding: const EdgeInsets.all(5),
            //   margin: const EdgeInsets.only(top: 4),
            //   color: Colors.deepOrange,
            //   child: Text(
            //     "\$ " + price,
            //     style: const TextStyle(
            //         color: Colors.white,
            //         fontWeight: FontWeight.bold,
            //         fontSize: 12),
            //   ),
            // ),
          ],
        ),
      ),
    );
  }

  void KullaniciVerileriGetir() {
    FirestoreDbServices firestoreDbService = FirestoreDbServices();
    debugPrint("Main Page- Gelen Ud : ${widget.userID}");
    firestoreDbService.readUser(widget.userID).then((value) {
      widget.appUser = value;
      Fluttertoast.showToast(msg: "Hoşgeldin ${widget.appUser!.adSoyad}");
      debugPrint(
          "Main Page- User verileri çekildi : ${widget.appUser!.adSoyad}");
    });
  }

  void EmailDogrulamaUyarisi() {
    if (widget.user!.emailVerified == false) {
      showDialog<String>(
        context: context,
        builder: (BuildContext context) => AlertDialog(
          title: const Text('Çiftçi Destek'),
          content: const Text(
              'Email doğrulaması yapılmadı. Lüften profil sayfasından doğrulamanızı yapınız. !'),
          actions: <Widget>[
            TextButton(
              onPressed: () => Navigator.push(
                context,
                MaterialPageRoute(
                  builder: (BuildContext) => UserProfile(
                    appUser: widget.appUser,
                  ),
                ),
              ),
              child: const Text('Profil Sayfası'),
            ),
            TextButton(
              onPressed: () => Navigator.pop(context),
              child: const Text('Tamam'),
            ),
          ],
        ),
      );
    }
  }
}
