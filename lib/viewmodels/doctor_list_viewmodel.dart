import 'package:flutter/material.dart';
import 'package:therapify/data/models/DoctorModel.dart';
import 'package:therapify/data/services/doctor_service.dart';

class DoctorListViewModel extends ChangeNotifier {
  final DoctorService _doctorService = DoctorService();

  List<DoctorModel> _allDoctors = [];
  List<DoctorModel> _filteredDoctors = [];
  bool _isLoading = false;

  // current filters
  String _searchQuery = '';

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

  /// Called by the search field `onChanged`
  void searchDoctors(String query) {
    _searchQuery = query;
    _applyFilters();
  }

  void _applyFilters() {
    var list = _allDoctors;



    // 2) filter by name search
    if (_searchQuery.isNotEmpty) {
      list = list.where((doc) {
        return doc.name.toLowerCase().contains(_searchQuery.toLowerCase());
      }).toList();
    }

    _filteredDoctors = list;
    notifyListeners();
  }
}
