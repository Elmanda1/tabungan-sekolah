import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import '../models/appconfig.dart';
import '../maintemplates.dart';
import '../services/akun_service.dart';

class AkunView extends StatefulWidget {
  const AkunView({super.key});

  @override
  State<AkunView> createState() => _AkunViewState();
}

class _AkunViewState extends State<AkunView> {
  Map<String, dynamic>? _userData;
  bool _isLoading = true;

  final _currentPasswordController = TextEditingController();
  final _newPasswordController = TextEditingController();
  final _confirmNewPasswordController = TextEditingController();

  @override
  void initState() {
    super.initState();
    _loadUserData();
  }

  Future<void> _loadUserData() async {
    try {
      final akunService = Provider.of<AkunService>(context, listen: false);
      final userData = await akunService.getAkunInfo();
      setState(() {
        _userData = userData;
        _isLoading = false;
      });
    } catch (e) {
      // Handle error
      setState(() {
        _isLoading = false;
      });
    }
  }

  Future<void> _changePassword() async {
    if (_newPasswordController.text != _confirmNewPasswordController.text) {
      // Show error dialog
      showDialog(
        context: context,
        builder: (context) => AlertDialog(
          title: const Text('Error'),
          content: const Text('New passwords do not match.'),
          actions: [
            TextButton(
              onPressed: () => Navigator.of(context).pop(),
              child: const Text('OK'),
            ),
          ],
        ),
      );
      return;
    }

    try {
      final akunService = Provider.of<AkunService>(context, listen: false);
      await akunService.changePassword(
        _currentPasswordController.text,
        _newPasswordController.text,
      );
      // Show success dialog
      showDialog(
        context: context,
        builder: (context) => AlertDialog(
          title: const Text('Success'),
          content: const Text('Password changed successfully.'),
          actions: [
            TextButton(
              onPressed: () => Navigator.of(context).pop(),
              child: const Text('OK'),
            ),
          ],
        ),
      );
    } catch (e) {
      // Show error dialog
      showDialog(
        context: context,
        builder: (context) => AlertDialog(
          title: const Text('Error'),
          content: Text(e.toString().replaceFirst('Exception: ', '')),
          actions: [
            TextButton(
              onPressed: () => Navigator.of(context).pop(),
              child: const Text('OK'),
            ),
          ],
        ),
      );
    }
  }

  @override
  Widget build(BuildContext context) {
    final colors = context.watch<AppConfig>().colorPalette;

    return MainTemplate(
      backgroundColor: colors['background'],
      body: _isLoading
          ? const Center(child: CircularProgressIndicator())
          : SingleChildScrollView(
              child: Column(
                children: [
                  // Profile Card
                  Container(
                    margin: const EdgeInsets.only(left: 25, right: 25, top: 50, bottom: 25),
                    padding: const EdgeInsets.all(16),
                    decoration: BoxDecoration(
                      color: colors['primary'],
                      borderRadius: BorderRadius.circular(24),
                    ),
                    child: Row(
                      children: [
                        // Profile Icon
                        Container(
                          width: 60,
                          height: 90,
                          decoration: BoxDecoration(
                            color: colors['background'],
                            shape: BoxShape.circle,
                          ),
                          child: Icon(
                            Icons.person_outline,
                            size: 32,
                            color: colors['text'],
                          ),
                        ),
                        const SizedBox(width: 16),
                        // User Info
                        Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Text(
                              _userData?['nama_siswa'] ?? 'User',
                              style: TextStyle(
                                color: colors['text'],
                                fontSize: 18,
                                fontWeight: FontWeight.bold,
                              ),
                            ),
                            const SizedBox(height: 4),
                            Text(
                              _userData?['kelas'] ?? 'Role',
                              style: TextStyle(
                                color: colors['text']?.withOpacity(0.8),
                                fontSize: 14,
                              ),
                            ),
                          ],
                        ),
                      ],
                    ),
                  ),
          // Change Password Card
          Container(
            margin: const EdgeInsets.only(left: 25, right: 25, bottom: 25),
            padding: const EdgeInsets.all(25),
            decoration: BoxDecoration(
              color: colors['card'],
              borderRadius: BorderRadius.circular(24),
            ),
            child: Column(
              children: [
                // Title
                Row(
                  mainAxisAlignment: MainAxisAlignment.start,
                  children: [
                    Icon(
                      Icons.lock_outline,
                      color: colors['primaryLight'],
                    ),
                    const SizedBox(width: 8),
                    Text(
                      'Change Password',
                      style: TextStyle(
                        color: colors['text'],
                        fontSize: 16,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                  ],
                ),
                const SizedBox(height: 24),
                // Current Password
                TextFormField(
                  controller: _currentPasswordController,
                  obscureText: true,
                  decoration: const InputDecoration(labelText: 'Current Password'),
                ),
                const SizedBox(height: 16),
                // New Password
                TextFormField(
                  controller: _newPasswordController,
                  obscureText: true,
                  decoration: const InputDecoration(labelText: 'New Password'),
                ),
                const SizedBox(height: 16),
                // Confirm New Password
                TextFormField(
                  controller: _confirmNewPasswordController,
                  obscureText: true,
                  decoration: const InputDecoration(labelText: 'Confirm New Password'),
                ),
                const SizedBox(height: 24),
                // Change Password Button
                ElevatedButton(
                  onPressed: _changePassword,
                  child: const Text('Change Password'),
                ),
              ],
            ),
          ),
          // Logout Button
          Container(
            margin: const EdgeInsets.symmetric(horizontal: 28, vertical: 8),
            width: double.infinity,
            child: ElevatedButton(
              onPressed: () {
                // Show logout confirmation dialog
                showDialog(
                  context: context,
                  builder: (BuildContext context) {
                    return AlertDialog(
                      backgroundColor: colors['card'],
                      title: Text(
                        'Logout',
                        style: TextStyle(color: colors['text']),
                      ),
                      content: Text(
                        'Are you sure you want to logout?',
                        style: TextStyle(color: colors['textSecondary']),
                      ),
                      actions: [
                        TextButton(
                          onPressed: () => Navigator.of(context).pop(),
                          child: Text(
                            'Cancel',
                            style: TextStyle(color: colors['textSecondary']),
                          ),
                        ),
                        TextButton(
                          onPressed: () {
                            // Navigate to login and remove all previous routes
                            Navigator.of(context).pushNamedAndRemoveUntil(
                              '/',
                              (Route<dynamic> route) => false,
                            );
                          },
                          style: TextButton.styleFrom(
                            foregroundColor: colors['error'],
                          ),
                          child: const Text('LOGOUT'),
                        ),
                      ],
                    );
                  },
                );
              },
              style: ElevatedButton.styleFrom(
                backgroundColor: colors['card'],
                foregroundColor: colors['error'],
                padding: const EdgeInsets.symmetric(vertical: 16),
                shape: RoundedRectangleBorder(
                  side: BorderSide(color: colors['error']!),
                  borderRadius: BorderRadius.circular(10),
                ),
                elevation: 0,
              ),
              child: Row(
                mainAxisSize: MainAxisSize.min,
                children: [
                  const Icon(Icons.logout, size: 20),
                  const SizedBox(width: 8),
                  const Text('Logout', style: TextStyle(fontWeight: FontWeight.bold)),
                ],
              ),
            ),
          ),
        ],
        ),
      ),
    );
  }
}
