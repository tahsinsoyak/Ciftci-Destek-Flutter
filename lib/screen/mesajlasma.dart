import 'package:ciftci_destek_mobil/models/app_user.dart';
import 'package:ciftci_destek_mobil/models/firestore_db_services.dart';
import 'package:ciftci_destek_mobil/models/mesaj.dart';
import 'package:ciftci_destek_mobil/screen/uzmana_sor.dart';
import 'package:ciftci_destek_mobil/themes/main_colors.dart';
import 'package:cloud_firestore_platform_interface/src/timestamp.dart';
import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:fluttertoast/fluttertoast.dart';

import 'package:ciftci_destek_mobil/themes/main_colors.dart';

//https://cybdom.tech/flutter-tutorial-messengerish-app-ui/
class Mesajlasma extends StatefulWidget {
  AppUser? appUser;
  AppUser? uzmanUser;
  Mesajlasma({this.appUser, this.uzmanUser, Key? key}) : super(key: key);

  @override
  _MesajlasmaState createState() => _MesajlasmaState();
}

class _MesajlasmaState extends State<Mesajlasma> {
  FirestoreDbServices firestoreDbServices = FirestoreDbServices();
  var _mesajController = TextEditingController();
  ScrollController _scrollController = ScrollController();

  @override
  Widget build(BuildContext context) {
    String mesajGonderenID = widget.appUser!.userID.toString();
    String mesajAlanID = widget.uzmanUser!.userID.toString();

    return Scaffold(
      appBar: AppBar(
        title: TitleOlustur(),
      ),
      body: Padding(
        padding: const EdgeInsets.all(8.0),
        child: Column(
          children: [
            Expanded(
              child: StreamBuilder<List<Mesaj>>(
                stream: firestoreDbServices.getMesages(
                    mesajGonderenID, mesajAlanID),
                builder: (context, streamMesajlarListesi) {
                  if (!streamMesajlarListesi.hasData) {
                    return CircularProgressIndicator();
                  }
                  List<Mesaj>? tumMesajlar = streamMesajlarListesi.data;

                  print(tumMesajlar!.length);

                  return ListView.builder(
                    reverse: true,
                    controller: _scrollController,
                    itemCount: tumMesajlar.length,
                    itemBuilder: (context, index) {
                      Mesaj AnlikMesaj = tumMesajlar[index];
                      if (AnlikMesaj.bendenmi == true) {
                        return Padding(
                          padding: const EdgeInsets.all(8.0),
                          child: mesajGonderici(context, AnlikMesaj),
                        );
                      } else {
                        return Padding(
                          padding: const EdgeInsets.all(8.0),
                          child: mesajAlici(context, AnlikMesaj),
                        );
                      }
                    },
                  );
                },
              ),
            ),
            mesajYazmaKutusu(mesajGonderenID, mesajAlanID),
          ],
        ),
      ),
    );
  }

  Widget TitleOlustur() {
    return Row(
      mainAxisSize: MainAxisSize.min,
      children: <Widget>[
        CircleAvatar(
          //Uzman Profil Resimi Gelecek
          child: Icon(Icons.account_tree_sharp),
        ),
        SizedBox(width: 15),
        Column(
          mainAxisAlignment: MainAxisAlignment.center,
          crossAxisAlignment: CrossAxisAlignment.start,
          children: <Widget>[
            Text(
              widget.uzmanUser!.adSoyad.toString(),
              overflow: TextOverflow.clip,
            ),
            Uzmanmi(),
          ],
        ),
        SizedBox(
          width: 25,
        ),
        Icon(Icons.call),
        SizedBox(
          width: 20,
        ),
        Icon(
          Icons.keyboard_control_sharp,
        ),
      ],
    );
  }

