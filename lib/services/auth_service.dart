class AuthService {
  // Dummy user credentials
  static final Map<String, String> _dummyUsers = {
    '2407411068': 'juen123',
    'user@example.com': 'user123',
    'test@example.com': 'test123',
  };

  // Check if credentials are valid
  static bool validateCredentials(String email, String password) {
    return _dummyUsers[email] == password;
  }

  // Get list of dummy emails (for autocomplete or testing)
  static List<String> getDummyEmails() {
    return _dummyUsers.keys.toList();
  }
}
