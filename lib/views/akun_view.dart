import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import '../models/appconfig.dart';
import '../components/nav_bar.dart';

class AkunView extends StatefulWidget {
  const AkunView({super.key});

  @override
  State<AkunView> createState() => _AkunViewState();
}

class _AkunViewState extends State<AkunView> {
  final _emailController = TextEditingController(text: 'john.doe@example.com');
  final _passwordController = TextEditingController(text: '********');
  bool _obscurePassword = true;

  @override
  Widget build(BuildContext context) {
    final colors = context.watch<AppConfig>().colorPalette;

    return Scaffold(
      backgroundColor: colors['background'],
      bottomNavigationBar: BottomNavBar(
        currentRoute: '/akun',
        onItemTapped: (route) {
          if (route != '/akun') {
            Navigator.pushReplacementNamed(context, route);
          }
        },
      ),
      body: Column(
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
                    color: colors['primary'],
                  ),
                ),
                const SizedBox(width: 16),
                // User Info
                Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      'John Doe',
                      style: TextStyle(
                        color: colors['text'],
                        fontSize: 18,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                    const SizedBox(height: 4),
                    Text(
                      'Siswa',
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
          //email & password card
          Container(
            margin: const EdgeInsets.only(left: 25, right: 25, bottom: 25),
            padding: const EdgeInsets.all(25),
            decoration: BoxDecoration(
              color: colors['card'],
              borderRadius: BorderRadius.circular(24),
            ),
            child: Column(
              children: [
                // Email
                Row(
                  mainAxisAlignment: MainAxisAlignment.start,
                  children: [
                    Icon(
                      Icons.email_outlined,
                      color: colors['primaryLight'],
                    ),
                    const SizedBox(width: 8),
                    Text(
                      'Email',
                      style: TextStyle(
                        color: colors['text'],
                        fontSize: 16,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                  ],
                ),
                const SizedBox(height: 8),
                Container(
                  padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 10),
                  decoration: BoxDecoration(
                    color: colors['surface'],
                    borderRadius: BorderRadius.circular(11),
                    border: Border.all(color: colors['outline'] ?? Colors.grey.shade300),
                  ),
                  child: TextFormField(
                    controller: _emailController,
                    style: TextStyle(
                      color: colors['text'],
                      fontSize: 14,
                    ),
                    decoration: const InputDecoration(
                      border: InputBorder.none,
                      isDense: true,
                      contentPadding: EdgeInsets.zero,
                    ),
                    keyboardType: TextInputType.emailAddress,
                    onChanged: (value) {
                      // Handle email change
                    },
                  ),
                ),
                const SizedBox(height: 24),
                // Password
                Row(
                  mainAxisAlignment: MainAxisAlignment.start,
                  children: [
                    Icon(
                      Icons.lock_outlined,
                      color: colors['primaryLight'],
                    ),
                    const SizedBox(width: 8),
                    Text(
                      'Password',
                      style: TextStyle(
                        color: colors['text'],
                        fontSize: 16,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                  ],
                ),
                const SizedBox(height: 8),
                Container(
                  padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 10),
                  decoration: BoxDecoration(
                    color: colors['surface'],
                    borderRadius: BorderRadius.circular(11),
                    border: Border.all(color: colors['outline'] ?? Colors.grey.shade300),
                  ),
                  child: Row(
                    children: [
                      Expanded(
                        child: TextFormField(
                          controller: _passwordController,
                          obscureText: _obscurePassword,
                          style: TextStyle(
                            color: colors['text'],
                            fontSize: 14,
                          ),
                          decoration: const InputDecoration(
                            border: InputBorder.none,
                            isDense: true,
                            contentPadding: EdgeInsets.zero,
                          ),
                        ),
                      ),
                      GestureDetector(
                        onTap: () {
                          setState(() {
                            _obscurePassword = !_obscurePassword;
                          });
                        },
                        child: Padding(
                          padding: const EdgeInsets.only(left: 8.0),
                          child: Icon(
                            _obscurePassword ? Icons.visibility : Icons.visibility_off,
                            color: colors['textSecondary'],
                            size: 20,
                          ),
                        ),
                      ),
                    ],
                  ),
                ),
              ],
            ),
          ),
          // Logout Button
          Container(
            margin: const EdgeInsets.symmetric(horizontal: 25, vertical: 8),
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
    );
  }
}
