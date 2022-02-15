import 'package:ciftci_destek_mobil/models/app_user.dart';
import 'package:ciftci_destek_mobil/themes/main_colors.dart';
import 'package:flutter/material.dart';

import 'analiz_sonucu.dart';


class ToprakAnalizi extends StatefulWidget {
  final GlobalKey<FormState> _formKey = GlobalKey<FormState>();
  AppUser? appUser;
  String text = '';
  List<String>? secilen_besin;
  List<String> girilen_deger = [];
  List<String> besinler = [];
  List<String> besin_analiz_sonucu = [];
  ToprakAnalizi({this.appUser,this.secilen_besin, Key? key}) : super(key: key);

  @override
  State<ToprakAnalizi> createState() => _ToprakAnaliziState();
}

class _ToprakAnaliziState extends State<ToprakAnalizi> {
  late List<TextEditingController> controllers;

  @override
  void initState() {
    widget.besinler.add("PH");
    widget.besinler.add("K");
    widget.besinler.add("N");
    widget.besinler.add("P");
    widget.besinler.add("Ca");
    widget.besinler.add("Mg");
    widget.besinler.add("Mn");
    widget.besinler.add("Zn");
    widget.besinler.add("Fe");
    widget.besinler.add("Cu");
    widget.besinler.add("Tuz");
    widget.besinler.add("Kireç");
    widget.besinler.add("Tekstür");

    for (int i = 0; i < widget.secilen_besin!.length; i++) {
      widget.girilen_deger.add('0');
    }
    for (int i = 0; i < widget.secilen_besin!.length; i++) {
      widget.besin_analiz_sonucu.add('0');
    }
    super.initState();
    controllers = List.generate(
        widget.secilen_besin!.length, (i) => TextEditingController());
  }

