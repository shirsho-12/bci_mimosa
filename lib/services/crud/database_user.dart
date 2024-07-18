import 'package:flutter/material.dart';

import 'crud_constants.dart';

@immutable
class DatabaseUser {
  final String id;
  final int age;

  const DatabaseUser({
    required this.id,
    required this.age,
  });

  DatabaseUser.fromRow(Map<String, Object?> map)
      : id = map[participantIdColumn] as String,
        age = map[participantAge] as int;

  @override
  String toString() => "Person, ID = $id, age = $age";

  @override
  bool operator ==(covariant DatabaseUser other) => id == other.id;

  @override
  int get hashCode => id.hashCode;
}
