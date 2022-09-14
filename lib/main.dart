import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:online_last_bloc/application/detail/bloc/detail_bloc.dart';
import 'package:online_last_bloc/application/home/view/home_view.dart';

import 'application/home/bloc/home_bloc.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return MultiBlocProvider(
      providers: [
      BlocProvider(
        create: (BuildContext context) => HomeBloc(),
      ),
      BlocProvider(
        create: (BuildContext context) => DetailBloc(),
      ),
    ], child: const MaterialApp(
       home: HomeView(),
    ));
  }
}