  @override
  void dispose() {
    controllers.forEach((c) => c.dispose());
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        automaticallyImplyLeading: false,
        backgroundColor: Colors.white,
        foregroundColor: MainColors.Blue2,
        elevation: 0,
        centerTitle: true,
        title: const Text(
          "Toprak Analizi",
        ),
        actions: [
          IconButton(
              onPressed: () async {}, icon: const Icon(Icons.switch_left_sharp))
        ],
      ),
      body: Container(
          child: Form(
        key: widget._formKey,
        child: Column(
          children: <Widget>[
            Expanded(
              child: ListView.builder(
                itemCount: widget.secilen_besin!.length,
                itemBuilder: (context, index) {
                  return Padding(
                    padding: const EdgeInsets.all(16.0),
                    child: TextFormField(
                      
                      validator: (value) {
                        if (value!.isNotEmpty) {
                          return null;
                        } else {
                          return "Lutfen gecerli bir deger girin";
                        }
                      },
                      controller: controllers[index],
                      onChanged: (value) {
                        widget.girilen_deger[index] = controllers[index].text;
                      },
                      decoration: InputDecoration(
                          
                          labelText: widget.secilen_besin![index],
                          border: OutlineInputBorder()),
                    ),
                  );
                },
              ),
            ),
            ElevatedButton(
              style: ButtonStyle(
                  backgroundColor: MaterialStateProperty.all(MainColors.Blue2)),
              onPressed: () {
                Navigator.of(context).pop();
                widget.secilen_besin!.clear();
              },
              child: Text('Geri don'),
            ),
            Padding(
              padding: const EdgeInsets.all(8.0),
              child: ElevatedButton(
                  style: ButtonStyle(
                      backgroundColor:
                          MaterialStateProperty.all(MainColors.Blue2)),
                  onPressed: () {
                    if (widget._formKey.currentState!.validate()) {
                      Navigator.of(context).push(MaterialPageRoute(
                          builder: (context) => AnalizSonucu(
                            appUser: widget.appUser,
                                besin_analiz_sonucu: widget.besin_analiz_sonucu,
                                secilen_besin: widget.secilen_besin,
                              )));
                    }
                    for (int i = 0; i < widget.secilen_besin!.length; i++) {
                      for (int j = 0; j < widget.besinler.length; j++) {
                        if (widget.secilen_besin![i] == widget.besinler[j]) {
                          widget.besin_analiz_sonucu[i] = besinGonder(
                              widget.besinler[j],
                              double.parse(widget.girilen_deger[i]));
                        }
                      }
                    }
                  },
                  child: Text('Analiz et')),
            )
          ],
        ),
      )),
    );
  }

  String besinGonder(String besin, double deger) {
    if (besin == "PH") {
      return PH(deger);
    }
    if (besin == "K") {
      return K(deger);
    }
    if (besin == "N") {
      return N(deger);
    }
    if (besin == "P") {
      return P(deger);
    }
    if (besin == "Ca") {
      return Ca(deger);
    }
    if (besin == "Mg") {
      return Mg(deger);
    }
    if (besin == "Mn") {
      return Mn(deger);
    }
    if (besin == "Zn") {
      return Zn(deger);
    }
    if (besin == "Fe") {
      return Fe(deger);
    }
    if (besin == "Cu") {
      return Cu(deger);
    }
    if (besin == "Tuz") {
      return Tuz(deger);
    }
    if (besin == "Kireç") {
      return Kirec(deger);
    }
    if (besin == "Tekstür") {
      return Tekstur(deger);
    }
    return 'gecersiz';
  }

  String PH(double deger) {
    String PH_analizi = "";
    if (deger < 4.5)
      PH_analizi = 'Kuvvetli Asit Alkali';
    else if (deger >= 4.5 && deger < 5.5)
      PH_analizi = 'Orta Asit';
    else if (deger >= 5.5 && deger < 6.5)
      PH_analizi = 'Hafif Asit';
    else if (deger >= 6.5 && deger < 7.5)
      PH_analizi = 'Nötr';
    else if (deger >= 7.5 && deger < 8.5)
      PH_analizi = 'Hafif Alkali';
    else
      PH_analizi = 'Kuvvetli';
    return PH_analizi;
  }

  String K(double deger) {
    String K_analizi = "";
    if (deger < 50)
      K_analizi = 'Çok Az';
    else if (deger >= 50 && deger < 140)
      K_analizi = 'Az';
    else if (deger >= 140 && deger < 370)
      K_analizi = 'Yeterli';
    else if (deger >= 370 && deger < 1000)
      K_analizi = 'Fazla';
    else
      K_analizi = 'Çok Fazla';
    return K_analizi;
  }

  String N(double deger) {
    String N_analizi = "";
    if (deger < 0.045)
      N_analizi = 'Çok Az';
    else if (deger >= 0.045 && deger < 0.090)
      N_analizi = 'Az';
    else if (deger >= 0.090 && deger < 0.170)
      N_analizi = 'Yeterli';
    else if (deger >= 0.170 && deger < 0.320)
      N_analizi = 'Fazla';
    else
      N_analizi = 'Çok Fazla';
    return N_analizi;
  }

  String P(double deger) {
    String P_analizi = "";
    if (deger < 2.5)
      P_analizi = 'Çok Az';
    else if (deger >= 2.5 && deger < 8.0)
      P_analizi = 'Az';
    else if (deger >= 8.0 && deger < 25.0)
      P_analizi = 'Yeterli';
    else if (deger >= 25.0 && deger < 80.0)
      P_analizi = 'Fazla';
    else
      P_analizi = 'Çok Fazla';
    return P_analizi;
  }

  String Ca(double deger) {
    String Ca_analizi = "";
    if (deger >= 0 && deger < 380)
      Ca_analizi = 'Çok Az';
    else if (deger >= 380 && deger < 1150)
      Ca_analizi = 'Az';
    else if (deger >= 1150 && deger < 3500)
      Ca_analizi = 'Yeterli';
    else if (deger >= 3500 && deger < 10000)
      Ca_analizi = 'Fazla';
    else
      Ca_analizi = 'Çok Fazla';
    return Ca_analizi;
  }

  String Mg(double deger) {
    String Mg_analizi = "";
    if (deger < 50)
      Mg_analizi = 'Çok Az';
    else if (deger >= 50 && deger < 140)
      Mg_analizi = 'Az';
    else if (deger >= 140 && deger < 370)
      Mg_analizi = 'Yeterli';
    else if (deger >= 370 && deger < 1000)
      Mg_analizi = 'Fazla';
    else
      Mg_analizi = 'Çok Fazla';
    return Mg_analizi;
  }

  String Mn(double deger) {
    String Mn_analizi = "";
    if (deger < 4)
      Mn_analizi = 'Çok Az';
    else if (deger >= 4 && deger < 14)
      Mn_analizi = 'Az';
    else if (deger >= 14 && deger < 50)
      Mn_analizi = 'Yeterli';
    else if (deger >= 50 && deger < 170)
      Mn_analizi = 'Fazla';
    else
      Mn_analizi = 'Çok Fazla';
    return Mn_analizi;
  }

  String Zn(double deger) {
    String Zn_analizi = "";
    if (deger < 0.2)
      Zn_analizi = 'Çok Az';
    else if (deger >= 0.2 && deger < 0.7)
      Zn_analizi = 'Az';
    else if (deger >= 0.7 && deger < 2.4)
      Zn_analizi = 'Yeterli';
    else if (deger >= 2.4 && deger < 8.0)
      Zn_analizi = 'Fazla';
    else
      Zn_analizi = 'Çok Fazla';
    return Zn_analizi;
  }

  String Fe(double deger) {
    String Fe_analizi = "";
    if (deger < 0.2)
      Fe_analizi = 'Az';
    else if (deger >= 0.2 && deger < 4.5)
      Fe_analizi = 'Orta';
    else
      Fe_analizi = 'Fazla';
    return Fe_analizi;
  }

  String Cu(double deger) {
    String Cu_analizi = "";
    if (deger <= 0.2)
      Cu_analizi = 'Yetersiz';
    else
      Cu_analizi = 'Yeterli';
    return Cu_analizi;
  }

  String Tuz(double deger) {
    String Tuz_analizi = "";
    if (deger <= 0.0 && deger > 0.015)
      Tuz_analizi = 'Tuzsuz';
    else if (deger >= 0.015 && deger < 0.35)
      Tuz_analizi = 'Hafif Tuzlu';
    else if (deger >= 0.35 && deger < 0.65)
      Tuz_analizi = 'Orta Tuzlu';
    else
      Tuz_analizi = 'Çok Tuzlu';
    return Tuz_analizi;
  }

  String Kirec(double deger) {
    String Kirec_analizi = "";
    if (deger <= 0 && deger > 2)
      Kirec_analizi = 'Kireçsiz Kireçli';
    else if (deger >= 2 && deger < 4)
      Kirec_analizi = 'Az Kireçli';
    else if (deger >= 4 && deger < 8)
      Kirec_analizi = 'Orta Kireçli';
    else if (deger >= 8 && deger < 15)
      Kirec_analizi = 'Kireçli';
    else if (deger >= 15 && deger < 50)
      Kirec_analizi = 'Çok Kireçli';
    else
      Kirec_analizi = 'Çok Fazla';
    return Kirec_analizi;
  }

  String Tekstur(double deger) {
    String Tekstur_analizi = "";
    if (deger <= 0 && deger < 30)
      Tekstur_analizi = 'Kum';
    else if (deger >= 30 && deger < 50)
      Tekstur_analizi = 'Tın';
    else if (deger >= 50 && deger < 70)
      Tekstur_analizi = 'Killi Tın';
    else if (deger >= 70 && deger < 110)
      Tekstur_analizi = 'Kil';
    else
      Tekstur_analizi = 'Ağır Kill';
    return Tekstur_analizi;
  }
}
