import 'package:employ_info/cubit/employee_list/employe_list_cubit.dart';
import 'package:employ_info/cubit/home/home_cubit.dart';
import 'package:employ_info/cubit/home/home_state.dart';
import 'package:employ_info/widgets/employee_list/employee_list_widget.dart';
import 'package:employ_info/widgets/ui_helper/ui_helper.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:provider/provider.dart';

class HomeWidget extends StatelessWidget {
  const HomeWidget({super.key});

  @override
  Widget build(BuildContext context) {
    context.read<HomeCubit>().initializeDatabase();
    return Scaffold(
      appBar: AppBar(
        title: const Text('Home'),
        backgroundColor: Colors.blueAccent,
      ),
      body: BlocBuilder<HomeCubit, HomeState>(
        builder: (context, state) {
          if (state is InitHomeState) {
            return UIHelper.getProgress(txt: 'Loading database, please wait ...');
          } else if (state is HomeInitializedState) {
            return Column(children: [
              Padding(
                padding: const EdgeInsets.all(8.0),
                child: UIHelper.getListItem(context: context,
                title: 'Employee List',
                callBack: () => _goToEmployees(context),
                )
              )
            ]);
          } else {
            return const SizedBox();
          }
        },
      ),
    );
  }

  void _goToEmployees(BuildContext context) {
    Navigator.of(context).push(
      MaterialPageRoute(
        builder: (context) => BlocProvider(
            create: (context) =>
                EmployeeListCubit(Provider.of(context, listen: false)),
            child: const EmployeeListWidget()),
      ),
    );
  }
}
