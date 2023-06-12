import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_grpc_example/user/presentation/bloc/user_bloc.dart';

class UserListPage extends StatelessWidget {
  const UserListPage({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Scaffold(
        appBar: AppBar(
          title: const Text(
            "User List",
          ),
        ),
        body: const UserListBody(),
      ),
    );
  }
}

class UserListBody extends StatelessWidget {
  const UserListBody({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<UserBloc, UserState>(builder: (context, state) {
      switch (state.state) {
        case UiState.success:
          return ListView.builder(
              itemBuilder: (BuildContext context, int index) {
            return ListTile(
              title: Text(state.users[index].name),
              subtitle: Text(state.users[index].email),
              onTap: (){
                context.read<UserBloc>().add(const SendRabbitMQMessageEvent(message: "Hello from Client"));
              },
            );
          },itemCount: state.users.length,);
        case UiState.loading:
          return const Center(
            child: CircularProgressIndicator(),
          );
        case UiState.failed:
          return Center(
            child: Text(state.errorMsg),
          );
      }
    });
  }
}
