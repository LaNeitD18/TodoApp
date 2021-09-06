final String columnId = 'id';
final String columnTitle = 'title';
final String columnComplete = 'complete';
final String columnTime = 'estimatedTime';

class Task {
  int? id; // auto increment
  late String title;
  late bool complete;
  late int estimatedTime;

  Map<String, Object?> toMap() {
    var map = <String, Object?>{
      columnTitle: title,
      columnComplete: complete == true ? 1 : 0,
      columnTime: estimatedTime
    };
    if (id != null) {
      map[columnId] = id;
    }
    return map;
  }

  Task();

  Task.fromInput(String title, int time) {
    this.title = title;
    this.estimatedTime = time;
    this.complete = false;
  }

  Task.fromMap(Map<String, Object?> map) {
    id = map[columnId] as int;
    title = map[columnTitle] as String;
    complete = map[columnComplete] == 1;
    estimatedTime = map[columnTime] as int;
  }
}
