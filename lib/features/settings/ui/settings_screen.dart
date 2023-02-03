import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:navigation/navigation.dart';
import 'package:noty_mobile/core/di/app_di.dart';
import 'package:noty_mobile/core/localization/localization.dart';
import 'package:noty_mobile/core_ui/src/theme/app_text_theme.dart';
import 'package:noty_mobile/core_ui/src/theme/app_theme.dart';
import 'package:noty_mobile/core_ui/src/widgets/app_background_image.dart';
import 'package:noty_mobile/core_ui/src/widgets/page_app_bar.dart';
import 'package:noty_mobile/core_ui/src/widgets/settings_sub_tile.dart';
import 'package:noty_mobile/core_ui/src/widgets/settings_title.dart';
import 'package:noty_mobile/features/settings/bloc/settings_bloc.dart';

class SettingsScreen extends StatelessWidget {
  const SettingsScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return AppBackgroundImage(
      child: Scaffold(
        backgroundColor: Colors.transparent,
        appBar: PageAppBar(
          title: AppLocalizations.of(context).value('Profile'),
          color: AppTheme.lightColor,
          onLeadingPressed: () {
            appLocator<AppRouterDelegate>().pop();
          },
        ),
        body: BlocBuilder<SettingsBloc, SettingsState>(
          builder: (BuildContext context, SettingsState state) {
            return Padding(
              padding: const EdgeInsets.only(left: 28),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    AppLocalizations.of(context).value('Settings'),
                    style: AppTextTheme.poppins24Medium.copyWith(
                      color: AppTheme.lightColor,
                    ),
                  ),
                  Expanded(
                    child: SingleChildScrollView(
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: <Widget>[
                          SettingsTitle(
                            title: AppLocalizations.of(context).value('Profile'),
                          ),
                          SettingSubTile(
                            isNeedChevron: true,
                            title: AppLocalizations.of(context).value('Update Profile'),
                            leadingIcon: CupertinoIcons.profile_circled,
                            onPressed: () {
                              context.read<SettingsBloc>().add(UpdateProfile());
                            },
                          ),
                          SettingSubTile(
                            title: AppLocalizations.of(context).value('Verify account'),
                            leadingIcon: CupertinoIcons.person_crop_circle_fill_badge_checkmark,
                            onPressed: () {
                              context.read<SettingsBloc>().add(VerifyAccount());
                            },
                          ),
                          SettingsTitle(
                            title: AppLocalizations.of(context).value(
                              'Security & Privacy',
                            ),
                          ),
                          SettingSubTile(
                            isNeedChevron: true,
                            title: AppLocalizations.of(context).value('Change password'),
                            leadingIcon: Icons.key_outlined,
                            onPressed: () {
                              context.read<SettingsBloc>().add(ChangePassword());
                            },
                          ),
                          SettingSubTile(
                            title: AppLocalizations.of(context).value('Privacy Policy'),
                            leadingIcon: CupertinoIcons.eye,
                            onPressed: () {
                              context.read<SettingsBloc>().add(PrivacyPolicy());
                            },
                          ),
                          SettingSubTile(
                            title: AppLocalizations.of(context).value('Terms & Conditions'),
                            leadingIcon: CupertinoIcons.news,
                            onPressed: () {
                              context.read<SettingsBloc>().add(TermsAndConditions());
                            },
                          ),
                          SettingsTitle(
                            title: AppLocalizations.of(context)
                                .value(AppLocalizations.of(context).value('App')),
                          ),
                          SettingSubTile(
                            title: AppLocalizations.of(context).value('Invite NOTYFER'),
                            leadingIcon: CupertinoIcons.paperplane,
                            onPressed: () {
                              context.read<SettingsBloc>().add(InviteNotyfer());
                            },
                          ),
                          SettingSubTile(
                            title: AppLocalizations.of(context).value('Leave a review'),
                            leadingIcon: CupertinoIcons.star,
                            onPressed: () {
                              context.read<SettingsBloc>().add(LiveReview());
                            },
                          ),
                          SettingSubTile(
                            title: AppLocalizations.of(context).value('Contact support'),
                            leadingIcon: CupertinoIcons.mail,
                            onPressed: () {
                              context.read<SettingsBloc>().add(ContactSupport());
                            },
                          ),
                          SettingSubTile(
                            isNeedChevron: true,
                            title: 'Supporta NOTY',
                            onPressed: () {
                              context.read<SettingsBloc>().add(SupportNoty());
                            },
                          ),
                          SettingSubTile(
                            title: AppLocalizations.of(context).value('Logout'),
                            leadingIcon: Icons.logout_outlined,
                            onPressed: () {
                              context.read<SettingsBloc>().add(Logout());
                            },
                          ),
                          SettingSubTile(
                            title: AppLocalizations.of(context).value('Delete account'),
                            leadingIcon: CupertinoIcons.trash,
                            onPressed: () {
                              context.read<SettingsBloc>().add(DeleteAccount());
                            },
                          ),
                          const SettingsTitle(title: 'Social'),
                          SettingSubTile(
                            isNeedChevron: true,
                            title: 'Iscriviti alla mailing list',
                            leadingIcon: CupertinoIcons.envelope_badge,
                            onPressed: () {
                              context.read<SettingsBloc>().add(SubscribeToMailList());
                            },
                          ),
                          SettingSubTile(
                            isNeedChevron: true,
                            title: 'Facebook',
                            leadingIcon: FontAwesomeIcons.facebook,
                            onPressed: () {
                              context.read<SettingsBloc>().add(OpenFacebook());
                            },
                          ),
                          SettingSubTile(
                            isNeedChevron: true,
                            title: 'Instagram',
                            leadingIcon: FontAwesomeIcons.instagram,
                            onPressed: () {
                              context.read<SettingsBloc>().add(OpenInstagram());
                            },
                          ),
                          SettingSubTile(
                            isNeedChevron: true,
                            title: 'Twitter',
                            leadingIcon: FontAwesomeIcons.twitter,
                            onPressed: () {
                              context.read<SettingsBloc>().add(OpenTwitter());
                            },
                          ),
                          SettingSubTile(
                            isNeedChevron: true,
                            title: 'Tik Tok',
                            leadingIcon: FontAwesomeIcons.tiktok,
                            onPressed: () {
                              context.read<SettingsBloc>().add(OpenTikTok());
                            },
                          ),
                          SettingSubTile(
                            isNeedChevron: true,
                            title: 'Telegram',
                            leadingIcon: FontAwesomeIcons.telegram,
                            onPressed: () {
                              context.read<SettingsBloc>().add(OpenTelegram());
                            },
                          ),
                          const SizedBox(height: 30),
                        ],
                      ),
                    ),
                  ),
                ],
              ),
            );
          },
        ),
      ),
    );
  }
}
