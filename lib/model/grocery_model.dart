import 'package:flutter/cupertino.dart';

class Grocery {
  final int? id;
  final String? name;
  final String? lastname;
  final String? comment;

  Grocery({this.id, @required this.name, this.lastname, this.comment});

  factory Grocery.fromMap(Map<String, dynamic> json) => Grocery(
        id: json['id'],
        name: json['name'],
        lastname: json['lastname'],
        comment: json['comment'],
      );

  Map<String, dynamic> toMap() => {
        'id': id,
        'name': name,
        'lastname': lastname,
        'comment': comment,
      };
}
