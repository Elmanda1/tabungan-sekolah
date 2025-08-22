import 'dart:developer';
import 'package:flutter/material.dart';
import 'package:flutter/foundation.dart';
import 'package:provider/provider.dart';
import 'package:flutter_secure_storage/flutter_secure_storage.dart';
import '../models/appconfig.dart';
import '../services/profile_service.dart';

typedef InfoCardBuilder = Widget Function({
  required String title,
  bool titleOnly,
  String customTitle,
});

// Helper method to build info cards
Widget buildInfoCard({
  required BuildContext context,
  required String title,
  bool titleOnly = false,
  String customTitle = '',
}) {
  final colors = context.read<AppConfig>().colorPalette;

  return Card(
    color: colors['surface'],
    shape: RoundedRectangleBorder(
      borderRadius: BorderRadius.circular(16),
    ),
    child: Padding(
      padding: const EdgeInsets.fromLTRB(12.0, 6.0, 12.0, 6.0),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        mainAxisSize: MainAxisSize.min,
        children: [
          Text(
            title,
            style: TextStyle(
              color: colors['textSecondary'],
              fontSize: 12,
            ),
          ),
          const SizedBox(height: 6),
          Text(
            titleOnly ? customTitle : customTitle,
            style: TextStyle(
              color: colors['text'],
              fontSize: 16,
              fontWeight: FontWeight.bold,
            ),
          ),
        ],
      ),
    ),
  );
}

class StudentInfoRow extends StatelessWidget {
  final Map<String, dynamic> colors;
  final String studentName;
  final String studentClass;
  final String? nisn;
  final String? email;

  const StudentInfoRow({
    Key? key,
    required this.colors,
    required this.studentName,
    required this.studentClass,
    this.nisn,
    this.email,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.fromLTRB(20.0, 0, 20.0, 20.0),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.stretch,
        children: [
          // Student Name Card
          buildInfoCard(
            context: context,
            title: 'Nama',
            titleOnly: true,
            customTitle: studentName,
          ),
          // Student Class Card
          buildInfoCard(
            context: context,
            title: 'Kelas',
            titleOnly: true,
            customTitle: studentClass,
          ),
          // NISN Card if available
          if (nisn != null)
            buildInfoCard(
              context: context,
              title: 'NISN',
              titleOnly: true,
              customTitle: nisn!,
            ),
          // Email Card if available
          if (email != null)
            buildInfoCard(
              context: context,
              title: 'Email',
              titleOnly: true,
              customTitle: email!,
            ),
        ],
      ),
    );
  }
}

class ProfileCard extends StatefulWidget {
  final Map<String, dynamic> colors;
  final String userName;
  final String studentName;
  final String studentClass;

  const ProfileCard({
    Key? key,
    required this.colors,
    required this.userName,
    required this.studentName,
    required this.studentClass,
  }) : super(key: key);

  @override
  _ProfileCardState createState() => _ProfileCardState();
}

class _ProfileCardState extends State<ProfileCard> {
  Map<String, dynamic>? _profileData;
  bool _isLoading = true;
  String _errorMessage = '';

  @override
  void initState() {
    super.initState();
    _loadProfile();
  }

  Future<void> _loadProfile() async {
    log('Starting profile load...');
    setState(() {
      _isLoading = true;
      _errorMessage = '';
    });

    try {
      log('Fetching profile...');
      final token = await const FlutterSecureStorage().read(key: 'auth_token');
      log('Auth token: ${token != null ? 'found' : 'not found'}');
      
      final result = await ProfileService.getProfile();
      
      log('Profile fetch result: $result');
      
      if (mounted) {
        setState(() {
          if (result['success'] == true) {
            _profileData = result['data'];
            log('Profile data loaded successfully');
            log('Data: $_profileData');
          } else {
            _errorMessage = result['message'] ?? 'Failed to load profile';
            log('Profile load failed: $_errorMessage');
            log('Status code: ${result['statusCode']}');
          }
          _isLoading = false;
        });
      }
    } catch (e, stackTrace) {
      log('Exception during profile load: $e');
      log('Stack trace: $stackTrace', error: e, stackTrace: stackTrace);
      if (mounted) {
        setState(() {
          _errorMessage = 'Error loading profile: ${e.toString()}';
          _isLoading = false;
        });
      }
    }
  }

  @override
  Widget build(BuildContext context) {
    return Card(
      color: widget.colors['primary'],
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(16),
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          // Top Row with Profile Info
          Padding(
            padding: const EdgeInsets.fromLTRB(20.0, 20.0, 20.0, 12.0),
            child: Row(
              children: [
                // Profile Avatar
                Container(
                  width: 60,
                  height: 60,
                  decoration: BoxDecoration(
                    color: widget.colors['surface'],
                    borderRadius: BorderRadius.circular(100),
                    boxShadow: [
                      BoxShadow(
                        color: Colors.black.withOpacity(0.1),
                        blurRadius: 4,
                        offset: const Offset(0, 2),
                      ),
                    ],
                  ),
                  child: Icon(
                    Icons.school_outlined,
                    size: 30,
                    color: widget.colors['text'],
                  ),
                ),
                const SizedBox(width: 16),
                // User Info
                Expanded(
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(
                        'Sekolah Menengah Atas Falih',
                        style: TextStyle(
                          color: widget.colors['text'],
                          fontSize: 16,
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                      if (_isLoading)
                        const Padding(
                          padding: EdgeInsets.only(top: 4.0),
                          child: SizedBox(
                            height: 16,
                            width: 100,
                            child: LinearProgressIndicator(),
                          ),
                        ),
                      if (_errorMessage.isNotEmpty)
                        Padding(
                          padding: const EdgeInsets.only(top: 4.0),
                          child: Text(
                            _errorMessage,
                            style: TextStyle(
                              color: Colors.red[200],
                              fontSize: 12,
                            ),
                          ),
                        ),
                    ],
                  ),
                ),
              ],
            ),
          ),
          // Student Info Row
          StudentInfoRow(
            colors: widget.colors,
            studentName: _profileData?['name'] ?? widget.studentName,
            studentClass: _profileData?['class'] ?? widget.studentClass,
            nisn: _profileData?['nisn'],
            email: _profileData?['email'],
          ),
          if (_errorMessage.isNotEmpty)
            Padding(
              padding: const EdgeInsets.only(bottom: 16.0),
              child: Center(
                child: ElevatedButton.icon(
                  onPressed: _loadProfile,
                  icon: const Icon(Icons.refresh),
                  label: const Text('Retry'),
                ),
              ),
            ),
        ],
      ),
    );
  }
}
