import 'package:employ_info/cubit/employee_detail/employee_detail_cubit.dart';
import 'package:employ_info/cubit/employee_list/employe_list_cubit.dart';
import 'package:employ_info/extension/date_time_extensions.dart';
import 'package:employ_info/widgets/employee_detail/employee_detail_widget.dart';
import 'package:employ_info/widgets/ui_helper/ui_helper.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:provider/provider.dart';
import '../../cubit/employee_list/employe_list_state.dart';

class EmployeeListWidget extends StatelessWidget {
  const EmployeeListWidget({super.key});

  @override
  Widget build(BuildContext context) {
    context.read<EmployeeListCubit>().loadEmployeeList();
    return Scaffold(
      appBar: AppBar(
        title: const Text('Employee List'),
        backgroundColor: Colors.blueAccent,
      ),
      body: BlocBuilder<EmployeeListCubit, EmployeeListState>(
        builder: (context, state) {
          if (state is InitialEmployeeList || state is LoadEmployeeList) {
            return UIHelper.getProgress(
                txt: 'Fetching database, please wait ...');
          } else if (state is EmployeeListLoaded) {
            return ListView.builder(
              itemCount: state.employees.length,
              itemBuilder: (context, index) {
                final item = state.employees[index];
                return Padding(
                    padding: const EdgeInsets.all(8.0),
                    child: UIHelper.getListItem(
                        context: context,
                        title: '${item.name} ${item.surName}',
                        subtitle: item.birthDate.ddMMYYYY,
                        callBack: () async {
                          var res = await Navigator.of(context)
                              .push(MaterialPageRoute(
                                  builder: (context) => BlocProvider(
                                        create: (context) =>
                                            EmployeeDetailCubit(
                                                employee: item,
                                                sqlService: Provider.of(context,
                                                    listen: false)),
                                        child: const EmployeeDetailsWidget(),
                                      )));
                          if (res != null) {
                            await context
                                .read<EmployeeListCubit>()
                                .loadEmployeeList();
                          }
                        })
                    );
              },
            );
          } else {
            return const SizedBox();
          }
        },
      ),
    );
  }
}
