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

  void _listenToDoctors() async {
    _isLoading = true;
    notifyListeners();
    try {
      _allDoctors = await _doctorService.streamAllDoctors();
      _filteredDoctors = _allDoctors; // Initially show all doctors
    } catch (e) {
      _isLoading = false;
      notifyListeners();
      // Handle error, e.g., show a snackbar or log the error
      print('Error fetching doctors: $e');
    } finally {
      _isLoading = false;
      notifyListeners();
    }
    ;
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
