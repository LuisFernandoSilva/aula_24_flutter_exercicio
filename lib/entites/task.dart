class Task {
  int id;
  String task;
  bool finish;
  Task.empty();

  Task({this.id, this.task, this.finish = false});

  factory Task.ofMap(Map<String, dynamic> map) {
    return Task(
      id: map['id'],
      task: map['task'],
      finish: map['finish'] == 1 ? true : false,
    );
  }

  Map<String, dynamic> forMap() {
    return {
      'id': id,
      'task': task,
      'finish': finish ? 1 : 0,
    };
  }
}
