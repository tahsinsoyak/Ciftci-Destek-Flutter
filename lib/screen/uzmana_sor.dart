import 'package:ciftci_destek_mobil/models/app_user.dart';
import 'package:ciftci_destek_mobil/models/firestore_db_services.dart';
import 'package:ciftci_destek_mobil/screen/mesajlasma.dart';
import 'package:ciftci_destek_mobil/themes/main_colors.dart';
import 'package:flutter/material.dart';

class UzmanaSor extends StatefulWidget {
  AppUser? appUser;
  UzmanaSor({this.appUser , Key? key}) : super(key: key);

  @override
  State<UzmanaSor> createState() => _UzmanaSorState();
}

class _UzmanaSorState extends State<UzmanaSor> {
  FirestoreDbServices firestoreDbServices = FirestoreDbServices();

  @override
  Widget build(BuildContext context) {
    print(widget.appUser!.eMail);
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
              onPressed: () async {}, icon: const Icon(Icons.switch_left_sharp))
        ],
      ),
      body: Column(
        mainAxisAlignment: MainAxisAlignment.start,
        children: [
        UyariWidget(),
        Expanded(child: KullanicilariGetir())
      ],),
    );
  }
  Widget UyariWidget() {
    return Center(child:  Text("Lüften mesajlaşmak istediğiniz uzmanı seçiniz",style: TextStyle(color: Colors.blueGrey.shade300),),);
  }

  Widget KullanicilariGetir(){
    return FutureBuilder<List<AppUser>>(
        future: firestoreDbServices.TumKullanicilariGetir(),
        builder: (context, Veri) {
          if (Veri.hasData) {
            var tumKullaniclar = Veri.data;

            if (tumKullaniclar!.length > 0) {
              return ListView.builder(
                itemCount: tumKullaniclar.length,
                itemBuilder: (context, index) {
                  return KullanicilariListele(tumKullaniclar[index]);
                },
              );
            } else {
              return Center(
                child: Text("Kayıtlı Uzman Bulunamadı"),
              );
            }
          } else {
            return Center(child: CircularProgressIndicator());
          }
        },
      );
  }

  Widget KullanicilariListele(AppUser GelenKullanici) {
    return GestureDetector(
      child: ListTile(
        leading: IconButton(
          icon: icongetir(GelenKullanici),
          onPressed: () { },
        ),
        title: Text(GelenKullanici.adSoyad.toString() , style: TextStyle(fontWeight: FontWeight.bold, fontSize: 16),),
        subtitle: Row(
          children: [
            Icon(Icons.star,color: Colors.yellowAccent.shade700,),
            Icon(Icons.star,color: Colors.yellowAccent.shade700),
            Icon(Icons.star_half_outlined,color: Colors.yellowAccent.shade700)
          ],
        ),
        trailing: Icon(Icons.message_outlined,size: 30,color: Colors.blue.shade200,),
      ),
      onTap: (){
        //SEÇİLEN UZMAN İLE MESAJLAŞILACAK
        Navigator.push(context, MaterialPageRoute(builder: (context)=>Mesajlasma(appUser: widget.appUser , uzmanUser: GelenKullanici )));
      },
    );
  }

  Widget icongetir( AppUser gelenKullanici) {

    if(gelenKullanici.uzmanMi==true){
      return Image.asset('lib/assets/u.png');
    }
    else{
      return Image.asset('lib/assets/c.png');
    }


  }


}
