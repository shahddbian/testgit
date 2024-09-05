class Myuser {
  static const String collectionName = 'users';

  String id;
  String name;

  String email;

  Myuser({required this.id, required this.email, required this.name});

  Myuser.Fromfirestore(Map<String, dynamic> data)
      : this(
            id: data['id'] as String, name: data['name'], email: data['email']);

  Map<String, dynamic> tofiesStore() {
    return {'id': id, 'email': email, 'name': name};
  }
}
