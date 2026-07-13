# ShambaAI — Implementation Plan & Phase Tracker

> **Stack**: Flutter · GetX · Firebase · FastAPI (Python) · AWS  
> **Platform**: Android (primary), iOS later  
> **Languages**: Swahili + English (user selects before splash)  
> **Design**: Premium, alive, reference-quality UI — no placeholders  
> **Project Location**: `/Users/tech02/Documents/Shamba AI/shamba_ai/`

---

## Decisions Locked ✅

| Question | Decision |
|---|---|
| Firebase project | Create new — ShambaAI project |
| Language | EN + SW from the start; user picks language before splash |
| Design | No Figma — design from scratch, reference stunning agtech UI |
| Platform | Android first (for testing + simulation) |
| Flutter project | Brand new GetX project inside `/Documents/Shamba AI/` |

---

## Source Documents (All in `/Documents/Shamba AI/`)

| File | Role |
|---|---|
| `ShambaAI_SRD.docx` | System Requirements (what to build) |
| `ShambaAI_Addendum.docx` | Business model, go-to-market, KPIs |
| `ShambaAI_TechStack_Roadmap.docx` | Stack decisions + 24-week roadmap |
| `implementation_plan.md` *(this file)* | Master plan & phase tracker |
| `task.md` | Active task checklist (created during execution) |
| `walkthrough.md` | Post-execution summary (created after each phase) |

---

## Full Phase Map (24 Weeks → Pilot Launch)

```
Phase 0  │ Foundation Setup         │ Weeks 1–4
Phase 1  │ Core Platform            │ Weeks 3–10
Phase 2  │ AI Crop Intelligence v1  │ Weeks 7–16
Phase 3  │ Advisory & Market        │ Weeks 12–18
Phase 4  │ Offline-First & Channels │ Weeks 16–20
Phase 5  │ Trust & Review Tooling   │ Weeks 18–22
Phase 6  │ Hardening & Launch       │ Weeks 20–24
```

---

## Phase 0 — Foundation Setup `[Weeks 1–4]`

> **Goal**: Project scaffold, Firebase connected, CI/CD running, environments ready.

### Status: `🟡 IN PROGRESS — FOUNDATION MOSTLY EXECUTED`

### Deliverables

#### 0.1 Flutter Project
- [x] Create Flutter project `shamba_ai` in `/Documents/Shamba AI/`
- [x] Configure GetX (routing, dependency injection, controllers)
- [x] Set up folder structure (features-first architecture)
- [x] Add all Phase 0 + Phase 1 dependencies to `pubspec.yaml`

#### 0.2 Firebase Setup
- [x] Configure Firebase project: **shamba-ai-726f4** (`521914521560`)
- [x] Register Android app (`com.shamba.shamba_ai`)
- [x] Download & place `google-services.json`
- [x] Enable: Auth (Email/password)
- [x] Enable: Auth (Phone OTP)
- [x] Create Firestore database: `(default)` · Standard · Native · `africa-south1`
- [x] Deploy Firestore rules and indexes
- [ ] Allow Tanzania (`+255`) in Firebase Auth SMS region policy
- [ ] Verify: Auth (Phone OTP) on a real/simulated Android device
- [ ] Initialize/verify: FCM, Crashlytics, Analytics runtime setup

#### 0.3 Design System
- [x] Define color palette (green-earth + dark premium tones)
- [x] Set up Google Font (Outfit)
- [x] Build `AppTheme` with dark tokens
- [ ] Build light theme tokens
- [ ] Create reusable widget library (buttons, cards, inputs)

#### 0.4 Localization Scaffold
- [x] Configure `flutter_localizations` + `intl`
- [x] Create ARB files: `app_en.arb`, `app_sw.arb`
- [x] Wire `GetX` locale switching
- [x] Implement **Language Selection screen** (first screen ever shown)

#### 0.5 App Entry Flow
- [x] Language Selection screen (EN / SW toggle)
- [x] Splash screen (animated logo, locale-aware)
- [x] Onboarding carousel (3 slides — what ShambaAI does)

### Phase 0 Remaining

- [ ] Allow Tanzania (`+255`) in Firebase Auth SMS region policy.
- [ ] Verify Phone OTP on a real/simulated Android device.
- [ ] Finish FCM, Crashlytics, and Analytics runtime initialization and smoke tests.
- [ ] Add light theme tokens or explicitly lock Phase 0 to dark-only.
- [ ] Extract repeated buttons/cards/inputs into a reusable widget library.
- [ ] Add CI/CD workflow for analysis/tests/builds.
- [ ] Complete Android debug build verification; the last run was interrupted after Gradle stayed quiet for ~225s.

### Phase 0 Additions Completed

- [x] Add user Profile/Settings screen.
- [x] Allow signed-in user to update display name and photo URL.
- [x] Persist profile updates to Firebase Auth and Firestore `users/{uid}`.
- [x] Allow signed-in user to switch app language from profile.
- [x] Persist selected language locally and in Firestore as `languageCode`.
- [x] Add logout action that clears local auth state and returns to language selection.
- [x] Update and deploy Firestore rules for profile/language fields.

