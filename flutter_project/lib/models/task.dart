import 'dart:convert'; // <-- Add this import to use json

class Task {
  final int id;
  final String title;
  final String description;

  Task({
    required this.id,
    required this.title,
    required this.description,
  });

  // Factory constructor to create a Task from a map (for parsing API response)
  factory Task.fromMap(Map<String, dynamic> map) {
    return Task(
      id: map['id'],
      title: map['title'],
      description: map['description'],
    );
  }

  // Method to convert the Task into a map (for converting to JSON when sending data to the API)
  Map<String, dynamic> toMap() {
    return {
      'id': id,
      'title': title,
      'description': description,
    };
  }

  // Method to convert the Task into JSON string (useful when sending the task data)
  String toJson() {
    return json.encode(toMap()); // This will now work because json is imported
  }
}
