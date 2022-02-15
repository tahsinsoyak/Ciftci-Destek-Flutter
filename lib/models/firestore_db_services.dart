import 'package:ciftci_destek_mobil/models/app_user.dart';
import 'package:ciftci_destek_mobil/models/mesaj.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:ciftci_destek_mobil/models/firestore_db_services.dart';
import 'package:flutter/animation.dart';

class FirestoreDbServices {
  FirebaseFirestore firestore = FirebaseFirestore.instance;

  Future<bool> saveUser(AppUser AppUser) async {
    try {
      await firestore
          .collection("users")
          .doc(AppUser.userID)
          .set(AppUser.toMap());
      return true;
    } catch (e) {
      return false;
    }
  }

  Future<AppUser> readUser(String? userID) async {
    if (userID != null) {
      DocumentSnapshot _OkunanVeriler =
          await FirebaseFirestore.instance.doc("users/${userID}").get();
      Map<String, dynamic> _okunanUserBilgileriMap =
          _OkunanVeriler.data() as Map<String, dynamic>;
      AppUser OkunanAppUserNesnesi = AppUser.fromMap(_okunanUserBilgileriMap);
      print("user verisi çekildi : " + OkunanAppUserNesnesi.eMail.toString());
      return OkunanAppUserNesnesi;
    } else {
      print("Read User methoduna Boş UserID verisi geldi!!");
      return AppUser();
    }
  }

  Future<bool> uzmanKaydet(AppUser UzmanUser) async {
    try {
      await firestore
          .collection("uzmanUsers")
          .doc(UzmanUser.userID)
          .set(UzmanUser.toMap());
      return true;
    } catch (e) {
      return false;
    }
  }

  Future<List<AppUser>> UzmanlariGetir() async {
    List<AppUser> TumUzmanlar = [];
    QuerySnapshot querySnapshot =
        await firestore.collection("uzmanUsers").get();

    for (DocumentSnapshot user in querySnapshot.docs) {
      AppUser _tekUser = AppUser.fromMap(user.data() as Map<String, dynamic>);
      TumUzmanlar.add(_tekUser);

      //print("okunan user ${user.data( ).toString()} ");
    }
    return TumUzmanlar;
  }

    Future<List<AppUser>> TumKullanicilariGetir() async {
    List<AppUser> TumKullanicilar = [];
    QuerySnapshot querySnapshot =
        await firestore.collection("users").get();

    for (DocumentSnapshot user in querySnapshot.docs) {
      AppUser _tekUser = AppUser.fromMap(user.data() as Map<String, dynamic>);
      TumKullanicilar.add(_tekUser);

      //print("okunan user ${user.data( ).toString()} ");
    }
    return TumKullanicilar;
  }

  Stream<List<Mesaj>> getMesages(String mesajGonderenID, String mesajAlanID) {

    var snapShot = firestore
        .collection("konusmalar")
        .doc(mesajGonderenID + "--" + mesajAlanID)
        .collection("mesajlar")
        .orderBy("date" ,descending: true )
        .snapshots();

    return snapShot.map((mesaListesi) =>
        mesaListesi.docs.map((mesaj) => Mesaj.fromMap(mesaj.data())).toList());
  }

  Future<bool> saveMessage(Mesaj kaydedilecekMesaj) async {
    var mesajID = firestore.collection("konusmalar").doc().id;
    var _gonderenDocID =
        kaydedilecekMesaj.kimden! + "--" + kaydedilecekMesaj.kime!;
    var _AliciDocID = kaydedilecekMesaj.kime! + "--" + kaydedilecekMesaj.kimden!;

    var kaydedilecekMesajMap = kaydedilecekMesaj.toMap();

    await firestore
        .collection("konusmalar")
        .doc(_gonderenDocID)
        .collection("mesajlar")
        .doc(mesajID)
        .set(kaydedilecekMesajMap);

    kaydedilecekMesajMap.update("bendenmi", (value) => false);

        await firestore
        .collection("konusmalar")
        .doc(_AliciDocID)
        .collection("mesajlar")
        .doc(mesajID)
        .set(kaydedilecekMesajMap);

    return true;
    
  }

  
  
}
