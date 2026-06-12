import 'dart:async';

import 'package:flutter/foundation.dart';
import 'package:flutter/widgets.dart';
import 'package:flutter_localizations/flutter_localizations.dart';
import 'package:intl/intl.dart' as intl;

import 'app_localizations_ar.dart';
import 'app_localizations_en.dart';

// ignore_for_file: type=lint

/// Callers can lookup localized strings with an instance of AppLocalizations
/// returned by `AppLocalizations.of(context)`.
///
/// Applications need to include `AppLocalizations.delegate()` in their app's
/// `localizationDelegates` list, and the locales they support in the app's
/// `supportedLocales` list. For example:
///
/// ```dart
/// import 'generated/app_localizations.dart';
///
/// return MaterialApp(
///   localizationsDelegates: AppLocalizations.localizationsDelegates,
///   supportedLocales: AppLocalizations.supportedLocales,
///   home: MyApplicationHome(),
/// );
/// ```
///
/// ## Update pubspec.yaml
///
/// Please make sure to update your pubspec.yaml to include the following
/// packages:
///
/// ```yaml
/// dependencies:
///   # Internationalization support.
///   flutter_localizations:
///     sdk: flutter
///   intl: any # Use the pinned version from flutter_localizations
///
///   # Rest of dependencies
/// ```
///
/// ## iOS Applications
///
/// iOS applications define key application metadata, including supported
/// locales, in an Info.plist file that is built into the application bundle.
/// To configure the locales supported by your app, you’ll need to edit this
/// file.
///
/// First, open your project’s ios/Runner.xcworkspace Xcode workspace file.
/// Then, in the Project Navigator, open the Info.plist file under the Runner
/// project’s Runner folder.
///
/// Next, select the Information Property List item, select Add Item from the
/// Editor menu, then select Localizations from the pop-up menu.
///
/// Select and expand the newly-created Localizations item then, for each
/// locale your application supports, add a new item and select the locale
/// you wish to add from the pop-up menu in the Value field. This list should
/// be consistent with the languages listed in the AppLocalizations.supportedLocales
/// property.
abstract class AppLocalizations {
  AppLocalizations(String locale)
    : localeName = intl.Intl.canonicalizedLocale(locale.toString());

  final String localeName;

  static AppLocalizations? of(BuildContext context) {
    return Localizations.of<AppLocalizations>(context, AppLocalizations);
  }

  static const LocalizationsDelegate<AppLocalizations> delegate =
      _AppLocalizationsDelegate();

  /// A list of this localizations delegate along with the default localizations
  /// delegates.
  ///
  /// Returns a list of localizations delegates containing this delegate along with
  /// GlobalMaterialLocalizations.delegate, GlobalCupertinoLocalizations.delegate,
  /// and GlobalWidgetsLocalizations.delegate.
  ///
  /// Additional delegates can be added by appending to this list in
  /// MaterialApp. This list does not have to be used at all if a custom list
  /// of delegates is preferred or required.
  static const List<LocalizationsDelegate<dynamic>> localizationsDelegates =
      <LocalizationsDelegate<dynamic>>[
        delegate,
        GlobalMaterialLocalizations.delegate,
        GlobalCupertinoLocalizations.delegate,
        GlobalWidgetsLocalizations.delegate,
      ];

  /// A list of this localizations delegate's supported locales.
  static const List<Locale> supportedLocales = <Locale>[
    Locale('ar'),
    Locale('en'),
  ];

  /// تسجيل الدخول
  ///
  /// In en, this message translates to:
  /// **'Login'**
  String get login;

  /// تسجيل الدخول
  ///
  /// In en, this message translates to:
  /// **'Account'**
  String get account;

  /// تسجيل الدخول
  ///
  /// In en, this message translates to:
  /// **'donation'**
  String get donation;

  ///  زر التالي
  ///
  /// In en, this message translates to:
  /// **'next'**
  String get next;

  ///  زر التخطي
  ///
  /// In en, this message translates to:
  /// **'skip'**
  String get skip;

  ///  انظم الينا
  ///
  /// In en, this message translates to:
  /// **' Join Us'**
  String get joinUs;

