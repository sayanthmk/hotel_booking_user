//------------------------------------------------------------fixed------------------------------------------//

class UserEntity {
  String? id;
  final String? email;
  final String? password;

  UserEntity(this.id, {required this.email, required this.password});
}
