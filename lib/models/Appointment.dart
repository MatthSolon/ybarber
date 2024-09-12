import 'package:cloud_firestore/cloud_firestore.dart';

class AppointmentModel {
  String id;   
  bool isConfirmed;     
  DateTime date;      
  String serviceId;        
  String userId;             
   

  AppointmentModel({
    required this.id,
    required this.isConfirmed,
    required this.date,
    required this.serviceId,
    required this.userId,
  });

  factory AppointmentModel.fromMap(Map<String, dynamic> data, String documentId) {
    return AppointmentModel(
      id: documentId,
      isConfirmed: data['Confirmado'],
      date: (data['data'] as Timestamp).toDate(), 
      serviceId: data['id_servico'],
      userId: data['id_usuario'],
    );
  }

  Map<String, dynamic> toMap() {
    return {
      'Confirmado': isConfirmed,
      'data': date, 
      'id_servico': serviceId,
      'id_usuario': userId,
    };
  }
}



