import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_grpc_example/user/data/user_repo_impl.dart';
import 'package:flutter_grpc_example/user/presentation/bloc/user_bloc.dart';
import 'package:flutter_grpc_example/user/presentation/screen/user_list_page.dart';
import 'package:users_api/users_api.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'gRPC Demo',
      theme: ThemeData(
        primarySwatch: Colors.blue,
      ),
      home: BlocProvider(
        create: (context) => UserBloc(
          repository: UserRepoImpl(
            ApiClient(baseUrl: '10.200.10.150', port: 8080),
            FemtoClient(baseUrl: '10.200.10.170', port: 50051),
          ),
        )..add(FetchUserListEvent()),
        child: const UserListPage(),
      ),
    );
  }
}
