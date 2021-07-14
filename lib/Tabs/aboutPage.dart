import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';

class AboutUs extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Color(0xffdb0b46),
        title: Text("About Us"),
      ),
      body: Padding(
        padding: EdgeInsets.all(40.0),
        child: Column(
          children: <Widget>[
            SvgPicture.asset(
              'assets/stethoscope.svg',
              height: 200,
              width: 400,
            ),
            Text(
                "Plasma Donation is a Plasma & Blood Donation App,which puts the power to save a lives in the palm of your hand. "
                "The main purpose of Plasma Donation App is to create & manage a platform for"
                " all donors of Kurdistan region & remove the recent crisis. Which is the first blood & plasma donation application in kurdistan."
                "it helps you find donor and donate blood by searching for donors and mark yourself as a donor."
                " Developed by Tishik International Students "
                "for graduation project.",
                style: TextStyle(
                    fontSize: 15.0,
                    fontWeight: FontWeight.bold,
                    color: Colors.black,
                    height: 2)),
            ListTile(
                title: Center(
              child: Text(
                "Supervisor: Mr.Mohammad Salim "
                "Developers:"
                "(avin.kakamin@gmail.com ),(payam.mizori22@gmail.com ),(aya.abdullah@gmail.com)"
                "",
                style: TextStyle(
                    fontWeight: FontWeight.bold,
                    fontSize: 11.0,
                    color: Color(0xffc11144),
                    height: 2),
              ),
            ))
          ],
        ),
      ),
    );
  }
}
