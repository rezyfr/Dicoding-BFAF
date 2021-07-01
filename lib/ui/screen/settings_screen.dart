import 'dart:io';

import 'package:dicoding_flutter_fundamental/common/navigation.dart';
import 'package:dicoding_flutter_fundamental/provider/preferences_provider.dart';
import 'package:dicoding_flutter_fundamental/provider/scheduling_provider.dart';
import 'package:dicoding_flutter_fundamental/widgets/platform_widget.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

class SettingsScreen extends StatelessWidget {
  static String routeName = '/settings_screen';
  static const String settingsTitle = 'Settings';

  Widget _buildAndroid(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(settingsTitle),
      ),
      body: _buildList(context),
    );
  }

  Widget _buildIos(BuildContext context) {
    return CupertinoPageScaffold(
      navigationBar: CupertinoNavigationBar(
        middle: Text(settingsTitle),
      ),
      child: _buildList(context),
    );
  }

  Widget _buildList(BuildContext context) {
    return Consumer<PreferencesProvider>(
      builder: (context, provider, child) {
        return ListView(
          children: [
            Material(
              child: ListTile(
                title: Text('Scheduling Reminder'),
                trailing: Consumer<SchedulingProvider>(
                  builder: (context, scheduled, _) {
                    return Switch.adaptive(
                      value: provider.isDailyReminderActive,
                      onChanged: (value) async {
                        if (Platform.isIOS) {
                          showCupertinoDialog(
                            context: context,
                            barrierDismissible: true,
                            builder: (context) {
                              return CupertinoAlertDialog(
                                title: Text('Coming Soon!'),
                                content:
                                    Text('This feature will be coming soon!'),
                                actions: [
                                  CupertinoDialogAction(
                                    child: Text('Ok'),
                                    onPressed: () {
                                      Navigation.back();
                                    },
                                  ),
                                ],
                              );
                            },
                          );
                        } else {
                          scheduled.scheduledReminder(value);
                          provider.enableDailyReminder(value);
                        }
                      },
                    );
                  },
                ),
              ),
            ),
          ],
        );
      },
    );
  }

  @override
  Widget build(BuildContext context) {
    return PlatformWidget(
      androidBuilder: _buildAndroid,
      iosBuilder: _buildIos,
    );
  }
}
