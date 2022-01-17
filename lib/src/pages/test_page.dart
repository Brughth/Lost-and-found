import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:lost_and_found/src/authentification/cubit/user_cubit.dart';

class TestPage extends StatefulWidget {
  const TestPage({Key? key}) : super(key: key);

  @override
  _TestPageState createState() => _TestPageState();
}

class _TestPageState extends State<TestPage> {
  @override
  Widget build(BuildContext context) {
    return BlocBuilder<UserCubit, UserState>(
      builder: (context, state) {
        if (state.user == null) {
          context.read<UserCubit>().getAuthenticatedUser();
          return const Center(child: CircularProgressIndicator());
        }

        if (state.user != null) {
          return Scaffold(
            appBar: AppBar(),
            body: Column(
              children: [
                Text(
                  state.user!.email,
                  style: const TextStyle(
                    fontSize: 20,
                  ),
                ),
                Text(
                  state.user!.name,
                  style: const TextStyle(
                    fontSize: 20,
                  ),
                ),
                Text(
                  state.user!.subname!,
                  style: const TextStyle(
                    fontSize: 20,
                  ),
                ),
                Text(
                  state.user!.teken!,
                  style: const TextStyle(
                    fontSize: 20,
                  ),
                ),
                Text(
                  state.user!.tel,
                  style: const TextStyle(
                    fontSize: 20,
                  ),
                ),
                Text(
                  state.user!.photoUrl!,
                  style: const TextStyle(
                    fontSize: 20,
                  ),
                ),
                Text(
                  state.user!.uid,
                  style: const TextStyle(
                    fontSize: 20,
                  ),
                ),
              ],
            ),
          );
        }

        return Container();
      },
    );
  }
}
