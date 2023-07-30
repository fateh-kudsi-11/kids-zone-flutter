import 'package:flutter/cupertino.dart';
import 'package:kidszone/layouts/noti_button.dart';
import 'package:provider/provider.dart';
import '/providers/theme.dart';
import '/layouts/heading_text.dart';

class NotificationPage extends StatefulWidget {
  const NotificationPage({super.key});

  @override
  State<NotificationPage> createState() => _NotificationPageState();
}

class _NotificationPageState extends State<NotificationPage> {
  bool _mainNotif = false;
  bool _discountNotif = false;
  bool _newNotif = false;
  bool _orderNotif = false;
  @override
  Widget build(BuildContext context) {
    final themeDark =
        Provider.of<ThemeManager>(context, listen: false).themeMode;
    return CupertinoPageScaffold(
      navigationBar: CupertinoNavigationBar(
        middle: const HeadingText(
          text: 'Notification',
          size: 18,
          letterSpacing: 0.5,
        ),
        leading: CupertinoButton(
          padding: EdgeInsets.zero,
          child: const Icon(
            CupertinoIcons.back,
            size: 28,
            color: Color(0xff757575),
          ),
          onPressed: () {
            Navigator.of(context).pop();
          },
        ),
      ),
      child: SafeArea(
        child: Column(
          children: [
            Container(
              width: double.infinity,
              height: 46,
              margin: const EdgeInsets.fromLTRB(0, 5, 0, 20),
              color:
                  themeDark ? const Color(0xff1d1d1d) : const Color(0xffeeeeee),
              padding: const EdgeInsets.fromLTRB(20, 10, 20, 10),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  const HeadingText(
                    text: 'ALLOW NOTIFICATIONS',
                    size: 18,
                  ),
                  CupertinoSwitch(
                    activeColor: const Color(0xff3B864F),
                    value: _mainNotif,
                    onChanged: (value) {
                      setState(() {
                        _mainNotif = value;
                        _discountNotif = value;
                        _newNotif = value;
                        _orderNotif = value;
                      });
                    },
                  ),
                ],
              ),
            ),
            NotiButton(
              icon: 'discount',
              title: 'DISCOUNT AND SALES',
              value: _discountNotif,
              onChanged: (value) {
                setState(() {
                  _discountNotif = value;
                });
              },
            ),
            NotiButton(
              icon: 'new',
              title: 'NEW STUFF',
              value: _newNotif,
              onChanged: (value) {
                setState(() {
                  _newNotif = value;
                });
              },
            ),
            NotiButton(
              icon: 'order',
              title: 'ORDER & RETURN UPDATES',
              value: _orderNotif,
              onChanged: (value) {
                setState(() {
                  _orderNotif = value;
                });
              },
            ),
          ],
        ),
      ),
    );
  }
}