  ///  طريقة بسيطة وموثوقة للتبرع
  ///
  /// In en, this message translates to:
  /// **'A simple and trusted way to donate'**
  String get subJoin;

  ///   أحدث فرقاً في حياة شخص ما
  ///
  /// In en, this message translates to:
  /// **' make a difference in someone\'s life'**
  String get supWelcom;

  ///    مرحبا في في التطبيق
  ///
  /// In en, this message translates to:
  /// **'welcome to donation'**
  String get welcome;

  /// البريد الالكتروني
  ///
  /// In en, this message translates to:
  /// **'email'**
  String get email;

  /// الرقم السري
  ///
  /// In en, this message translates to:
  /// **'password'**
  String get password;

  /// ليس لديك حساب
  ///
  /// In en, this message translates to:
  /// **'You don\'t have an account'**
  String get daccount;

  ///   تسجيل
  ///
  /// In en, this message translates to:
  /// **'Registration'**
  String get registration;

  ///   انضم الينا
  ///
  /// In en, this message translates to:
  /// **'  join us'**
  String get join;

  ///   الاسم
  ///
  /// In en, this message translates to:
  /// **'user name'**
  String get name;

  ///   هل لديك  حساب؟
  ///
  /// In en, this message translates to:
  /// **'Do you have an account?'**
  String get haccount;

  ///   هل نسيت كلمة المرور
  ///
  /// In en, this message translates to:
  /// **'Forgot your password?'**
  String get forgot;

  ///  استعدها
  ///
  /// In en, this message translates to:
  /// **'Reset it'**
  String get reset;

  ///  ادخل بريدك الالكتروني
  ///
  /// In en, this message translates to:
  /// **' Enter your email to receive a password reset link'**
  String get enteryouremail;

  ///  تذكرت
  ///
  /// In en, this message translates to:
  /// **' Remember your password?'**
  String get remember;

  /// نص لزر أو رابط إعادة تعيين كلمة المرور
  ///
  /// In en, this message translates to:
  /// **'Did you forget your password?'**
  String get forgotpassword;

  /// Text shown to the user for a button or link
  ///
  /// In en, this message translates to:
  /// **'Click here'**
  String get clickhere_en;

  /// تاكيد كلمة السر
  ///
  /// In en, this message translates to:
  /// **'  Confirm password'**
  String get confirm;

  /// App theme mode setting (light or dark)
  ///
  /// In en, this message translates to:
  /// **'Theme Mode'**
  String get themeMode;

  /// App language selection setting
  ///
  /// In en, this message translates to:
  /// **'Language'**
  String get language;

  /// Policies and control options section
  ///
  /// In en, this message translates to:
  /// **'Policies and Controls'**
  String get policiesControls;

  /// Frequently asked questions section
  ///
  /// In en, this message translates to:
  /// **'Frequently Asked Questions'**
  String get faq;

  /// First FAQ question
  ///
  /// In en, this message translates to:
  /// **'How do I create an account?'**
  String get faq_q1;

  /// Answer to the first FAQ question
  ///
  /// In en, this message translates to:
  /// **'Click on Sign Up and enter your personal details.'**
  String get faq_a1;

  /// Second FAQ question
  ///
  /// In en, this message translates to:
  /// **'How do I donate?'**
  String get faq_q2;

  /// Answer to the second FAQ question
  ///
  /// In en, this message translates to:
  /// **'Choose a category, select an institution, and complete the payment process.'**
  String get faq_a2;

  /// Third FAQ question
  ///
  /// In en, this message translates to:
  /// **'Is my donation secure?'**
  String get faq_q3;

  /// Answer to the third FAQ question
  ///
  /// In en, this message translates to:
  /// **'Yes, all donations are securely stored and processed.'**
  String get faq_a3;

  /// Fourth FAQ question
  ///
  /// In en, this message translates to:
  /// **'Can I see my donation history?'**
  String get faq_q4;

  /// Answer to the fourth FAQ question
  ///
  /// In en, this message translates to:
  /// **'Yes, you can view all your previous donations in your profile.'**
  String get faq_a4;

