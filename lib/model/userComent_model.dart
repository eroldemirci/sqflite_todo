class UserComent {
  int? id;
  String? name;
  String? lastname;
  String? description;
  bool? active;

  UserComent(
      {this.id, this.name, this.lastname, this.description, this.active});

  factory UserComent.fromMap(Map<String, dynamic> json) => UserComent(
        id: json['id'],
        name: json['name'],
        lastname: json['lastname'],
        description: json['description'],
        active: json['active'],
      );

  Map<String, dynamic> toJson() => {
        'id': id,
        'name': name,
        'lastname': lastname,
        'description': description,
        'active': active,
      };
}
