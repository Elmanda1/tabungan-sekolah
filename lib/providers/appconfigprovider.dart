import 'package:flutter/material.dart';
import '../models/appconfig.dart';

final dummyAppConfig = AppConfig(
  menuTexts: {
    'beranda': 'Beranda',
    'riwayat': 'Riwayat',
    'transaksi': 'Transaksi',
    'akun': 'Akun',
  },
  menuIcons: {
    'beranda': Icons.home_outlined,
    'riwayat': Icons.history_outlined,
    'transaksi': Icons.add_circle_outline,
    'akun': Icons.person_outline,
  },
  menuActiveIcons: {
    'beranda': Icons.home_filled,
    'riwayat': Icons.history,
    'transaksi': Icons.add_circle,
    'akun': Icons.person,
  },
  colorPalette: <String, Color>{
    // Primary colors
    'primary': const Color(0xFF01986c),     // Green primary color
    'primaryLight': const Color(0xFF34D399), // Lighter green
    'primaryDark': const Color(0xFF047857),  // Darker green
    
    // Background colors
    'background': const Color(0xFF0F172A),   // Dark background
    'surface': const Color(0xFF1E293B),      // Slightly lighter surface color
    'card': const Color(0xFF1E293B),         // Card background
    
    // Text colors
    'text': Colors.white,                   // Primary text
    'textSecondary': const Color(0xFF94A3B8), // Secondary text
    'textTertiary': const Color(0xFF64748B),  // Tertiary/hint text
    
    // Status colors (using only green and red)
    'success': const Color(0xFF10B981),     // Green for success/income
    'error': const Color(0xFFEF4444),       // Red for errors/expenses
    
    // Additional UI colors
    'divider': const Color(0xFF334155),     // For dividers and borders
    'highlight': const Color(0x1AFFFFFF),   // For selection/highlight
  },
  featureFlags: <String, bool>{
    // Navigation items
    'feature.beranda.enabled': true,
    'feature.riwayat.enabled': false,
    'feature.transaksi.enabled': false,
    'feature.akun.enabled': true,
    
    // App features
    'feature.dark_mode': true,
    'feature.notifications': true,
    'feature.biometric_auth': false,
    'feature.offline_mode': true,
    
    // Experimental features
    'feature.experimental_ui': false,
    'feature.analytics': true,
  },
);
