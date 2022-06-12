import 'package:bloc_tutorial2/blocs/internet%20blocs/internet_bloc.dart';
import 'package:bloc_tutorial2/blocs/internet%20blocs/internet_state.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class HomeScreen extends StatelessWidget {
  const HomeScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SafeArea(
        child: Center(
          child: BlocConsumer<InternetBloc, InternetState>(
            listener: (context, state) {
              if (state is InternetActiveState) {
                ScaffoldMessenger.of(context).showSnackBar(
                  SnackBar(
                    content: Text('Internet Connection Active'),
                    backgroundColor: Colors.green,
                  ),
                );
              }
              if (state is InternetLostState) {
                ScaffoldMessenger.of(context).showSnackBar(
                  SnackBar(
                    content: Text('Internet Connection Lost'),
                    backgroundColor: Colors.red,
                  ),
                );
              } else {
                ScaffoldMessenger.of(context).showSnackBar(
                  SnackBar(
                    content: Text('Loading...'),
                    backgroundColor: Colors.deepPurple,
                  ),
                );
              }
            },
            builder: (context, state) {
              if (state is InternetActiveState) {
                return Text('Connected');
              }
              if (state is InternetLostState) {
                return Text('Not Connected');
              } else {
                return Text('Loading..');
              }
            },
          ),
        ),
      ),
    );
  }
}
