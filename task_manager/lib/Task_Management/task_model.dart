// class Task {
//   int id;
//   String title;
//   bool isCompleted;

//   Task({required this.id, required this.title, this.isCompleted = false});

//   Map<String, dynamic> toJson() => {
//     'id': id,
//     'title': title,
//     'isCompleted': isCompleted,
//   };

//   Task.fromJson(Map<String, dynamic> json) 
//     : id = json['id'],
//       title = json['title'],
//       isCompleted = json['isCompleted'];  
// }


class Task {
  int id;
  String name;
  String job;

  Task({required this.id, required this.name, required this.job});

  factory Task.fromJson(Map<String, dynamic> json) {
    return Task(
      id: json['id'],
      name: json['name'],
      job: json['job'],
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'id': id,
      'name': name,
      'job': job,
    };
  }
}
