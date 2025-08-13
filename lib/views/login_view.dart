import 'package:flutter/material.dart';
import '../providers/appconfigprovider.dart';
import '../services/auth_service.dart';

class LoginView extends StatefulWidget {
  const LoginView({super.key});

  @override
  State<LoginView> createState() => _LoginViewState();
}

class _LoginViewState extends State<LoginView> {
  final _formKey = GlobalKey<FormState>();
  final _nisnController = TextEditingController();
  final _passwordController = TextEditingController();
  bool _isLoading = false;
  bool _isPasswordVisible = false;

  // Get the first enabled feature route
  String _getFirstEnabledRoute() {
    final appConfig = dummyAppConfig;
    
    // Define the order of checking routes
    final routesInOrder = [
      {'key': 'beranda', 'route': '/home'},
      {'key': 'riwayat', 'route': '/riwayat'},
      {'key': 'transaksi', 'route': '/transaksi'},
      {'key': 'akun', 'route': '/akun'},
    ];
    
    // Find the first enabled route
    for (var item in routesInOrder) {
      final featureFlag = 'feature.${item['key']}.enabled';
      if (appConfig.isFeatureEnabled(featureFlag)) {
        return item['route']!;
      }
    }
    
    // Fallback to home if no route is enabled (shouldn't happen)
    return '/home';
  }

  // Form validation and submission
  Future<void> _handleLogin() async {
    if (_formKey.currentState!.validate()) {
      setState(() => _isLoading = true);
      
      final nisn = _nisnController.text.trim();
      final password = _passwordController.text;
      
      // Simulate network delay
      await Future.delayed(const Duration(seconds: 1));
      
      if (!mounted) return;
      
      setState(() => _isLoading = false);
      
      if (AuthService.validateCredentials(nisn, password)) {
        if (!mounted) return;
        final firstEnabledRoute = _getFirstEnabledRoute();
        Navigator.of(context).pushReplacementNamed(firstEnabledRoute);
      } else {
        if (!mounted) return;
        final colors = dummyAppConfig.colorPalette;
        ScaffoldMessenger.of(context).showSnackBar(
          SnackBar(
            content: const Text('Invalid nisn or password', style: TextStyle(color: Colors.white)),
            backgroundColor: colors['error'],
          ),
        );
      }
    }
  }