  Widget mesajAlici(BuildContext context, Mesaj gosterilecekMesaj) {
    String _saaatDakikaDegeri = SaatDakikaGoster(gosterilecekMesaj.date);
    return Row(
      mainAxisAlignment: MainAxisAlignment.start,
      crossAxisAlignment: CrossAxisAlignment.center,
      children: <Widget>[
        Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: <Widget>[
            Container(
              constraints: BoxConstraints(
                  maxWidth: MediaQuery.of(context).size.width * .6),
              padding: const EdgeInsets.all(15.0),
              decoration: BoxDecoration(
                color: Colors.grey.shade300,
                borderRadius: const BorderRadius.only(
                  topRight: Radius.circular(25),
                  bottomLeft: Radius.circular(25),
                  bottomRight: Radius.circular(25),
                ),
              ),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.end,
                children: [
                  Text(gosterilecekMesaj.mesaj.toString()),
                  Text(
                    _saaatDakikaDegeri,
                    style: TextStyle(fontSize: 9),
                  ),
                ],
              ),
            ),
          ],
        ),
        SizedBox(width: 15),
      ],
    );
  }

  Widget mesajGonderici(BuildContext context, Mesaj gosterilecekMesaj) {
    String _saaatDakikaDegeri = "R";
    try {
      _saaatDakikaDegeri =
          SaatDakikaGoster(gosterilecekMesaj.date ?? Timestamp(1, 1));
    } catch (e) {}

    return Row(
      mainAxisAlignment: MainAxisAlignment.end,
      children: <Widget>[
        Column(
          crossAxisAlignment: CrossAxisAlignment.end,
          children: <Widget>[
            Container(
              constraints: BoxConstraints(
                  maxWidth: MediaQuery.of(context).size.width * .6),
              padding: const EdgeInsets.all(15.0),
              decoration: const BoxDecoration(
                color: MainColors.Green1,
                borderRadius: BorderRadius.only(
                  topLeft: Radius.circular(25),
                  bottomLeft: Radius.circular(25),
                  bottomRight: Radius.circular(25),
                ),
              ),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(gosterilecekMesaj.mesaj.toString()),
                  Text(
                    _saaatDakikaDegeri,
                    style: TextStyle(fontSize: 9),
                  ),
                ],
              ),
            ),
          ],
        ),
      ],
    );
  }

  Widget mesajYazmaKutusu(String mesajGonderenID, String mesajAlanId) {
    return Container(
      margin: EdgeInsets.all(15.0),
      height: 61,
      child: Row(
        children: <Widget>[
          Expanded(
            child: Container(
              decoration: BoxDecoration(
                color: Colors.white,
                borderRadius: BorderRadius.circular(35.0),
                boxShadow: const [
                  BoxShadow(
                      offset: Offset(0, 3), blurRadius: 5, color: Colors.grey)
                ],
              ),
              child: Row(
                children: <Widget>[
                  IconButton(icon: const Icon(Icons.face), onPressed: () {}),
                  Expanded(
                    child: TextField(
                      controller: _mesajController,
                      decoration: const InputDecoration(
                          hintText: "Mesaj Yazınız...",
                          border: InputBorder.none),
                    ),
                  ),
                  IconButton(
                    icon: const Icon(Icons.photo_camera),
                    onPressed: () {
                      Fluttertoast.showToast(
                          msg: "Bu Hizmet Aktif Edilmemiştir..");
                    },
                  ),
                  IconButton(
                    icon: const Icon(Icons.attach_file),
                    onPressed: () {
                      Fluttertoast.showToast(
                          msg: "Bu Hizmet Aktif Edilmemiştir..");
                    },
                  )
                ],
              ),
            ),
          ),
          SizedBox(width: 15),
          Container(
            padding: const EdgeInsets.all(15.0),
            decoration: const BoxDecoration(
                color: MainColors.Green1, shape: BoxShape.circle),
            child: InkWell(
              child: const Icon(
                Icons.send_outlined,
                color: Colors.white,
              ),
              onTap: () async {
                if (_mesajController.text.trim().length > 0) {
                  Mesaj kaydedilecekMesaj = Mesaj(
                      bendenmi: true,
                      kimden: mesajGonderenID,
                      kime: mesajAlanId,
                      mesaj: _mesajController.text);
                  var sonuc =
                      await firestoreDbServices.saveMessage(kaydedilecekMesaj);
                  if (sonuc) {
                    _mesajController.clear();
                  } else {
                    _mesajController.text = "Mesaj Gönderiminde Hata";
                    _scrollController.animateTo(00,
                        duration: const Duration(milliseconds: 100),
                        curve: Curves.easeOut);
                  }
                }
              },
            ),
          )
        ],
      ),
    );
  }

  String SaatDakikaGoster(Timestamp? date) {
    var _formatter = DateFormat.Hm();
    var _formatlanmisTarih = _formatter.format(date!.toDate());
    return _formatlanmisTarih;
  }

  Widget Uzmanmi() {
    if (widget.appUser!.uzmanMi == true) {
      return Text(
        "Uzman",
        style: TextStyle(color: Colors.green.shade200, fontSize: 13),
      );
    } else {
      return Text(
        "Çiftçi ",
        style: TextStyle(color: Colors.green.shade200, fontSize: 13),
      );
    }
  }
}
