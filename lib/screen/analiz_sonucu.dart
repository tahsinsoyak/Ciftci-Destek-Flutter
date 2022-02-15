import 'package:ciftci_destek_mobil/models/app_user.dart';
import 'package:ciftci_destek_mobil/screen/main_page.dart';
import 'package:ciftci_destek_mobil/themes/main_colors.dart';
import 'package:flutter/material.dart';

class AnalizSonucu extends StatefulWidget {
  AppUser? appUser;
  List<String>? besin_analiz_sonucu;
  List<String>? secilen_besin;
  AnalizSonucu(
      {this.appUser, this.besin_analiz_sonucu, this.secilen_besin, Key? key})
      : super(key: key);

  @override
  State<AnalizSonucu> createState() => _AnalizSonucuState();
}

class _AnalizSonucuState extends State<AnalizSonucu> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.white,
        foregroundColor: MainColors.Blue2,
        elevation: 0,
        centerTitle: true,
        title: Text('Analiz Sonucu'),
        actions: [
          IconButton(
              onPressed: () async {}, icon: const Icon(Icons.switch_left_sharp))
        ],
      ),
        body: Container(
          child: Column(
            children: [
              Expanded(
                child: ListView.builder(
                  itemCount: widget.secilen_besin!.length,
                  itemBuilder: (context, index) {
                    return Padding(
                      padding: const EdgeInsets.all(16.0),
                      child: Text(
                        widget.secilen_besin![index] +
                            ' degeri: ' +
                            widget.besin_analiz_sonucu![index],
                      ),
                    );
                  },
                ),
              ),
              ElevatedButton(
                style: ButtonStyle(
                    backgroundColor:
                        MaterialStateProperty.all(MainColors.Blue2)),
                onPressed: () {
                  Navigator.of(context).pop();
                },
                child: Text('Geri don'),
              ),
              ElevatedButton(
                  style: ButtonStyle(
                      backgroundColor:
                          MaterialStateProperty.all(MainColors.Blue2)),
                  onPressed: () {
                    Navigator.push(
                        context,
                        MaterialPageRoute(
                            builder: (context) =>
                                MainPaage(appUser: widget.appUser)));
                  },
                  child: Text('Anasayfa')),
            ],
          ),
        ));
  }
}
