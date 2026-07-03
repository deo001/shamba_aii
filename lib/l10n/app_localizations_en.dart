// ignore: unused_import
import 'package:intl/intl.dart' as intl;
import 'app_localizations.dart';

// ignore_for_file: type=lint

/// The translations for English (`en`).
class AppLocalizationsEn extends AppLocalizations {
  AppLocalizationsEn([String locale = 'en']) : super(locale);

  @override
  String get selectLanguage => 'Select Language';

  @override
  String get continueBtn => 'Continue';

  @override
  String get english => 'English';

  @override
  String get swahili => 'Kiswahili';

  @override
  String get onboardTitle1 => 'Smart Crop Diagnosis';

  @override
  String get onboardDesc1 =>
      'Photograph your crops and get instant AI-powered disease, pest, and nutrient diagnoses in seconds.';

  @override
  String get onboardTitle2 => 'Farm Intelligence';

  @override
  String get onboardDesc2 =>
      'Get personalized planting schedules, weather-aware advice, and market price insights — all in one place.';

  @override
  String get onboardTitle3 => 'Your AI Farm Co-Pilot';

  @override
  String get onboardDesc3 =>
      'Ask anything about your farm in plain language. ShambaAI guides you from planting to harvest.';

  @override
  String get getStarted => 'Get Started';

  @override
  String get next => 'Next';

  @override
  String get skip => 'Skip';

  @override
  String get welcomeBack => 'Welcome to ShambaAI';

  @override
  String get enterPhone => 'Enter your phone number to continue';

  @override
  String get phoneHint => 'Phone number';

  @override
  String get sendOtp => 'Send Code';

  @override
  String get verifyOtp => 'Verify Code';

  @override
  String otpSentTo(String phone) {
    return 'Code sent to $phone';
  }

  @override
  String get otpHint => 'Enter 6-digit code';

  @override
  String get resendOtp => 'Resend Code';

  @override
  String resendIn(int seconds) {
    return 'Resend in ${seconds}s';
  }

  @override
  String get confirm => 'Confirm';

  @override
  String get agreeToTerms =>
      'By continuing, you agree to our Terms of Service and Privacy Policy';

  @override
  String get goodMorning => 'Good morning';

  @override
  String get goodAfternoon => 'Good afternoon';

  @override
  String get goodEvening => 'Good evening';

  @override
  String get myFarm => 'My Farm';

  @override
  String get myCrops => 'My Crops';

  @override
  String get weather => 'Weather';

  @override
  String get market => 'Market';

  @override
  String get aiDiagnosis => 'AI Diagnosis';

  @override
  String get advisory => 'Advisory';

  @override
  String get comingSoon => 'Coming Soon';

  @override
  String activeCrops(int count) {
    return '$count active crops';
  }

  @override
  String get noActiveCrops => 'No active crops yet';

  @override
  String get addFirstCrop => 'Add your first crop';

  @override
  String get farmProfile => 'Farm Profile';

  @override
  String get farmName => 'Farm Name';

  @override
  String get farmNameHint => 'e.g. Mwangi Family Farm';

  @override
  String get farmSize => 'Farm Size';

  @override
  String get farmSizeHint => 'Enter size';

  @override
  String get farmLocation => 'Farm Location';

  @override
  String get detectLocation => 'Detect My Location';

  @override
  String get manualLocation => 'Enter Manually';

  @override
  String get acres => 'Acres';

  @override
  String get hectares => 'Hectares';

  @override
  String get saveProfile => 'Save Profile';

  @override
  String get myCropsList => 'My Crops';

  @override
  String get addCrop => 'Add Crop';

  @override
  String get cropType => 'Crop Type';

  @override
  String get cropTypeHint => 'e.g. Maize, Tomato, Beans';

  @override
  String get plantingDate => 'Planting Date';

  @override
  String get growthStage => 'Growth Stage';

  @override
  String get notes => 'Notes';

  @override
  String get notesHint => 'Optional notes about this crop';

  @override
  String get saveCrop => 'Save Crop';

  @override
  String get updateStage => 'Update Stage';

  @override
  String get cropHistory => 'Crop History';

  @override
  String daysInField(int days) {
    return '$days days in field';
  }

  @override
  String get stagePlanted => 'Planted';

  @override
  String get stageGerminated => 'Germinated';

  @override
  String get stageVegetative => 'Vegetative';

  @override
  String get stageFlowering => 'Flowering';

  @override
  String get stageHarvest => 'Harvest Ready';

  @override
  String get notifications => 'Notifications';

  @override
  String get noNotifications => 'No notifications yet';

  @override
  String get markAllRead => 'Mark all as read';

  @override
  String get errorGeneric => 'Something went wrong. Please try again.';

  @override
  String get errorNetwork => 'No internet connection. Check your network.';

  @override
  String get errorInvalidPhone => 'Please enter a valid phone number.';

  @override
  String get errorInvalidOtp => 'Invalid code. Please check and try again.';

  @override
  String get errorLocationPermission =>
      'Location permission is required to detect your farm location.';

  @override
  String get fieldRequired => 'This field is required';

  @override
  String get save => 'Save';

  @override
  String get cancel => 'Cancel';

  @override
  String get edit => 'Edit';

  @override
  String get delete => 'Delete';

  @override
  String get loading => 'Loading...';

  @override
  String get retry => 'Retry';

  @override
  String get ok => 'OK';
}
