import 'package:cloud_firestore/cloud_firestore.dart';

class AgendamentoController {
  final CollectionReference agendamentosRef = FirebaseFirestore.instance.collection('agendamentos');

  // Add agendamento
  Future<void> adicionarAgendamento(Map<String, dynamic> agendamentoData) async {
    try {
      await agendamentosRef.add(agendamentoData);
    } catch (e) {
      print('Erro ao adicionar agendamento: $e');
    }
  }

  // Att agendamento
  Future<void> atualizarAgendamento(String agendamentoId, Map<String, dynamic> agendamentoData) async {
    try {
      await agendamentosRef.doc(agendamentoId).update(agendamentoData);
    } catch (e) {
      print('Erro ao atualizar agendamento: $e');
    }
  }

  // Del agendamento
  Future<void> deletarAgendamento(String agendamentoId) async {
    try {
      await agendamentosRef.doc(agendamentoId).delete();
    } catch (e) {
      print('Erro ao deletar agendamento: $e');
    }
  }

  // Buscar todos os agendamentos
  Stream<List<Map<String, dynamic>>> listarAgendamentos() {
    return agendamentosRef.snapshots().map((querySnapshot) {
      return querySnapshot.docs.map((doc) => doc.data() as Map<String, dynamic>).toList();
    });
  }

  // Buscar agendamento específico
  Future<Map<String, dynamic>?> buscarAgendamento(String agendamentoId) async {
    try {
      DocumentSnapshot doc = await agendamentosRef.doc(agendamentoId).get();
      return doc.data() as Map<String, dynamic>?;
    } catch (e) {
      print('Erro ao buscar agendamento: $e');
      return null;
    }
  }
}
