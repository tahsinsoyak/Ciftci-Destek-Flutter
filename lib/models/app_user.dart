import 'package:flutter/cupertino.dart';

class AppUser {
  String? userID;
  String? eMail;
  String? parola;
  String? adSoyad;
  String? konum="Girilmedi";
  bool? uzmanMi=false;
  bool? mailDogrulamasi=false;
  

  AppUser({userID, eMail, Parola});

  Map<String, dynamic> toMap() {
    return {
      "userID": userID,
      "eMail": eMail,
      "parola": parola,
      "adSoyad" : adSoyad,
      "konum" : konum,
      "uzmanMi" : uzmanMi,
      "mailDogrulamasi" : mailDogrulamasi,
    };
  }

  AppUser.fromMap(Map<String , dynamic> map):
    userID = map["userID"],
    eMail = map["eMail"],
    parola = map["parola"],
    adSoyad = map["adSoyad"],
    konum = map["konum"],
    uzmanMi = map["uzmanMi"],
    mailDogrulamasi = map["mailDogrulamasi"];

}
