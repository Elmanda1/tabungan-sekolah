import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import '../models/appconfig.dart';
import '../maintemplates.dart';
import '../modules/dashboard_tabungan.dart';
import '../modules/profil_sekolah_siswa.dart';
import '../modules/riwayat_singkat.dart';

class HomeView extends StatefulWidget {
  const HomeView({super.key, required this.title});

  final String title;

  @override
  State<HomeView> createState() => _HomeViewState();
}

class _HomeViewState extends State<HomeView> {
  // Dummy data in IDR
  final double _currentBalance = 9400000.00;

  @override
  Widget build(BuildContext context) {
    final appConfig = context.watch<AppConfig>();
    final colors = appConfig.colorPalette;

    return MainTemplate(
      backgroundColor: colors['background'],
      appBar: PreferredSize(
        preferredSize: const Size.fromHeight(0),
        child: AppBar(
          backgroundColor: Colors.transparent,
          elevation: 0,
          automaticallyImplyLeading: false,
        ),
      ),
      body: SingleChildScrollView(
        child: Padding(
          padding: const EdgeInsets.only(left: 20.0, right: 20.0, bottom: 25.0, top: 25.0),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              // Profile Card with Student Info
              if (appConfig.featureFlags['feature.home.profile_card.enabled'] ?? false)
                Column(
                  children: [
                    ProfileCard(
                      colors: colors,
                      userName: 'John Doe',
                      studentName: 'John Doe',
                      studentClass: 'XI IPA 1',
                    ),
                    const SizedBox(height: 20),
                  ],
                ),
              
              // Dashboard Tabungan
              if (appConfig.featureFlags['feature.home.dashboard_tabungan.enabled'] ?? false)
                Column(
                  children: [
                    DashboardTabungan(
                      colors: colors,
                      currentBalance: _currentBalance,
                    ),
                    const SizedBox(height: 20),
                  ],
                ),
              
              // Recent Transactions Card
              RiwayatSingkat(
                colors: colors,
                onViewAll: () {
                  Navigator.pushNamed(context, '/riwayat');
                },
              ),
            ],
          ),
        ),
      ),
    );
  }
}
