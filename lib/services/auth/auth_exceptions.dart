// Login page
class UserNotFoundAuthException implements Exception{}
class WrongPasswordAuthException implements Exception{}

// Register Page
class WeakPasswordAuthException implements Exception{}
class EmailAlreadyInUseAuthException implements Exception{}
class InvalidEmailAuthException implements Exception{}

// Generic Exceptions:
class GenericAuthException implements Exception{}
class UserNotLoggedInAuthException implements Exception{}