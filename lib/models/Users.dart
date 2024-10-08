class UsersModel {
  String id;
  String email;         
  String nome;
  String telefone;
  String tipo;           
  bool isAvailable;

  UsersModel({
    required this.id,
    required this.email,
    required this.nome,
    required this.telefone,
    required this.tipo,
    required this.isAvailable,
  });


  factory UsersModel.fromMap(Map<String, dynamic> data, String documentId) {
    return UsersModel(
      id: documentId,
      email: data['email'],
      nome: data['nome'],
      telefone: data['telefone'] ,
      tipo: data['tipo'],
      isAvailable: data['disponivel'],
    );
  }

  Map<String, dynamic> toMap() {
    return {
      'email': email,
      'nome': nome,
      'telefone': telefone,
      'tipo': tipo,
      'disponivel': isAvailable,
    };
  }
}
