import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_share/flutter_share.dart';
import 'package:navigation/navigation.dart';
import 'package:noty_mobile/core/utils/url_launcher.dart';
import 'package:noty_mobile/core_ui/src/dialogs/dialog_for_result/dialog_for_result_page.dart';
import 'package:noty_mobile/features/auth/forgot_password/ui/forgot_password_page.dart';
import 'package:noty_mobile/features/update_profile/ui/update_account_page.dart';

part 'settings_event.dart';

part 'settings_state.dart';

class SettingsBloc extends Bloc<SettingsEvent, SettingsState> {
  final AppRouterDelegate _appRouter;

  SettingsBloc({
    required AppRouterDelegate appRouter,
  })  : _appRouter = appRouter,
        super(ContentState()) {
    on<UpdateProfile>(_onUpdateAccount);
    on<VerifyAccount>(_onVerifyAccount);
    on<ChangePassword>(_onChangePassword);
    on<PrivacyPolicy>(_onPrivacyPolicy);
    on<TermsAndConditions>(_onTermsAndConditions);
    on<InviteNotyfer>(_onInviteNotyfer);
    on<LiveReview>(_onLiveReview);
    on<ContactSupport>(_onContactSupport);
    on<SupportNoty>(_onSupportNoty);
    on<Logout>(_onLogout);
    on<DeleteAccount>(_onDeleteAccount);
    on<SubscribeToMailList>(_onSubscribeToMailList);
    on<OpenFacebook>(_onOpenFacebook);
    on<OpenInstagram>(_onOpenInstagram);
    on<OpenTwitter>(_onOpenTwitter);
    on<OpenTikTok>(_onOpenTikTok);
    on<OpenTelegram>(_onOpenTelegram);
  }

  Future<void> _onUpdateAccount(
    UpdateProfile event,
    Emitter<SettingsState> emit,
  ) async {
    _appRouter.push(UpdateProfilePage());
  }

  Future<void> _onVerifyAccount(
    VerifyAccount event,
    Emitter<SettingsState> emit,
  ) async {}

  Future<void> _onChangePassword(
    ChangePassword event,
    Emitter<SettingsState> emit,
  ) async {
    _appRouter.push(const ForgotPasswordPage());
  }

  Future<void> _onPrivacyPolicy(
    PrivacyPolicy event,
    Emitter<SettingsState> emit,
  ) async {
    await UrlLauncher.openLink(url: 'https://notyapp.it/privacy-policy/');
  }

  Future<void> _onTermsAndConditions(
    TermsAndConditions event,
    Emitter<SettingsState> emit,
  ) async {
    await UrlLauncher.openLink(url: 'https://notyapp.it/termini-e-condizioni/');
  }

  Future<void> _onInviteNotyfer(
    InviteNotyfer event,
    Emitter<SettingsState> emit,
  ) async {
    await _shareData();
  }

  Future<void> _onLiveReview(
    LiveReview event,
    Emitter<SettingsState> emit,
  ) async {
    //No need to implement
  }

  Future<void> _onContactSupport(
    ContactSupport event,
    Emitter<SettingsState> emit,
  ) async {
    await UrlLauncher.openEmail(emailAddress: 'support@notyapp.it');
  }

  Future<void> _onSupportNoty(
    SupportNoty event,
    Emitter<SettingsState> emit,
  ) async {}

  Future<void> _onLogout(
    Logout event,
    Emitter<SettingsState> emit,
  ) async {}

  Future<void> _onDeleteAccount(
    DeleteAccount event,
    Emitter<SettingsState> emit,
  ) async {
    final bool? result = await _appRouter.pushForResult(
      const DialogForResultPage(
        title: 'Delete Account',
        message: 'Do you really want to delete your account?',
      ),
    );

    if (result != null && result) {}
  }

  Future<void> _onSubscribeToMailList(
    SubscribeToMailList event,
    Emitter<SettingsState> emit,
  ) async {
    await UrlLauncher.openLink(url: 'https://notyapp.it/iscriviti-alla-newsletter/');
  }

  Future<void> _onOpenFacebook(
    OpenFacebook event,
    Emitter<SettingsState> emit,
  ) async {
    await UrlLauncher.openLink(url: 'https://www.facebook.com/notyapp');
  }

  Future<void> _onOpenInstagram(
    OpenInstagram event,
    Emitter<SettingsState> emit,
  ) async {
    await UrlLauncher.openLink(url: 'https://www.instagram.com/notyapp/');
  }

  Future<void> _onOpenTwitter(
    OpenTwitter event,
    Emitter<SettingsState> emit,
  ) async {
    await UrlLauncher.openLink(url: 'https://twitter.com/Noty_app');
  }

  Future<void> _onOpenTikTok(
    OpenTikTok event,
    Emitter<SettingsState> emit,
  ) async {
    await UrlLauncher.openLink(url: 'https://www.tiktok.com/@noty.app');
  }

  Future<void> _onOpenTelegram(
    OpenTelegram event,
    Emitter<SettingsState> emit,
  ) async {
    await UrlLauncher.openLink(url: 'https://t.me/noty_app');
  }

  Future<void> _shareData() async {
    await FlutterShare.share(
      title: 'Hey!',
      text: 'Download Noty from the App Store at: ',
      linkUrl: 'https://apps.apple.com/app/noty/id6443537056',
      chooserTitle: '',
    );
  }
}
