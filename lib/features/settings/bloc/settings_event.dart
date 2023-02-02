part of 'settings_bloc.dart';

abstract class SettingsEvent {}

class UpdateProfile implements SettingsEvent {}

class VerifyAccount implements SettingsEvent {}

class ChangePassword implements SettingsEvent {}

class PrivacyPolicy implements SettingsEvent {}

class TermsAndConditions implements SettingsEvent {}

class InviteNotyfer implements SettingsEvent {}

class LiveReview implements SettingsEvent {}

class ContactSupport implements SettingsEvent {}

class SupportNoty implements SettingsEvent {}

class Logout implements SettingsEvent {}

class DeleteAccount implements SettingsEvent {}

class SubscribeToMailList implements SettingsEvent {}

class OpenFacebook implements SettingsEvent {}

class OpenInstagram implements SettingsEvent {}

class OpenTwitter implements SettingsEvent {}

class OpenTikTok implements SettingsEvent {}

class OpenTelegram implements SettingsEvent {}
