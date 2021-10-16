import 'package:todo/Locator.dart';
import 'package:todo/core/models/Todo.dart';
import 'package:todo/core/pagesAndViewModels/base/BaseModel.dart';
import 'package:todo/core/services/TodoService.dart';

class TodoModel extends BaseModel{

  TodoService _todoService = locator<TodoService>();



  List<Todo> get todos => _todoService.todos;
  set todos(List<Todo> value){
    _todoService.todos = value;
  }

  bool getTodosCompleted(int index) {
    return todos[index].completed ?? false;
  }

  void setTodosCompleted(int index, bool value) {
    todos[index].completed = value;
    notifyListeners();
  }


}