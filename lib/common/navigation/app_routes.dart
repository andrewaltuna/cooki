class AppRoutes {
  const AppRoutes._();

  static const authPaths = [
    login,
    registration,
    completeRegistration,
  ];

  static const loading = '/';

  static const login = '/login';
  static const registration = '/register';
  static const completeRegistration = '/complete-registration';

  static const home = '/home';
  static const map = '/map';
  static const shoppingLists = '/shopping-list';
  static const settings = '/settings';
}
