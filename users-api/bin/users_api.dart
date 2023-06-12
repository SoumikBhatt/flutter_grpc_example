import 'package:users_api/users_api.dart';

class UserService extends UserServiceBase {
  final List<User> users = List.generate(
      10000,
      (index) => User(
          id: "${index + 1}",
          name: "Test User ${index + 1}",
          email: "testUser${index + 1}@gmail.com"));

  @override
  Future<User> getUserById(ServiceCall call, UserByIdRequest request) async {
    final userId = request.id;

    return users.firstWhere(
      (user) => user.id == userId,
      orElse: () => User(),
    );
  }

  @override
  Future<UsersResponse> getUsers(ServiceCall call, UsersRequest request) async {
    return UsersResponse(users: users);
  }
}

void main(List<String> arguments) async {
  final server = Server([UserService()]);
  final port = 8080;
  await server.serve(port: port);

  print('Server is running at localhost: ${server.port}');
}
