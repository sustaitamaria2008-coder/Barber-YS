import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';

import '../models/work_model.dart';

class WorkProvider extends ChangeNotifier {
  List<WorkModel> _works = [];

  List<WorkModel> get works => _works;

  WorkProvider() {
    loadWorks();
  }

  Future<void> addWork(WorkModel work) async {
    _works.add(work);

    await saveWorks();

    notifyListeners();
  }

  Future<void> removeWork(int index) async {
    _works.removeAt(index);

    await saveWorks();

    notifyListeners();
  }

  Future<void> saveWorks() async {
    final prefs = await SharedPreferences.getInstance();

    List<String> worksJson = _works
        .map((work) => jsonEncode(work.toMap()))
        .toList();

    await prefs.setStringList('works', worksJson);
  }

  Future<void> loadWorks() async {
    final prefs = await SharedPreferences.getInstance();

    final worksJson = prefs.getStringList('works');

    if (worksJson != null) {
      _works = worksJson
          .map((item) => WorkModel.fromMap(jsonDecode(item)))
          .toList();

      notifyListeners();
    }
  }
}
