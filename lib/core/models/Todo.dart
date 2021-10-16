
class Todo{

  int? id;
  String? title;
  bool? completed;

  Todo();

  Todo.fromJson(Map json){

    id = json["id"];
    title = json["title"];
    completed = json["completed"];

  }

  List<Todo> getList(List jsonList) {

    return jsonList.map((element) {
        return Todo.fromJson(element);
    }).toList();
  }

}