import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import '../models/appconfig.dart';

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

  const StudentInfoRow({
    Key? key,
    required this.colors,
    required this.studentName,
    required this.studentClass,
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
        ],
      ),
    );
  }
}

class ProfileCard extends StatelessWidget {
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
  Widget build(BuildContext context) {
    return Card(
      color: colors['primary'],
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
                    color: colors['surface'],
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
                    color: colors['text'],
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
                          color: colors['text'],
                          fontSize: 16,
                          fontWeight: FontWeight.bold,
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
            colors: colors,
            studentName: studentName,
            studentClass: studentClass,
          ),
        ],
      ),
    );
  }
}