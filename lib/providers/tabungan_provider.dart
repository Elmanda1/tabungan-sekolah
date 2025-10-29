import '../services/tabungan_service.dart';
import 'base_provider.dart';
import '../services/error_service.dart';
import '../services/cache_service.dart';
import '../services/connectivity_service.dart';
import '../services/profile_service.dart';

class TabunganProvider extends BaseProvider {
  final TabunganService tabunganService;
  final ProfileService profileService;

  Map<String, dynamic>? _balance;
  List<Map<String, dynamic>> _recentTransactions = [];
  Map<String, dynamic>? _userProfile;
  double _income = 0;
  double _expenses = 0;

  Map<String, dynamic>? get balance => _balance;
  List<Map<String, dynamic>> get recentTransactions => _recentTransactions;
  Map<String, dynamic>? get userProfile => _userProfile;
  double get income => _income;
  double get expenses => _expenses;

  final ErrorService _errorService = ErrorService();
  final CacheService _cacheService = CacheService();
  final ConnectivityService _connectivityService = ConnectivityService();

  TabunganProvider(this.tabunganService, this.profileService);

  Future<void> fetchData() async {
    setState(ViewState.loading);
    try {
      if (await _connectivityService.isConnected()) {
        _balance = await tabunganService.getBalance();
        _recentTransactions = await tabunganService.getRecentTransactions();
        _userProfile = await profileService.getProfile();
        final incomeExpensesData = await tabunganService.getIncomeExpenses();
        _income = (incomeExpensesData['total_income'] ?? 0).toDouble();
        _expenses = (incomeExpensesData['total_expenses'] ?? 0).toDouble();

        await _cacheService.set('balance', _balance);
        await _cacheService.set('recent_transactions', _recentTransactions);
        await _cacheService.set('user_profile', _userProfile);
        await _cacheService.set('income', _income);
        await _cacheService.set('expenses', _expenses);

        setState(ViewState.idle);
      } else {
        final cachedBalance = await _cacheService.get('balance');
        final cachedRecentTransactions = await _cacheService.get('recent_transactions');
        final cachedUserProfile = await _cacheService.get('user_profile');
        final cachedIncome = await _cacheService.get('income');
        final cachedExpenses = await _cacheService.get('expenses');

        if (cachedBalance != null && cachedRecentTransactions != null && cachedUserProfile != null && cachedIncome != null && cachedExpenses != null) {
          _balance = cachedBalance;
          _recentTransactions = List<Map<String, dynamic>>.from(cachedRecentTransactions);
          _userProfile = cachedUserProfile;
          _income = cachedIncome;
          _expenses = cachedExpenses;
          setState(ViewState.idle);
        } else {
          setError('Tidak ada koneksi internet dan tidak ada data cache yang tersedia.', 'Tidak ada koneksi internet dan tidak ada data cache yang tersedia.');
        }
      }
    } catch (e) {
      setError(await _errorService.getFriendlyErrorMessage(e), e);
    }
  }
}
