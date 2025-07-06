import 'package:flutter/material.dart';
import 'package:therapify/data/models/DoctorModel.dart';
import 'package:therapify/data/services/doctor_service.dart';

class DoctorListViewModel extends ChangeNotifier {
  final DoctorService _doctorService = DoctorService();

  List<DoctorModel> _allDoctors = [];
  List<DoctorModel> _filteredDoctors = [];
  bool _isLoading = true;

  List<DoctorModel> get doctors => _filteredDoctors;
  bool get isLoading => _isLoading;

  DoctorListViewModel() {
    _listenToDoctors();
  }

  void _listenToDoctors() {
    _doctorService.streamAllDoctors().listen((doctorList) {
      _allDoctors = doctorList;
      _filteredDoctors = doctorList;
      _isLoading = false;
      notifyListeners();
    });
  }

  void searchDoctors(String query) {
    if (query.isEmpty) {
      _filteredDoctors = _allDoctors;
    } else {
      _filteredDoctors = _allDoctors
          .where((doc) => doc.name.toLowerCase().contains(query.toLowerCase()))
          .toList();
    }
    notifyListeners();
  }
}
