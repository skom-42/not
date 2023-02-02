import 'package:flutter/material.dart';
import 'package:flutter_slidable/flutter_slidable.dart';
import 'package:noty_mobile/core_ui/src/theme/app_icon_theme.dart';
import 'package:noty_mobile/core_ui/src/theme/app_text_theme.dart';
import 'package:noty_mobile/core_ui/src/theme/app_theme.dart';

class ChatsListItem extends StatelessWidget {
  final String name;
  final Function onTap;
  final Function onDelete;

  const ChatsListItem({
    required this.name,
    required this.onTap,
    required this.onDelete,
    Key? key,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Slidable(
      key: UniqueKey(),
      endActionPane: ActionPane(
        extentRatio: 0.2,
        motion: ScrollMotion(),
        children: [
          SlidableAction(
            onPressed: (BuildContext context) {
              onDelete();
            },
            backgroundColor: Colors.red,
            foregroundColor: Colors.white,
            icon: Icons.delete_forever,
          ),
        ],
      ),
      child: Padding(
        padding: const EdgeInsets.symmetric(vertical: 8),
        child: GestureDetector(
          behavior: HitTestBehavior.opaque,
          onTap: () {
            onTap();
          },
          child: Row(
            crossAxisAlignment: CrossAxisAlignment.center,
            children: <Widget>[
              Image.asset(
                AppIconsTheme.sovuh,
                fit: BoxFit.fill,
                height: 42,
                width: 42,
              ),
              const SizedBox(width: 12),
              Text(
                name,
                style: AppTextTheme.poppins17SemiBold.copyWith(
                  color: AppTheme.lightColor,
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
