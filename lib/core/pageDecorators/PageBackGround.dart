import 'package:flutter/material.dart';

class PageBackGround extends StatelessWidget {

  final Widget child;

  const PageBackGround({Key? key, required this.child}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Center( 

        child: Container(
          height: double.infinity,
          width: double.infinity,
          decoration: BoxDecoration(
            gradient: LinearGradient(

              begin: Alignment.topCenter,

              colors: [
                Colors.grey.shade50,
                Colors.green.shade100,
              ]
            )
          ),

           child: child,
        ),
      );
  }
}
