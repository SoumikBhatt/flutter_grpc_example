import 'package:flutter_grpc_example/user/domain/i_user_repo.dart';
import 'package:flutter_grpc_example/utils/response_wrapper.dart';
import 'package:users_api/users_api.dart';

class UserRepoImpl extends IUserRepo {
  final ApiClient _apiClient;

  UserRepoImpl(this._apiClient);

  @override
  Future<Resource<List<User>>?> getUsers() async {
    try {
      final users = await _apiClient.getUsers();
      if (users.isNotEmpty) {
        return Resource.success(users);
      } else {
        return Resource.error("No user found", 0);
      }
    } catch (error) {
      print('UserRepoImpl.getUsers: $error');
      return Resource.error(error.toString(), 1);
    }
  }

  @override
  Future<Resource<User>?> getUsersById(String userId) async {
    try {
      final user = await _apiClient.getUserById(id: userId);
      return Resource.success(user);
    } catch (error) {
      print('UserRepoImpl.getUsers: $error');
      return Resource.error(error.toString(), 1);
    }
  }
}
