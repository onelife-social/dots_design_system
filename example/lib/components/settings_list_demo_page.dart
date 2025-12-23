import 'package:dots_design_system/dots_design_system.dart';
import 'package:flutter/material.dart';

class SettingsListDemoPage extends StatefulWidget {
  const SettingsListDemoPage({super.key});

  @override
  State<SettingsListDemoPage> createState() => _SettingsListDemoPageState();
}

class _SettingsListDemoPageState extends State<SettingsListDemoPage> {
  bool _notificationsEnabled = true;
  bool _emailNotificationsEnabled = false;
  bool _autoBackupEnabled = true;
  bool _locationEnabled = false;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: context.dotsTheme.colors.bgContainerSecondary,
      body: SafeArea(
        child: SingleChildScrollView(
          padding: const EdgeInsets.all(16),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              const SizedBox(height: 20),
              SettingsList(
                title: 'Account',
                description: 'Manage your account settings and preferences',
                items: [
                  SettingsItem(
                    variant: SettingsItemVariant.icon,
                    label: 'Profile Settings',
                    startIcon: DotsIconData.user,
                    endIcon: DotsIconData.chevronRight,
                    onTap: () {
                      ScaffoldMessenger.of(context).showSnackBar(
                        const SnackBar(content: Text('Profile Settings tapped')),
                      );
                    },
                  ),
                ],
              ),
              const SizedBox(height: 32),
              SettingsList(
                title: 'Privacy',
                description: 'Control your privacy and security settings',
                items: [
                  SettingsItem(
                    variant: SettingsItemVariant.icon,
                    label: 'Privacy Policy',
                    startIcon: DotsIconData.lock,
                    endIcon: DotsIconData.chevronRight,
                    onTap: () {
                      ScaffoldMessenger.of(context).showSnackBar(
                        const SnackBar(content: Text('Privacy Policy tapped')),
                      );
                    },
                  ),
                  SettingsItem(
                    variant: SettingsItemVariant.icon,
                    label: 'Terms of Service',
                    startIcon: DotsIconData.bookOpen,
                    endIcon: DotsIconData.chevronRight,
                    onTap: () {
                      ScaffoldMessenger.of(context).showSnackBar(
                        const SnackBar(content: Text('Terms of Service tapped')),
                      );
                    },
                  ),
                  SettingsItem(
                    variant: SettingsItemVariant.icon,
                    label: 'Data Management',
                    startIcon: DotsIconData.archive,
                    endIcon: DotsIconData.chevronRight,
                    onTap: () {
                      ScaffoldMessenger.of(context).showSnackBar(
                        const SnackBar(content: Text('Data Management tapped')),
                      );
                    },
                  ),
                ],
              ),
              const SizedBox(height: 32),
              SettingsList(
                title: 'Notifications',
                description: 'Customize your notification preferences',
                items: [
                  SettingsItem(
                    variant: SettingsItemVariant.toggle,
                    label: 'Push Notifications',
                    startIcon: DotsIconData.notification,
                    toggleValue: _notificationsEnabled,
                    onToggleTap: () {
                      setState(() {
                        _notificationsEnabled = !_notificationsEnabled;
                      });
                    },
                  ),
                  SettingsItem(
                    variant: SettingsItemVariant.toggle,
                    label: 'Email Notifications',
                    startIcon: DotsIconData.send,
                    toggleValue: _emailNotificationsEnabled,
                    onToggleTap: () {
                      setState(() {
                        _emailNotificationsEnabled = !_emailNotificationsEnabled;
                      });
                    },
                  ),
                ],
              ),
              const SizedBox(height: 32),
              SettingsList(
                title: 'General',
                description: 'General app settings and preferences',
                items: [
                  SettingsItem(
                    variant: SettingsItemVariant.icon,
                    label: 'Language',
                    startIcon: DotsIconData.globe,
                    endIcon: DotsIconData.chevronRight,
                    onTap: () {
                      ScaffoldMessenger.of(context).showSnackBar(
                        const SnackBar(content: Text('Language tapped')),
                      );
                    },
                  ),
                  SettingsItem(
                    variant: SettingsItemVariant.toggle,
                    label: 'Auto Backup',
                    startIcon: DotsIconData.cloud,
                    toggleValue: _autoBackupEnabled,
                    onToggleTap: () {
                      setState(() {
                        _autoBackupEnabled = !_autoBackupEnabled;
                      });
                    },
                  ),
                  SettingsItem(
                    variant: SettingsItemVariant.toggle,
                    label: 'Location Services',
                    startIcon: DotsIconData.locationPin,
                    toggleValue: _locationEnabled,
                    onToggleTap: () {
                      setState(() {
                        _locationEnabled = !_locationEnabled;
                      });
                    },
                  ),
                  SettingsItem(
                    variant: SettingsItemVariant.icon,
                    label: 'About',
                    startIcon: DotsIconData.info,
                    endIcon: DotsIconData.chevronRight,
                    onTap: () {
                      ScaffoldMessenger.of(context).showSnackBar(
                        const SnackBar(content: Text('About tapped')),
                      );
                    },
                  ),
                ],
              ),
              const SizedBox(height: 32),
              SettingsList(
                title: 'Support',
                description: 'Get help and contact support',
                items: [
                  SettingsItem(
                    variant: SettingsItemVariant.icon,
                    label: 'Help Center',
                    endIcon: DotsIconData.chevronRight,
                    onTap: () {
                      ScaffoldMessenger.of(context).showSnackBar(
                        const SnackBar(content: Text('Help Center tapped')),
                      );
                    },
                  ),
                  SettingsItem(
                    variant: SettingsItemVariant.icon,
                    label: 'Contact Us',
                    endIcon: DotsIconData.chevronRight,
                    onTap: () {
                      ScaffoldMessenger.of(context).showSnackBar(
                        const SnackBar(content: Text('Contact Us tapped')),
                      );
                    },
                  ),
                ],
              ),
              const SizedBox(height: 40),
            ],
          ),
        ),
      ),
    );
  }
}
