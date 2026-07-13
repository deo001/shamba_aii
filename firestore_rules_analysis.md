# Firestore Rules Analysis

## Codebase Findings

- Platform: Flutter app with Firebase Authentication and Cloud Firestore.
- Current Firestore writes added in this setup:
  - `users/{uid}` in the default Firestore database via `FirestoreService.upsertCurrentUser`.
- Current Firestore queries:
  - No collection queries, `where`, `orderBy`, or `limit` clauses are present.
- Authentication patterns:
  - Firebase Email/password Authentication.
  - Firebase Phone Authentication.
- Firestore database:
  - Project: `shamba-ai-726f4`
  - Database: `(default)`
  - Edition: Standard
  - Type: Native mode
  - Location: `africa-south1`
- Assumed `users/{uid}` schema:
  - `uid`: string, required, immutable, must match `request.auth.uid`.
  - `email`: string or null, optional, private PII.
  - `phoneNumber`: string or null, optional, private PII.
  - `displayName`: string or null, optional.
  - `photoUrl`: string or null, optional.
  - `languageCode`: string or null, optional, must be `en` or `sw`.
  - `createdAt`: timestamp, required after creation, immutable.
  - `updatedAt`: timestamp, required.
  - `lastLoginAt`: timestamp, required.

## Devil's Advocate Checks

- Public list exploit: denied because all `users` reads require ownership and catch-all denies everything else.
- Unauthorized read/write: denied because `users/{userId}` requires `request.auth.uid == userId`.
- Update bypass/schema pollution: denied by strict `hasOnly` field checks and validator use on create/update.
- Ownership hijacking: denied because document ID and `uid` must match `request.auth.uid`; `uid` is immutable on update.
- Immutable field modification: denied for `uid` and `createdAt`.
- Data corruption/type juggling: denied for known fields with explicit type-or-null checks.
- Resource exhaustion: constrained for string fields.
- Privilege escalation: no role/admin fields are allowed.
