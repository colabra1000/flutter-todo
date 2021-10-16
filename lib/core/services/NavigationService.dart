
import 'package:flutter/material.dart';
import 'package:todo/core/models/Todo.dart';
import 'package:todo/core/pagesAndViewModels/todo/TodoPage.dart';

class NavigationService{

  navigateToTodos(BuildContext context, int index, Todo todo){

    return Navigator.push(context, MaterialPageRoute(
      builder: (context) => TodoPage(index: index, todo: todo,),)
    );

  }


}