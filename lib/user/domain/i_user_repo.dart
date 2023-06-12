import 'package:users_api/users_api.dart';

import '../../utils/response_wrapper.dart';

abstract class IUserRepo {
  Future<Resource<List<User>>?> getUsers();
  Future<Resource<User>?> getUsersById(String userId);
  Future<Resource<RabbitMQResponse>?> rabbitMqResponse(String message);
}