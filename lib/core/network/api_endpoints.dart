class ApiEndpoints {
  // Auth endpoints
  static const String login = '/auth/login';
  static const String register = '/auth/register';
  static const String logout = '/auth/logout';
  static const String refreshToken = '/auth/refresh';

  // User endpoints
  static const String profile = '/user/profile';
  static const String updateProfile = '/user/profile';

  // Sample endpoints
  static const String posts = '/posts';
  static const String comments = '/comments';

  // Utils
  static String postById(int id) => '/posts/$id';
  static String commentsByPost(int postId) => '/posts/$postId/comments';
}
