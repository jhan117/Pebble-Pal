import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:graytalk/features/diary/data/diary_model.dart';

class DiaryRepository {
  final FirebaseFirestore _firestore = FirebaseFirestore.instance;
  final String _collection = 'diaries';

  String _formatDate(DateTime date) =>
      '${date.year}${date.month.toString().padLeft(2, '0')}${date.day.toString().padLeft(2, '0')}';

  // create
  Future<void> add(Diary diary) async {
    try {
      await _firestore
          .collection(_collection)
          .doc(diary.id)
          .set(diary.toJson());
    } catch (e) {
      throw Exception('Failed to add diary: $e');
    }
  }

  // read
  Stream<List<Diary>> getByDate(DateTime date) {
    try {
      final formattedDate = _formatDate(date);
      return _firestore
          .collection(_collection)
          .where('date', isEqualTo: formattedDate)
          .snapshots()
          .map((snapshot) =>
              snapshot.docs.map((doc) => Diary.fromJson(doc.data())).toList());
    } catch (e) {
      throw Exception('Failed to get diaries by date: $e');
    }
  }

  Future<Diary?> getById(String diaryId) async {
    try {
      final docSnapshot =
          await _firestore.collection(_collection).doc(diaryId).get();
      if (docSnapshot.exists) {
        return Diary.fromJson(docSnapshot.data()!);
      }
      return null;
    } catch (e) {
      throw Exception('Failed to fetch diary: $e');
    }
  }

  // update
  Future<void> update(Diary diary) async {
    try {
      await _firestore
          .collection(_collection)
          .doc(diary.id)
          .update(diary.toJson());
    } catch (e) {
      throw Exception('Failed to update diary: $e');
    }
  }

  // delete
  Future<void> delete(String diaryId) async {
    try {
      await _firestore.collection(_collection).doc(diaryId).delete();
    } catch (e) {
      throw Exception('Failed to delete diary: $e');
    }
  }
}