  @override
  void dispose() {
    _nisnController.dispose();
    _passwordController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final colorPalette = dummyAppConfig.colorPalette;
    
    return Scaffold(
      backgroundColor: colorPalette['background'],
      body: SafeArea(
        child: Center(
          child: SingleChildScrollView(
            padding: const EdgeInsets.all(24.0),
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Icon(Icons.school, size: 100, color: colorPalette['primary']),
                const SizedBox(height: 16),
                
                // Sign Up Link
                Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    Text(
                      'Belum Punya Akun? ',
                      style: TextStyle(color: colorPalette['text']),
                    ),
                    TextButton(
                      onPressed: _isLoading
                          ? null
                          : () {
                              ScaffoldMessenger.of(context).showSnackBar(
                                SnackBar(
                                  content: Text('Sign up functionality coming soon!', style: TextStyle(color: colorPalette['text'])),
                                ),
                              );
                            },
                      child: Text(
                        'Daftar',
                        style: TextStyle(
                          color: colorPalette['primary'], 
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                    ),
                  ],
                ),
                
                const SizedBox(height: 20),
                
                // Login Form
                Form(
                  key: _formKey,
                  child: Column(
                    children: [
                      // NISN Field
                      TextFormField(
                        controller: _nisnController,
                        style: TextStyle(color: colorPalette['text']),
                        decoration: InputDecoration(
                          labelText: 'NISN',
                          labelStyle: TextStyle(color: colorPalette['text']?.withOpacity(0.7)),
                          prefixIcon: Icon(Icons.credit_card, color: colorPalette['text']?.withOpacity(0.7)),
                          enabledBorder: OutlineInputBorder(
                            borderRadius: BorderRadius.circular(12),
                            borderSide: BorderSide(color: colorPalette['border'] ?? Colors.white.withOpacity(0.3)),
                          ),
                          focusedBorder: OutlineInputBorder(
                            borderRadius: BorderRadius.circular(12),
                            borderSide: BorderSide(color: colorPalette['primary']!),
                          ),
                        ),
                        keyboardType: TextInputType.number,
                        validator: (value) {
                          if (value == null || value.isEmpty) {
                            return 'Masukkan NISN';
                          }
                          return null;
                        },
                      ),
                      
                      const SizedBox(height: 16),
                      
                      // Password Field
                      TextFormField(
                        controller: _passwordController,
                        style: TextStyle(color: colorPalette['text']),
                        onFieldSubmitted: (value) {
                          if (_formKey.currentState?.validate() ?? false) {
                            _handleLogin();
                          }
                        },
                        obscureText: !_isPasswordVisible,
                        decoration: InputDecoration(
                          labelText: 'Password',
                          labelStyle: TextStyle(color: colorPalette['text']?.withOpacity(0.7)),
                          prefixIcon: Icon(Icons.lock, color: colorPalette['text']?.withOpacity(0.7)),
                          suffixIcon: IconButton(
                            icon: Icon(
                              _isPasswordVisible 
                                  ? Icons.visibility_off 
                                  : Icons.visibility,
                              color: colorPalette['text']?.withOpacity(0.7),
                            ),
                            onPressed: () {
                              setState(() {
                                _isPasswordVisible = !_isPasswordVisible;
                              });
                            },
                          ),
                          enabledBorder: OutlineInputBorder(
                            borderRadius: BorderRadius.circular(12),
                            borderSide: BorderSide(color: colorPalette['border'] ?? Colors.white.withOpacity(0.3)),
                          ),
                          focusedBorder: OutlineInputBorder(
                            borderRadius: BorderRadius.circular(12),
                            borderSide: BorderSide(color: colorPalette['primary']!),
                          ),
                        ),
                        validator: (value) {
                          if (value == null || value.isEmpty) {
                            return 'Masukkan Password';
                          }
                          if (value.length < 6) {
                            return 'Password minimal 6 karakter';
                          }
                          return null;
                        },
                      ),
                      
                      // Forgot Password
                      Align(
                        alignment: Alignment.center,
                        child: TextButton(
                          onPressed: _isLoading
                              ? null
                              : () {
                                  ScaffoldMessenger.of(context).showSnackBar(
                                    SnackBar(
                                      content: Text('Password reset functionality coming soon!', style: TextStyle(color: colorPalette['text'])),
                                    ),
                                  );
                                },
                          child: Text(
                            'Forgot Password?',
                            style: TextStyle(
                              decoration: TextDecoration.underline,
                              decorationColor: colorPalette['text'],
                              decorationThickness: 1.0,
                              color: colorPalette['text'],
                              fontWeight: FontWeight.w500,
                            ),
                          ),
                        ),
                      ),
                      
                      const SizedBox(height: 24),
                      
                      // Login Button
                      SizedBox(
                        width: double.infinity,
                        height: 50,
                        child: ElevatedButton(
                          onPressed: _isLoading ? null : _handleLogin,
                          style: ElevatedButton.styleFrom(
                            backgroundColor: colorPalette['primary'],
                            shape: RoundedRectangleBorder(
                              borderRadius: BorderRadius.circular(12),
                            ),
                          ),
                          child: _isLoading
                              ? SizedBox(
                                  width: 20,
                                  height: 20,
                                  child: CircularProgressIndicator(
                                    strokeWidth: 2,
                                    valueColor: AlwaysStoppedAnimation<Color>(colorPalette['onPrimary'] ?? Colors.white),
                                  ),
                                )
                              : Row(
                                  mainAxisSize: MainAxisSize.min,
                                  children: [
                                    Icon(Icons.login, size: 20, color: colorPalette['text']),
                                    SizedBox(width: 8),
                                    Text(
                                      'LOGIN',
                                      style: TextStyle(
                                        fontSize: 16,
                                        fontWeight: FontWeight.bold,
                                        color: colorPalette['text'],
                                      ),
                                    ),
                                  ],
                                ),
                        ),
                      ),
                    ],
                  ),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}