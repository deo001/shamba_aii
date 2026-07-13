import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';

class FirestoreService {
  FirestoreService._();

  static FirebaseFirestore get db => FirebaseFirestore.instance;
  static CollectionReference<Map<String, dynamic>> get usersRef =>
      db.collection('users');

  static DocumentReference<Map<String, dynamic>> userRef(String uid) =>
      usersRef.doc(uid);

  static Stream<DocumentSnapshot<Map<String, dynamic>>> streamUserProfile(
    String uid,
  ) {
    return userRef(uid).snapshots();
  }

  static Future<void> upsertCurrentUser(User user) async {
    final now = FieldValue.serverTimestamp();
    final ref = userRef(user.uid);
    final snapshot = await ref.get();

    final data = {
      'uid': user.uid,
      'email': user.email,
      'phoneNumber': user.phoneNumber,
      'displayName': user.displayName,
      'photoUrl': user.photoURL,
      'lastLoginAt': now,
      'updatedAt': now,
    };

    if (snapshot.exists) {
      await ref.update(data);
      return;
    }

    await ref.set({...data, 'createdAt': now});
  }

  static Future<void> updateCurrentUserProfile({
    String? displayName,
    String? photoUrl,
    String? languageCode,
  }) async {
    final user = FirebaseAuth.instance.currentUser;
    if (user == null) {
      throw FirebaseAuthException(
        code: 'no-current-user',
        message: 'No signed-in user is available.',
      );
    }

    final trimmedName = displayName?.trim();
    final trimmedPhotoUrl = photoUrl?.trim();

    if (trimmedName != null) {
      await user.updateDisplayName(trimmedName.isEmpty ? null : trimmedName);
    }
    if (trimmedPhotoUrl != null) {
      await user.updatePhotoURL(
        trimmedPhotoUrl.isEmpty ? null : trimmedPhotoUrl,
      );
    }
    await user.reload();

    final updates = <String, Object?>{
      'updatedAt': FieldValue.serverTimestamp(),
    };

    if (trimmedName != null) updates['displayName'] = trimmedName;
    if (trimmedPhotoUrl != null) updates['photoUrl'] = trimmedPhotoUrl;
    if (languageCode != null) updates['languageCode'] = languageCode;

    await userRef(user.uid).update(updates);
  }
}
