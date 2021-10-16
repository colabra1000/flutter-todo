import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:todo/core/pagesAndViewModels/base/BaseModel.dart';
import 'package:todo/locator.dart';

class BaseView<T extends BaseModel> extends StatefulWidget {

  final Widget Function(BuildContext context, T model, Widget? child,) builder;
  final Function(T)? onModelReady;


  BaseView({Key? key, required this.builder, this.onModelReady}) : super(key: key);

  @override
  _BaseViewState<T> createState() => _BaseViewState<T>();
}

class _BaseViewState<T extends BaseModel> extends State<BaseView<T>> {

  T model = locator<T>();

  @override
  void initState() {
    if(widget.onModelReady != null) {
      widget.onModelReady!(model);
    }
    super.initState();
  }



  @override
  Widget build(BuildContext context) {
    return ChangeNotifierProvider<T>(

        create: (context) => model,
        builder: (context, _)=> widget.builder(context, model, null)

    );
  }
}
