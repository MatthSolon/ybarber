class ServiceModel {
  String id;
  String nome;
  double preco;
  String tempo;
  

  ServiceModel({
    required this.id,
    required this.nome,
    required this.preco,
    required this.tempo,
    
  });

  factory ServiceModel.fromMap(Map<String, dynamic> data, String documentId) {
    return ServiceModel(
      id: documentId,
      nome: data['nome'],
      preco: data['preco'],
      tempo: data['tempo'],
      
    );
  }

  Map<String, dynamic> toMap() {
    return {
      'nome': nome,
      'preco': preco,
      'tempo': tempo,
      
    };
  }
}