  /// Fifth FAQ question
  ///
  /// In en, this message translates to:
  /// **'How are institutions verified?'**
  String get faq_q5;

  /// Answer to the fifth FAQ question
  ///
  /// In en, this message translates to:
  /// **'Institutions are reviewed and approved by the admin before being published.'**
  String get faq_a5;

  /// Validation message when the field is empty
  ///
  /// In en, this message translates to:
  /// **'This field is required'**
  String get required_field;

  /// Validation message for invalid email format
  ///
  /// In en, this message translates to:
  /// **'Enter a valid email'**
  String get invalid_email;

  /// Validation message for password length requirement
  ///
  /// In en, this message translates to:
  /// **'Password must be between 8 and 12 characters'**
  String get password_length;

  /// Validation message when password and confirm password do not match
  ///
  /// In en, this message translates to:
  /// **'Password and confirm password must match'**
  String get password_match;

  /// Message asking the user to enter their email
  ///
  /// In en, this message translates to:
  /// **'Please enter your email'**
  String get enter_email;

  /// Message asking the user to verify their email before logging in
  ///
  /// In en, this message translates to:
  /// **'Please verify your email before logging in.'**
  String get verify_email_before_login;

  /// Message shown when no user is found for the entered email
  ///
  /// In en, this message translates to:
  /// **'No user found for that email'**
  String get no_user_found_email;

  /// Message shown when an incorrect password is entered for the user
  ///
  /// In en, this message translates to:
  /// **'Wrong password provided for that user'**
  String get wrong_password;

  /// General message when login attempt fails
  ///
  /// In en, this message translates to:
  /// **'Login failed'**
  String get login_failed;

  /// Message shown after sending the verification email to the user
  ///
  /// In en, this message translates to:
  /// **'Verification email sent. Please check your email and confirm your account.'**
  String get verification_email_sent;

  /// Message shown when the provided password is too weak
  ///
  /// In en, this message translates to:
  /// **'The password provided is too weak'**
  String get weak_password;

  /// Message shown when an account already exists for the entered email
  ///
  /// In en, this message translates to:
  /// **'The account already exists for that email'**
  String get email_already_exists;

  /// Message shown when the user signs in successfully
  ///
  /// In en, this message translates to:
  /// **'Signed in successfully'**
  String get signed_in_successfully;

  /// Phone number field label
  ///
  /// In en, this message translates to:
  /// **'Phone'**
  String get phone;

  /// Reset password button or screen title
  ///
  /// In en, this message translates to:
  /// **'Reset password'**
  String get reset_password;

  /// Generic error message when an unexpected error occurs
  ///
  /// In en, this message translates to:
  /// **'Something went wrong'**
  String get something_went_wrong;

  /// Message shown when the password reset email is successfully sent
  ///
  /// In en, this message translates to:
  /// **'Password reset email sent'**
  String get password_reset_email_sent;

  /// Button or action label for deleting a category
  ///
  /// In en, this message translates to:
  /// **'Delete Category'**
  String get delete_category;

  /// Confirmation message before deleting a category
  ///
  /// In en, this message translates to:
  /// **'Are you sure you want to delete this category?'**
  String get confirm_delete_category;

  /// Button or title label for editing a category
  ///
  /// In en, this message translates to:
  /// **'Edit Category'**
  String get edit_category;

  /// Save button label
  ///
  /// In en, this message translates to:
  /// **'Save'**
  String get save;

  /// Cancel button label
  ///
  /// In en, this message translates to:
  /// **'Cancel'**
  String get cancel;

  /// Institutions label or title
  ///
  /// In en, this message translates to:
  /// **'Institutions'**
  String get institutions;

  /// Button or title label for updating an institution
  ///
  /// In en, this message translates to:
  /// **'Update Institution'**
  String get update_institution;

  /// Confirmation message before deleting an institution
  ///
  /// In en, this message translates to:
  /// **'Are you sure you want to delete this institution?'**
  String get confirm_delete_institution;

  /// Button or title label for deleting an institution
  ///
  /// In en, this message translates to:
  /// **'Delete Institution'**
  String get delete_institution;