---

## Phase 1 — Core Platform `[Weeks 3–10]`

> **Goal**: Full Auth flow, Farm Profile, Crop Tracking, Home Dashboard, Notifications wired.

### Status: `⚪ PENDING`

### Deliverables

#### 1.1 Authentication
- [ ] Phone number entry screen (with country picker)
- [ ] OTP verification screen (6-digit input)
- [ ] Firebase Auth (Phone OTP) integration
- [ ] `AuthController` (GetX) — state: unauthenticated → verifying → authenticated
- [ ] Persist login state (no re-login on app restart)
- [ ] Logout flow

#### 1.2 Farm Profile
- [ ] Farmer name + profile photo (optional)
- [ ] Farm name input
- [ ] Farm location: GPS auto-detect OR manual pin on map
- [ ] Farm size (acres / hectares selector)
- [ ] `FarmController` (GetX) — CRUD operations
- [ ] Offline persistence (Hive)

#### 1.3 Crop Tracking
- [ ] Add crop screen (crop type picker, planting date, notes)
- [ ] Crop list screen (card-based with stage badges)
- [ ] Crop detail screen (growth stage timeline, update action)
- [ ] Growth stage progression: Planted → Germinated → Vegetative → Flowering → Harvest
- [ ] `CropController` (GetX)
- [ ] Offline-first with Hive

#### 1.4 Home Dashboard
- [ ] Welcome header (farmer name + greeting)
- [ ] My Farm summary card (crops count, active seasons)
- [ ] Quick-action grid (entry points to each module — locked ones shown as "Coming Soon")
- [ ] Recent activity feed (last crop updates, alerts)

#### 1.5 Notifications System
- [ ] Firebase Cloud Messaging (FCM) integration
- [ ] `flutter_local_notifications` for in-app alerts
- [ ] Notification Center screen (list of received alerts)
- [ ] `NotificationController` (GetX)

#### Phase 1 Tech Stack
| Concern | Package |
|---|---|
| State / Routing | `get` |
| Auth | `firebase_auth` |
| Local Storage | `hive` + `hive_flutter` |
| Location | `geolocator` + `geocoding` |
| Notifications | `firebase_messaging` + `flutter_local_notifications` |
| Localization | `flutter_localizations` + `intl` |
| Crash | `firebase_crashlytics` |
| Analytics | `firebase_analytics` |

---

## Phase 2 — AI Crop Intelligence v1 `[Weeks 7–16]`

> **Goal**: Farmer can photograph a crop leaf → get a disease/pest diagnosis + treatment suggestion.

### Status: `⚪ PENDING`

### Deliverables

#### 2.1 Image Capture Flow
- [ ] Camera integration (`camera` package)
- [ ] Image picker (gallery fallback)
- [ ] Client-side image compression before upload
- [ ] Upload to AWS S3 (via FastAPI backend)

#### 2.2 On-Device Classifier (Lightweight)
- [ ] Integrate `tflite_flutter`
- [ ] Baseline model (PlantVillage-trained, quantized TFLite)
- [ ] Run local inference for common disease classes
- [ ] Show confidence score to user

#### 2.3 Cloud Inference (High-confidence / rare cases)
- [ ] FastAPI endpoint: `POST /api/v1/diagnose`
- [ ] SageMaker / TorchServe integration (backend)
- [ ] Response: disease name + confidence + treatment steps
- [ ] Active-learning flag: low confidence → queue for expert review

#### 2.4 Diagnosis UI
- [ ] Scan/Upload screen (live camera view or pick from gallery)
- [ ] Processing screen (animated loader, fun farming facts while waiting)
- [ ] Result screen: disease name, severity badge, treatment steps, disclaimer
- [ ] Save diagnosis to crop history

#### 2.5 Backend (FastAPI — Phase 2 starts)
- [ ] FastAPI project scaffold
- [ ] PostgreSQL (RDS) setup + SQLAlchemy models
- [ ] S3 bucket for image storage
- [ ] Alembic migration setup
- [ ] `/diagnose` endpoint + model integration

---

## Phase 3 — Advisory & Market Modules `[Weeks 12–18]`

> **Goal**: AI chat assistant + crop market price tracking + sell timing engine.

### Status: `⚪ PENDING`

### Deliverables

#### 3.1 Farm Knowledge Assistant (AI Chat)
- [ ] Chat UI screen (bubble messages, typing indicator)
- [ ] Anthropic Claude API integration (via FastAPI backend)
- [ ] RAG knowledge base: agricultural facts embedded in pgvector
- [ ] Context-aware: chat knows farmer's crops, location, season
- [ ] Multilingual: respond in the user's selected language
- [ ] `ChatController` (GetX)

