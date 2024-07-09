class ListAPI {
  ListAPI._();

  static const String baseUrl = String.fromEnvironment('API_URL');


  static const String runSession = "/api/run/session";


  static const String register = "/api/register";

  static const String login = "/api/login";
  static const String logout = "/api/logout";
  static const String users = "/api/users";

  static const String user = "/api/user";



  static const String challenges = "/api/user/challenges";
  static const String checkChallenges = "/api/challenges/check";

  static const String leaderboard = "/api/leaderboard";
}
