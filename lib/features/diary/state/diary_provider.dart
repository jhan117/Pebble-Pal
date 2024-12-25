import 'package:flutter/material.dart';
import 'package:graytalk/features/diary/data/diary_model.dart';
import 'package:graytalk/features/diary/data/diary_repository.dart';

class DiaryProvider extends ChangeNotifier {
  final DiaryRepository _diaryRepository = DiaryRepository();
  List<Diary> _diaries = [];
  DateTime _getDay = DateTime.now();

  List<Diary> get diaries => _diaries;
  DateTime get getDay => _getDay;

  // create
  Future<void> addDiary(Diary diary) async {
    try {
      await _diaryRepository.add(diary);
      _diaries.add(diary);
      notifyListeners();
    } catch (e) {
      throw Exception('Failed to add diary: $e');
    }
  }

  // read
  List<Diary> getByDay(int day) =>
      _diaries.where((diary) => diary.date.day == day).toList();

  Future<void> getByMonth(int year, int month) async {
    try {
      final snapshot = await _diaryRepository.getByMonth(year, month);
      _diaries = snapshot;
      _getDay = DateTime(year, month);
      notifyListeners();
    } catch (e) {
      throw Exception('Failed to fetch diaries: $e');
    }
  }

  // update
  Future<void> updateDiary(Diary diary, String newContent) async {
    try {
      await _diaryRepository.update(diary, newContent);
      _diaries = _diaries.map((existingDiary) {
        if (existingDiary.id == diary.id) {
          return existingDiary.clone(content: newContent);
        }
        return existingDiary;
      }).toList();
      notifyListeners();
    } catch (e) {
      throw Exception('Failed to update diary: $e');
    }
  }

  // delete
  Future<void> deleteDiary(Diary diary) async {
    try {
      await _diaryRepository.delete(diary);
      _diaries.removeWhere((diary) => diary.id == diary.id);
      notifyListeners();
    } catch (e) {
      throw Exception('Failed to delete diary: $e');
    }
  }
}
