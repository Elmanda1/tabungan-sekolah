import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import '../models/appconfig.dart';
import '../components/nav_bar.dart';

class AkunView extends StatelessWidget {
  const AkunView({super.key});

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
      body: CustomScrollView(
        slivers: [
          SliverAppBar(
            expandedHeight: 180,
            pinned: true,
            backgroundColor: colors['background'],
            elevation: 0,
            flexibleSpace: FlexibleSpaceBar(
              title: Text(
                'My Account',
                style: TextStyle(
                  color: colors['text'],
                  fontWeight: FontWeight.bold,
                ),
              ),
              centerTitle: true,
              background: Container(
                decoration: BoxDecoration(
                  gradient: LinearGradient(
                    begin: Alignment.topCenter,
                    end: Alignment.bottomCenter,
                    colors: [
                      colors['primary']!.withOpacity(0.1),
                      Colors.transparent,
                    ],
                  ),
                ),
              ),
            ),
          ),
          
          // Profile Section
          SliverToBoxAdapter(
            child: Padding(
              padding: const EdgeInsets.all(16.0),
              child: Column(
                children: [
                  // Profile Picture
                  Container(
                    width: 100,
                    height: 100,
                    decoration: BoxDecoration(
                      shape: BoxShape.circle,
                      border: Border.all(
                        color: colors['primary']!,
                        width: 2,
                      ),
                    ),
                    child: ClipOval(
                      child: Container(
                        color: colors['surface'],
                        child: Icon(
                          Icons.person,
                          size: 60,
                          color: colors['textSecondary'],
                        ),
                      ),
                    ),
                  ),
                  
                  const SizedBox(height: 16),
                  
                  // User Name
                  Text(
                    'John Doe',
                    style: TextStyle(
                      color: colors['text'],
                      fontSize: 20,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                  
                  const SizedBox(height: 4),
                  
                  // User Email
                  Text(
                    'john.doe@example.com',
                    style: TextStyle(
                      color: colors['textSecondary'],
                      fontSize: 14,
                    ),
                  ),
                  
                  const SizedBox(height: 24),
                  
                  // Edit Profile Button
                  OutlinedButton(
                    onPressed: () {
                      // TODO: Implement edit profile
                    },
                    style: OutlinedButton.styleFrom(
                      side: BorderSide(color: colors['primary']!),
                      shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(20),
                      ),
                      padding: const EdgeInsets.symmetric(
                        horizontal: 24,
                        vertical: 8,
                      ),
                    ),
                    child: Text(
                      'Edit Profile',
                      style: TextStyle(
                        color: colors['primary'],
                        fontWeight: FontWeight.w500,
                      ),
                    ),
                  ),
                ],
              ),
            ),
          ),
          
          // Account Settings Section
          SliverToBoxAdapter(
            child: Padding(
              padding: const EdgeInsets.symmetric(horizontal: 16.0, vertical: 8.0),
              child: Text(
                'Account Settings',
                style: TextStyle(
                  color: colors['textSecondary'],
                  fontSize: 14,
                  fontWeight: FontWeight.w500,
                ),
              ),
            ),
          ),
          
          SliverList(
            delegate: SliverChildListDelegate([
              _buildListTile(
                context,
                icon: Icons.person_outline,
                title: 'Personal Information',
                onTap: () {
                  // TODO: Navigate to personal info
                },
              ),
              _buildListTile(
                context,
                icon: Icons.notifications_outlined,
                title: 'Notifications',
                onTap: () {
                  // TODO: Navigate to notifications
                },
              ),
              _buildListTile(
                context,
                icon: Icons.lock_outline,
                title: 'Security',
                onTap: () {
                  // TODO: Navigate to security
                },
              ),
              _buildListTile(
                context,
                icon: Icons.payment_outlined,
                title: 'Payment Methods',
                onTap: () {
                  // TODO: Navigate to payment methods
                },
              ),
            ]),
          ),
          
          // More Section
          SliverToBoxAdapter(
            child: Padding(
              padding: const EdgeInsets.only(
                left: 16.0,
                right: 16.0,
                top: 24.0,
                bottom: 8.0,
              ),
              child: Text(
                'More',
                style: TextStyle(
                  color: colors['textSecondary'],
                  fontSize: 14,
                  fontWeight: FontWeight.w500,
                ),
              ),
            ),
          ),
          
          SliverList(
            delegate: SliverChildListDelegate([
              _buildListTile(
                context,
                icon: Icons.help_outline,
                title: 'Help & Support',
                onTap: () {
                  // TODO: Navigate to help & support
                },
              ),
              _buildListTile(
                context,
                icon: Icons.info_outline,
                title: 'About Us',
                onTap: () {
                  // TODO: Navigate to about us
                },
              ),
              _buildListTile(
                context,
                icon: Icons.privacy_tip_outlined,
                title: 'Privacy Policy',
                onTap: () {
                  // TODO: Navigate to privacy policy
                },
              ),
              _buildListTile(
                context,
                icon: Icons.logout,
                title: 'Logout',
                textColor: colors['error'],
                iconColor: colors['error'],
                onTap: () {
                  // Show logout confirmation dialog
                  showDialog(
                    context: context,
                    builder: (BuildContext context) {
                      return AlertDialog(
                        backgroundColor: colors['surface'],
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
              ),
            ]),
          ),
          
          const SliverToBoxAdapter(
            child: SizedBox(height: 24),
          ),
        ],
      ),
    );
  }
  
  Widget _buildListTile(
    BuildContext context, {
    required IconData icon,
    required String title,
    Color? iconColor,
    Color? textColor,
    VoidCallback? onTap,
  }) {
    final colors = context.watch<AppConfig>().colorPalette;
    
    return ListTile(
      leading: Container(
        width: 40,
        height: 40,
        decoration: BoxDecoration(
          color: colors['surface'],
          borderRadius: BorderRadius.circular(8),
        ),
        child: Icon(
          icon,
          color: iconColor ?? colors['textSecondary'],
        ),
      ),
      title: Text(
        title,
        style: TextStyle(
          color: textColor ?? colors['text'],
          fontWeight: FontWeight.w500,
        ),
      ),
      trailing: Icon(
        Icons.chevron_right,
        color: colors['textSecondary'],
      ),
      onTap: onTap,
    );
  }
}
