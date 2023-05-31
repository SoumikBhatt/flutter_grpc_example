import 'package:grpc/grpc.dart';
import 'package:users_api/src/generated/user.pbgrpc.dart';

class ApiClient {
  ApiClient({
    required String baseUrl,
    required int port,
    ClientChannel? channel,
  }) {
    _channel = ClientChannel(
      baseUrl,
      port: port,
      options: const ChannelOptions(
        credentials: ChannelCredentials.insecure(),
      ),
    );

    stub = UserServiceClient(_channel);
  }

  late final ClientChannel _channel;
  late final UserServiceClient stub;

  // Get the list of users
  Future<List<User>> getUsers() async {
    final response = await stub.getUsers(UsersRequest());
    return response.users;
  }

  // Get a single user by id
Future<User> getUserById({required String id}) async {
    final user = await stub.getUserById(UserByIdRequest(id: id));
    return user;
}
}
