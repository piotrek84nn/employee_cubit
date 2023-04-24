import 'package:employ_info/cubit/home/home_cubit.dart';
import 'package:employ_info/provider_setup.dart';
import 'package:employ_info/widgets/home/home_widget.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:provider/provider.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return MultiProvider(
        providers: providers,
        child: MaterialApp(
          debugShowCheckedModeBanner: false,
          themeMode: ThemeMode.dark,
          theme: ThemeData(
            primarySwatch: Colors.blue,
          ),
          home: BlocProvider(
              create: (context) => HomeCubit(
                  Provider.of(context, listen: false),
                  Provider.of(context, listen: false)),
              child: const HomeWidget()),
        ));
  }
}
