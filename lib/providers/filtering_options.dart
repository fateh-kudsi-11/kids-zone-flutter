import 'package:flutter/material.dart';

class FilteringManger with ChangeNotifier {
  String _gender = 'boys';
  String _directory = '';
  String _sort = 'newProduct';
  Map<String, String> _filterOutput = {
    'brand': '',
    'color': '',
    'size': '',
    'priceRange': ''
  };

  get gender => _gender;
  get directory => _directory;
  get sort => _sort;
  get filterOutput => _filterOutput;

  setGender(String gender) {
    _gender = gender;
    notifyListeners();
  }

  setDirectory(String directory) {
    _directory = directory;
    notifyListeners();
  }

  setSort(String sort) {
    _sort = sort;
    notifyListeners();
  }

  setFilterOutput(String kind, String value) {
    _filterOutput[kind] = value;
    notifyListeners();
  }

  clearFilterOutput() {
    _filterOutput = {'brand': '', 'color': '', 'size': '', 'priceRange': ''};
    notifyListeners();
  }
}
