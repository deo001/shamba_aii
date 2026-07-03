// ignore: unused_import
import 'package:intl/intl.dart' as intl;
import 'app_localizations.dart';

// ignore_for_file: type=lint

/// The translations for Swahili (`sw`).
class AppLocalizationsSw extends AppLocalizations {
  AppLocalizationsSw([String locale = 'sw']) : super(locale);

  @override
  String get selectLanguage => 'Chagua Lugha';

  @override
  String get continueBtn => 'Endelea';

  @override
  String get english => 'English';

  @override
  String get swahili => 'Kiswahili';

  @override
  String get onboardTitle1 => 'Uchunguzi wa Mazao kwa AI';

  @override
  String get onboardDesc1 =>
      'Piga picha mazao yako na upate uchunguzi wa haraka wa magonjwa, wadudu, na upungufu wa virutubisho.';

  @override
  String get onboardTitle2 => 'Akili ya Shamba';

  @override
  String get onboardDesc2 =>
      'Pata ratiba za kupanda, ushauri kulingana na hali ya hewa, na bei za soko — mahali pamoja.';

  @override
  String get onboardTitle3 => 'Mshauri Wako wa AI';

  @override
  String get onboardDesc3 =>
      'Uliza chochote kuhusu shamba lako kwa lugha ya kawaida. ShambaAI inakuongoza tangu kupanda hadi kuvuna.';

  @override
  String get getStarted => 'Anza Sasa';

  @override
  String get next => 'Ifuatayo';

  @override
  String get skip => 'Ruka';

  @override
  String get welcomeBack => 'Karibu ShambaAI';

  @override
  String get enterPhone => 'Weka nambari yako ya simu kuendelea';

  @override
  String get phoneHint => 'Nambari ya simu';

  @override
  String get sendOtp => 'Tuma Nambari';

  @override
  String get verifyOtp => 'Thibitisha Nambari';

  @override
  String otpSentTo(String phone) {
    return 'Nambari imetumwa kwa $phone';
  }

  @override
  String get otpHint => 'Weka nambari ya tarakimu 6';

  @override
  String get resendOtp => 'Tuma Tena';

  @override
  String resendIn(int seconds) {
    return 'Tuma tena baada ya ${seconds}s';
  }

  @override
  String get confirm => 'Thibitisha';

  @override
  String get agreeToTerms =>
      'Kwa kuendelea, unakubali Masharti ya Huduma na Sera ya Faragha';

  @override
  String get goodMorning => 'Habari za asubuhi';

  @override
  String get goodAfternoon => 'Habari za mchana';

  @override
  String get goodEvening => 'Habari za jioni';

  @override
  String get myFarm => 'Shamba Langu';

  @override
  String get myCrops => 'Mazao Yangu';

  @override
  String get weather => 'Hali ya Hewa';

  @override
  String get market => 'Soko';

  @override
  String get aiDiagnosis => 'Uchunguzi wa AI';

  @override
  String get advisory => 'Ushauri';

  @override
  String get comingSoon => 'Inakuja Hivi Karibuni';

  @override
  String activeCrops(int count) {
    return 'mazao $count yanayoendelea';
  }

  @override
  String get noActiveCrops => 'Hakuna mazao bado';

  @override
  String get addFirstCrop => 'Ongeza zao lako la kwanza';

  @override
  String get farmProfile => 'Wasifu wa Shamba';

  @override
  String get farmName => 'Jina la Shamba';

  @override
  String get farmNameHint => 'mfano: Shamba la Familia Mwangi';

  @override
  String get farmSize => 'Ukubwa wa Shamba';

  @override
  String get farmSizeHint => 'Weka ukubwa';

  @override
  String get farmLocation => 'Eneo la Shamba';

  @override
  String get detectLocation => 'Gundua Eneo Langu';

  @override
  String get manualLocation => 'Weka Manually';

  @override
  String get acres => 'Ekari';

  @override
  String get hectares => 'Hekta';

  @override
  String get saveProfile => 'Hifadhi Wasifu';

  @override
  String get myCropsList => 'Mazao Yangu';

  @override
  String get addCrop => 'Ongeza Zao';

  @override
  String get cropType => 'Aina ya Zao';

  @override
  String get cropTypeHint => 'mfano: Mahindi, Nyanya, Maharagwe';

  @override
  String get plantingDate => 'Tarehe ya Kupanda';

  @override
  String get growthStage => 'Hatua ya Ukuaji';

  @override
  String get notes => 'Maelezo';

  @override
  String get notesHint => 'Maelezo ya ziada kuhusu zao hili';

  @override
  String get saveCrop => 'Hifadhi Zao';

  @override
  String get updateStage => 'Sasisha Hatua';

  @override
  String get cropHistory => 'Historia ya Zao';

  @override
  String daysInField(int days) {
    return 'siku $days shambani';
  }

  @override
  String get stagePlanted => 'Limepandwa';

  @override
  String get stageGerminated => 'Limechipuka';

  @override
  String get stageVegetative => 'Ukuaji';

  @override
  String get stageFlowering => 'Maua';

  @override
  String get stageHarvest => 'Tayari Kuvuna';

  @override
  String get notifications => 'Arifa';

  @override
  String get noNotifications => 'Hakuna arifa bado';

  @override
  String get markAllRead => 'Weka zote kuwa zimesomwa';

  @override
  String get errorGeneric => 'Kuna tatizo. Tafadhali jaribu tena.';

  @override
  String get errorNetwork =>
      'Hakuna muunganisho wa intaneti. Angalia mtandao wako.';

  @override
  String get errorInvalidPhone => 'Tafadhali weka nambari sahihi ya simu.';

  @override
  String get errorInvalidOtp =>
      'Nambari si sahihi. Tafadhali angalia na jaribu tena.';

  @override
  String get errorLocationPermission =>
      'Ruhusa ya eneo inahitajika kugundua eneo la shamba lako.';

  @override
  String get fieldRequired => 'Sehemu hii inahitajika';

  @override
  String get save => 'Hifadhi';

  @override
  String get cancel => 'Ghairi';

  @override
  String get edit => 'Hariri';

  @override
  String get delete => 'Futa';

  @override
  String get loading => 'Inapakia...';

  @override
  String get retry => 'Jaribu Tena';

  @override
  String get ok => 'Sawa';
}