#### 3.2 Weather-Aware Farming
- [ ] Tomorrow.io / OpenWeatherMap API integration
- [ ] GPS-based local forecast fetch
- [ ] Weather card on dashboard (temperature, rain chance, humidity)
- [ ] Farming action recommendations: "Good day to spray", "Avoid irrigation — rain expected"
- [ ] Risk alerts: storm/frost/drought warnings

#### 3.3 Market Module
- [ ] Crop price tracking (partner data feed / commodity APIs)
- [ ] Price trend chart (line graph, 30-day history)
- [ ] "Best time to sell" recommendation card
- [ ] Market comparison (price across nearby markets)
- [ ] `MarketController` (GetX)

---

## Phase 4 — Offline-First & Channels `[Weeks 16–20]`

> **Goal**: The app works in low/no connectivity areas. SMS/USSD channel live.

### Status: `⚪ PENDING`

### Deliverables

#### 4.1 Store-and-Forward Sync
- [ ] Queue images + queries locally when offline
- [ ] Auto-sync on reconnect (`connectivity_plus`)
- [ ] Sync status indicator in UI
- [ ] Conflict resolution logic

#### 4.2 SMS / USSD Channel
- [ ] Africa's Talking integration (backend)
- [ ] USSD menu: farm status, weather alert, market price
- [ ] SMS advisory delivery for farmers without smartphones

#### 4.3 Full Multilingual UI
- [ ] Complete Swahili translations across all screens
- [ ] In-app language switcher (accessible from settings)
- [ ] RTL-safe layouts (for future Arabic/other support)

---

## Phase 5 — Trust & Review Tooling `[Weeks 18–22]`

> **Goal**: Build trust layer — extension officers, confidence routing, disclaimers.

### Status: `⚪ PENDING`

### Deliverables

#### 5.1 Extension Officer Role
- [ ] Officer login (separate role in Firebase Auth)
- [ ] Review dashboard: flagged low-confidence diagnoses
- [ ] Officer can verify or override AI diagnosis
- [ ] Verified result feeds back into the training set

#### 5.2 Confidence-Threshold Routing
- [ ] Diagnoses below threshold shown with "Expert Review Pending" badge
- [ ] Farmer notified when expert confirms result

#### 5.3 In-App Disclaimers
- [ ] Advisory (not prescriptive) language on all AI results
- [ ] Escalation CTA: "Talk to an extension officer"
- [ ] Terms of use acknowledgement during onboarding

---

## Phase 6 — Hardening & Launch `[Weeks 20–24]`

> **Goal**: Production-ready. 200–1,000 farmer pilot cohort onboarded.

### Status: `⚪ PENDING`

### Deliverables

#### 6.1 Security Review
- [ ] TLS everywhere verified
- [ ] Firebase Auth JWT validation on all API endpoints
- [ ] AWS WAF rules configured
- [ ] Data protection review (Kenya DPA / Tanzania PDPA)

#### 6.2 Performance & Load Testing
- [ ] Load test: AI diagnosis endpoint at pilot scale
- [ ] App startup time < 2s (cold launch)
- [ ] AI response < 5s target (SRD NFR)
- [ ] Image analysis < 10s target (SRD NFR)

#### 6.3 Play Store Submission
- [ ] App icon, splash, screenshots
- [ ] Store listing (EN + SW)
- [ ] Privacy policy page
- [ ] Play Store internal → closed testing → production

#### 6.4 Phase 0 Pilot Onboarding
- [ ] 200–1,000 farmer cohort registered
- [ ] Analytics dashboards live (Firebase + CloudWatch)
- [ ] KPI baseline recorded: diagnostic accuracy, retention, DAU/MAU

---

## Post-Pilot: Phase 7+ (Months 6–12)

These phases activate only after the pilot milestone gate is met:

| Future Phase | Focus |
|---|---|
| 7 | Community Intelligence Layer (aggregated alerts, outbreak maps) |
| 8 | Yield Prediction Engine (ML model on farm history) |
| 9 | Farm Planning Engine (planting schedules, rotation, irrigation) |
| 10 | Drone + Satellite integration |
| 11 | Insurance integration |
| 12 | Government agriculture dashboard |
| 13 | IoT soil sensors |

---

## Progress Status Key

| Symbol | Meaning |
|---|---|
| 🔵 NEXT TO START | Approved and ready to begin |
| 🟡 IN PROGRESS | Currently being built |
| 🟢 COMPLETE | Done and verified |
| ⚪ PENDING | Waiting for previous phases |
| 🔴 BLOCKED | Dependency or decision needed |

---

## Competitive Context (from Addendum)

| Player | Our Differentiator |
|---|---|
| Plantix | We add market + planning + advisory in one system |
| PlantVillage Nuru | Broader crops + AI chat + market timing |
| Digital Green | Real-time personalized AI vs. pre-recorded video |
| FarmDrive | Complementary — potential partner for input financing |

---

*Last updated: 2026-07-03 | Version 1.1 — Phases added, decisions locked*