  /// Input field for new name
  ///
  /// In en, this message translates to:
  /// **'Enter new name'**
  String get enter_new_name;

  /// Input field for new description
  ///
  /// In en, this message translates to:
  /// **'Enter new description'**
  String get enter_new_description;

  /// Input field for new donation number
  ///
  /// In en, this message translates to:
  /// **'Enter new donation number'**
  String get enter_new_donation_number;

  /// Button or title label for deleting a campaign
  ///
  /// In en, this message translates to:
  /// **'Delete Campaign'**
  String get delete_campaign;

  /// Confirmation message before deleting a campaign
  ///
  /// In en, this message translates to:
  /// **'Are you sure you want to delete this campaign?'**
  String get confirm_delete_campaign;

  /// Button or title label for deleting a campaign
  ///
  /// In en, this message translates to:
  /// **'Delete Campaign'**
  String get delete_campaigns;

  /// Button or title label for editing a campaign
  ///
  /// In en, this message translates to:
  /// **'Edit Campaign'**
  String get edit_campaign;

  /// Amount input field
  ///
  /// In en, this message translates to:
  /// **'Amount'**
  String get amount;

  /// Generic click text
  ///
  /// In en, this message translates to:
  /// **'Click'**
  String get click;

  /// Payment method card label
  ///
  /// In en, this message translates to:
  /// **'Card'**
  String get card;

  /// Input field for card number
  ///
  /// In en, this message translates to:
  /// **'Card Number'**
  String get card_number;

  /// Validation message for invalid amount
  ///
  /// In en, this message translates to:
  /// **'Enter valid amount'**
  String get enter_valid_amount;

  /// Success message after donation
  ///
  /// In en, this message translates to:
  /// **'Donation Successful'**
  String get donation_successful;

  /// Donate button label
  ///
  /// In en, this message translates to:
  /// **'Donate'**
  String get donate;

  /// Active status
  ///
  /// In en, this message translates to:
  /// **'Active'**
  String get active;

  /// Inactive status
  ///
  /// In en, this message translates to:
  /// **'Inactive'**
  String get inactive;

  /// Admin dashboard title
  ///
  /// In en, this message translates to:
  /// **'Admin Dashboard'**
  String get admin_dashboard;

  /// Button to add a new category
  ///
  /// In en, this message translates to:
  /// **'Add Category'**
  String get add_category;

  /// Button to add a new institution
  ///
  /// In en, this message translates to:
  /// **'Add Institution'**
  String get add_institution;

  /// Button to add a new campaign
  ///
  /// In en, this message translates to:
  /// **'Add Campaign'**
  String get add_campaign;

  /// Welcome message for admin user
  ///
  /// In en, this message translates to:
  /// **'Welcome Admin'**
  String get welcome_admin;

  /// Instruction text in admin dashboard
  ///
  /// In en, this message translates to:
  /// **'Manage the application from here'**
  String get manage_app_here;

  /// Category name field
  ///
  /// In en, this message translates to:
  /// **'Category Name'**
  String get category_name;

  /// Image URL field
  ///
  /// In en, this message translates to:
  /// **'Image URL'**
  String get image_url;
}

class _AppLocalizationsDelegate
    extends LocalizationsDelegate<AppLocalizations> {
  const _AppLocalizationsDelegate();

  @override
  Future<AppLocalizations> load(Locale locale) {
    return SynchronousFuture<AppLocalizations>(lookupAppLocalizations(locale));
  }

  @override
  bool isSupported(Locale locale) =>
      <String>['ar', 'en'].contains(locale.languageCode);

  @override
  bool shouldReload(_AppLocalizationsDelegate old) => false;
}

AppLocalizations lookupAppLocalizations(Locale locale) {
  // Lookup logic when only language code is specified.
  switch (locale.languageCode) {
    case 'ar':
      return AppLocalizationsAr();
    case 'en':
      return AppLocalizationsEn();
  }

  throw FlutterError(
    'AppLocalizations.delegate failed to load unsupported locale "$locale". This is likely '
    'an issue with the localizations generation tool. Please file an issue '
    'on GitHub with a reproducible sample app and the gen-l10n configuration '
    'that was used.',
  );
}
