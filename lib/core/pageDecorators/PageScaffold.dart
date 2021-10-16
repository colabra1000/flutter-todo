import 'package:flutter/material.dart';
import 'package:todo/custom_packages/CText.dart';

class PageScaffold extends StatelessWidget {
  final Widget? leading;
  final String? pageTitle;
  final Widget child;

  const PageScaffold({Key? key, this.leading, this.pageTitle, required this.child}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(leading: leading,
        title: CText(pageTitle ?? ""),
      ),

      body: Column(
        children: [
          Expanded(child: child),

        ],
      ),

    );
  }
}
