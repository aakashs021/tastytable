import 'package:cloud_firestore/cloud_firestore.dart';

class ApiKeyFirebase {
 static final docRef = FirebaseFirestore.instance
      .collection('apiKeys')
      .doc('apikeys');
      static final datedocRef = FirebaseFirestore.instance
      .collection('apiKeys')
      .doc('lastresetdate');

  static Future<int> getLeastUsedKeyIndexAndUpdate() async {
    
    

    final snapshot = await docRef.get();

    if (!snapshot.exists) {
      throw Exception("The 'apikeys' document does not exist.");
    }

    final data = snapshot.data();
    final List<dynamic> rawList = data?['apikeys'] ?? [];
        List<int> counts = rawList.map((e) => e as int).toList();


    Timestamp? lastResetTimestamp = data?['date']; // Firestore timestamp
    final DateTime now = DateTime.now();
    final DateTime today = DateTime(now.year, now.month, now.day);

    if (lastResetTimestamp != null) {
      final lastReset = lastResetTimestamp.toDate();
      final lastResetDate = DateTime(lastReset.year, lastReset.month, lastReset.day);

      if (lastResetDate != today) {
        // Reset counts if it's a new day
        counts = List.filled(counts.length, 0);
        await docRef.update({
          'apikeys': counts,
          'date': Timestamp.fromDate(today), // Save today back to Firestore
        });
      }
    } else {
      // First time setup: set date field
      await docRef.update({
        'date': Timestamp.fromDate(today),
      });
    }

    // Convert to List<int>

    if (counts.isEmpty) {
      throw Exception("The 'apikeys' array is empty.");
    }

    // Find index with the least count
    int minIndex = 0;
    for (int i = 1; i < counts.length; i++) {
      if (counts[i] < counts[minIndex]) {
        minIndex = i;
      }
    }

    // Increment count
    counts[minIndex]++;

    // Update Firestore
    await docRef.update({'apikeys': counts});

    return minIndex; // Or map this to your actual API key
  }

}