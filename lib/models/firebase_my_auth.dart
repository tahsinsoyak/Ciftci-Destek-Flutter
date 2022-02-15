import 'package:firebase_core/firebase_core.dart';
import 'package:firebase_auth/firebase_auth.dart';

class FirebaseMyAuth {
  //GİRİŞ İŞLEMLERİ
  Future<List<dynamic>> Login(String eMail, String password) async {
    List<dynamic> islemSonucu = [];
    ///Başarılı ise => Index 0 : userCredential
    ///Başarısız ve hatalı ise => Index 0 : Hata Mesajı 
    try {
      UserCredential userCredential = await FirebaseAuth.instance
          .signInWithEmailAndPassword(email: eMail, password: password);

      if (userCredential != Null) {
        print("UID: ${userCredential.user?.uid}");
        islemSonucu.add(userCredential);
      } else{
        islemSonucu.add("Bir Sorun Oluştu-r01");
      }

      return islemSonucu;
    } on FirebaseAuthException catch (e) {
      if (e.code == 'user-not-found') {
        islemSonucu.add("Kullanıcı adı bulunamadı.");
        //  Fluttertoast.showToast(msg: "Kullanıcı adı bulunamadı.");
      } else if (e.code == 'wrong-password') {
        islemSonucu.add("Hatalı Şifre.");
      } else {
        islemSonucu.add("Bir Sorun Oluştu-${e.toString()}");
      }

      return islemSonucu;
    }
  }

  //KAYIT İŞLEMLERİ
  Future<dynamic> SignUp(String eMail, String password) async {
      dynamic islemSonucu;
    try {
      UserCredential userCredential = await FirebaseAuth.instance
          .createUserWithEmailAndPassword(email: eMail, password: password);
      

      if (userCredential != Null){
        islemSonucu =userCredential;
      }        
      else{
        islemSonucu = "Bir Sorun Oluştu-r01";
      }
    } on FirebaseAuthException catch (e) {
      if (e.code == 'weak-password') {
        islemSonucu = 'Zayıf Şifre...';
      } else if (e.code == 'email-already-in-use') {
        islemSonucu= 'Bu eposta zaten kullanılıyor...';
      } else {
        islemSonucu= "Bir Sorun Oluştu-${e.toString()}";
      }
    } catch (e) {
      islemSonucu= "Bir Hata Oluştu-${e.toString()}";
    }
    return islemSonucu;
  }
  
}
