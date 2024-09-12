import 'package:cloud_firestore/cloud_firestore.dart';

class UsersController {
  final CollectionReference usuarioRef = FirebaseFirestore.instance.collection('usuarios');

  // Add cliente
  Future<void> adicionarUsuario(Map<String, dynamic> usuarioData) async {
    try {
      await usuarioRef.add(usuarioData);
    } catch (e) {
      print('Erro ao adicionar usuario: $e');
    }
  }

  // Att usuario
  Future<void> atualizarUsuario(String usuariosId, Map<String, dynamic> usuarioData) async {
    try {
      await usuarioRef.doc(usuariosId).update(usuarioData);
    } catch (e) {
      print('Erro ao atualizar usuario: $e');
    }
  }

  // Del usuarios
  Future<void> deletarUsuario(String usuariosId) async {
    try {
      await usuarioRef.doc(usuariosId).delete();
    } catch (e) {
      print('Erro ao deletar usuario: $e');
    }
  }

  // Buscar todos os usuarios
  Stream<List<Map<String, dynamic>>> listarUsuarios() {
    return usuarioRef.snapshots().map((querySnapshot) {
      return querySnapshot.docs.map((doc) => doc.data() as Map<String, dynamic>).toList();
    });
  }

  // Buscar usuario específico
  Future<Map<String, dynamic>?> buscarUsuario(String usuariosId) async {
    try {
      DocumentSnapshot doc = await usuarioRef.doc(usuariosId).get();
      return doc.data() as Map<String, dynamic>?;
    } catch (e) {
      print('Erro ao buscar Usuario: $e');
      return null;
    }
  }
}
