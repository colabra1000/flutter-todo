import 'dart:async';
import 'dart:convert';

import 'package:flutter/cupertino.dart';
import 'package:todo/Locator.dart';
import 'package:todo/core/models/Todo.dart';
import 'package:todo/core/pagesAndViewModels/base/BaseModel.dart';
import 'package:todo/core/pagesAndViewModels/home/HomePage.dart';
import 'package:todo/core/services/ApiFetcher.dart';
import 'package:todo/core/services/ErrorService.dart';
import 'package:todo/core/services/NavigationService.dart';
import 'package:todo/core/services/TodoService.dart';
import 'package:todo/custom_packages/cInputController/CInputController.dart';
import 'package:todo/custom_packages/cModal/CModal.dart';

class HomeModel extends BaseModel {

  NavigationService _navigationService = locator<NavigationService>();
  TodoService _todoService = locator<TodoService>();
  ApiFetcher _api = locator<ApiFetcher>();
  ErrorService _errorService = locator<ErrorService>();




  List<Todo> get todos => _todoService.todos;


  int? editIndex;
  bool? editCompleted;


  set todos(List<Todo> value){
    _todoService.todos = value;
  }

  //controllers
  CModalController cModalController = CModalController();
  ValueNotifier<bool> displayAdderPanel = ValueNotifier(false);
  late Completer onDismissCompleter;
  final GlobalKey<AnimatedListState> listKey = GlobalKey<AnimatedListState>();


  CInputController todoInputController = CInputController();

  late String getTodoError;

  void openAdder() {
    cModalController.changeModalState = CModalStateChanger(state: CModalState.custom1);
    onDismissCompleter = Completer();
  }

  Future closeAdder() async {
    displayAdderPanel.value = false;
    await onDismissCompleter.future;
  }

  bool getTodosCompleted(int index) {

    try{
      return todos[index].completed ?? false;
    }catch(e){
      return false;
    }


  }

  void setTodosCompleted(int index, bool value) {
    todos[index].completed = value;
    notifyListeners();
  }

  Future<bool> fetchTodos(){
    return _api.fetchTodos(
        onSuccess: (result){

          todos = Todo().getList(jsonDecode(result.toString()));

        },
        onError: (e) {
          getTodoError = _errorService.errorMessage(e);
        });
  }

  Future navigateToTodos(BuildContext context, int index, Todo todo) {
    return _navigationService.navigateToTodos(context, index, todo);
  }

  void removeTodo(int index, TodoHolder todoHolder) {

    todos.removeAt(index);

    listKey.currentState!.removeItem(
        index, (_, animation)=> SlideTransition(
              position: Tween<Offset>(
              begin: const Offset(-1, 0),

              end: Offset(0, 0),

      ).animate(animation),
      child: todoHolder,
    ),
        duration: const Duration(milliseconds: 500)
    );



  }

  void addTodo(int? editIndex) {

    Todo todo = Todo();
    todo.title = todoInputController.selectedValue;
    todo.completed = editCompleted;

    //edit
    if(editIndex != null){
      todos[editIndex] = todo;
      notifyListeners();
    }else {
      todos.insert(0, todo);
      listKey.currentState!.insertItem(
          0, duration: const Duration(milliseconds: 500)
      );
      notifyListeners();
    }
  }

  editTodo(Todo todo, int editIndex,) {
    this.editIndex = editIndex;

    openAdder();
    todoInputController.setSelectedValue(todo.title);
    this.editCompleted = todo.completed;
  }

  void loadTodos(Function reload) async{
    cModalController.changeModalState = CModalStateChanger(state: CModalState.loading,);
    if(await fetchTodos()){
      cModalController.changeModalState = CModalStateChanger(state: CModalState.none,);
      reload();
    }else{
      cModalController.changeModalState = CModalStateChanger(state: CModalState.error,
      displayMessage: getTodoError,
    );
    }
  }





}