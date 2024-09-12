import 'package:cloud_firestore/cloud_firestore.dart';

class ServiceController {
  final CollectionReference servicoRef = FirebaseFirestore.instance.collection('servicos');

  // Add serviço
  Future<void> adicionarServico(Map<String, dynamic> ServicoData) async {
    try {
      await servicoRef.add(ServicoData);
    } catch (e) {
      print('Erro ao adicionar funcionario: $e');
    }
  }

  // Att serviço
  Future<void> atualizarServico(String servicoId, Map<String, dynamic> ServicoData) async {
    try {
      await servicoRef.doc(servicoId).update(ServicoData);
    } catch (e) {
      print('Erro ao atualizar servico: $e');
    }
  }

  // Del funcserviço
  Future<void> deletarServico(String servicoId) async {
    try {
      await servicoRef.doc(servicoId).delete();
    } catch (e) {
      print('Erro ao deletar servico: $e');
    }
  }
 
}
