import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:todo/core/models/Todo.dart';
import 'package:todo/core/pageDecorators/PageBackGround.dart';
import 'package:todo/core/pageDecorators/PageScaffold.dart';
import 'package:todo/core/pagesAndViewModels/base/BaseView.dart';
import 'package:todo/core/pagesAndViewModels/home/HomeModel.dart';
import 'package:todo/core/pagesAndViewModels/todo/TodoModel.dart';
import 'package:todo/core/shared/SharedUi.dart';
import 'package:todo/custom_packages/CText.dart';
import 'package:todo/enum/Enums.dart';



class TodoPage extends StatelessWidget {

  final int index;
  final Todo todo;

  TodoPage({required this.index, required this.todo});

  @override
  Widget build(BuildContext context) {
    return BaseView<TodoModel>(

      builder:(_, model, __) =>
          PageScaffold(
            pageTitle: "Todos",
            child: PageBackGround(
              child: Selector(
                selector: (_, TodoModel model)=> model.getTodosCompleted(index),

                builder: (_, bool value, child){

                  Color gr1 = value ? Colors.blue.shade400 : Colors.lightGreen.shade200;
                  Color gr2 = value ? Colors.blue.shade300 : Colors.blue.shade200;

                  return Padding(
                    padding: const EdgeInsets.all(10.0),
                    child: Column(
                      children: [
                        Spacer(),
                        Hero(
                          tag: "heroPanel$index",
                          flightShuttleBuilder: SharedUi.heroFlightShuttle,
                          child: Container(
                            padding: EdgeInsets.all(30),

                            decoration: BoxDecoration(
                                border: Border.all(color: Colors.grey.shade50),
                                borderRadius: BorderRadius.circular(20),
                                gradient: LinearGradient(
                                    colors: [
                                      gr1,
                                      gr2,
                                    ]

                                )
                            ),

                            height: MediaQuery.of(context).size.height * .6,
                            width: double.infinity,
                            child: child,

                          ),
                        ),

                        SizedBox(height: 20,),
                        Container(
                            padding: EdgeInsets.all(30),

                            decoration: BoxDecoration(
                                border: Border.all(color: Colors.grey.shade50),
                                borderRadius: BorderRadius.circular(20),
                                gradient: LinearGradient(
                                    colors: [
                                      Colors.lightGreen.shade200,
                                      Colors.lightBlue.shade300,
                                    ]

                                )
                            ),

                            height: MediaQuery.of(context).size.height * .15,
                            child: SharedUi.mSwitch(switchValue: value, label: value ?"Completed": "Pending",
                                onSwitchChange: (bool? value){
                                  model.setTodosCompleted(index, value!);
                                }
                            )

                        ),
                        Spacer(),
                      ],
                    ),
                  );

                },

                child: SingleChildScrollView(
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [

                      SizedBox(height: 30,),

                      CText("Description", fontWeight: FontWeight.w500, size: 30, color: SharedUi.getColor(mColor:  mColors.outlier),),
                      SizedBox(height: 10,),
                      CText("${todo.title ?? ""}"),


                    ],
                  ),
                ),

              ),
            ),



          ),
    );
  }
}

class TodoHolder extends StatelessWidget {

  final int index;
  final Todo todo;

  TodoHolder({Key? key,required this.todo, required this.index}) : super(key: key);

  @override
  Widget build(BuildContext context) {

    late HomeModel homeModel;

    return Container(
      padding: EdgeInsets.all(10) ,

      height: 300,
      width: double.infinity,





      child: Selector(

        selector: (_, HomeModel model){
          homeModel = model;
          return model.getTodosCompleted(index);
        },

        builder: (_, bool value, __){

          Color gr1 = value ?  Colors.blue.shade500 : Colors.blue.shade300;
          Color gr2 = value ?  Colors.green.shade500 : Colors.blue.shade400;

          return AnimatedContainer(
            duration: Duration(milliseconds: 700),


            padding: EdgeInsets.all(20),
            decoration: BoxDecoration(

              // color: value? Colors.blue.shade600 : Colors.blue.shade300,
                border: Border.all(color: Colors.grey.shade100),
                borderRadius: BorderRadius.circular(20),

                gradient: LinearGradient(
                    colors: [
                      gr1,
                      gr2
                    ]
                )
            ),

            child:  Column(
              children: [
                Row(
                  children: [

                    Spacer(),

                    Icon(Icons.edit, color: SharedUi.getColor(mColor: mColors.divergent)),
                    SizedBox(width: 20,),
                    Icon(Icons.remove_red_eye_rounded, color: SharedUi.getColor(mColor: mColors.divergent))

                  ],
                ),

                Spacer(),
                Divider(color: SharedUi.getColor(mColor: mColors.light),),
                Spacer(),

                SharedUi.titleValueText("Description", todo.title ?? "",
                    valueMaxLines: 2,
                    mColor: mColors.light),

                SharedUi.mSwitch(switchValue: value, label: value == true ?"Completed": "pending", mColor: value == true ? mColors.divergent:mColors.light, onSwitchChange: (bool? value){
                  homeModel.setTodosCompleted(index, value ?? false);
                }),

              ],
            ),

          );
        },


      ),
    );
  }
}

