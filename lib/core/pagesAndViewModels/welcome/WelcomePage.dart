import 'dart:async';

import 'package:flutter/material.dart';
import 'package:todo/core/pageDecorators/PageBackGround.dart';
import 'package:todo/core/pageDecorators/PageScaffold.dart';
import 'package:todo/core/pagesAndViewModels/home/HomePage.dart';
import 'package:todo/custom_packages/CText.dart';

class WelcomePage extends StatefulWidget {
  const WelcomePage({Key? key}) : super(key: key);

  @override
  _WelcomePageState createState() => _WelcomePageState();
}

class _WelcomePageState extends State<WelcomePage> {

  @override
  void initState() {

    Timer(Duration(seconds: 3), (){
      Navigator.of(context).pushAndRemoveUntil(
        MaterialPageRoute(builder:(_)=>HomePage() )
      , (route) => false);
    });

    super.initState();
  }


  @override
  Widget build(BuildContext context) {
    return PageScaffold(
        pageTitle: "Welcome",
        child: PageBackGround(
          child: Container(
            width: double.infinity,
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.center,
              children: [
                Spacer(),
                CText("TODO", color: Colors.blue, size: 40,),
                CText("APPLICATION", color: Colors.red, size: 40,),
                Spacer(),
              ],
            ),
          ),
        ));
  }
}
