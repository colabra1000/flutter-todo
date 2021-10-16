import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:todo/core/models/Todo.dart';
import 'package:todo/core/pageDecorators/AdderPanel.dart';
import 'package:todo/core/pageDecorators/PageBackGround.dart';
import 'package:todo/core/pageDecorators/PageScaffold.dart';
import 'package:todo/core/pagesAndViewModels/base/BaseView.dart';
import 'package:todo/core/pagesAndViewModels/home/HomeModel.dart';
import 'package:todo/core/shared/SharedUi.dart';
import 'package:todo/custom_packages/CText.dart';
import 'package:todo/custom_packages/cButton/CButton.dart';
import 'package:todo/custom_packages/cModal/CModal.dart';
import 'package:todo/enum/Enums.dart';



class HomePage extends StatefulWidget {
  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {



  @override
  Widget build(BuildContext context) {
    return BaseView<HomeModel>(

      onModelReady: (model) async {
       model.loadTodos(()=>setState((){}));
      },

      builder:(_, model, __) =>
        PageScaffold(
          pageTitle: "Home",
          child: CModal(

            builder: (_, CModalState state){
              print(state);
              if(state == CModalState.custom1){
                return AdderPanel(
                    displayAdderPanel: model.displayAdderPanel,
                    cModalController: model.cModalController,
                    onDismissCompleter: model.onDismissCompleter,
                    child: AddTodoPanel(model: model),
                );
              }
            },

            controller: model.cModalController,

            child: PageBackGround(
              child:
              model.todos.length == 0? Column(
                children: [
                  Spacer(),
                  CButton(

                    child: CText("reload"),
                    onTapHandler: (){
                      model.loadTodos(()=>setState((){}));
                    },
                  ),
                  Spacer(),
                ],
              ) :
              Stack(
                children: [


                  Align(
                    alignment: Alignment.center,
                    child:
                    AnimatedList(

                      key: model.listKey,

                      itemBuilder: (BuildContext context, int index, animation) {

                        return SlideTransition(
                          position: Tween<Offset>(
                            begin: const Offset(-1, 0),
                            end: Offset(0, 0),
                          ).animate(animation),
                          child:
                          Column(
                            children: [
                              Selector(
                                selector: (_, HomeModel model) => model.todos[index],
                                  builder:(_, Todo val, __) =>TodoHolder(index: index, todo: model.todos[index],)

                              ),

                              if(index == model.todos.length-1)
                                SharedUi.vFooterSpace()
                            ],
                          ),
                        );






                      },

                      initialItemCount: model.todos.length,
                    ),
                  ),

                  Align(
                    alignment: Alignment.bottomCenter,
                    child: Column(
                      mainAxisAlignment: MainAxisAlignment.end,
                      children: [



                        Padding(
                          padding: const EdgeInsets.all(8.0),
                          child: Row(

                            mainAxisAlignment: MainAxisAlignment.center,

                            children: [



                              SharedUi.outlierButton([Padding(
                                padding: const EdgeInsets.all(8.0),
                                child: Icon(Icons.add, color: Colors.grey.shade50,),
                              ), "Add New Todo", SizedBox(width: 15,)],
                                  radius: 50,
                                  onTap: (){
                                    model.openAdder();
                                  }
                              )
                            ],
                          ),
                        ),

                      ],
                    ),
                  ),
                ],
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

          return Hero(

            tag: "heroPanel$index",

            flightShuttleBuilder: SharedUi.heroFlightShuttle,

            child: AnimatedContainer(
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

                      GestureDetector(
                          onTap: (){
                            homeModel.editTodo(todo, index);
                          },
                          child: Icon(Icons.edit, color: SharedUi.getColor(mColor: mColors.divergent))),
                      SizedBox(width: 20,),
                      GestureDetector(

                          child: Icon(Icons.remove_red_eye_rounded, color: SharedUi.getColor(mColor: mColors.divergent)),

                          onTap: (){
                            homeModel.navigateToTodos(context, index, todo);
                          },


                      )

                    ],
                  ),

                  Spacer(),
                  Divider(color: SharedUi.getColor(mColor: mColors.light),),
                  Spacer(),

                  Row(
                    children: [
                      Flexible(
                        child: SharedUi.titleValueText("Description", todo.title ?? "",
                            valueMaxLines: 2,
                            mColor: mColors.light),
                      ),
                    ],
                  ),

                  Row(
                    children: [
                      Expanded(
                        child: SharedUi.mSwitch(switchValue: value, label: value == true ?"Completed": "pending", mColor: value == true ? mColors.divergent:mColors.light, onSwitchChange: (bool? value){
                          homeModel.setTodosCompleted(index, value ?? false);
                        }),
                      ),
                      
                      // Spacer(),
                      
                      SharedUi.cancelButtonSlim([Icon(Icons.remove_circle_outline_sharp, color: Colors.grey.shade50,), SizedBox(width: 10,), "remove", SizedBox(width: 10,),],
                        onTap: (){
                            homeModel.removeTodo(index, this);
                        }
                      )
                      
                    ],
                  ),

                ],
              ),

            ),
          );
        },


      ),
    );
  }
}



class AddTodoPanel extends StatelessWidget {

  final HomeModel model;

  const AddTodoPanel({Key? key, required this.model,}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.all(20.0),
      child: SingleChildScrollView(
        child: Column(
          children: [

            SharedUi.headerText( model.editIndex != null ? "Edit Todo" : "Add Todo"),

            SharedUi.vHeaderSpace(),

            SharedUi.mTextField(model.todoInputController, "What do you want todo?", "Enter Text..",
                maxLine: 6
            ),

            Row(
              children: [
                SharedUi.successButton([Icon(Icons.add, color: Colors.grey.shade50,), model.editIndex == null ? "Add" : "Save", SizedBox(width: 50,),],
                    onTap: () async {

                      await model.closeAdder();
                      model.addTodo(model.editIndex);
                      model.editIndex = null;
                      model.editCompleted = false;
                    }
                ),

                Spacer(),

                SharedUi.cancelButton([Icon(Icons.exit_to_app_sharp, color: Colors.grey.shade50,), "Cancel", SizedBox(width: 50,),],
                    onTap: () async {


                      await model.closeAdder();
                      model.editIndex = null;
                      model.editCompleted = false;

                    }
                )

              ],
            )
          ],
        ),
      ),
    );
  }
}


