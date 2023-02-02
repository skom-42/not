import 'package:flutter/widgets.dart';
import 'package:noty_mobile/core_ui/src/paintes/chat_bubble_painter.dart';
import 'package:noty_mobile/core_ui/src/theme/app_icon_theme.dart';
import 'package:noty_mobile/core_ui/src/theme/app_text_theme.dart';
import 'package:noty_mobile/core_ui/src/theme/app_theme.dart';
import 'package:noty_mobile/domain/models/chat_message.dart';

class MessageWidget extends StatelessWidget {
  final ChatMessage message;
  const MessageWidget({
    Key? key,
    required this.message,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.all(8.0),
      child: Row(
        mainAxisAlignment:
            !message.isMyMessage ? MainAxisAlignment.start : MainAxisAlignment.end,
        children: <Widget>[
          if (!message.isMyMessage)
            Container(
              width: 30,
              height: 30,
              decoration: BoxDecoration(
                  shape: BoxShape.circle,
                  image: DecorationImage(
                      image: Image.asset(
                    AppIconsTheme.chatLogo,
                  ).image)),
            ),
          const SizedBox(
            width: 15,
          ),
          CustomPaint(
            painter: CustomChatBubble(
                color: AppTheme.chatBubbleColor, isOwn: message.isMyMessage),
            child: Container(
              padding: const EdgeInsets.all(8),
              child: Text(
                message.content,
                style: AppTextTheme.poppins14Regular.copyWith(color: AppTheme.lightColor),
              ),
            ),
          ),
          const SizedBox(
            width: 15,
          ),
          if (message.isMyMessage)
            Container(
              width: 30,
              height: 30,
              decoration: BoxDecoration(
                shape: BoxShape.circle,
                image: DecorationImage(
                    image: Image.asset(
                  AppIconsTheme.chatLogo,
                ).image),
              ),
            ),
        ],
      ),
    );
  }
}
