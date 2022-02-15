import 'package:ciftci_destek_mobil/themes/main_colors.dart';
import 'package:flutter/material.dart';

class GubreFiyatlari extends StatefulWidget {
  const GubreFiyatlari({Key? key}) : super(key: key);

  @override
  _GubreFiyatlariState createState() => _GubreFiyatlariState();
}

class _GubreFiyatlariState extends State<GubreFiyatlari> {
  @override
  Widget build(BuildContext context) {
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
      body: Padding(
        padding: const EdgeInsets.all(8.0),
        child: Column(
          children: [
            mesajAlici(),
            SizedBox(
              height: 25,
            ),
            mesajGonderici(),
          ],
        ),
      ),
    );
  }

  Widget mesajAlici() {
    return Row(
      mainAxisAlignment: MainAxisAlignment.start,
      crossAxisAlignment: CrossAxisAlignment.center,
      children: <Widget>[

        Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: <Widget>[
            Text(
              "Furkan Ayyıldız",
              style: Theme.of(context).textTheme.caption,
            ),
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
                  Text("Uzmanın Gonderdiği Mesaj  sadasdsdsad"),
                  Text(
                    "22.15",
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

  Widget mesajGonderici() {
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
              decoration: BoxDecoration(
                color: Colors.lightGreenAccent,
                borderRadius: BorderRadius.only(
                  topLeft: Radius.circular(25),
                  bottomLeft: Radius.circular(25),
                  bottomRight: Radius.circular(25),
                ),
              ),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text("Uzmanın Gonderdiği Mesaj"),
                  Text(
                    "22.15",
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
}
