import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';

class SettingsScreen extends StatefulWidget {
  @override
  _SettingsScreenState createState() => _SettingsScreenState();
}

class _SettingsScreenState extends State<SettingsScreen> {
  bool _isDarkMode = false;
  bool _notificationsEnabled = true;
  double _fontSize = 16.0;
  bool _showMatureContent = false;
  double _dailyReadingGoal = 1.0;
  bool _autoDownloadChapters = false;
  bool _offlineMode = false;
  bool _backupData = false;
  String _language = 'English';
  bool _syncAcrossDevices = false;

  @override
  void initState() {
    super.initState();
    _loadPreferences();
  }

  Future<void> _loadPreferences() async {
    final prefs = await SharedPreferences.getInstance();
    setState(() {
      _isDarkMode = prefs.getBool('isDarkMode') ?? false;
      _notificationsEnabled = prefs.getBool('notificationsEnabled') ?? true;
      _fontSize = prefs.getDouble('fontSize') ?? 16.0;
      _showMatureContent = prefs.getBool('showMatureContent') ?? false;
      _dailyReadingGoal = prefs.getDouble('dailyReadingGoal') ?? 1.0;
      _autoDownloadChapters = prefs.getBool('autoDownloadChapters') ?? false;
      _offlineMode = prefs.getBool('offlineMode') ?? false;
      _backupData = prefs.getBool('backupData') ?? false;
      _language = prefs.getString('language') ?? 'English';
      _syncAcrossDevices = prefs.getBool('syncAcrossDevices') ?? false;
    });
  }

  Future<void> _savePreferences() async {
    final prefs = await SharedPreferences.getInstance();
    await prefs.setBool('isDarkMode', _isDarkMode);
    await prefs.setBool('notificationsEnabled', _notificationsEnabled);
    await prefs.setDouble('fontSize', _fontSize);
    await prefs.setBool('showMatureContent', _showMatureContent);
    await prefs.setDouble('dailyReadingGoal', _dailyReadingGoal);
    await prefs.setBool('autoDownloadChapters', _autoDownloadChapters);
    await prefs.setBool('offlineMode', _offlineMode);
    await prefs.setBool('backupData', _backupData);
    await prefs.setString('language', _language);
    await prefs.setBool('syncAcrossDevices', _syncAcrossDevices);
  }

  Future<void> _resetPreferences() async {
    final prefs = await SharedPreferences.getInstance();
    await prefs.clear();
    setState(() {
      _isDarkMode = false;
      _notificationsEnabled = true;
      _fontSize = 16.0;
      _showMatureContent = false;
      _dailyReadingGoal = 1.0;
      _autoDownloadChapters = false;
      _offlineMode = false;
      _backupData = false;
      _language = 'English';
      _syncAcrossDevices = false;
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Settings'),
      ),
      body: ListView(
        padding: EdgeInsets.all(16),
        children: [
          SwitchListTile(
            title: Text('Dark Mode'),
            value: _isDarkMode,
            onChanged: (value) {
              setState(() {
                _isDarkMode = value;
                _savePreferences();
              });
            },
          ),
          SwitchListTile(
            title: Text('Enable Notifications'),
            value: _notificationsEnabled,
            onChanged: (value) {
              setState(() {
                _notificationsEnabled = value;
                _savePreferences();
              });
            },
          ),
          ListTile(
            title: Text('Font Size: ${_fontSize.toStringAsFixed(1)}'),
            subtitle: Slider(
              min: 12.0,
              max: 24.0,
              value: _fontSize,
              onChanged: (value) {
                setState(() {
                  _fontSize = value;
                });
              },
              onChangeEnd: (value) => _savePreferences(),
            ),
          ),
          SwitchListTile(
            title: Text('Show Mature Content'),
            value: _showMatureContent,
            onChanged: (value) {
              setState(() {
                _showMatureContent = value;
                _savePreferences();
              });
            },
          ),
          ListTile(
            title: Text('Daily Reading Goal: ${_dailyReadingGoal.toStringAsFixed(1)} hours'),
            subtitle: Slider(
              min: 0.5,
              max: 5.0,
              divisions: 9,
              value: _dailyReadingGoal,
              onChanged: (value) {
                setState(() {
                  _dailyReadingGoal = value;
                });
              },
              onChangeEnd: (value) => _savePreferences(),
            ),
          ),
          SwitchListTile(
            title: Text('Auto Download Chapters'),
            value: _autoDownloadChapters,
            onChanged: (value) {
              setState(() {
                _autoDownloadChapters = value;
                _savePreferences();
              });
            },
          ),
          SwitchListTile(
            title: Text('Offline Mode'),
            value: _offlineMode,
            onChanged: (value) {
              setState(() {
                _offlineMode = value;
                _savePreferences();
              });
            },
          ),
          SwitchListTile(
            title: Text('Backup Data Automatically'),
            value: _backupData,
            onChanged: (value) {
              setState(() {
                _backupData = value;
                _savePreferences();
              });
            },
          ),
          ListTile(
            title: Text('Language'),
            subtitle: DropdownButton<String>(
              value: _language,
              onChanged: (String? newValue) {
                setState(() {
                  _language = newValue!;
                  _savePreferences();
                });
              },
              items: <String>['English', 'Japanese', 'Spanish', 'French']
                  .map<DropdownMenuItem<String>>((String value) {
                return DropdownMenuItem<String>(
                  value: value,
                  child: Text(value),
                );
              }).toList(),
            ),
          ),
          SwitchListTile(
            title: Text('Sync Across Devices'),
            value: _syncAcrossDevices,
            onChanged: (value) {
              setState(() {
                _syncAcrossDevices = value;
                _savePreferences();
              });
            },
          ),
          SizedBox(height: 20),
          ElevatedButton(
            onPressed: _resetPreferences,
            child: Text('Reset to Default'),
            style: ElevatedButton.styleFrom(
              backgroundColor: Colors.redAccent,
            ),
          ),
        ],
      ),
    );
  }
}
