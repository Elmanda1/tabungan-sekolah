import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import '../providers/tabungan_provider.dart';
import '../providers/base_provider.dart';
import '../services/dialog_service.dart';

import '../models/appconfig.dart';
import '../maintemplates.dart';
import '../modules/dashboard_tabungan.dart';
import '../modules/profil_sekolah_siswa.dart';
import '../widgets/profile_card_skeleton.dart';
import '../widgets/dashboard_tabungan_skeleton.dart';
import '../widgets/riwayat_singkat_skeleton.dart';
import '../modules/riwayat_singkat.dart';

class HomeView extends StatefulWidget {
  const HomeView({super.key, required this.title});

  final String title;

  @override
  State<HomeView> createState() => _HomeViewState();
}

class _HomeViewState extends State<HomeView> {
  final DialogService _dialogService = DialogService();

  @override
  void initState() {
    super.initState();
    WidgetsBinding.instance.addPostFrameCallback((_) {
      Provider.of<TabunganProvider>(context, listen: false).fetchData();
    });
  }

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
      body: Consumer<TabunganProvider>(
        builder: (context, tabunganProvider, child) {
          if (tabunganProvider.state == ViewState.loading) {
            return SingleChildScrollView(
              child: Padding(
                padding: const EdgeInsets.all(20.0),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    if (appConfig.featureFlags['feature.home.profile_card.enabled'] ?? false)
                      const Column(
                        children: [
                          ProfileCardSkeleton(),
                          SizedBox(height: 20),
                        ],
                      ),
                    if (appConfig.featureFlags['feature.home.dashboard_tabungan.enabled'] ?? false)
                      const Column(
                        children: [
                          DashboardTabunganSkeleton(),
                          SizedBox(height: 20),
                        ],
                      ),
                    const RiwayatSingkatSkeleton(),
                  ],
                ),
              ),
            );
          }

          if (tabunganProvider.state == ViewState.error) {
            WidgetsBinding.instance.addPostFrameCallback((_) {
              _dialogService.showError(context, tabunganProvider.errorMessage!, tabunganProvider.error);
            });
            return Center(child: Text(tabunganProvider.errorMessage!));
          }

          return SingleChildScrollView(
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
                          userName: tabunganProvider.userProfile?['nama_siswa'] ?? 'N/A',
                          studentName: tabunganProvider.userProfile?['nama_siswa'] ?? 'N/A',
                          studentClass: tabunganProvider.userProfile?['kelas'] ?? 'N/A',
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
                          currentBalance: (tabunganProvider.balance?['saldo'] ?? 0).toDouble(),
                          income: tabunganProvider.income,
                          expenses: tabunganProvider.expenses,
                        ),
                        const SizedBox(height: 20),
                      ],
                    ),
                  
                  // Recent Transactions Card
                  RiwayatSingkat(
                    colors: colors,
                    onViewAll: () async {
                      await Navigator.pushNamed(context, '/riwayat');
                      if (mounted) {
                        Provider.of<TabunganProvider>(context, listen: false).fetchData();
                      }
                    },
                  ),
                ],
              ),
            ),
          );
        },
      ),
    );
  }
}
