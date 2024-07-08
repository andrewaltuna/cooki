class AuthFormErrors {
  const AuthFormErrors._();

  // General
  static const nameRequired = 'Nickname is required';
  static const emailRequired = 'Email is required';
  static const passwordRequired = 'Password is required';

  // Login
  static const invalidCredentials = 'Email or password is incorrect';

  // Registration
  static const passwordMismatch = 'Passwords do not match';
  static const invalidEmail = 'Invalid email address';
  static const emailInUse = 'Email already in use';
  static const weakPassword = 'Password must be at least 6 characters';
}
