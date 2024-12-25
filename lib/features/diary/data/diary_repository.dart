import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:graytalk/features/diary/data/diary_model.dart';

class DiaryRepository {
  final FirebaseFirestore _firestore = FirebaseFirestore.instance;
  final String _collection = 'diaries';

  // create
  Future<void> add(Diary diary) async {
    final year = diary.year.toString();
    final month = diary.month.toString().padLeft(2, '0');

    try {
      await _firestore
          .collection(_collection)
          .doc(year)
          .collection(month)
          .doc(diary.id)
          .set(diary.toJson());
    } catch (e) {
      throw Exception('Failed to add diary: $e');
    }
  }

  // read
  Future<List<Diary>> getByMonth(int year, int month) async {
    try {
      final snapshot = await _firestore
          .collection(_collection)
          .doc(year.toString())
          .collection(month.toString().padLeft(2, '0'))
          .get();

      return snapshot.docs.map((doc) => Diary.fromJson(doc.data())).toList();
    } catch (e) {
      throw Exception('Failed to fetch diary: $e');
    }
  }

  // update
  Future<void> update(Diary diary, String newContent) async {
    try {
      await _firestore
          .collection(_collection)
          .doc(diary.year.toString())
          .collection(diary.month.toString().padLeft(2, '0'))
          .doc(diary.id)
          .update({
        'content': newContent,
      });
    } catch (e) {
      throw Exception('Failed to update diary: $e');
    }
  }

  // delete
  Future<void> delete(Diary diary) async {
    try {
      await _firestore
          .collection(_collection)
          .doc(diary.year.toString())
          .collection(diary.month.toString().padLeft(2, '0'))
          .doc(diary.id)
          .delete();
    } catch (e) {
      throw Exception('Failed to delete diary: $e');
    }
  }
}
