import 'package:cloud_firestore/cloud_firestore.dart';

class Mesaj {
  String? kimden;
  String? kime;
  bool? bendenmi;
  String? mesaj;
  Timestamp? date;
  Mesaj({
    this.kimden,
    this.kime,
    this.bendenmi,
    this.mesaj,
    this.date,
  });

  Map<String, dynamic> toMap() {
    return {
      "kimden": kimden,
      "kime": kime,
      "bendenmi": bendenmi,
      "mesaj": mesaj,
      "date": date ?? FieldValue.serverTimestamp(),
    };
  }

  Mesaj.fromMap(Map<String, dynamic> map)
      : kimden = map["kimden"],
        kime = map["kime"],
        bendenmi = map["bendenmi"],
        mesaj = map["mesaj"],
        date = map["date"];

  @override
  String toString() {
    return 'Mesaj(kimden: $kimden, kime: $kime, bendenmi: $bendenmi, mesaj: $mesaj, date: $date)';
  }
}
