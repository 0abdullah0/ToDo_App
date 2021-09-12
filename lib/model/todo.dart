
class Todo{
  late String id;
  late String title;
  late String description;

  Todo(this.title,this.description);

  Todo.fromFirestore(var doc){
    id= doc.id;
    title= doc.data()["title"].toString();
    description=doc.data()["description"].toString();
  }
}