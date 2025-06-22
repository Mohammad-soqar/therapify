// lib/data/services/registration_service.dart

import 'package:firebase_auth/firebase_auth.dart';
import 'package:cloud_firestore/cloud_firestore.dart';

class RegistrationService {
  final FirebaseAuth _auth = FirebaseAuth.instance;
  final FirebaseFirestore _db = FirebaseFirestore.instance;

  /// Registers a new patient:
  /// 1. Creates a Firebase Auth user
  /// 2. Writes a /users/{uid} profile
  /// 3. Writes a /patients/{uid} detail record
  Future<void> registerNewPatient({
    required String fullName,
    required String phoneNumber,
    required String email,
    required String nationality,
    required String gender,
    required DateTime birthDate,
    required String password,
    required String emergencyContact,
    required String doctorId,
    required String prescriptionId,
    required String gloveId,
  }) async {
    // 1️⃣ Create the Auth user
    final credential = await _auth.createUserWithEmailAndPassword(
      email: email.trim(),
      password: password,
    );
    final uid = credential.user!.uid;

    // 2️⃣ Write the user profile
    await _db.collection('users').doc(uid).set({
      'name': fullName,
      'phoneNumber': phoneNumber,
      'email': email.trim(),
      'country': nationality,
      'gender': gender,
      'dob': birthDate.toIso8601String(),
      'role': 'patient',
    });

    // 3️⃣ Write the patient-specific data
    await _db.collection('patients').doc(uid).set({
      'patientId': uid,
      'emergencyContact': emergencyContact,
      'doctorId': doctorId,
      'prescriptionId': prescriptionId,
      'gloveId': gloveId,
    });
  }
}
